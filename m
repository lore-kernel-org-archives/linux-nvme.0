From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 21 Jun 2019 08:19:04 -0700
Subject: [PATCH v3 2/3] nvmet: Export NVMe namespace attributes
In-Reply-To: <yq1blyrpupw.fsf@oracle.com>
References: <20190617161222.253849-1-bvanassche@acm.org>
 <20190617161222.253849-3-bvanassche@acm.org> <yq1a7eeusa5.fsf@oracle.com>
 <68786de5-cdd8-c6d8-98a7-8a4310dac789@acm.org> <yq1blyrpupw.fsf@oracle.com>
Message-ID: <7e51e415-16af-2fc5-42e9-ebd0e6f94c0e@acm.org>

On 6/20/19 6:56 PM, Martin K. Petersen wrote:
> Also, I haven't actually looked at the code, but what happens with the
> buffered I/O backend?

Hi Martin,

The NVMe target code supports two types of backends: "bdev" and "file". 
The file backend code does not set the IOCB_DIRECT flag. So I assume 
that "buffered I/O backend" refers to the file backend? As you must have 
noticed the patch at the start of this thread touches both the bdev and 
the file backends. So I'm not sure what your question is about?

Bart.
