From: greg@kroah.com (Greg KH)
Date: Wed, 3 Apr 2019 16:04:27 +0200
Subject: [RESEND PATCH stable only] nvmet: set loop queue's segment
 boundary mask as PAGE_SIZE - 1
In-Reply-To: <20190402015610.26320-1-ming.lei@redhat.com>
References: <20190402015610.26320-1-ming.lei@redhat.com>
Message-ID: <20190403140427.GD8633@kroah.com>

On Tue, Apr 02, 2019@09:56:10AM +0800, Ming Lei wrote:
> NVMe target only accepts single-page sg list, either file or block
> device backed target code follows this assumption.
> 
> However, loop target is one exception, given the sg list is from
> the host queue directly.
> 
> This patch sets loop queue's segment boundary mask as PAGE_SIZE - 1
> for following NVMe target assumption.
> 
> Multi-page bvec has been merged to v5.1-rc1, so commit 02db99548d36
> ("nvmet: fix building bvec from sg list") can fix the current issue
> simply without needing to limit the segment size for nvme-loop.

I don't understand, 02db99548d36 does not work for older kernels, so
because of that, you need/want this patch to be applied?  If so, what
specific kernel versions do you want this to go to?

thanks,

greg k-h
