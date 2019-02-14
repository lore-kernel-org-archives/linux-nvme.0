From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 14 Feb 2019 21:47:55 +0100
Subject: [patch V5 0/8] genirq/affinity: Overhaul the multiple interrupt sets
 support
Message-ID: <20190214204755.819014197@linutronix.de>

This is a follow up on Ming's V4 patch series, which addresses the short
comings of multiple interrupt sets in the core code:

  https://lkml.kernel.org/r/20190214122347.17372-1-ming.lei at redhat.com

The series applies against:

     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

and is also available from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 

The changes vs. Ming's v4 are:

  1) Do a cleanup as a first step to convert all the integer logic over to
     use unsigned int. I did this because I tripped over the plain integer
     calculation at some point and there is really no reason why any of
     this should be signed. In hindsight I should had asked for that when
     the whole stuff got introduced but for some reason I totally missed
     that.

  2) Fix the memcpy() in the preparatory patch which moves the set_size
     array into struct irq_affinity. Fixed up the kerneldoc comments

  3) Fixed the case for simple invocations (no sets, no callback) by
     installing a default callback which just sets nr_sets to 1 and
     transfers the number of spreadable vectors to the set_size array at
     index 0. That allows multiple consequtive invocations from the PCI
     code without having conditionals and corner case handling in the
     affinity spreading logic. IOW, it's just a variant of set handling.

     Moved the sanity check for the number of sets after the callback
     invocation so broken driver callback code is catched properly.

     The callback is now invoked with the number of spreadable interrupts
     instead of the total vectors, so the callback does not have to worry
     about the pre/post_vector reservation at all.

  4) Simplified the NVME callback logic further and brought the adjustments
     of the number of sets back which got dropped accidentaly.

  5) Remove all workarounds and leftovers of the old set support because
     from now on multiple interrupt sets can only be supported when a
     driver callback is supplied. Checking irq_affinity::nr_sets and the
     callback does not make any sense now.

On top of that I added the two patches which I postponed due to Ming's
work. They add support for marking a set unmanaged. This was asked for
the MegaSaS folks (Cc'ed) so they can request one managed set for the
normal multi queue logic and one unmanaged set for special driver specific
interrupts. The unmanaged set is spread out in the usual way, but not
marked managed and therefore the interrupts are treated as regular device
interrupts like the pre/post vectors.

Ming, thanks for the great work and your patience. I picked that up and
fixed up the missing bits only because my deadline for 5.1 feature patches
is basically tomorrow and not because I'm disappointed with your
work. Quite the contrary!

As I dropped the reviewed/acked-by's due to some fundamental changes,
can I ask everyone to have an eye on the set again please? Especially
the NVME callback needs some scrunity, it looks way too simple now :)

Some testing would be appreciated as well.

Thanks,

	tglx

8<----------------
 drivers/nvme/host/pci.c         |  111 ++++++++++------------------------------
 drivers/pci/msi.c               |   32 +++--------
 drivers/scsi/be2iscsi/be_main.c |    2 
 include/linux/interrupt.h       |   35 ++++++++----
 include/linux/pci.h             |    4 -
 kernel/irq/affinity.c           |  107 +++++++++++++++++++++-----------------
 6 files changed, 126 insertions(+), 165 deletions(-)
