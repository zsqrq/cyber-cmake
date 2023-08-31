/******************************************************************************
 * Copyright 2018 The Apollo Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *****************************************************************************/

#pragma once

#include <map>
#include <memory>
#include <string>
#include <vector>

#include <boost/shared_ptr.hpp>

#include "modules/perception/base/blob.h"

#if GPU_PLATFORM == NVIDIA
  #include <c10/cuda/CUDACachingAllocator.h>
  using c10::cuda::CUDACachingAllocator::emptyCache;
#elif GPU_PLATFORM == AMD
  #include <c10/hip/HIPCachingAllocator.h>
  using c10::hip::HIPCachingAllocator::emptyCache;
#endif

namespace apollo {
namespace perception {
namespace inference {

typedef std::map<std::string,
                 std::shared_ptr<apollo::perception::base::Blob<float>>>
    BlobMap;

class Inference {
 public:
  Inference() = default;

  virtual ~Inference() = default;

  virtual bool Init(const std::map<std::string, std::vector<int>> &shapes) = 0;

  virtual void Infer() = 0;

  virtual std::shared_ptr<apollo::perception::base::Blob<float>> get_blob(
      const std::string &name) = 0;

  void set_max_batch_size(const int &batch_size);

  void set_gpu_id(const int &gpu_id);

 protected:
  int max_batch_size_ = 1;
  int gpu_id_ = 0;
};

}  // namespace inference
}  // namespace perception
}  // namespace apollo
