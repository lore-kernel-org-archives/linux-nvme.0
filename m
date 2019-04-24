From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Apr 2019 10:20:46 -0700
Subject: [PATCH] block: use static bio_set for bio_split() calls
In-Reply-To: <20190418143429.GA19175@ming.t460p>
References: <20190418140632.60606-1-hare@suse.de>
 <20190418143429.GA19175@ming.t460p>
Message-ID: <98d8549a-2663-b404-e38a-6f55dfb575bf@grimberg.me>


> per-queue bioset is used originally for avoiding deadlock, are you
> sure the static bioset is safe?

Can you explain this? I didn't find any indication of that in the change
log history...

Originally introduced by Kent:
--
commit 54efd50bfd873e2dbf784e0b21a8027ba4299a3e
Author: Kent Overstreet <kent.overstreet at gmail.com>
Date:   Thu Apr 23 22:37:18 2015 -0700

     block: make generic_make_request handle arbitrarily sized bios

     The way the block layer is currently written, it goes to great lengths
     to avoid having to split bios; upper layer code (such as 
bio_add_page())
     checks what the underlying device can handle and tries to always create
     bios that don't need to be split.

     But this approach becomes unwieldy and eventually breaks down with
     stacked devices and devices with dynamic limits, and it adds a lot of
     complexity. If the block layer could split bios as needed, we could
     eliminate a lot of complexity elsewhere - particularly in stacked
     drivers. Code that creates bios can then create whatever size bios are
     convenient, and more importantly stacked drivers don't have to deal 
with
     both their own bio size limitations and the limitations of the
     (potentially multiple) devices underneath them.  In the future this 
will
     let us delete merge_bvec_fn and a bunch of other code.

     We do this by adding calls to blk_queue_split() to the various
     make_request functions that need it - a few can already handle 
arbitrary
     size bios. Note that we add the call _after_ any call to
     blk_queue_bounce(); this means that blk_queue_split() and
     blk_recalc_rq_segments() don't need to be concerned with bouncing
     affecting segment merging.

     Some make_request_fn() callbacks were simple enough to audit and verify
     they don't need blk_queue_split() calls. The skipped ones are:

      * nfhd_make_request (arch/m68k/emu/nfblock.c)
      * axon_ram_make_request (arch/powerpc/sysdev/axonram.c)
      * simdisk_make_request (arch/xtensa/platforms/iss/simdisk.c)
      * brd_make_request (ramdisk - drivers/block/brd.c)
      * mtip_submit_request (drivers/block/mtip32xx/mtip32xx.c)
      * loop_make_request
      * null_queue_bio
      * bcache's make_request fns

     Some others are almost certainly safe to remove now, but will be left
     for future patches.
--
