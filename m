Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166E606A31B
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UXtILYeS;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PEsgsdHr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7pBb8peZLyGlupbuSNH0lecZVCjEl1ALPaCWnm6Cx3o=; b=UXtILYeSrzqDVi
	QyRwHkVVHzvLA+Eh+vZUERUYZE4LL5cbLJEvlHrdR3mnAwUHXlbuO1W8orTyPp78Hbabq/Hbp+gvJ
	iKlAmj4WPb21Fapyy6EX3GuIme21KdAVR9N58QONVjPoP/Q6vYo8t9z1KG7LMCAe4MjBHQ1s74GLI
	Zwnijx1F8La0nDjgZhdwg7zBpctaYaMPXpELgp556uxNCc5htjx6iLNa137cfkgqVvL2+2N7JnXVo
	6tDhZ0E7OMUXrjmnyDmYhRdgIKaZc14H2G2EbjxVVNsA/nEw6OU5QqN8rSBnQGNRM/PyLQkJNUVMx
	sYTw7N8UFJ3BjZL+e0yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLABU-00000001bFs-1BBo;
	Mon, 26 Oct 2026 02:11:36 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLABR-00000001bFW-1w1K
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 02:11:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792980691; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7pBb8peZLyGlupbuSNH0lecZVCjEl1ALPaCWnm6Cx3o=;
	b=PEsgsdHr/rg1fxjhS1K8jYPszRrh1G6p6dCZC3R/XoF80+rqGdR6JJ9Rx+wTD0x/DXEKNR2O92Vi9yYoOuYrVg/TdO0kaRnVenDkuSm6fDKGpN9shXbCzLcToSx63q4YiHxlj8D15lc95UX/JxC+hkEkY5PAHjT1oqiSnvfj4Pc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0XDRPkTX_1792980690;
Received: from 30.178.69.120(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDRPkTX_1792980690 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 10:11:30 +0800
Message-ID: <4be183a5-5d40-49ba-ac26-30fac06c007c@linux.alibaba.com>
Date: Mon, 26 Oct 2026 10:11:29 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] nvme: export nvme_bdev_ops
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261023080251.2606443-1-kanie@linux.alibaba.com>
 <20261023080251.2606443-4-kanie@linux.alibaba.com>
 <sashiko-outbox-182494@kernel.org>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <sashiko-outbox-182494@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_191133_675121_212E7D1E 
X-CRM114-Status: GOOD (  14.53  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/10/23 16:14, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] nvme: exporting only nvme_bdev_ops misses multipathed NVMe namespaces
> --
>
> commit 764e628e097c80c3a597aca0fdc4893155c2715b
> Author: Guixin Liu <kanie@linux.alibaba.com>
>
> nvme: export nvme_bdev_ops
>
> This commit exports nvme_bdev_ops so that external subsystems such as the
> NVMe target FDP bridge can identify an NVMe namespace block device by its
> block_device_operations pointer and access its underlying NVMe structures.
>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 7eb0f9fe6b18d..0099ce5730b20 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2719,6 +2719,7 @@ const struct block_device_operations nvme_bdev_ops = {
>>  	.report_zones	= nvme_report_zones,
>>  	.pr_ops		= &nvme_pr_ops,
>>  };
>> +EXPORT_SYMBOL_GPL(nvme_bdev_ops);
> [Severity: Medium]
> Does exporting only nvme_bdev_ops work when NVMe multipathing is active for
> the backing namespace?
>
> When multipathing is enabled for a namespace, nvme_mpath_alloc_disk() in
> drivers/nvme/host/multipath.c sets up the user-visible /dev/nvmeXnY gendisk
> with nvme_ns_head_ops and stores struct nvme_ns_head * in private_data:
>
> 	head->disk->fops = &nvme_ns_head_ops;
> 	head->disk->private_data = head;
>
> Meanwhile, nvme_alloc_ns() in drivers/nvme/host/core.c marks the
> per-controller disk (which uses nvme_bdev_ops and stores struct nvme_ns * in
> disk->private_data) as hidden so it cannot be opened as a backing block
> device:
>
> 	if (nvme_ns_head_multipath(ns->head)) {
> 		sprintf(disk->disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
> 			ctrl->instance, ns->head->instance);
> 		disk->flags |= GENHD_FL_HIDDEN;
> 	}
>
> When the NVMe target FDP bridge in nvmet_fdp_init_ns() checks
> bdev->bd_disk->fops != &nvme_bdev_ops on an opened /dev/nvmeXnY device,
> won't it reject valid multipathed NVMe namespaces with -EINVAL because
> bdev->bd_disk->fops is &nvme_ns_head_ops?
>
> Instead of exporting nvme_bdev_ops and having callers inspect
> bdev->bd_disk->fops and bdev->bd_disk->private_data directly, would it make
> sense to provide a helper in drivers/nvme/host/core.c (similar to
> nvme_ctrl_from_file()) that handles both nvme_bdev_ops and nvme_ns_head_ops?
Well, this only support NVMe-only backends, I declared the restriction in commit
message.

Best Regards,
Guixin Liu
>


