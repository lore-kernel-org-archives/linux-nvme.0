From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 08 Sep 2015 14:24:27 -0400
Subject: [PATCH 3/4] block: Refuse adding appending a gaped integrity page
 to a bio
In-Reply-To: <55EBEF5B.3030608@dev.mellanox.co.il> (Sagi Grimberg's message of
 "Sun, 6 Sep 2015 10:46:35 +0300")
References: <1441297703-10753-1-git-send-email-sagig@mellanox.com>
 <1441297703-10753-4-git-send-email-sagig@mellanox.com>
 <yq1a8t2amtj.fsf@sermon.lab.mkp.net>
 <55EBEF5B.3030608@dev.mellanox.co.il>
Message-ID: <yq137yo6a78.fsf@sermon.lab.mkp.net>

>>>>> "Sagi" == Sagi Grimberg <sagig at dev.mellanox.co.il> writes:

Sagi,

Sagi> So given that this is a bug fix (was completely not handled
Sagi> before) I think we should make an incremental progress towards
Sagi> getting it right.  Are you fine with that?

Yeah, I don't have an objection to your changes.

Sagi> Now, given that drivers which set virt_boundary won't be able to
Sagi> accept 8-byte sg elements for DIX, would you prefer it being
Sagi> bounced rather than refusing the merge? This would require some
Sagi> additional logic given that we won't want to bounce on every merge
Sagi> attempt but only when the request is kicked?

For some workloads I think bouncing is inevitable by virtue of the PI
payload being teeny tiny by design. I don't mind that happening in block
as opposed to the driver. This would also help things like NVMe.

-- 
Martin K. Petersen	Oracle Linux Engineering
