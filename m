From: keith.busch@intel.com (Keith Busch)
Date: Wed, 13 Dec 2017 08:34:35 -0700
Subject: [PATCH V2 0/2] nvme-cli: add options to set/get property of NVMf
In-Reply-To: <1513131091-15840-1-git-send-email-guanjunxiong@huawei.com>
References: <1513131091-15840-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <20171213153433.GK11218@localhost.localdomain>

On Wed, Dec 13, 2017@10:11:29AM +0800, Guan Junxiong wrote:
> Hi all,
> 
> To make it easy to use, this two patches add the support to set/get the
> properties for NVMe over Fabric. 
> 
> Patch 1/2  makes use of show-regs option which only supports PCIe previously
> to support NVMf.
> Patch 2/2  adds new option named set-property to support setting the property 
> of NVMf. IMO, it is the responsibility of kernel to try to avoid malicious
> operation such as setting NRSS from the user space. So I ignore this in
> the nvme-cli.
> 
> Welcome any comments.

Thanks, I've applied both with some merge and asciidoc fixups.
