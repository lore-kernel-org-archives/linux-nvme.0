From: luto@amacapital.net (Andy Lutomirski)
Date: Tue, 30 Aug 2016 09:00:33 -0700
Subject: [PATCH 2/3] nvme: Pass pointers, not dma addresses,
 to nvme_get/set_features()
In-Reply-To: <20160830063651.GA32323@lst.de>
References: <cover.1472462539.git.luto@kernel.org>
 <2756c572e066ed91a41e35568a4d9346e47d6b42.1472462539.git.luto@kernel.org>
 <20160829162735.GD19986@localhost.localdomain>
 <CALCETrWzfovS+kh=UsJZxNvN-_eypav+Df+NppPHt8FPPOSipw@mail.gmail.com>
 <20160830063651.GA32323@lst.de>
Message-ID: <CALCETrX_A9t1zb_WjpKG23uGM_872qKoLgc1pkG5KWxQO_Kw2w@mail.gmail.com>

On Mon, Aug 29, 2016@11:36 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Aug 29, 2016@04:20:43PM -0700, Andy Lutomirski wrote:
>> The "Set Features" command (section 5.15) Figure 103 says:
>>
>> If using PRPs, this field shall not be a pointer to a PRP List as the
>> data buffer may not cross more than one page boundary. If no data
>> structure is used as part of the specified feature, then this field is
>> not used.
>>
>> Does the Linux driver use PRPs?
>
> The Linux PCIe driver always uses PRPs - and for admin command only
> Fabrics can use SGLs anyway.
>
>> Do we need to worry about kmalloc
>> returning a buffer that spans a 4k boundary but does not span a Linux
>> page boundary?
>
> Isn't kmalloc supposed to return naturally aligned buffers?

>From brief inspection of the code, it looks like kmalloc always
returns a pointer aligned to a biggest power of two that can hold the
allocation except when it uses 96-byte or 192-byte alignment.  96 and
192 don't divide 4k.

However, I think this is all moot because I misunderstood the spec.  It says:

Data Pointer (DPTR): This field specifies the start of the data
buffer. Refer to Figure 11 for the
definition of this field. If using PRPs, this field shall not be a
pointer to a PRP List as the data buffer
may not cross more than one page boundary. If no data structure is
used as part of the specified
feature, then this field is not used.

It doesn't say "may not cross a page boundary" -- it says it may not
cross *more than one* page boundary.  I think that all it's trying to
say is that there aren't any features that have buffers larger than a
page, so no matter how they're aligned there are at most two PRP
entries, and two PRP entries can be expressed without a PRP List.

So I'm just going to remove the warning.

--Andy
