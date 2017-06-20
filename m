From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 20 Jun 2017 11:35:32 -0600
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <59FF0C04-2BFB-4F66-81BA-A598A9A087FC@oracle.com>
References: <779753075.36035391.1495025796237.JavaMail.zimbra@kalray.eu>
 <20170518133439.GD3616@mtr-leonro.local>
 <CAANLjFrCLpX3nb3q7LpFPpLJKciU+1Hvmt_hxyTovQJM2-zQmg@mail.gmail.com>
 <6073e553-e8c2-6d14-ba5d-c2bd5aff15eb@grimberg.me>
 <20170620074639.GP17846@mtr-leonro.local>
 <1c706958-992e-b104-6bae-4a6616c0a9f9@grimberg.me>
 <20170620083309.GQ17846@mtr-leonro.local>
 <bd0b986f-9bed-3dfa-7454-0661559a527b@grimberg.me>
 <614481c7-22dd-d93b-e97e-52f868727ec3@grimberg.me>
 <59FF0C04-2BFB-4F66-81BA-A598A9A087FC@oracle.com>
Message-ID: <20170620173532.GA827@obsidianresearch.com>

On Tue, Jun 20, 2017@01:01:39PM -0400, Chuck Lever wrote:

> >> Shouldn't this be protected somehow by the device?
> >> Can someone explain why the above cannot happen? Jason? Liran? Anyone?
> >> Say host register MR (a) and send (1) from that MR to a target,
> >> send (1) ack got lost, and the target issues SEND_WITH_INVALIDATE
> >> on MR (a) and the host HCA process it, then host HCA timeout on send (1)
> >> so it retries, but ehh, its already invalidated.

I'm not sure I understand the example.. but...

If you pass a MR key to a send, then that MR must remain valid until
the send completion is implied by an observation on the CQ. The HCA is
free to re-execute the SEND against the MR at any time up until the
completion reaches the CQ.

As I've explained before, a ULP must not use 'implied completion', eg
a receive that could only have happened if the far side got the
send. In particular this means it cannot use an incoming SEND_INV/etc
to invalidate an MR associated with a local SEND, as that is a form
of 'implied completion'

For sanity a MR associated with a local send should not be remote
accessible at all, and shouldn't even have a 'rkey', just a 'lkey'.

Similarly, you cannot use a MR with SEND and remote access sanely, as
the far end could corrupt or invalidate the MR while the local HCA is
still using it.

> So on occasion there is a Remote Access Error. That would
> trigger connection loss, and the retransmitted Send request
> is discarded (if there was externally exposed memory involved
> with the original transaction that is now invalid).

Once you get a connection loss I would think the state of all the MRs
need to be resync'd. Running through the CQ should indicate which ones
are invalidate and which ones are still good.

> NFS has a duplicate replay cache. If it sees a repeated RPC
> XID it will send a cached reply. I guess the trick there is
> to squelch remote invalidation for such retransmits to avoid
> spurious Remote Access Errors. Should be rare, though.

.. and because of the above if a RPC is re-issued it must be re-issued
with corrected, now-valid rkeys, and the sender must somehow detect
that the far side dropped it for replay and tear down the MRs.

> RPC-over-RDMA uses persistent registration for its inline
> buffers. The problem there is avoiding buffer reuse to soon.
> Otherwise a garbled inline message is presented on retransmit.
> Those would probably not be caught by the DRC.

We've had this discussion on the list before. You can *never* re-use a
SEND, or RDMA WRITE buffer until you observe the HCA is done with it
via a CQ poll.

> But the real problem is preventing retransmitted Sends from
> causing a ULP request to be executed multiple times.

IB RC guarentees single delivery for SEND, so that doesn't seem
possible unless the ULP re-transmits the SEND on a new QP.

> > Signalling all send completions and also finishing I/Os only after
> > we got them will add latency, and that sucks...

There is no choice, you *MUST* see the send completion before
reclamining any resources associated with the send. Only the
completion guarentees that the HCA will not resend the packet or
otherwise continue to use the resources.

> With FRWR, won't subsequent WRs be delayed until the HCA is
> done with the Send? I don't think a signal is necessary in
> every case. Send Queue accounting currently relies on that.

No. The SQ side is asynchronous to the CQ side, the HCA will pipeline
send packets on the wire up to some internal limit.

Only the local state changed by FRWR related op codes happens
sequentially with other SQ work.

Jason
