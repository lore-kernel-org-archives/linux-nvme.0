From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Aug 2015 15:45:27 +0200
Subject: [PATCH 4/6] dm: refactor ioctl handling
In-Reply-To: <20150804175616.GA28971@redhat.com>
References: <1438672271-11309-1-git-send-email-hch@lst.de>
 <1438672271-11309-5-git-send-email-hch@lst.de>
 <20150804175616.GA28971@redhat.com>
Message-ID: <20150806134527.GB1646@lst.de>

On Tue, Aug 04, 2015@01:56:16PM -0400, Mike Snitzer wrote:
> This should be renamed to dm_prepare_ioctl_fn and the targets' hook
> would be .prepare_ioctl
> 
> Open to other names but if the targets no longer issue the ioctl there
> is little point to call it .ioctl

Sure.  I had ioctl_allowed first but that sounded so ugly that I
undid the renaming..
