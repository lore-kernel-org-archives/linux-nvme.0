Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616EBD73E9F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 04:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HISGZJM+I+Kxj44kFEa1AU4S3pBrwScJ7JjgDjf3zv0=; b=cyX389wWHUf4GGRZZd8WyL8spD
	vvGAshoXnjQ1hA/XcXnemxSLJhV6fFtxdyTyr2Jotwf4PKLMPq8Ai4eoCH0Fp1PIh8zPm+uA3LV+c
	Y6r+QNRiWWIP5FOHoJr4cCiTvh5ib7VsY6DFsa2H7otY7GgB8utVVO9Bo/tIoxrxwwuzOBkvlo8Wf
	S6Bq0STWE8KLH4g8fH2YCaxBgrnkOZcbL6ok0+mWuEK2GO0K7MLDCnbehnEjMlmVQcIaL1TbC68ad
	2eOxIE5dgmjWcdWJRL70ZUq7e6bzB2uYmJanG7NGuRxAOZqhYmshh6IhfRnkesC4nuliD4ZJrt9RS
	NhuHIbxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlgW2-000000011KI-0CxE;
	Fri, 30 Jan 2026 04:53:54 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlgVy-000000011JM-1fRx
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 04:53:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769748815; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HISGZJM+I+Kxj44kFEa1AU4S3pBrwScJ7JjgDjf3zv0=;
	b=Mn4naTQrfYg3zw7m9hYMQ9uDLChwzi95cUohZD2kS6cMhmhj6JsMtL7Ico62qKbsICQ3UhloIKMBJPT/X7QVzkAFtUePJZNXTZDysCpM9bxcrkg8KPTfIxSNSrJG45w3y2r5iVsIfLoRFp2OjxZj/2/W6lz2+rrf9x1JUXThvoA=
Received: from 30.178.83.24(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0Wy9XcF1_1769748806 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 Jan 2026 12:53:31 +0800
Message-ID: <88437e1a-2df0-41e6-a58f-dcc68d4458bc@linux.alibaba.com>
Date: Fri, 30 Jan 2026 12:53:25 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Xunlei Pang <xlpang@linux.alibaba.com>, Guixin Liu
 <kanie@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
 Guanghui Feng <guanghuifeng@linux.alibaba.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20260127073344.2489873-1-qinyuntan@linux.alibaba.com>
 <20260127084807.GA342@lst.de>
From: qinyuntan <qinyuntan@linux.alibaba.com>
In-Reply-To: <20260127084807.GA342@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_205351_329044_5EFB6754 
X-CRM114-Status: GOOD (  22.63  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi All,

Thank you all for the insightful discussion!

I agree with Leon's point that not all devices are created equal when it
comes to SR-IOV handling during driver unbind.

Looking at existing driver implementations, I found two different 
approaches:

1) mlx5 - unconditionally disables SR-IOV in remove:

    drivers/net/ethernet/mellanox/mlx5/core/main.c:
    static void remove_one(struct pci_dev *pdev)
    {
        ...
        mlx5_sriov_disable(pdev, false);
        ...
    }

    drivers/net/ethernet/mellanox/mlx5/core/sriov.c:
    void mlx5_sriov_disable(struct pci_dev *pdev, bool num_vf_change)
    {
        struct mlx5_core_dev *dev  = pci_get_drvdata(pdev);
        struct devlink *devlink = priv_to_devlink(dev);
        int num_vfs = pci_num_vf(dev->pdev);

        pci_disable_sriov(pdev);  /* Always disable, no 
pci_vfs_assigned() check */
        devl_lock(devlink);
        mlx5_device_disable_sriov(dev, num_vfs, true, num_vf_change);
        devl_unlock(devlink);
    }

2) ixgbe - checks pci_vfs_assigned() and skips disable if VFs are in use:

    drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:
    static void ixgbe_remove(struct pci_dev *pdev)
    {
        ...
    #ifdef CONFIG_PCI_IOV
        ixgbe_disable_sriov(adapter);
    #endif
        ...
    }

    drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c:
    #ifdef CONFIG_PCI_IOV
        if (pci_vfs_assigned(adapter->pdev)) {
            e_dev_warn("Unloading driver while VFs are assigned - VFs 
will not be deallocated\n");
            return -EPERM;
        }
        pci_disable_sriov(adapter->pdev);
    #endif

Regarding the warning level discussion: I would prefer keeping it as
dev_warn() rather than downgrading to dev_info(). As Leon mentioned,
some devices do require SR-IOV to be disabled when the PF is unbound,
and for those cases, this warning is important for operators to notice
and take action. A warning level helps ensure it doesn't get lost in
normal system logs.

Please let me know how you'd like to proceed.

Thanks,
Qinyun

On 1/27/26 4:48 PM, Christoph Hellwig wrote:
> On Tue, Jan 27, 2026 at 03:33:44PM +0800, Qinyun Tan wrote:
>> The NVMe PCI driver exports the sriov_configure callback via
>> pci_sriov_configure_simple(), which allows userspace to enable SR-IOV
>> VFs through sysfs. However, when the PF driver is unbound, the driver
>> does not disable SR-IOV, leaving VFs orphaned in the system.
> 
> That sounds dangerous.
> 
>> According to Documentation/PCI/pci-iov-howto.rst, PCI drivers that
>> support SR-IOV should call pci_disable_sriov() in their remove callback
>> to properly clean up VFs before the driver is unloaded.
> 
> Bjorn and other PCI folks: is there any reason to not do this in
> the PCI code and leave a landmine for the drivers?
> 
>> Fix this by disabling SR-IOV in nvme_remove(). If VFs are not assigned
>> to a guest, disable SR-IOV. If VFs are still assigned, emit a warning
>> since forcibly disabling would disrupt the guest.
> 
> Well, I think we have to distrupt it, at least for hot unplug.  This
> sounds like we need some better handling in the core code as well.
> 
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 58f3097888a7..4f2dc13de48b 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -3666,6 +3666,15 @@ static void nvme_remove(struct pci_dev *pdev)
>>   	nvme_stop_ctrl(&dev->ctrl);
>>   	nvme_remove_namespaces(&dev->ctrl);
>>   	nvme_dev_disable(dev, true);
>> +
>> +	if (pci_num_vf(pdev)) {
>> +		if (pci_vfs_assigned(pdev))
>> +			dev_warn(&pdev->dev,
>> +				 "WARNING: Removing PF while VFs are assigned - VFs will not be deallocated!\n");
>> +		else
>> +			pci_disable_sriov(pdev);
>> +	}
>> +
>>   	nvme_free_host_mem(dev);
>>   	nvme_dev_remove_admin(dev);
>>   	nvme_dbbuf_dma_free(dev);
>> -- 
>> 2.43.5
> ---end quoted text---


