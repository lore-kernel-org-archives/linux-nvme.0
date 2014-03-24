From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 24 Mar 2014 16:36:39 +0100
Subject: [PATCH v2] NVMe: silence GCC warning on 32 bit
In-Reply-To: <20140324133154.GD5777@linux.intel.com>
References: <1392714172-2712-1-git-send-email-geert@linux-m68k.org>
 <1392934261.15264.22.camel@x220> <alpine.LRH.2.03.1402210921010.4656@AMR>
 <1393925767.3038.23.camel@x220> <20140324131104.GC5777@linux.intel.com>
 <20140324133154.GD5777@linux.intel.com>
Message-ID: <1395675399.6440.14.camel@x220>

On Mon, 2014-03-24@09:31 -0400, Matthew Wilcox wrote:
> I should try things myself before opening my big mouth.  Weird.  Using
> gcc-4.8, I see the same thing.  Guess I should just apply the patch,
> though it feels wrong to be initialising an entire struct just to silence
> a bogus compiler warning :-(

I noticed this difference on a 32 bit x86 machine and a 64 bit x86
machine that are both running Fedora 20. They both should be at
gcc-4.8.2 for quite some time now (if I grepped the yum log correctly).

Anyhow, the warning on 32 bit is rather noisy, so I wanted it gone. But
my comments should make clear I'm not really happy with this patch. 

And as this is now unlikely to be in time for v3.14, we might decide to
dig deeper. It won't be the first time that a rather small change (say,
converting a variable from signed to unsigned) turns out be enough to
make GCC understand the flow of the code.

Thanks,


Paul Bolle
