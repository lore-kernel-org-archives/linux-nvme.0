From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 24 Mar 2014 16:49:37 +0100
Subject: [PATCH v2] NVMe: silence GCC warning on 32 bit
In-Reply-To: <1395675399.6440.14.camel@x220>
References: <1392714172-2712-1-git-send-email-geert@linux-m68k.org>
 <1392934261.15264.22.camel@x220>
 <alpine.LRH.2.03.1402210921010.4656@AMR>
 <1393925767.3038.23.camel@x220>
 <20140324131104.GC5777@linux.intel.com>
 <20140324133154.GD5777@linux.intel.com>
 <1395675399.6440.14.camel@x220>
Message-ID: <CAMuHMdVMq30_XFLNzwjj6kXWVvasa8Ewog0MmOd1PNDQDuybqA@mail.gmail.com>

Hi Paul,

On Mon, Mar 24, 2014@4:36 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> And as this is now unlikely to be in time for v3.14, we might decide to
> dig deeper. It won't be the first time that a rather small change (say,
> converting a variable from signed to unsigned) turns out be enough to
> make GCC understand the flow of the code.

Anything we can do with factoring out the "if (!first)" in both branches?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
