From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 10 Feb 2017 09:14:04 -0700
Subject: [PATCH v2 0/4] New Microsemi PCI Switch Management Driver
In-Reply-To: <1486058763-7730-1-git-send-email-logang@deltatee.com>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
Message-ID: <CAKb3OG9N1ztR6kP-YykKE-tA49z=-TYofwP9eOZ9Ts=rm7Hc_g@mail.gmail.com>

On Thu, Feb 2, 2017@11:05 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Changes since v1:
>
> * Rebased onto 4.10-rc6 (cleanly)
> * Split the patch into a few more easily digestible patches (as
>   suggested by Greg Kroah-Hartman)
> * Folded switchtec.c into switchtec.h (per Greg)
> * Fixed a bunch of 32bit build warnings caught by the kbuild test robot
> * Fixed some issues in the documentation so it has a proper
>   reStructredText format (as noted by Jonathan Corbet)
> * Fixed padding and sizes in the IOCTL structures as noticed by Emil
>   Velikov and used pahole to verify their consistency across 32 and 64
>   bit builds
> * Reworked one of the IOCTL interfaces to be more future proof (per
>   Emil).
>
> Changes since RFC:
>
> * Fixed incorrect use of the drive model as pointed out by Greg
>   Kroah-Hartman
> * Used devm functions as suggested by Keith Busch
> * Added a handful of sysfs attributes to the switchtec class
> * Added a handful of IOCTLs to the switchtec device
> * A number of miscellaneous bug fixes
>
> --
>
> Hi,
>
> This is a continuation of the RFC we posted lasted month [1] which
> proposes a management driver for Microsemi's Switchtec line of PCI
> switches. This hardware is still looking to be used in the Open
> Compute Platform
>
> To make this entirely clear: the Switchtec products are compliant
> with the PCI specifications and are supported today with the standard
> in-kernel driver. However, these devices also expose a management endpoint
> on a separate PCI function address which can be used to perform some
> advanced operations. This is a driver for that function. See the patch
> for more information.
>
> Since the RFC, we've made the changes requested by Greg Kroah-Hartman
> and Keith Busch, and we've also fleshed out a number of features. We've
> added a couple of IOCTLs and sysfs attributes which are documented in
> the patch. Significant work has also been done on the userspace tool
> which is available under a GPL license at [2]. We've also had testing
> done by some of the interested parties.
>
> We hope to see this work included in either 4.11 or 4.12 assuming a
> smooth review process.
>
> The patch is based off of the v4.10-rc6 release.
>
> Thanks for your review,

Looks good to me, you can add my:

Reviewed-by: Jens Axboe <axboe at fb.com>
