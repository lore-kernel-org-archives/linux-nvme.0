From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 07 Nov 2016 10:29:38 -0800
Subject: nvmet_rdma crash - DISCONNECT event with NULL queue
In-Reply-To: <bd82c206-668a-0794-2d51-3c48058350d3@grimberg.me>
References: <6f42d056-284d-00fc-2b98-189f54957980@grimberg.me>
 <01cc01d2345b$d445acd0$7cd10670$@opengridcomputing.com>
 <4cc25277-429a-4ab9-470c-b3af1428ce93@grimberg.me>
 <01d101d2345e$2f054390$8d0fcab0$@opengridcomputing.com>
 <dbe5f18d-7928-f065-920f-753b30fb99a2@grimberg.me>
 <01d901d2345f$da0d2e00$8e278a00$@opengridcomputing.com>
 <1d09c064-1cbe-7e6e-43d2-cfa6cf0c19ea@grimberg.me>
 <024e01d23476$6668b890$333a29b0$@opengridcomputing.com>
 <3512b8bb-4d29-b90a-49e1-ebf1085c47d7@grimberg.me>
 <004601d2351a$d9db85b0$8d929110$@opengridcomputing.com>
 <20161102151540.GB14825@lst.de>
 <bd82c206-668a-0794-2d51-3c48058350d3@grimberg.me>
Message-ID: <1478543378.3350.17.camel@linux.intel.com>

On Sun, 2016-11-06@09:35 +0200, Sagi Grimberg wrote:
> > 
> > Btw, I want to actually make the ctrlid global for the target
> > instead of
> > per-subsystem to ease a few things, and debuggability is just one
> > more
> > on the list.

How will that be NVMe-over-Fabrics spec compliant?

The way I interpret the spec, ctrlid (I'm assuming you mean cntlid) is
allocated on a NVM subsystem basis. ?For example, Figure 34 of the
Discovery Log Page entry and Figure 20 of the Connect Command implies
to me CNTLID values are allocated on a NVM Subsystem granular-level
when I see statements such as:

(Figure 20: Connect Command Data): "...If the NVM subsystem uses the
static controller model and the value is FFFEh for the Admin Queue,
then any available controller may be returned."

This implies to me cntlid are allocated on an NVM subsystem basis, not
an NVMe Target basis.

> 
> Sounds good
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
