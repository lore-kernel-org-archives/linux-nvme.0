From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Apr 2017 08:34:26 +0200
Subject: [PATCH rfc 0/6] Automatic affinity settings for nvme over rdma
In-Reply-To: <14fd128d-7155-ab13-492f-952f072808d5@opengridcomputing.com>
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
 <14fd128d-7155-ab13-492f-952f072808d5@opengridcomputing.com>
Message-ID: <20170412063426.GA20883@lst.de>

On Mon, Apr 10, 2017@01:05:50PM -0500, Steve Wise wrote:
> I'll test cxgb4 if you convert it. :)

That will take a lot of work.  The problem with cxgb4 is that it
allocatesd all the interrupts at device enable time, but then only
allocates them to ULDs when they attached, while this scheme assumes
as way to map out queues / vectors at initialization time.
