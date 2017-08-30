From: keith.busch@intel.com (Keith Busch)
Date: Wed, 30 Aug 2017 10:27:42 -0400
Subject: [PATCH v2] nvme: fix the definition of Admin doorbell buffer
 config support
In-Reply-To: <1504166149-16770-1-git-send-email-changpeng.liu@intel.com>
References: <1504166149-16770-1-git-send-email-changpeng.liu@intel.com>
Message-ID: <20170830142742.GG4428@localhost.localdomain>

On Thu, Aug 31, 2017@03:55:49PM +0800, Changpeng Liu wrote:
> NVMe 1.3 specification defines the Optional Admin Command Support
> feature flags, bit 8 set to '1' then the controller supports the
> Doorbell Buffer Config command. Bit 7 is used for Virtualization
> Mangement command.
> 
> Signed-off-by: Changpeng Liu <changpeng.liu at intel.com>

Thanks for the fix. We also need this for 4.12+ stable.
