if(NOT COMMAND cmessage)

  message(STATUS "Setting up colored messages...")

  function(cmessage)
    if(NOT WIN32)
      string(ASCII 27 Esc)
      set(CM_ColourReset "${Esc}[m")
      set(CM_ColourBold "${Esc}[1m")
      set(CM_Red "${Esc}[31m")
      set(CM_Green "${Esc}[32m")
      set(CM_Yellow "${Esc}[33m")
      set(CM_Blue "${Esc}[34m")
      set(CM_Magenta "${Esc}[35m")
      set(CM_Cyan "${Esc}[36m")
      set(CM_White "${Esc}[37m")
      set(CM_BoldRed "${Esc}[1;31m")
      set(CM_BoldGreen "${Esc}[1;32m")
      set(CM_BoldYellow "${Esc}[1;33m")
      set(CM_BoldBlue "${Esc}[1;34m")
      set(CM_BoldMagenta "${Esc}[1;35m")
      set(CM_BoldCyan "${Esc}[1;36m")
      set(CM_BoldWhite "${Esc}[1;37m")
    endif()

    list(GET ARGV 0 MessageType)
    list(REMOVE_AT ARGV 0)
    if(MessageType STREQUAL FATAL_ERROR OR MessageType STREQUAL SEND_ERROR)
      message(${MessageType} "${CM_BoldRed}${ARGV}${CM_ColourReset}")
    elseif(MessageType STREQUAL WARNING)
      message(${MessageType} "${CM_BoldYellow}${ARGV}${CM_ColourReset}")
    elseif(MessageType STREQUAL AUTHOR_WARNING)
      message(${MessageType} "${CM_BoldCyan}${ARGV}${CM_ColourReset}")
    elseif(MessageType STREQUAL STATUS)
      message(${MessageType} "${CM_Green}[INFO]:${CM_ColourReset} ${ARGV}")
    elseif(MessageType STREQUAL CACHE)        
      message(-- "${CM_Blue}[CACHE]:${CM_ColourReset} ${ARGV}")
    elseif(MessageType STREQUAL DEBUG)
      if(DEFINED DEBUG_BUILDSYSTEMGENERATOR AND DEBUG_BUILDSYSTEMGENERATOR)
        message("${CM_Magenta}[DEBUG]:${CM_ColourReset} ${ARGV}")
      endif()
    else()
      message(${MessageType} "${CM_Green}[${MessageType}]:${CM_ColourReset} ${ARGV}")
    endif()
  endfunction()
endif()
