From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 27 Jun 2017 10:28:00 -0600
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <52ad3547-efcf-f428-6b39-117efda3379f@grimberg.me>
References: <614481c7-22dd-d93b-e97e-52f868727ec3@grimberg.me>
 <59FF0C04-2BFB-4F66-81BA-A598A9A087FC@oracle.com>
 <20170620173532.GA827@obsidianresearch.com>
 <D3DC49A2-FFC9-4F62-8876-3E6AD5167DE5@oracle.com>
 <20170620192742.GB827@obsidianresearch.com>
 <C14B071E-F1B2-466A-82CF-4E20BFAD9DC1@oracle.com>
 <20170620211958.GA5574@obsidianresearch.com>
 <4f0812f1-0067-4e63-e383-b913ee1f319d@grimberg.me>
 <28F6F58E-B6F4-4114-8DFF-B72353CE814B@oracle.com>
 <52ad3547-efcf-f428-6b39-117efda3379f@grimberg.me>
Message-ID: <20170627162800.GA22592@obsidianresearch.com>

On Tue, Jun 27, 2017@07:07:08PM +0300, Sagi Grimberg wrote:
> 
> >Go back and browse the end of the thread: there's no need to change
> >xprtrdma, and maybe no need to change the others either.
> 
> I think there is, even with inline, xprtrdma dma maps the immediate
> buffers, also the message head and tail so unmapping these buffers
> without waiting for the send completion would trigger a IOMMU access
> error (the HCA (re)tries to access an already unmapped buffer).

Yes, that is an excellent observation. When using the local rdma lkey
you still need to ensure the linux API DMA map remains until
completion.

send completion mitigation is still possible, if it is OK for the
backing pages to remain, but I think a more sophisticated strategy is
needed - eg maybe push some kind of NOP through the send q after a
timer or only complete when the last available work is stuffed or
something.

Jason
