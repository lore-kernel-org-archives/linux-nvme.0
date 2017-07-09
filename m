From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Sun, 9 Jul 2017 10:47:55 -0600
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <9E30754F-464A-4B62-ADE7-F6B2F6D95763@oracle.com>
References: <4f0812f1-0067-4e63-e383-b913ee1f319d@grimberg.me>
 <28F6F58E-B6F4-4114-8DFF-B72353CE814B@oracle.com>
 <52ad3547-efcf-f428-6b39-117efda3379f@grimberg.me>
 <9990B5CB-E0FF-481E-9F34-21EACF0E796E@oracle.com>
 <f1f1a68c-90db-e6bf-e35e-55c4b469c339@grimberg.me>
 <7D1C540B-FEA0-4101-8B58-87BCB7DB5492@oracle.com>
 <66b1b8be-e506-50b8-c01f-fa0e3cea98a4@grimberg.me>
 <9D8C7BC8-7E18-405A-9017-9DB23A6B5C15@oracle.com>
 <11aa1a24-9f0b-dbb8-18eb-ad357c7727b2@grimberg.me>
 <9E30754F-464A-4B62-ADE7-F6B2F6D95763@oracle.com>
Message-ID: <20170709164755.GB3058@obsidianresearch.com>

On Sun, Jul 02, 2017@02:17:52PM -0400, Chuck Lever wrote:

> I could kmalloc the SGE array instead, signal each Send,
> and then in the Send completion handler, unmap the SGEs
> and then kfree the SGE array. That's a lot of overhead.

Usually after allocating the send queue you'd pre-allocate all the
tracking memory needed for each SQE - eg enough information to do the
dma unmaps/etc?

> Or I could revert all the "map page cache pages" logic and
> just use memcpy for small NFS WRITEs, and RDMA the rest of
> the time. That keeps everything simple, but means large
> inline thresholds can't use send-in-place.

Don't you have the same problem with RDMA WRITE?

Jason
