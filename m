From: greg@kroah.com (Greg KH)
Date: Wed, 24 Apr 2019 18:48:13 +0200
Subject: [RESEND PATCH stable only] nvmet: set loop queue's segment
 boundary mask as PAGE_SIZE - 1
In-Reply-To: <20190403162226.GA22741@ming.t460p>
References: <20190402015610.26320-1-ming.lei@redhat.com>
 <20190403140427.GD8633@kroah.com>
 <20190403162226.GA22741@ming.t460p>
Message-ID: <20190424164813.GD21916@kroah.com>

On Thu, Apr 04, 2019@12:22:27AM +0800, Ming Lei wrote:
> On Wed, Apr 03, 2019@04:04:27PM +0200, Greg KH wrote:
> > On Tue, Apr 02, 2019@09:56:10AM +0800, Ming Lei wrote:
> > > NVMe target only accepts single-page sg list, either file or block
> > > device backed target code follows this assumption.
> > > 
> > > However, loop target is one exception, given the sg list is from
> > > the host queue directly.
> > > 
> > > This patch sets loop queue's segment boundary mask as PAGE_SIZE - 1
> > > for following NVMe target assumption.
> > > 
> > > Multi-page bvec has been merged to v5.1-rc1, so commit 02db99548d36
> > > ("nvmet: fix building bvec from sg list") can fix the current issue
> > > simply without needing to limit the segment size for nvme-loop.
> > 
> > I don't understand, 02db99548d36 does not work for older kernels, so
> > because of that, you need/want this patch to be applied?  If so, what
> > specific kernel versions do you want this to go to?
> 
> Old kernel needs both this patch and 02db99548d36, and you should see
> the description in 02db99548d36 commit log too.
> 
> This patch should be needed since nvme-loop is introduced.

I'm sorry, I still do not understand.  Please resend the patches that
you wish to have applied, with the proper git commit ids, and let us
know what trees they should be applied to.  I can not parse the above
text, sorry.

greg k-h
