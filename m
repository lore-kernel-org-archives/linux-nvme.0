From: keith.busch@intel.com (Keith Busch)
Date: Fri, 7 Dec 2018 15:16:17 -0700
Subject: [PATCH] nvme-ioctl: clear rae for discovery log pages
In-Reply-To: <20181207220530.30310-1-sagi@grimberg.me>
References: <20181207220530.30310-1-sagi@grimberg.me>
Message-ID: <20181207221617.GA21523@localhost.localdomain>

On Fri, Dec 07, 2018@02:05:30PM -0800, Sagi Grimberg wrote:
> The discovery controller should now be able to send
> us discovery log change events so we need to clear the
> rae bit for that.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Applied, thanks.
