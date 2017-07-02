From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 2 Jul 2017 12:45:26 +0300
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <9D8C7BC8-7E18-405A-9017-9DB23A6B5C15@oracle.com>
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
 <9990B5CB-E0FF-481E-9F34-21EACF0E796E@oracle.com>
 <f1f1a68c-90db-e6bf-e35e-55c4b469c339@grimberg.me>
 <7D1C540B-FEA0-4101-8B58-87BCB7DB5492@oracle.com>
 <66b1b8be-e506-50b8-c01f-fa0e3cea98a4@grimberg.me>
 <9D8C7BC8-7E18-405A-9017-9DB23A6B5C15@oracle.com>
Message-ID: <11aa1a24-9f0b-dbb8-18eb-ad357c7727b2@grimberg.me>


>> Or wait for the send completion before completing the I/O?
> 
> In the normal case, that works.
> 
> If a POSIX signal occurs (^C, RPC timeout), the RPC exits immediately
> and recovers all resources. The Send can still be running at that
> point, and it can't be stopped (without transitioning the QP to
> error state, I guess).

In that case we can't complete the I/O either (or move the
QP into error state), we need to defer/sleep on send completion.


> The alternative is reference-counting the data structure that has
> the ib_cqe and the SGE array. That adds one or more atomic_t
> operations per I/O that I'd like to avoid.

Why atomics?
