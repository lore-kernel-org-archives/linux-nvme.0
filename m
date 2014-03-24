From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 24 Mar 2014 16:57:46 +0100
Subject: [PATCH v2] NVMe: silence GCC warning on 32 bit
In-Reply-To: <CAMuHMdVMq30_XFLNzwjj6kXWVvasa8Ewog0MmOd1PNDQDuybqA@mail.gmail.com>
References: <1392714172-2712-1-git-send-email-geert@linux-m68k.org>
 <1392934261.15264.22.camel@x220> <alpine.LRH.2.03.1402210921010.4656@AMR>
 <1393925767.3038.23.camel@x220> <20140324131104.GC5777@linux.intel.com>
 <20140324133154.GD5777@linux.intel.com> <1395675399.6440.14.camel@x220>
 <CAMuHMdVMq30_XFLNzwjj6kXWVvasa8Ewog0MmOd1PNDQDuybqA@mail.gmail.com>
Message-ID: <1395676666.6440.19.camel@x220>

On Mon, 2014-03-24@16:49 +0100, Geert Uytterhoeven wrote:
> On Mon, Mar 24, 2014@4:36 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> > And as this is now unlikely to be in time for v3.14, we might decide to
> > dig deeper. It won't be the first time that a rather small change (say,
> > converting a variable from signed to unsigned) turns out be enough to
> > make GCC understand the flow of the code.
> 
> Anything we can do with factoring out the "if (!first)" in both branches?

That was basically my approach in version one: drop "first" all
together. Worked great: the warning was gone. But Keith noted that I
also completely broke the logic of the code. So I decided, after some
further attempts, to take the easy way out and and initialize "bvprv" to
{ NULL }.


Paul Bolle
