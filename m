From: osandov@osandov.com (Omar Sandoval)
Date: Fri, 6 Apr 2018 21:01:44 -0700
Subject: [PATCH] test/nvme/003: add test case for patch "nvme: don't send
 keep-alives to the discovery controller"
In-Reply-To: <20180327093147.10684-1-jthumshirn@suse.de>
References: <20180327092848.10404-1-jthumshirn@suse.de>
 <20180327093147.10684-1-jthumshirn@suse.de>
Message-ID: <20180407040144.GB533@vader>

On Tue, Mar 27, 2018@11:31:47AM +0200, Johannes Thumshirn wrote:
> Add a regression test for the patch titled "nvme: don't send
> keep-alives to the discovery controller".
> 
> This patch creates a local loopback nvme target and then connects to
> it. If the patch is not applied we see two error messages in dmesg:
> "failed nvme_keep_alive_end_io error=" from the nvme host and "nvmet:
> unsupported cmd 24" from the nvme target. If the patch is applied
> dmesg is quiet.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>

Applied, thanks, Johannes!
