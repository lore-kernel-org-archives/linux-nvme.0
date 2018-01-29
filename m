From: hare@suse.de (Hannes Reinecke)
Date: Mon, 29 Jan 2018 10:08:43 +0100
Subject: [LSF/MM TOPIC] irq affinity handling for high CPU count machines
Message-ID: <45dc032d-a0ce-816c-d2c5-74c69433bd29@suse.de>

Hi all,

here's a topic which came up on the SCSI ML (cf thread '[RFC 0/2]
mpt3sas/megaraid_sas: irq poll and load balancing of reply queue').

When doing I/O tests on a machine with more CPUs than MSIx vectors
provided by the HBA we can easily setup a scenario where one CPU is
submitting I/O and the other one is completing I/O. Which will result in
the latter CPU being stuck in the interrupt completion routine for
basically ever, resulting in the lockup detector kicking in.

How should these situations be handled?
Should it be made the responsibility of the drivers, ensuring that the
interrupt completion routine is terminated after a certain time?
Should it be made the resposibility of the upper layers?
Should it be the responsibility of the interrupt mapping code?
Can/should interrupt polling be used in these situations?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
