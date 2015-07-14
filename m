From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 14 Jul 2015 14:58:17 -0400
Subject: Partitions and end-to-end protection
In-Reply-To: <20150714184344.GA29437@infradead.org> (Christoph Hellwig's
 message of "Tue, 14 Jul 2015 11:43:44 -0700")
References: <55A40881.5000108@ranbarg.com>
 <alpine.LNX.2.00.1507131909210.15930@localhost.lm.intel.com>
 <20150714180634.GB10203@infradead.org>
 <yq1a8uyshso.fsf@sermon.lab.mkp.net>
 <20150714184344.GA29437@infradead.org>
Message-ID: <yq11tgash12.fsf@sermon.lab.mkp.net>

>>>>> "Christoph" == Christoph Hellwig <hch at infradead.org> writes:

>> The gendisk is a prerequisite by virtue of the integrity profile
>> hanging off of it.

Christoph> Having one allocated is.  But why do we need to have it added
Christoph> (at which point it is live)?

Well, we're poking at the queue (for block size) and the bdi. I guess we
could split things up and have another function to twiddle these
parameters separately. During revalidate, perhaps.

But the fundamental question remains: Why is it a prerequisite for the
NVMe integrity profile to be added before the disk is live? Nobody else
requires this (sd, md, dm).

-- 
Martin K. Petersen	Oracle Linux Engineering
