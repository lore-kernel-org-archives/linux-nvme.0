From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 28 Nov 2017 23:21:57 +0900
Subject: [PATCH] nvme-cli: add new HMB identify fields of TP 4002
In-Reply-To: <20171128130411.GA1822@infradead.org>
References: <1511870207-17033-1-git-send-email-minwoo.im.dev@gmail.com>
 <20171128123736.GA1736@infradead.org>
 <CAA7jztfaOPPMONxSZi+uMbdFAMqmxE7cESpX4kFH_-36R1FQSg@mail.gmail.com>
 <20171128130411.GA1822@infradead.org>
Message-ID: <CAA7jztdL1E5zaPDzQc3FtJ-mfuiY09QZ_n+xeP1wtssN+Gszfg@mail.gmail.com>

On Tue, Nov 28, 2017@10:04 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Nov 28, 2017@09:58:59PM +0900, Minwoo Im wrote:
>> I'm sorry for making confusions because of the numbering of reserved field.
>> It should be started with 338 instead of 332.
>>
>> The following patch will be good to be reviewed.
>
> To make things easier it might be a good idea to start by copying
> over nvme.h from the kernel as a first commit.

Hi Christoph,

I really appreciate your suggestion for a good idea of nvme.h.
I'm going to send a patch for a sync of nvme.h with kernel's to be reviewed.
After that, I'll send this kind of patch of "HMB identify fields" again.

If I've got anything wrong or misunderstood from your review, please
feel free to let me know.

Thanks,
