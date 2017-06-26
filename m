From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 Jun 2017 16:00:26 -0400
Subject: [PATCH 0/3] nvme-cli: supplement and fixup for smart-log
In-Reply-To: <1498021764-12092-1-git-send-email-guanjunxiong@huawei.com>
References: <1498021764-12092-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <20170626200026.GA15759@localhost.localdomain>

On Wed, Jun 21, 2017@01:09:21PM +0800, Guan Junxiong wrote:
> NVMe 1.3 introduces new thermal management temperature related
> fields into the smart log page. The first patch adds those fields
> into smart-log command.
> 
> Besides, next two patches address some fixup for smart-log such as
> adding temperatature sensor fields in json_smart_log and synchronizing
> the documenation for smart-log with the implementation of output-format
> option.

Thanks, all applied.
