From: luto@amacapital.net (Andy Lutomirski)
Date: Mon, 29 Aug 2016 16:20:43 -0700
Subject: [PATCH 2/3] nvme: Pass pointers, not dma addresses,
 to nvme_get/set_features()
In-Reply-To: <20160829162735.GD19986@localhost.localdomain>
References: <cover.1472462539.git.luto@kernel.org>
 <2756c572e066ed91a41e35568a4d9346e47d6b42.1472462539.git.luto@kernel.org>
 <20160829162735.GD19986@localhost.localdomain>
Message-ID: <CALCETrWzfovS+kh=UsJZxNvN-_eypav+Df+NppPHt8FPPOSipw@mail.gmail.com>

On Mon, Aug 29, 2016@9:27 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Mon, Aug 29, 2016@02:25:45AM -0700, Andy Lutomirski wrote:
>> +     /*
>> +      * A controller "page" may be bigger than a Linux page, but we can
>> +      * be conservative here.
>> +      */
>
> It is the actually other way around: the Linux page may be larger than the
> controller's. We currently use the smallest possible controller page (4k)
> regardless of the host's size due to limitations discovering the CPU's
> DMA alignment. PPC was the first to encounter this problem with NVMe.

The "Set Features" command (section 5.15) Figure 103 says:

If using PRPs, this field shall not be a pointer to a PRP List as the
data buffer may not cross more than one page boundary. If no data
structure is used as part of the specified feature, then this field is
not used.

Does the Linux driver use PRPs?  Do we need to worry about kmalloc
returning a buffer that spans a 4k boundary but does not span a Linux
page boundary?

--Andy
