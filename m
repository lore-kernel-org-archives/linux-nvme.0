From: hch@lst.de (Christoph Hellwig)
Date: Sun, 5 Feb 2017 17:40:23 +0100
Subject: [PATCH 1/6] genirq: allow assigning affinity to present but
 not online CPUs
In-Reply-To: <20170204015809.GA16203@zipoli.ccur.kvm>
References: <t6NbP-2IT-5@gated-at.bofh.it> <t6NbP-2IT-13@gated-at.bofh.it>
 <20170204015809.GA16203@zipoli.ccur.kvm>
Message-ID: <20170205164023.GA9281@lst.de>

Hi Joe,

On Fri, Feb 03, 2017@08:58:09PM -0500, Joe Korty wrote:
> IIRC, some years ago I ran across a customer system where
> the #cpus_present was twice as big as #cpus_possible.
> 
> Hyperthreading was turned off in the BIOS so it was not
> entirely out of line for the extra cpus to be declared
> present, even though none of them would ever be available
> for use.

This sounds like a system we should quirk around instead of optimizing
for it.  Unless I totally misunderstand the idea behind cpu_possible
and cpu_present.
