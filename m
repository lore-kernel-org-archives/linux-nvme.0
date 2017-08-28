From: felipeapolanco@gmail.com (Felipe Arturo Polanco)
Date: Mon, 28 Aug 2017 12:53:47 -0400
Subject: NVMe driver with kernel panic
In-Reply-To: <20170828150512.GA3913@localhost.localdomain>
References: <CADcj3=5oXJzsBO7eNPNbGM+W9qKwbVBmmokY9h7-qP8butZLTg@mail.gmail.com>
 <20170821200436.GF21397@localhost.localdomain>
 <CADcj3=7aCwiOLyo9E+zUs2HqNzsED28GVLkBx5t0Sdx91cdZVA@mail.gmail.com>
 <20170828143616.GG1207@localhost.localdomain>
 <CADcj3=5W68+MJDTwCGEcTqcKfRpOw5g+h3s8jFpT7hqcZoYvxw@mail.gmail.com>
 <20170828150512.GA3913@localhost.localdomain>
Message-ID: <CADcj3=5KGXuk7RRrKeQCCfM5H-JU_C1VQTXZe2UPLZNi_bv5Gg@mail.gmail.com>

Thanks Keith,

We got in touch with the people of VzLinux since we have support with
them, they analyzed the crash core dump and sent us a patch for the
nvme driver.

They said the following:
Presence of gap is known from crashdumps, there is misaligned request.
Only first and last requests can have free space in a page.
Crashdumps pointed to such request in the middle.

We are testing the patch and so far is good, we have no way to
reproduce the crash so we can't be 100% if this prevents it.

Have you heard of related cases with misaligned requests? Maybe this
was fixed in recent versions of the kernel or module.

Thanks,

On Mon, Aug 28, 2017@11:05 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Mon, Aug 28, 2017@10:47:02AM -0400, Felipe Arturo Polanco wrote:
>> Hi,
>>
>> Sorry, I truncated the message since they were all the same, some got
>> lost because there were a lot of information per second:
>>
>> [95673.434065] systemd-journald[709]: /dev/kmsg buffer overrun, some
>> messages lost.
>> [95673.434072] sg[14] phys_addr:0x0000007d867b5000 offset:0
>> length:4096 dma_address:0x0000007d867b5000 dma_length:4096
>> [95673.434078] sg[16] phys_addr:0x0000007d867eb000 offset:0
>> length:4096 dma_address:0x0000007d867eb000 dma_length:4096
>> [95673.434085] sg[18] phys_addr:0x0000007d63e7a000 offset:0
>> length:12288 dma_address:0x0000007d63e7a000 dma_length:12288
>> [95673.434099] sg[3] phys_addr:0x0000007d867ea000 offset:0 length:4096
>> dma_address:0x0000007d867ea000 dma_length:4096
>> [95673.434103] sg[5] phys_addr:0x0000007d63e1b000 offset:0 length:4096
>> dma_address:0x0000007d63e1b000 dma_length:4096
>> [95673.434108] sg[7] phys_addr:0x0000007d867c1000 offset:0 length:4096
>> dma_address:0x0000007d867c1000 dma_length:4096
>> [95673.434116] sg[10] phys_addr:0x0000007d86d08000 offset:0
>> length:4096 dma_address:0x0000007d86d08000 dma_length:4096
>> [95673.434120] sg[12] phys_addr:0x0000007d63e8c000 offset:0
>> length:1024 dma_address:0x0000007d63e8c000 dma_length:1024
>> [95673.434129] sg[15] phys_addr:0x0000007d8679f000 offset:0
>> length:4096 dma_address:0x0000007d8679f000 dma_length:4096
>> [95673.434137] sg[18] phys_addr:0x0000007d63e7a000 offset:0
>> length:12288 dma_address:0x0000007d63e7a000 dma_length:12288
>> [95673.434143] sg[1] phys_addr:0x0000007d8a4e8000 offset:0 length:4096
>> dma_address:0x0000007d8a4e8000 dma_length:4096
>> [95673.434149] sg[4] phys_addr:0x0000003c8d25e000 offset:0 length:4096
>> dma_address:0x0000003c8d25e000 dma_length:4096
>>
>> It was logs and logs of this.
>
> Hm, I won't be able to piece this together with missing and interleaved
> messages.  The code was supposed to just warn and print the sgl
> once, but it looks like "WARN_ONCE" returns true even if we already
> warned on that condition... I'll see if we can fix this.
