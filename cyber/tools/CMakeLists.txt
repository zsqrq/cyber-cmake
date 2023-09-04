cmake_minimum_required(VERSION 3.16)
project(tools)

cyber_add_excutable(
    TARGET cyber_cmake_monitor
    SOURCES cyber_monitor/cyber_topology_message.cc cyber_monitor/general_channel_message.cc
    cyber_monitor/general_message.cc cyber_monitor/general_message_base.cc
    cyber_monitor/renderable_message.cc cyber_monitor/screen.cc cyber_monitor/main.cc
    PUBLIC_LIBS cyber-cmake-core  ncurses
    INSTALL_PATH bin/cyber/tools/cyber_monitor
)

cyber_add_excutable(
    TARGET cyber_cmake_recorder
    SOURCES cyber_recorder/main.cc
    cyber_recorder/info.cc
    cyber_recorder/recorder.cc
    cyber_recorder/recoverer.cc
    cyber_recorder/spliter.cc
    cyber_recorder/player/play_task.cc
    cyber_recorder/player/play_task_buffer.cc
    cyber_recorder/player/play_task_consumer.cc
    cyber_recorder/player/play_task_producer.cc
    cyber_recorder/player/player.cc
    PUBLIC_LIBS cyber-cmake-core 
    INSTALL_PATH bin/cyber/tools/cyber_recorder
)

install(FILES cyber_channel/cyber_channel.py
  PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
  DESTINATION bin/cyber/tools/cyber_channel
  RENAME cyber_channel
)
install(FILES cyber_launch/cyber_launch.py
  PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
  DESTINATION bin/cyber/tools/cyber_launch
  RENAME cyber_launch
)
install(FILES cyber_node/cyber_node.py
  PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
  DESTINATION bin/cyber/tools/cyber_node
  RENAME cyber_node
)
install(FILES cyber_service/cyber_service.py
  PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
  DESTINATION bin/cyber/tools/cyber_service
  RENAME cyber_service
)

