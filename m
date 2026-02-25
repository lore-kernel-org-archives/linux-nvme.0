Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70454F5543E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 02:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kEXtL7AWy06JcGZuP09+ReXRlL8H709B76IV1riglzE=; b=XG3KCFU5gxrIktl1RxnIQpTOFX
	yeQRU0BwP+wojQ29QlbyWrgnRsXpgUGlQyEpGYRdycun3iCJ3X4yY808htznx7/vjmLwWdFTD1NUg
	G4yDrK8i/y0KcaOsnkzSwAwImsVoq2N6UK8K5kis3s2PwBo8A4p0ch6lLSVbdyVvSiWLDafvUvK5v
	IEgMk/PNB3X1WCCXU5PE3KMJaEV6Z7L5HEU6iWmoAsXbkSAFaVYoZ6YJ9EZRDbkNMuf7q6eDTSLBA
	NUWwdMheiU6UbBSG6Gf8zCLbjbks5t5yt198dA435hamQsnI4WIKlJJkjbai2LLlkFsqiQ4GrRCjz
	QVXuDSXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv4ht-000000036Ol-32GO;
	Wed, 25 Feb 2026 02:32:57 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv4hp-000000036Nq-3BoO
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 02:32:55 +0000
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fLJWP2v0xzKHLt3
	for <linux-nvme@lists.infradead.org>; Wed, 25 Feb 2026 10:31:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7DF7340574
	for <linux-nvme@lists.infradead.org>; Wed, 25 Feb 2026 10:32:40 +0800 (CST)
Received: from [10.174.178.253] (unknown [10.174.178.253])
	by APP4 (Coremail) with SMTP id gCh0CgBnE_REX55p6vqmIg--.46236S3;
	Wed, 25 Feb 2026 10:32:38 +0800 (CST)
Message-ID: <7d2a3f65-4272-46c1-991a-356f0d2323cb@huaweicloud.com>
Date: Wed, 25 Feb 2026 10:32:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] nvme: set max_hw_wzeroes_unmap_sectors if device
 supports DEAC bit
To: Robert Pang <robertpang@google.com>, Zhang Yi <yi.zhang@huawei.com>
Cc: bmarzins@redhat.com, brauner@kernel.org, chaitanyak@nvidia.com,
 chengzhihao1@huawei.com, djwong@kernel.org, dm-devel@lists.linux.dev,
 hch@lst.de, john.g.garry@oracle.com, linux-block@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 martin.petersen@oracle.com, shinichiro.kawasaki@wdc.com, tytso@mit.edu,
 yangerkun@huawei.com, yukuai3@huawei.com
References: <20250619111806.3546162-3-yi.zhang@huaweicloud.com>
 <20260225000531.3658802-1-robertpang@google.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20260225000531.3658802-1-robertpang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBnE_REX55p6vqmIg--.46236S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur4rJFyDCw15JF4UuF4fGrg_yoW5ZFyrpF
	4DWry0vrn8WF1UA3yDZw1I9FyUXws5Zry3Wa4kG3W5ZrZ0qryfZr1kuFZ0qa1DGrnrWw4F
	ya1xZryqvasrXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_183254_137053_F3DF67D9 
X-CRM114-Status: GOOD (  21.92  )
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

Hi Robert!

On 2/25/2026 8:05 AM, Robert Pang wrote:
> Dear Zhang Yi,
> 
> In reviewing your patch series implementing support for the
> FALLOC_FL_WRITE_ZEROES flag, I noted the logic propagating
> max_write_zeroes_sectors to max_hw_wzeroes_unmap_sectors in commit 545fb46e5bc6
> "nvme: set max_hw_wzeroes_unmap_sectors if device supports DEAC bit" [1]. This
> appears to be intended for devices that support the Write Zeroes command
> alongside the DEAC bit to indicate unmap capability.
> 
> Furthermore, within core.c, the NVME_QUIRK_DEALLOCATE_ZEROES quirk already
> identifies devices that deterministically return zeroes after a deallocate
> command [2]. This quirk currently enables Write Zeroes support via discard in
> existing implementations [3, 4].
> 
> Given this, would it be appropriate to respect NVME_QUIRK_DEALLOCATE_ZEROES also
> to enable unmap Write Zeroes for these devices, following the prior commit
> 6e02318eaea5 "nvme: add support for the Write Zeroes command" [5]? I have
> included a proposed change to nvme_update_ns_info_block() below for your
> consideration.
> 

Thank you for your point. Overall, this makes sense to me, but I have one
question below.

> Best regards
> Robert Pang
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f5ebcaa2f859..9c7e2cabfab3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2422,7 +2422,9 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>          * require that, it must be a no-op if reads from deallocated data
>          * do not return zeroes.
>          */
> -       if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3))) {
> +       if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3)) ||
> +           (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
> +           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
                                ^^^^^^^^^^^^^^^^^^
Why do you want to add a check for NVME_CTRL_ONCS_DSM? In nvme_config_discard(),
it appears that we prioritize ctrl->dmrsl, allowing discard to still be
supported even on some non-standard devices where NVME_CTRL_ONCS_DSM is not set.
In nvme_update_disk_info(), if the device only has NVME_QUIRK_DEALLOCATE_ZEROES,
we still populate lim->max_write_zeroes_sectors (which might be non-zero on
devices that support NVME_CTRL_ONCS_WRITE_ZEROES). Right? So I'm not sure if we
only need to check for NVME_QUIRK_DEALLOCATE_ZEROES here.

>                 ns->head->features |= NVME_NS_DEAC;

I think we should not set NVME_NS_DEAC for the quirks case.

Cheers,
Yi.

>                 lim.max_hw_wzeroes_unmap_sectors = lim.max_write_zeroes_sectors;
>         }
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=545fb46e5bc6
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/nvme.h#n72
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/core.c#n938
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/core.c#n2122
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e02318eaea5


