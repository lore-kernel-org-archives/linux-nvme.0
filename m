From: elliott@hpe.com (Elliott, Robert (Persistent Memory))
Date: Mon, 29 Jan 2018 15:41:02 +0000
Subject: [LSF/MM TOPIC] irq affinity handling for high CPU count machines
In-Reply-To: <45dc032d-a0ce-816c-d2c5-74c69433bd29@suse.de>
References: <45dc032d-a0ce-816c-d2c5-74c69433bd29@suse.de>
Message-ID: <AT5PR8401MB0387022075AF24A278FA522EABE50@AT5PR8401MB0387.NAMPRD84.PROD.OUTLOOK.COM>



> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf
> Of Hannes Reinecke
> Sent: Monday, January 29, 2018 3:09 AM
> To: lsf-pc at lists.linux-foundation.org
> Cc: linux-nvme at lists.infradead.org; linux-scsi at vger.kernel.org; Kashyap
> Desai <kashyap.desai at broadcom.com>
> Subject: [LSF/MM TOPIC] irq affinity handling for high CPU count machines
> 
> Hi all,
> 
> here's a topic which came up on the SCSI ML (cf thread '[RFC 0/2]
> mpt3sas/megaraid_sas: irq poll and load balancing of reply queue').
> 
> When doing I/O tests on a machine with more CPUs than MSIx vectors
> provided by the HBA we can easily setup a scenario where one CPU is
> submitting I/O and the other one is completing I/O. Which will result in
> the latter CPU being stuck in the interrupt completion routine for
> basically ever, resulting in the lockup detector kicking in.
> 
> How should these situations be handled?
> Should it be made the responsibility of the drivers, ensuring that the
> interrupt completion routine is terminated after a certain time?
> Should it be made the resposibility of the upper layers?
> Should it be the responsibility of the interrupt mapping code?
> Can/should interrupt polling be used in these situations?

Back when we introduced scsi-mq with hpsa, the best approach was to
route interrupts and completion handling so each CPU core handles its
own submissions; this way, they are self-throttling.

Every other arrangement was subject to soft lockups and other problems
when the completion CPUs become overwhelmed with work.

See https://lkml.org/lkml/2014/9/9/931.

---
Robert Elliott, HPE Persistent Memory
