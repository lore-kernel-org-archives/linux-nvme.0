From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 14 Jul 2015 14:41:43 -0400
Subject: Partitions and end-to-end protection
In-Reply-To: <20150714180634.GB10203@infradead.org> (Christoph Hellwig's
 message of "Tue, 14 Jul 2015 11:06:34 -0700")
References: <55A40881.5000108@ranbarg.com>
 <alpine.LNX.2.00.1507131909210.15930@localhost.lm.intel.com>
 <20150714180634.GB10203@infradead.org>
Message-ID: <yq1a8uyshso.fsf@sermon.lab.mkp.net>

>>>>> "Christoph" == Christoph Hellwig <hch at infradead.org> writes:

>> The driver did it this way because we need a disk allocated before we
>> can subscribe to block integrity extensions.

The gendisk is a prerequisite by virtue of the integrity profile hanging
off of it. What I don't understand is why you do this capacity
zeroing/revalidate business in the first place?

-- 
Martin K. Petersen	Oracle Linux Engineering
