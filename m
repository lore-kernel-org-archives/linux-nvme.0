From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 6 Jun 2019 17:43:41 +0900
Subject: [RFC PATCH V6 1/3] nvmet: introduce nvmet_req_to_ctrl to get
 ctrl instance
In-Reply-To: <20190606064848.GF27033@lst.de>
References: <20190606063229.17258-1-minwoo.im.dev@gmail.com>
 <20190606063229.17258-2-minwoo.im.dev@gmail.com>
 <20190606064848.GF27033@lst.de>
Message-ID: <20190606084341.GA18020@minwooim-desktop>

On 19-06-06 08:48:48, Christoph Hellwig wrote:
> On Thu, Jun 06, 2019@03:32:27PM +0900, Minwoo Im wrote:
> > nvme host driver can get the controller instance from
> > nvme_req(req)->ctrl.  In case of target driver, it needs to get
> > controller instance from the struct nvmet_req with sq where the request
> > has been submitted.
> 
> Note that normally we can just dereference ->sq just fine, as it only
> isn't set in the low-level code before accepting the initial connect.

That's good point.  I just wanted to have safe-code here, but that would
be fine.

> Maybe keep this as a helper in trace.h?

That would be better to put tihs function to nvmet.h once it's needed by
nvmet code later time.

Thanks for your review on this, I'll prepare the V7 series.
