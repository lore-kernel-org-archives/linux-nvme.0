From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 20 Jun 2017 20:12:50 +0300
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <59FF0C04-2BFB-4F66-81BA-A598A9A087FC@oracle.com>
References: <9465cd0c-83db-b058-7615-5626ef60dbb0@grimberg.me>
 <20170515143632.GH3616@mtr-leonro.local>
 <20170515145952.GA7871@infradead.org>
 <20170515170506.GK3616@mtr-leonro.local>
 <779753075.36035391.1495025796237.JavaMail.zimbra@kalray.eu>
 <20170518133439.GD3616@mtr-leonro.local>
 <CAANLjFrCLpX3nb3q7LpFPpLJKciU+1Hvmt_hxyTovQJM2-zQmg@mail.gmail.com>
 <6073e553-e8c2-6d14-ba5d-c2bd5aff15eb@grimberg.me>
 <20170620074639.GP17846@mtr-leonro.local>
 <1c706958-992e-b104-6bae-4a6616c0a9f9@grimberg.me>
 <20170620083309.GQ17846@mtr-leonro.local>
 <bd0b986f-9bed-3dfa-7454-0661559a527b@grimberg.me>
 <614481c7-22dd-d93b-e97e-52f868727ec3@grimberg.me>
 <59FF0C04-2BFB-4F66-81BA-A598A9A087FC@oracle.com>
Message-ID: <5f38efc7-af8a-c27e-37ae-8f8aed3d43a4@grimberg.me>


> So on occasion there is a Remote Access Error. That would
> trigger connection loss, and the retransmitted Send request
> is discarded (if there was externally exposed memory involved
> with the original transaction that is now invalid).

I'm actually not concerned about the remote invalidation, that
is good that its discarded or failed. Its the inline sends that
are a bug here.

> But the real problem is preventing retransmitted Sends from
> causing a ULP request to be executed multiple times.

Exactly.

>> Signalling all send completions and also finishing I/Os only after we
>> got them will add latency, and that sucks...
> 
> Typically, Sends will complete before the response arrives.
> The additional cost will be handling extra interrupts, IMO.

Not quite, heavy traffic _can_ results in dropped acks, my gut
feeling is that it can happen more than we suspect.

and yea, extra interrupt, extra cachelines, extra state,
but I do not see any other way around it.

> With FRWR, won't subsequent WRs be delayed until the HCA is
> done with the Send? I don't think a signal is necessary in
> every case. Send Queue accounting currently relies on that.

Not really, the Send after the FRWR might have a fence (not strong
ordered one) and CX3/CX4 strong order FRWR so for them that is a
non-issue. The problem is that ULPs can't rely on it.

> RPC-over-RDMA relies on the completion of Local Invalidation
> to ensure that the initial Send WR is complete.

Wait, is that guaranteed?

> For Remote
> Invalidation and pure inline, there is nothing to fence that
> Send.
> 
> The question I have is: how often do these Send retransmissions
> occur? Is it enough to have a robust recovery mechanism, or
> do we have to wire in assumptions about retransmission to
> every Send operation?

Even if its rare, we don't have any way to protect against devices
retrying the send operation.
