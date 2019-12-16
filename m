Return-Path: <SRS0=UA0h=2G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABFAC43603
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2019 16:53:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECED3206D7
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2019 16:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nx0gDq61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECED3206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/+NiTQTsIhB5KU83gNhGDHuSnLg+XkvyzmbSHpmyAgs=; b=Nx0gDq61+4EIYXo/2Sj7UEZGb5
	fpaNkMmzHvy/q9gLbD28mkwEiLZIZPTJ0fz/EJAijpiFZHq2MWdIk+VQOydFydigfE/5YKXfYcM0R
	JU8B5Z8Kiq+EVqcakQO43yUE4Cb7mm8AonuwdWFm8bmnSf6qE57iQUYFyEF8brImS9A6RQU3rbKhd
	Ym3q4KaBSTOkr+nYKhDWtc+TQkrrwvGva5zevDLrBUZp8CAcNuQrTViy6KAE0resEmlmJebmzw6Nw
	pSx4nLiAbswqvY0h3kHtPRdK5B01LwN+94rNFn9Ae0UqgqtuLpKIw2gBaBMh6t/RhtYTY59keqDcP
	5bUlW4Mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1igtcn-0006Qf-7F; Mon, 16 Dec 2019 16:53:37 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igtcj-0006Q7-6z
 for linux-nvme@lists.infradead.org; Mon, 16 Dec 2019 16:53:35 +0000
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id C1952E6EB6B0E6580052;
 Mon, 16 Dec 2019 16:53:29 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 16 Dec 2019 16:53:29 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Dec
 2019 16:53:29 +0000
From: John Garry <john.garry@huawei.com>
To: <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: NVMe WARN with DEBUG_TEST_DRIVER_REMOVE
Message-ID: <9731baa8-e814-f7f7-7bb9-1e90d8df5d07@huawei.com>
Date: Mon, 16 Dec 2019 16:53:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191216_085333_401403_83A8C880 
X-CRM114-Status: UNSURE (   7.46  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi guys,

JFYI, enabling CONFIG_DEBUG_TEST_DRIVER_REMOVE causes this WARN:

[   42.031103] nvme 0000:04:00.0: Adding to iommu group 2
[   42.059408] nvme nvme0: pci function 0000:04:00.0
[   42.180257] nvme nvme0: failed to mark controller CONNECTING
[   42.185936] nvme nvme0: Removing after probe failure status: -16
[   42.195654] nvme nvme1: pci function 0000:04:00.0
[   42.201573] nvme 0000:81:00.0: Adding to iommu group 3
[   42.230948] nvme nvme2: pci function 0000:81:00.0
[   42.236165] ------------[ cut here ]------------
[   42.240797] WARNING: CPU: 66 PID: 255 at drivers/nvme/host/pci.c:2539 
nvme_reset_work+0x5f0/0x1e80
[   42.244926] nvme nvme1: 23/0/0 default/read/poll queues
[   42.249746] Modules linked in:
[   42.249757] CPU: 66 PID: 255 Comm: kworker/u195:0 Tainted: G    B   W 
         5.5.0-rc1-dirty #565
[   42.249763] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[   42.275484] Workqueue: nvme-reset-wq nvme_reset_work
[   42.280442] pstate: 20c00009 (nzCv daif +PAN +UAO)
[   42.285226] pc : nvme_reset_work+0x5f0/0x1e80
[   42.289574] lr : nvme_reset_work+0xbc/0x1e80
[   42.293834] sp : ffff00236d8cf9d0
[   42.297139] x29: ffff00236d8cf9d0 x28: ffff002321848990
[   42.300280]  nvme1n1: p1 p2 p3
[   42.302445] x27: ffff00236f067918 x26: ffff002321848000
[   42.302451] x25: ffff002321848340 x24: 1fffe0046db19f5e
[   42.302455] x23: ffff00236d8cfd60 x22: ffff0023228c4000
[   42.302459] x21: ffff00236d8b0000 x20: ffff00236d8bc000
[   42.302463] x19: ffff00236d8c0000 x18: 0000000000000000
[   42.332009] x17: 0000000000000000 x16: 0000000000000000
[   42.337312] x15: 0000000000001348 x14: 0000000000000000
[   42.342615] x13: 0000000000001340 x12: 1fffe0046db16000
[   42.347917] x11: ffff80046db16000 x10: dfffa00000000000
[   42.353221] x9 : ffff80046db16001 x8 : 0000000000000001
[   42.358523] x7 : 0000000000000000 x6 : ffffa00010149a20
[   42.363826] x5 : 0000000000000000 x4 : ffff002321848344
[   42.369129] x3 : dfffa00000000000 x2 : dfffa00000000000
[   42.374431] x1 : 0000000000000007 x0 : 0000000000000004
[   42.379735] Call trace:
[   42.382176]  nvme_reset_work+0x5f0/0x1e80
[   42.386182]  process_one_work+0x4cc/0x7f8
[   42.390183]  worker_thread+0x400/0x6a0
[   42.393924]  kthread+0x1c0/0x1c8
[   42.397144]  ret_from_fork+0x10/0x18
[   42.400710] ---[ end trace 35a83b71b6578790 ]---
[   42.405357] nvme nvme2: Removing after probe failure status: -19
[   42.413659] nvme nvme3: pci function 0000:81:00.0


Full dmesg and .config is here:
https://pastebin.com/4P5yaZBS

I haven't had a chance to check it yet.

Thanks,
John

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
