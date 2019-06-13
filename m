From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 13 Jun 2019 19:57:59 -0400
Subject: [PATCH v2 3/3] nvme: Set physical block size and optimal I/O size
 according to NVMe 1.4
In-Reply-To: <fcd3b41c-38b9-4865-05c0-2f96c9382ea5@acm.org> (Bart Van Assche's
 message of "Thu, 13 Jun 2019 10:57:18 -0700 (PDT)")
References: <20190610210612.103952-1-bvanassche@acm.org>
 <20190610210612.103952-4-bvanassche@acm.org>
 <yq15zpa2que.fsf@oracle.com>
 <fcd3b41c-38b9-4865-05c0-2f96c9382ea5@acm.org>
Message-ID: <yq1blz1rqbc.fsf@oracle.com>


Bart,

> Namespace Atomic Write Unit Power Fail (NAWUPF): This field indicates
> the namespace specific size of the write operation guaranteed to be
> written atomically to the NVM during a power fail or error condition.
> A value of 0h indicates that the size for this namespace is the same
> size as that reported in the AWUPF field of the Identify Controller data
> structure. All other values specify a size in terms of logical blocks
> using the same encoding as the AWUPF field.

There's some ambiguity there. But I think you're right that the encoding
statement qualifies it. This means that there is no explicit way of
expressing a NAWUPF of 1 logical block but that is OK since it is
implied.

-- 
Martin K. Petersen	Oracle Linux Engineering
