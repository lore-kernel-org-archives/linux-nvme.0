From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 8 May 2018 22:11:56 -0700
Subject: [PATCH] nvme: block ioctls if controller not in a live state
In-Reply-To: <20180507225558.5009-1-jsmart2021@gmail.com>
References: <20180507225558.5009-1-jsmart2021@gmail.com>
Message-ID: <20180509051156.GB28673@infradead.org>

On Mon, May 07, 2018@03:55:58PM -0700, James Smart wrote:
> Rather than allow ioctl-based admin cmds to get intermixed on the admin
> queue with commands being used to initialize a controller or io commands
> to go to a controller in reconnect thus possibly hanging, reject them
> if the controller isn't in the LIVE state. Reject with an -EAGAIN status
> so that the app knows it could retry.

-EAGAIN implies that you can poll for the fd to be ready, so I think
this is the wrong error code here.
