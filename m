From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 20 Jun 2017 15:19:58 -0600
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <C14B071E-F1B2-466A-82CF-4E20BFAD9DC1@oracle.com>
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
Message-ID: <20170620211958.GA5574@obsidianresearch.com>

On Tue, Jun 20, 2017@04:56:39PM -0400, Chuck Lever wrote:

> > I thought the use of MR's with SEND was a new invention? If you use
> > the local rdma lkey with send, it is never invalidated, and this is
> > not an issue, which IIRC, was the historical configuration for NFS.
> 
> We may be conflating things a bit.
> 
> RPC-over-RDMA client uses persistently registered buffers, using
> the lkey, for inline data. The use of MRs is reserved for NFS READ
> and WRITE payloads. The inline buffers are never explicitly
> invalidated by RPC-over-RDMA.

That makes much more sense, but is that the original question in this
thread? Why are we even talking about invalidate ordering then?

> > All ULPs must ensure SEND/RDMA Write resources remain stable until the
> > CQ indicates that work is completed. 'In a perfect world' this
> > includes not changing the source memory as that would cause
> > retransmitted packets to be different.
> 
> I assume you mean the sending side (the server) for RDMA
> Write. I believe rdma_rw uses the local rdma lkey by default
> for RDMA Write source buffers.

RDMA Write or SEND

> >>> No. The SQ side is asynchronous to the CQ side, the HCA will pipeline
> >>> send packets on the wire up to some internal limit.
> >> 
> >> So if my ULP issues FastReg followed by Send followed by
> >> LocalInv (signaled), I can't rely on the LocalInv completion
> >> to imply that the Send is also complete?
> > 
> > Correct.
> > 
> > This is explicitly defined in Table 79 of the IBA.
> > 
> > It describes the ordering requirements, if you order Send followed by
> > LocalInv the ordering is 'L' which means they are not ordered unless
> > the WR has the Local Invalidate Fence bit set.
> > 
> > LIF is an optional feature, I do not know if any of our hardware
> > supports it, but it is defined to cause the local invalidate to wait
> > until all ongoing references to the MR are completed.
> 
> Now, since there was confusion about using an MR for a
> Send operation, let me clarify. If the client does:

> FastReg(payload buffer)
> Send(inline buffer)
> ...
> Recv
> LocalInv(payload buffer)
> wait for LI completion

Not sure what you are describing?

Is Recv landing memory for a SEND? In that case it is using a lkey,
lkeys are not remotely usable, so it does not need synchronous
invalidation. In all cases the LocalInv must only be posted once a CQE
for the Recv is observed.

If Recv is RDMA WRITE target memory, then it using the rkey and it
does does need synchronous invalidation. This must be done once a recv
CQE is observed, or optimized by having the other send via one of the
_INV operations.

In no case can you pipeline a LocalInv into the SQ that would impact
RQ activity, even with any of the fences.

> Is setting IB_SEND_FENCE on the LocalInv enough to ensure
> that the Send is complete?

No.

There are two fences in the spec, IB_SEND_FENCE is the mandatory one,
and it only interacts with RDMA READ and ATOMIC entries.

Local Invalidate Fence (the optinal one) also will not order the two
because LIF is only defined to order against SQE's that use the
MR. Since Send is using the global dma lkey it does not interact with
the LocalInv and LIF will not order them.

> > No idea on the relative performance of LIF vs doing it manually, but
> > the need for one or the other is unambigously clear in the spec.
> 
> It seems to me that the guarantee that the server sees
> only one copy of the Send payload is good enough. That
> means that by the time Recv completion occurs on the
> client, even if the client HCA still thinks it needs to
> retransmit the Send containing the RPC Call, the server
> ULP has already seen and processed that Send payload,
> and the HCA on the server won't deliver that payload a
> second time.

Yes, that is OK reasoning.

> If the only concern about preserving that inline buffer is
> guaranteeing that retransmits contain the same content, I
> don't think we have a problem. All HCA retransmits of an
> RPC Call, until the matching RPC Reply is received on the
> client, will contain the same content.

Right.

> The issue about the HCA not being able to access the inline
> buffer during a retransmit is also not an issue for RPC-
> over-RDMA because these buffers are always registered with
> the local rdma lkey.

Exactly.

Jason
