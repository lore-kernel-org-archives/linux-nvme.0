From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 31 Jul 2017 14:18:02 +0300
Subject: [PATCH V3] nvme-pci: add sgl support
In-Reply-To: <20170731071309.GD8674@localhost.localdomain>
References: <20170726181931.21150-1-chaitanya.kulkarni@hgst.com>
 <4af4843c-1f8e-3b97-af79-ec065dbffd5b@grimberg.me>
 <20170731071309.GD8674@localhost.localdomain>
Message-ID: <5061fd1e-664f-59ce-ef10-9daaa13f92b2@grimberg.me>


>> The fact that you introduce a sgl_threshold implies that prps
>> are better than sgls for small I/O sizes, are sgls better
>> than prps to large I/O size?
> 
> It can't possibly be just a matter of the IO size. It must be a matter of
> physical continuity as well. Considering that each SG entry is twice the
> size of a PRP entry, PRP must be faster for a physically discontiguous
> buffer if only because the PRP list is half the size.

Fully agree

> I've no device to test with, but I'd guess SGL is only better if the
> number of SGE's happens to be less than half the number of the equivalent
> PRP entries. Something like this:
> 
>    if (iod->nents <= ((blk_rq_bytes(req) / dev->page_size) / 2))
>      /* Use SGL */
>    else
>      /* Use PRP */

That's a device character really. I don't think we can/should come up
with heuristics that matches all the devices out there...
