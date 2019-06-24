From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Mon, 24 Jun 2019 19:30:40 -0400
Subject: [PATCH v3 2/3] nvmet: Export NVMe namespace attributes
In-Reply-To: <7e51e415-16af-2fc5-42e9-ebd0e6f94c0e@acm.org> (Bart Van Assche's
 message of "Fri, 21 Jun 2019 08:19:04 -0700")
References: <20190617161222.253849-1-bvanassche@acm.org>
 <20190617161222.253849-3-bvanassche@acm.org>
 <yq1a7eeusa5.fsf@oracle.com>
 <68786de5-cdd8-c6d8-98a7-8a4310dac789@acm.org>
 <yq1blyrpupw.fsf@oracle.com>
 <7e51e415-16af-2fc5-42e9-ebd0e6f94c0e@acm.org>
Message-ID: <yq136jyo927.fsf@oracle.com>


Hi Bart,

> As you must have noticed the patch at the start of this thread touches
> both the bdev and the file backends. So I'm not sure what your
> question is about?

I was contemplating what the observed I/O atomicity would be for the
initiator side when the target file backend is using buffered I/O.

-- 
Martin K. Petersen	Oracle Linux Engineering
