From: mlin@kernel.org (Ming Lin)
Date: Sat, 26 Sep 2015 23:49:42 -0700
Subject: [RFC PATCH 0/2] virtio nvme
In-Reply-To: <1443330116.15432.57.camel@haakon3.risingtidesystems.com>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>
 <CAJSP0QUmtgoh23G3u64xRnBbJkAoO19AEi=vkyPPyg9n9jqC2Q@mail.gmail.com>
 <1441906098.18716.21.camel@ssi>
 <1442470241.23132.77.camel@haakon3.risingtidesystems.com>
 <1442532687.4750.6.camel@ssi>
 <1442537752.11959.35.camel@haakon3.risingtidesystems.com>
 <1442599957.11660.8.camel@ssi>
 <1442610544.10492.33.camel@haakon3.risingtidesystems.com>
 <1443049097.28503.13.camel@ssi>
 <1443330116.15432.57.camel@haakon3.risingtidesystems.com>
Message-ID: <CAF1ivSYek_Y0pO4zNN4vkxxPmNTSN=mR1hwOPyzGuUeHTjKtug@mail.gmail.com>

On Sat, Sep 26, 2015 at 10:01 PM, Nicholas A. Bellinger
<nab@linux-iscsi.org> wrote:
>
> Btw, after chatting with Dr. Hannes this week at SDC here are his
> original rts-megasas -v6 patches from Feb 2013.
>
> Note they are standalone patches that require a sufficiently old enough
> LIO + QEMU to actually build + function.
>
> https://github.com/Datera/rts-megasas/blob/master/rts_megasas-qemu-v6.patch
> https://github.com/Datera/rts-megasas/blob/master/rts_megasas-fabric-v6.patch
>
> For groking purposes, they demonstrate the principle design for a host
> kernel level driver, along with the megasas firmware interface (MFI)
> specific emulation magic that makes up the bulk of the code.
>
> Take a look.

Big thanks. Reading the patches now.

>
> --nab
>
