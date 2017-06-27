From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 27 Jun 2017 10:37:14 +0300
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <20170620211958.GA5574@obsidianresearch.com>
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
Message-ID: <4f0812f1-0067-4e63-e383-b913ee1f319d@grimberg.me>

Jason,

>> The issue about the HCA not being able to access the inline
>> buffer during a retransmit is also not an issue for RPC-
>> over-RDMA because these buffers are always registered with
>> the local rdma lkey.
> 
> Exactly.

Lost track of the thread...


Indeed you raised this issue lots of times before, and I failed to see
why its important or why its error prone, but now I do...

My apologies for not listening :(

We should fix _all_ initiators for it, nvme-rdma, iser, srp
and xprtrdma (and probably some more ULPs out there)...

It also means that we cannot really suppress any send completions as
that would result in an unpredictable latency (which is not acceptable).

I wish we could somehow tell the HCA that it can ignore access fail to a
specific address when retransmitting.. but maybe its too much to ask...
