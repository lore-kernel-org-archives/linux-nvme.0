From: dmilburn@redhat.com (David Milburn)
Date: Thu, 31 May 2018 13:48:57 -0500
Subject: [PATCH] nvme: report subsystem-reset not supported by controller.
In-Reply-To: <20180531162213.GA30654@lst.de>
References: <1527626554-101086-1-git-send-email-dmilburn@redhat.com>
 <20180531162213.GA30654@lst.de>
Message-ID: <bcbf147d-9561-1aac-f935-7986c1e7ce42@redhat.com>

Hi,

On 05/31/2018 11:22 AM, Christoph Hellwig wrote:
> On Tue, May 29, 2018@03:42:34PM -0500, David Milburn wrote:
>> Add a little more description for "nvme subsystem-reset"
>> failures, currently driver reports "Inappropriate ioctl
>> for device".
> 
> A warning sounds nice, but why can't we add it in nvme-cli?

Ok, will do.

Thanks,
David

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
