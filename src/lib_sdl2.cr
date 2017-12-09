@[Link("SDL2")]
lib LibSDL2
  SWSURFACE = 0x00000000_u32
  HWSURFACE = 0x00000001_u32
  ASYNCBLIT = 0x00000004_u32

  ANYFORMAT  = 0x10000000_u32
  HWPALETTE  = 0x20000000_u32
  DOUBLEBUF  = 0x40000000_u32
  FULLSCREEN = 0x80000000_u32
  OPENGL     = 0x00000002_u32
  OPENGLBLIT = 0x0000000A_u32
  RESIZABLE  = 0x00000010_u32
  NOFRAME    = 0x00000020_u32

  HWACCEL     = 0x00000100_u32
  SRCCOLORKEY = 0x00001000_u32
  RLEACCELOK  = 0x00002000_u32
  RLEACCEL    = 0x00004000_u32
  SRCALPHA    = 0x00010000_u32
  PREALLOC    = 0x01000000_u32

  WINDOW_SHOWN      = 0x00000004_u32
  WINDOW_RESIZABLE  = 0x00000020_u32

  WINDOWPOS_UNDEFINED = 0x1FFF0000
  WINDOWPOS_CENTERED = 0x2FFF0000

  DISABLE = 0
  ENABLE = 1

  enum Bool
    SDL_FALSE = 0
    SDL_TRUE = 1
  end

  enum BlendMode
    NONE = 0x00000000
    BLEND = 0x00000001
    ADD = 0x00000002
    MOD = 0x00000004
  end

  enum TextureAccess
    STATIC
    STREAMING
    TARGET
  end

  struct Color
    r, g, b, unused : UInt8
  end

  struct Rect
    x, y : Int32
    w, h : Int32
  end

  struct Palette
    ncolors : Int32
    color : Color
  end

  enum PixelFormatEnum
  #TODO
    SOMETHING
  end

  struct PixelFormat
    format : PixelFormatEnum
    palette : Palette
    bits_per_pixel, bytes_per_pixel : UInt8
    r_mask, g_mask, b_mask, a_mask : UInt32
  end

  struct Surface
    flags : UInt32
    format : PixelFormat*
    w, h : Int32
    pitch : UInt16
    pixels : Void*
    #TODO
  end

  struct Window
    id : UInt32
    title : Char*
    icon : Surface*
    x, y, w, h : Int32
    min_w, min_h, max_w, max_h : Int32
    flags : UInt32
    #TODO
  end

  struct Renderer
    window : Window*
    #TODO
  end

  struct Texture
    #TODO
    something: Int32
  end

  enum Key
    ESCAPE = 27
    A = 97
    B = 98
    C = 99
    D = 100
    E = 101
    F = 102
    G = 103
    H = 104
    I = 105
    J = 106
    K = 107
    L = 108
    M = 109
    N = 110
    O = 111
    P = 112
    Q = 113
    R = 114
    S = 115
    T = 116
    U = 117
    V = 118
    W = 119
    X = 120
    Y = 121
    Z = 122
    UP = 273
    DOWN = 274
    RIGHT = 275
    LEFT = 276
    SPACE = 205
  end


  alias SDL2_Keycode = Int32

  struct KeySym
    scan_code : SDL2::Scancode
    sym : Key # SDL_Keycode
    #TODO
  end

  struct KeyboardEvent
    type : SDL2::EventType
    timestamp : UInt32
    window_id : UInt32
    state : UInt8
    repeat : UInt8
    padding : UInt8[2]
    key_sym : KeySym
  end

  struct UserEvent
    type : SDL2::EventType
    timestamp : UInt32
    windowID : UInt32
    code : Int32
    data1 : Void*
    data2 : Void*
  end

  union Event
    type : SDL2::EventType
    key : KeyboardEvent
    user : UserEvent
    padding : UInt8[56]
  end

  struct RWops
    dummy : Int32
  end

  struct Point
    x : Int32
    y : Int32
  end

  type TimerCallback = (UInt32, Void*) -> UInt32

  fun init = SDL_Init(flags : SDL2::INIT) : Int32
  fun get_error = SDL_GetError() : UInt8*
  fun was_init = SDL_WasInit(flags : UInt32) : UInt32
  fun init_subsystem = SDL_InitSubSystem(flags : UInt32) : Int32

  fun quit = SDL_Quit() : Void
  # fun set_video_mode = SDL_SetVideoMode(width : Int32, height : Int32, bpp : Int32, flags : UInt32) : Surface*
  # fun load_bmp = SDL_LoadBMP(file : UInt8*) : Surface*
  fun create_window = SDL_CreateWindow(title : UInt8*, x : Int32, y : Int32, width : Int32, height : Int32, flags : SDL2::Window::Flags) : Window*
  fun destroy_window = SDL_DestroyWindow(Window*) : Void
  fun delay = SDL_Delay(ms : UInt32) : Void
  fun poll_event = SDL_PollEvent(event : Event*) : Int32
  fun wait_event = SDL_WaitEvent(event : Event*) : Int32
  fun push_event = SDL_PushEvent(event : Event*) : Int32

  fun get_window_surface = SDL_GetWindowSurface(window : Window*) : Surface*
  fun lock_surface = SDL_LockSurface(surface : Surface*) : Int32
  fun unlock_surface = SDL_UnlockSurface(surface : Surface*) : Void
  fun update_window_surface = SDL_UpdateWindowSurface(window : Window*) : Int32

  fun update_rect = SDL_UpdateRect(screen : Surface*, x : Int32, y : Int32, w : Int32, h : Int32) : Void
  fun fill_rect = SDL_FillRect(surface : Surface*, rect : Rect*, c : UInt32) : Int32

  fun show_cursor = SDL_ShowCursor(toggle : Int32) : Int32
  fun get_ticks = SDL_GetTicks : UInt32
  fun flip = SDL_Flip(screen : Surface*) : Int32

  fun create_renderer = SDL_CreateRenderer(window : Window*, index : Int32, flags : SDL2::Renderer::Flags) : Renderer*
  fun destroy_renderer = SDL_DestroyRenderer(renderer : Renderer*) : Void
  fun render_clear = SDL_RenderClear(renderer : Renderer*) : Int32
  fun render_present = SDL_RenderPresent(renderer : Renderer*) : Int32
  fun render_copy = SDL_RenderCopy(renderer : Renderer*, texture : Texture*, srcrect : Rect*, dstrect : Rect*) : Int16
  fun render_copy_ex = SDL_RenderCopyEx(renderer : Renderer*, texture : Texture*, srcrect : Rect*, dstrect : Rect*, angle : Float64, center : Point*, flip : SDL2::RenderFlip) : Int32
  fun set_render_draw_blend_mode = SDL_SetRenderDrawBlendMode(renderer : Renderer*, mode : BlendMode) : Int32
  fun set_render_target = SDL_SetRenderTarget(renderer : Renderer*, texture : Texture*) : Int32
  fun set_render_draw_color = SDL_SetRenderDrawColor(renderer : Renderer*, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int32

  fun create_texture_from_surface = SDL_CreateTextureFromSurface(renderer : Renderer*, surface : Surface*) : Texture*
  fun create_texture = SDL_CreateTexture(renderer : Renderer*, format : UInt32, access : TextureAccess, w : Int32, h : Int32) : Texture*
  fun destroy_texture = SDL_DestroyTexture(texture : Texture*) : Void

  fun rw_from_file = SDL_RWFromFile(str1 : UInt8*, str2 : UInt8*) : RWops*
  fun load_bmp_rw = SDL_LoadBMP_RW(rw_ops : RWops*, int : Int32) : Surface*

  fun map_rgb = SDL_MapRGB(format : PixelFormat*, r : UInt8, g : UInt8, b : UInt8) : UInt32

  fun blit_surface = SDL_UpperBlit(src : Surface*, src_rect : Rect*, dst : Surface*, dst_rect : Rect*) : Int32
  fun free_surface = SDL_FreeSurface(surface : Surface*) : Void

  fun add_timer = SDL_AddTimer(interval : UInt32, callback : TimerCallback, param : Void*) : Int32
  fun remove_timer = SDL_RemoveTimer(id : Int32) : Int32


############### rect
  fun has_intersection = SDL_HasIntersection( a : Rect*, b : Rect*) : Bool
  fun intersect_rect = SDL_IntersectRect(a : Rect*, b : Rect*, result : Rect*) : Bool
  fun union_rect = SDL_UnionRect( a : Rect*, b : Rect*, result : Rect*)
  #fun enclose_points = SDL_EnclosePoints(points : SDL_Point*, count : Int32, clip : Rect*, result : Rect*)
  fun intersect_rect_and_line = SDL_IntersectRectAndLine(rect : Rect*, x1 : Int32*, y1 : Int32*, x2 : Int32*, y2 : Int32*) : Bool

############## blend mode

  # enum BlendMode
  #   SDL_BLENDMODE_NONE = 0x00000000_u32     #< no blending
  #                                           #	dstRGBA = srcRGBA */
  #   SDL_BLENDMODE_BLEND = 0x00000001_u32    #< alpha blending
  #                                           #	dstRGB = (srcRGB * srcA) + (dstRGB * (1-srcA))
  #                                           #	dstA = srcA + (dstA * (1-srcA)) */
  #   SDL_BLENDMODE_ADD = 0x00000002_u32      #< additive blending
  #                                           #	dstRGB = (srcRGB * srcA) + dstRGB
  #                                           #	dstA = dstA */
  #   SDL_BLENDMODE_MOD = 0x00000004_u32      #< color modulate
  #                                           #	dstRGB = srcRGB * dstRGB
  #                                           #	dstA = dstA */
  # end


############### video

  fun get_num_video_drivers = SDL_GetNumVideoDrivers() : UInt32
  fun get_video_driver = SDL_GetVideoDriver(n : UInt32) : UInt8*
  fun get_current_video_driver = SDL_GetCurrentVideoDriver() : UInt8*

  fun video_init = SDL_VideoInit(UInt8*) : Int32
  fun video_quit = SDL_VideoQuit() : Void

  fun get_num_video_displays = SDL_GetNumVideoDisplays() : Int32
  fun get_display_name = SDL_GetDisplayName(UInt32) : UInt8*
  fun get_display_bounds = SDL_GetDisplayBounds(id : UInt32, rect : Rect*) : Int32


  struct DisplayMode
    format : UInt32
    w : Int32
    h : Int32
    refresh_rate : Int32
    driver_data : Void*
  end

  enum GLattr
    SDL_GL_RED_SIZE,
    SDL_GL_GREEN_SIZE,
    SDL_GL_BLUE_SIZE,
    SDL_GL_ALPHA_SIZE,
    SDL_GL_BUFFER_SIZE,
    SDL_GL_DOUBLEBUFFER,
    SDL_GL_DEPTH_SIZE,
    SDL_GL_STENCIL_SIZE,
    SDL_GL_ACCUM_RED_SIZE,
    SDL_GL_ACCUM_GREEN_SIZE,
    SDL_GL_ACCUM_BLUE_SIZE,
    SDL_GL_ACCUM_ALPHA_SIZE,
    SDL_GL_STEREO,
    SDL_GL_MULTISAMPLEBUFFERS,
    SDL_GL_MULTISAMPLESAMPLES,
    SDL_GL_ACCELERATED_VISUAL,
    SDL_GL_RETAINED_BACKING,
    SDL_GL_CONTEXT_MAJOR_VERSION,
    SDL_GL_CONTEXT_MINOR_VERSION,
    SDL_GL_CONTEXT_EGL,
    SDL_GL_CONTEXT_FLAGS,
    SDL_GL_CONTEXT_PROFILE_MASK,
    SDL_GL_SHARE_WITH_CURRENT_CONTEXT,
    SDL_GL_FRAMEBUFFER_SRGB_CAPABLE
  end



############### cpu info
  fun get_cpu_count = SDL_GetCPUCount() : Int32
  fun get_cpu_cache_line_size = SDL_GetCPUCacheLineSize() : Int32
  fun has_RDTSC = SDL_HasRDTSC() : Bool
  fun has_alti_vec = SDL_HasAltiVec() : Bool
  fun has_MMX = SDL_HasMMX() : Bool
  fun has_3DNow = SDL_Has3DNow() : Bool
  fun has_SSE = SDL_HasSSE() : Bool
  fun has_SSE2 = SDL_HasSSE2() : Bool
  fun has_SSE3 = SDL_HasSSE3() : Bool
  fun has_SSE41 = SDL_HasSSE41() : Bool
  fun has_SSE42 = SDL_HasSSE42() : Bool
  fun has_AVX = SDL_HasAVX() : Bool
  fun get_system_RAM = SDL_GetSystemRAM() : Int32

end

############ events

  enum EventType
    SDL_FIRSTEVENT = 0
    SDL_QUIT = 0x100
    SDL_APP_TERMINATING
    SDL_APP_LOWMEMORY
    SDL_APP_WILLENTERBACKGROUND
    SDL_APP_DIDENTERBACKGROUND
    SDL_APP_WILLENTERFOREGROUND
    SDL_APP_DIDENTERFOREGROUND
    SDL_WINDOWEVENT = 0x200
    SDL_SYSWMEVENT

    SDL_KEYDOWN = 0x300
    SDL_KEYUP
    SDL_TEXTEDITING
    SDL_TEXTINPUT

    SDL_MOUSEMOTION = 0x400
    SDL_MOUSEBUTTONDOWN
    SDL_MOUSEBUTTONUP
    SDL_MOUSEWHEEL

    SDL_JOYAXISMOTION = 0x600
    SDL_JOYBALLMOTION
    SDL_JOYHATMOTION
    SDL_JOYBUTTONDOWN
    SDL_JOYBUTTONUP
    SDL_JOYDEVICEADDED
    SDL_JOYDEVICEREMOVED

    SDL_CONTROLLERAXISMOTION = 0x650
    SDL_CONTROLLERBUTTONDOWN
    SDL_CONTROLLERBUTTONUP
    SDL_CONTROLLERDEVICEADDED
    SDL_CONTROLLERDEVICEREMOVED
    SDL_CONTROLLERDEVICEREMAPPED

    SDL_FINGERDOWN = 0x700
    SDL_FINGERUP
    SDL_FINGERMOTION

    SDL_DOLLARGESTURE = 0x800
    SDL_DOLLARRECORD
    SDL_MULTIGESTURE

    SDL_CLIPBOARDUPDATE = 0x900
    SDL_DROPFILE = 0x1000
    SDL_RENDER_TARGETS_RESET = 0x2000
  end
