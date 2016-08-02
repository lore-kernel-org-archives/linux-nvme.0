From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 2 Aug 2016 10:53:06 -0500
Subject: Where are all the patches landing?
In-Reply-To: <7c785bb2-777a-10ff-dd42-c48c2e48cee6@grimberg.me>
References: <CAEqzOjuwPci12idmihNknojg7CuS9P0OPttBOqkEzPfTdcL4aw@mail.gmail.com>
 <CAEqzOjvcKZWWvpsJQhc6AzmSLtauA0y7esK_cZdMi=0Ct0m1sg@mail.gmail.com>
 <7c785bb2-777a-10ff-dd42-c48c2e48cee6@grimberg.me>
Message-ID: <010501d1ecd5$f5f1f8c0$e1d5ea40$@opengridcomputing.com>

> 
> Hi Robert,
> 
> > May have answered this already.  The patches appear to be landing on
> > the nvmf-4.9 branch.
> >
> > Please let me know if I should be using a different branch.
> 
> We are maintaining two branches in nvme-fabrics.git
> 
> 1. nvmf-<next-ver> for patches targeting the
> next merge window (this is nvmf-4.9)
> 
> 2. nvmf-<current-ver>-rc for patches targeting
> the upcoming rc releases (usually bug fixes)
> 
> This is so Jens can have a clear look of what patches
> exist and where they are targeted.
> 
> So, each patch will exist in either of the branches.
> 

Thanks for explaining this.  I've been using Jens' for-linus branch for
linux-block repo...  I wasn't sure the nvmf repo was being maintained after the
merge...
