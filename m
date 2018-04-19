From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Apr 2018 10:50:01 +0200
Subject: [PATCH] nvme: Fix disk names when not using nvme multipath
In-Reply-To: <20180418160942.GN11513@localhost.localdomain>
References: <20180417220344.14698-1-keith.busch@intel.com>
 <20180418064412.GB11757@lst.de>
 <20180418132657.GJ11513@localhost.localdomain> <20180418150429.GA7862@lst.de>
 <20180418153410.GM11513@localhost.localdomain> <20180418153445.GA8513@lst.de>
 <20180418160942.GN11513@localhost.localdomain>
Message-ID: <20180419085001.GA22593@lst.de>

On Wed, Apr 18, 2018@10:09:42AM -0600, Keith Busch wrote:
> On Wed, Apr 18, 2018@05:34:45PM +0200, Christoph Hellwig wrote:
> > True.  We should do that anyway.  I'll turn this into a real series
> > with a few more final touches tomorrow.
> 
> I started this before I saw your message:

Even better :)

>  static bool multipath = true;
> -module_param(multipath, bool, 0644);
> +module_param(multipath, bool, 0444);
>  MODULE_PARM_DESC(multipath,

I think this part should be split into a separate patch as it's already
unsafe.

Otherwise this looks ok to me, but I wonder if the helper is really
worth the effort.
