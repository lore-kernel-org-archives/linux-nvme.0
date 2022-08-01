Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA56C00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 08:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qNfGtU0KRsWb1DZwBmyK4viDWoc4BKSXUW5qk8L6eKg=; b=IktqARulJi9c1Q5j9KlufD00Z7
	cFW6blkYkzXTsIVTKIAR3Sp3Y65MHFuPwtvIDMScuwg8QZn1UPvwDjfEajPapKepDtMwyW8PDteXq
	TWtYGbvXPtPDmNEuM8qH4T/2pAlzQI++EsLSuNTXM/EQN0kB5qB6B5eW7Ta1DzgppiokDBL8n7VzQ
	F0+TFxnIWYKjJTwQ/Mk40DboWGYZAK1xdO5n6ItZvLVwuh53nqbA/RjNfDLXCstzQaj+S9LiaOzlE
	2tmu/fYiDfchOk+PUZ/WpEjC8WJaREVpwfRccmfJlUynIbhhZFp5En4G777izW72dmbU/fhBvJ4bk
	QYBqxRIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIRCO-004C3y-3T; Mon, 01 Aug 2022 08:54:52 +0000
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIRCJ-004Bxb-OX
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 08:54:50 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VL4MhQ7_1659344076;
Received: from 30.178.82.41(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VL4MhQ7_1659344076)
          by smtp.aliyun-inc.com;
          Mon, 01 Aug 2022 16:54:37 +0800
Message-ID: <5d0c0304-9116-732d-f4ea-0264501b6b2e@linux.alibaba.com>
Date: Mon, 1 Aug 2022 16:54:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3] nvmet: avoid unnecessary flush bio
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <1659066785-88807-1-git-send-email-kanie@linux.alibaba.com>
In-Reply-To: <1659066785-88807-1-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_015448_003999_466DE87A 
X-CRM114-Status: GOOD (  17.69  )
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

Hi,

Gentle ping.

thanks,

Guixin Liu

在 2022/7/29 11:53, Guixin Liu 写道:
> For no volatile write cache block device backend, sending flush bio is
> unnecessary, avoid to do that.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>
> Changes on v3:
> - Remove file backend change.
>
> Changes on v2:
> - Use bdev_write_cache instead of open code.
> - Use NVME_SC_SUCCESS instead of translation, and remove "else".
>
> Test log:
> - Add printk log at new if branch.
> - Use nvme_loop to emulate nvme device.
> - Use tcm_loop and tcmu to emulate no volatile write cache block backend
>    by setting emulate_write_cache=0.
> - Send "nvme flush /dev/nvme0n1", there is a log print, and cmd return success.
> - Send "nvme set-feature /dev/nvme0n1 --namespace-id=1 --feature-id=0x84 --value=1",
>    there is a log print, and cmd return success.
> - Format nvme0n1 to ext4 filesystem, then create a file, write data and save, there
>    is a log print, and no error.
>
>   drivers/nvme/target/io-cmd-bdev.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 2dc1c10..8d527a8 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -334,6 +334,11 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
>   {
>   	struct bio *bio = &req->b.inline_bio;
>   
> +	if (!bdev_write_cache(req->ns->bdev)) {
> +		nvmet_req_complete(req, NVME_SC_SUCCESS);
> +		return;
> +	}
> +
>   	if (!nvmet_check_transfer_len(req, 0))
>   		return;
>   
> @@ -347,6 +352,9 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
>   
>   u16 nvmet_bdev_flush(struct nvmet_req *req)
>   {
> +	if (!bdev_write_cache(req->ns->bdev))
> +		return 0;
> +
>   	if (blkdev_issue_flush(req->ns->bdev))
>   		return NVME_SC_INTERNAL | NVME_SC_DNR;
>   	return 0;

