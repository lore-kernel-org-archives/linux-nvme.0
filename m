From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 28 Jun 2017 10:16:18 +0300
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <1498586933.14963.1.camel@wdc.com>
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
 <1498586933.14963.1.camel@wdc.com>
Message-ID: <47bbf598-6c82-610f-dc1d-706a1d869b8d@grimberg.me>

> Hello Sagi,

Hi Bart,

> Can you clarify why you think that the SRP initiator needs to be changed?
> The SRP initiator submits the local invalidate work request after the RDMA
> write request. According to table 79 "Work Request Operation Ordering" the
> order of these work requests must be maintained by the HCA. I think if a HCA
> would start with invalidating the MR before the remote HCA has acknowledged
> the written data that that's a firmware bug.

That flow is fine, we were discussing immediate data sends.

SRP only needs fixing by waiting for the all local invalidates to
complete before unmapping the user buffers and completing the I/O.

BTW, did the efforts on standardizing remote invalidate in SRP ever
evolved to something? Would it be acceptable to add a non-standard
ib_srp and ib_srpt? We can default to off and allow the user to opt
it in if it knows the two sides comply...

We need to fix that in nvmf and iser too btw (luckily we have remote
invalidate so its not a big issue).

> The upstream SRP initiator does not use inline data.

Yet :)

IIRC you have a branch with immediate-data support against scst so
it might be relevant there...
