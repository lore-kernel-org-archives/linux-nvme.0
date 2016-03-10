From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Thu, 10 Mar 2016 12:08:48 +0100 (CET)
Subject: [PATCH] nvme: avoid cqe corruption when update at the same time
 as read
In-Reply-To: <20160309170846.GA14926@infradead.org>
References: <1963234885.1121305.1457109031908.JavaMail.zimbra@kalray.eu>
 <1380738962.1128342.1457162595145.JavaMail.zimbra@kalray.eu>
 <20160309170846.GA14926@infradead.org>
Message-ID: <881149974.3314758.1457608128188.JavaMail.zimbra@kalray.eu>


----- Le 9 Mar 16, ? 18:08, Christoph Hellwig hch at infradead.org a ?crit :

> On Sat, Mar 05, 2016@08:23:15AM +0100, Marta Rybczynska wrote:
>> The cqe structure read normally happens from lower to upper addresses
>> and the validity bit (status) is at the highest address. If the PCI
>> updates the memory when the cqe is read by multiple non-atomic loads,
>> the structure may be corrupted. Avoid this by reading the status
>> first and then the whole structure.
> 
> Doing the phase check separately sounds sensible to me, but how about
> doing something like the version below, which ensures we only read the
> whole cqe after the check, and cleans things up a bit by using a common
> helper:
> 

Looks like a good refactoring to me. However, it seems to me that in
nvme_cqe_valid we should be checking for phase, not for head.

I will test it and re-submit.

Regards,
Marta Rybczynska
