From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 21 Dec 2016 01:47:31 -0800
Subject: [PATCH v3 2/5] lib: Add Sed-opal library
In-Reply-To: <20161220220746.GA3939@localhost.localdomain>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-3-git-send-email-scott.bauer@intel.com>
 <20161220072847.GA11946@infradead.org>
 <20161220220746.GA3939@localhost.localdomain>
Message-ID: <20161221094731.GD32084@infradead.org>

On Tue, Dec 20, 2016@03:07:46PM -0700, Jon Derrick wrote:
> > This pretty much seem to contain the OPAL protocol defintions, so why
> > not opal_proto.h?
> Since there might eventually be a whole class of opal-like sed
> protocols, why does it make more sense to have opal_proto.h instead of
> sed-opal.h or some variation? This is similar to how leds-*.h look to
> me. Although I agree that sed-ATA.h would be dishonest since ATA
> security doesn't imply a self-encrypting-disk.

As far as I can tell the NVMe / SCSI / ATA security landscape looks
like:

 - ATA security - specified in ATA, kinda implicitly referenced by SPC
   and then even more implitly in NVMe.  Actually implemented in various
   NVMe consumer devices because OEMs insist on it.  Basically just
   a trivial plain text password lock/unlock.

 - TCG OPAL including the subsets OPALite and Pyrite, whereas the latter
   is just the above lock/unlock in a TCG way.

 - TCG Enterprise SSC

I think it's pretty obvious that ATA security should be something on
it's own.  OPALite and Pyrite are strict subsets of OPAL, so having them
in something named opal shouldn't be surprising.  The big question
is what to do about Enterprise SSC.  Which has some overlaps with OPAL
but also major differences, so keeping it separate if we ever have to
implement it (I hope we don't) would be best.

> I'm on board with this if you think we won't have enough different, but
> similar, SED protocols to justify the indirection. In that case you can
> ignore the above comment as well.

This goes back to the above.  The only thing that is not a strict subset
of OPAL but kinda sorta similar is TCG Enterprise SSC, but my preference
would be to ignore it, and the second best preference would be to keep
it separate.
