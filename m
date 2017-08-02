From: keith.busch@intel.com (Keith Busch)
Date: Wed, 2 Aug 2017 04:02:05 -0400
Subject: [PATCH V2] nvme-cli/list: fix when nvme device can not be open
In-Reply-To: <1501660269-11024-1-git-send-email-guanjunxiong@huawei.com>
References: <1501660269-11024-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <20170802080205.GA11094@localhost.localdomain>

On Wed, Aug 02, 2017@03:51:09PM +0800, Guan Junxiong wrote:
> This patch checks the validity of fd returned by open operation on
> the nvme divices. For example, when a user who doesn't have the
> permission to open the device trys to use nvme list command to list
> nvme devices, the fd is returned as -1 and errno indicates permission
> denied.
> In addition,this patch closes the current open device before
> processing the next device.
> 
> Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Applied to the repo, thanks for the resend.
