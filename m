From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 14 May 2018 09:23:08 -0600
Subject: [PATCH] nvme: block ioctls if controller not in a live state
In-Reply-To: <20180507225558.5009-1-jsmart2021@gmail.com>
References: <20180507225558.5009-1-jsmart2021@gmail.com>
Message-ID: <20180514152308.GF7772@localhost.localdomain>

On Mon, May 07, 2018@03:55:58PM -0700, James Smart wrote:
> Rather than allow ioctl-based admin cmds to get intermixed on the admin
> queue with commands being used to initialize a controller or io commands
> to go to a controller in reconnect thus possibly hanging, reject them
> if the controller isn't in the LIVE state. Reject with an -EAGAIN status
> so that the app knows it could retry.

The admin ioctl is fine to use in ADMIN_ONLY state as well.
