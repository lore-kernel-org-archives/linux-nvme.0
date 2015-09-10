From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 10 Sep 2015 18:22:47 -0400
Subject: [PATCH 3/4] block: Refuse adding appending a gaped integrity page
 to a bio
In-Reply-To: <55F1490C.7050105@dev.mellanox.co.il> (Sagi Grimberg's message of
 "Thu, 10 Sep 2015 12:10:36 +0300")
References: <1441297703-10753-1-git-send-email-sagig@mellanox.com>
 <1441297703-10753-4-git-send-email-sagig@mellanox.com>
 <yq1a8t2amtj.fsf@sermon.lab.mkp.net>
 <55EBEF5B.3030608@dev.mellanox.co.il>
 <yq137yo6a78.fsf@sermon.lab.mkp.net>
 <55F1490C.7050105@dev.mellanox.co.il>
Message-ID: <yq1twr13oeg.fsf@sermon.lab.mkp.net>

>>>>> "Sagi" == Sagi Grimberg <sagig at dev.mellanox.co.il> writes:

>> For some workloads I think bouncing is inevitable by virtue of the PI
>> payload being teeny tiny by design.

Sagi> I see. I guess we can bounce DIX data, but is it always "right" to
Sagi> bounce? I don't know, as you say, it is workload dependent.

The right place to make that call, I guess, is in
bio_integrity_add_page() based on whether we exceed any of the
constraints set by the LLD.

-- 
Martin K. Petersen	Oracle Linux Engineering
