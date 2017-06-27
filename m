From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 27 Jun 2017 12:14:14 -0600
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <1498586933.14963.1.camel@wdc.com>
References: <bd0b986f-9bed-3dfa-7454-0661559a527b@grimberg.me>
 <614481c7-22dd-d93b-e97e-52f868727ec3@grimberg.me>
 <59FF0C04-2BFB-4F66-81BA-A598A9A087FC@oracle.com>
 <20170620173532.GA827@obsidianresearch.com>
 <D3DC49A2-FFC9-4F62-8876-3E6AD5167DE5@oracle.com>
 <20170620192742.GB827@obsidianresearch.com>
 <C14B071E-F1B2-466A-82CF-4E20BFAD9DC1@oracle.com>
 <20170620211958.GA5574@obsidianresearch.com>
 <4f0812f1-0067-4e63-e383-b913ee1f319d@grimberg.me>
 <1498586933.14963.1.camel@wdc.com>
Message-ID: <20170627181414.GA5578@obsidianresearch.com>

On Tue, Jun 27, 2017@06:08:57PM +0000, Bart Van Assche wrote:

> Can you clarify why you think that the SRP initiator needs to be changed?
> The SRP initiator submits the local invalidate work request after the RDMA
> write request. According to table 79 "Work Request Operation
> Ordering" the

That table has a 'L' for invalidate that follows RDMA Write.

L means they are not ordered unless the optional Local Invalidate
Fence mode is used.

Jason
