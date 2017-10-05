From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 5 Oct 2017 00:52:49 -0700
Subject: [PATCH] nvmet: bump NVMET_NR_QUEUES to 128
In-Reply-To: <ee9de017-69e9-670e-b763-1eea73598d66@gmail.com>
References: <20170911231450.20409-1-jsmart2021@gmail.com>
 <20170914170300.GA1235@infradead.org>
 <ee9de017-69e9-670e-b763-1eea73598d66@gmail.com>
Message-ID: <20171005075249.GB25401@infradead.org>

On Thu, Sep 14, 2017@11:36:48AM -0700, James Smart wrote:
> On 9/14/2017 10:03 AM, Christoph Hellwig wrote:
> > This looks ok as a quick check, but any chance you could send
> > a patch to make this configurable through configfs?  Preferably
> > also for the max queue size.
> 
> Yep - I'll put one together

Did you get a chance to look at that?
