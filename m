From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 Mar 2018 11:42:20 -0700
Subject: [PATCH rfc] nvme-pci: make sure to flush sqe writes before db
 record update
In-Reply-To: <20180308183623.GE6785@ziepe.ca>
References: <20180307175626.15222-1-sagi@grimberg.me>
 <20180308155147.GD3766@localhost.localdomain>
 <20180308172018.GA6785@ziepe.ca>
 <c6a92092-f1f0-cf3c-3f34-fe5904d9718b@grimberg.me>
 <20180308183623.GE6785@ziepe.ca>
Message-ID: <20180308184220.GA6163@localhost.localdomain>

On Thu, Mar 08, 2018@11:36:23AM -0700, Jason Gunthorpe wrote:
> On Thu, Mar 08, 2018@07:56:37PM +0200, Sagi Grimberg wrote:
> > If the SQE and DB update have been reordered,
> 
> But that can't happen, the SQE is written before
> nvme_dbbuf_update_and_check_event(), and that function does wmb.

I believe Sagi is talking about the typical controller that doesn't
have shadow db registers (no real nvme device has those), which doesn't
currently go through a path calling wmb().
