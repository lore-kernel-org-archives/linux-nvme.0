From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 20 Jun 2019 21:56:11 -0400
Subject: [PATCH v3 2/3] nvmet: Export NVMe namespace attributes
In-Reply-To: <68786de5-cdd8-c6d8-98a7-8a4310dac789@acm.org> (Bart Van Assche's
 message of "Wed, 19 Jun 2019 08:44:41 -0700")
References: <20190617161222.253849-1-bvanassche@acm.org>
 <20190617161222.253849-3-bvanassche@acm.org>
 <yq1a7eeusa5.fsf@oracle.com>
 <68786de5-cdd8-c6d8-98a7-8a4310dac789@acm.org>
Message-ID: <yq1blyrpupw.fsf@oracle.com>


Bart,

> Are you perhaps referring to the parameter that can be specified as
> command-line option -b to mkfs? I'm not sure that we should report
> that size as the physical block size since that parameter can be set
> to a value that is much larger than the physical block size of the
> storage medium (in the target system).

An admin can create all sorts of weird configurations by twiddling
options. But trying to match the physical block size is one of the
heuristics for mkfs.

Also, I haven't actually looked at the code, but what happens with the
buffered I/O backend?

-- 
Martin K. Petersen	Oracle Linux Engineering
