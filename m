From: hch@lst.de (Christoph Hellwig)
Date: Fri, 19 May 2017 10:57:49 +0200
Subject: spread MSI(-X) vectors to all possible CPUs V2
Message-ID: <20170519085756.29742-1-hch@lst.de>

Hi all,

this series changes our automatic MSI-X vector assignment so that it
takes all present CPUs into account instead of all online ones.  This
allows to better deal with cpu hotplug events, which could happen
frequently due to power management for example.

Changes since V1:
 - rebase to current Linus' tree
 - add irq_lock_sparse calls
 - move memory allocations outside of (raw) spinlocks
 - remove the irq_force_complete_move call
 - factor some common code into helpers
 - identation fixups
