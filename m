From: chuck.lever@oracle.com (Chuck Lever)
Date: Tue, 27 Jun 2017 12:28:22 -0400
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <52ad3547-efcf-f428-6b39-117efda3379f@grimberg.me>
References: <20170620074639.GP17846@mtr-leonro.local>
 <1c706958-992e-b104-6bae-4a6616c0a9f9@grimberg.me>
 <20170620083309.GQ17846@mtr-leonro.local>
 <bd0b986f-9bed-3dfa-7454-0661559a527b@grimberg.me>
 <614481c7-22dd-d93b-e97e-52f868727ec3@grimberg.me>
 <59FF0C04-2BFB-4F66-81BA-A598A9A087FC@oracle.com>
 <20170620173532.GA827@obsidianresearch.com>
 <D3DC49A2-FFC9-4F62-8876-3E6AD5167DE5@oracle.com>
 <20170620192742.GB827@obsidianresearch.com>
 <C14B071E-F1B2-466A-82CF-4E20BFAD9DC1@oracle.com>
 <20170620211958.GA5574@obsidianresearch.com>
 <4f0812f1-0067-4e63-e383-b913ee1f319d@grimberg.me>
 <28F6F58E-B6F4-4114-8DFF-B72353CE814B@oracle.com>
 <52ad3547-efcf-f428-6b39-117efda3379f@grimberg.me>
Message-ID: <9990B5CB-E0FF-481E-9F34-21EACF0E796E@oracle.com>


> On Jun 27, 2017,@12:07 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
> 
> 
>> Go back and browse the end of the thread: there's no need to change
>> xprtrdma, and maybe no need to change the others either.
> 
> I think there is, even with inline, xprtrdma dma maps the immediate
> buffers, also the message head and tail so unmapping these buffers
> without waiting for the send completion would trigger a IOMMU access
> error (the HCA (re)tries to access an already unmapped buffer).

Thinking out loud:

IIRC the message head and tail reside in the persistently registered
and DMA mapped buffers with few exceptions.

However, when page cache pages are involved, xprtrdma will do a DMA
unmap as you say.

So:
- we don't have a problem transmitting a garbled request thanks to
  exactly-once receive semantics
- we don't have a problem with the timing of registration and
  invalidation on the initiator because the PD's DMA lkey is used
- we do have a problem with DMA unmap

Using only persistently registered and DMA mapped Send buffers
should avoid the need to signal all Sends. However, when page
cache pages are involved, then the Send needs to be signaled,
and the pages unmapped only after Send completion, to be completely
safe.

Or, the initiator should just use RDMA Read and Write, and stick
with small inline sizes.


--
Chuck Lever
