Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A39C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:27:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691022075E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ibKPmAHC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNXw1c+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691022075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3SiU7XWT4DCDMH9+ZBwaWEZABKsy+ODlPx5eaS2x2Hs=; b=ibKPmAHCaiOy2R0/CfSJT4X73
	S7Ix9Ykuvx/J35OVWXpcxS5ZkCEfAdyPp4eAkDHyIf4ag+loLz+nZ9YCJrd/KerlP9JMYky6Rr3tR
	TZPGICUknkJ7R161lPQeqiIxMuNUtcFZsl8KFN1N6jUfqDyjbOFFXyZ/N2GeK3ZLXV2V4PHGTipyY
	xSgFsK0ooKHNEvfCUrCCyYMnUWBpglnzCCbuowQnpuKzGU6QHxkCeVuPUpRAmpdNNmoWZ8U6HsICN
	z/4E9XOKC8UuwhCbFbvTady0B71/K3G1QOQzne3dKyc1uw0KSnP9W25t0azVu60kcLPYrY+UT0YXs
	526akovNw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNN9f-00043q-Dd; Tue, 29 Sep 2020 21:27:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNN9c-000435-Ik
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 21:27:21 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 33E6C2076A;
 Tue, 29 Sep 2020 21:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601414839;
 bh=9L58yshskdx/ZnBG52eQcl5MAB8NNU0p1Y/6GOXZsUw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gNXw1c+o914c9uiVYEmA2F68F6uHZueQ4nOTt+bevzo9EjL2xRibDVc1u6J6QzSXw
 LLkHgluXDy1HJcCAxvhVAd4Cv8JWI6UjB6d6v9t7SEbqcWIoPNiQxvt1z+5Gh/d0qK
 nhxz9lvHyflhoeipAatOROj9v3wAmAIi8GxVLayw=
Date: Tue, 29 Sep 2020 14:27:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/20] nvme: fix initialization of the zone bitmaps
Message-ID: <20200929212717.GA508696@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-3-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200928123502.435373-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_172720_808669_D840EF5B 
X-CRM114-Status: GOOD (  13.20  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 28, 2020 at 02:34:44PM +0200, Christoph Hellwig wrote:
> @@ -4052,7 +4032,9 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  		return;
>  	}
>  
> -	ret = nvme_revalidate_disk(ns->disk);
> +	ret = _nvme_revalidate_disk(ns->disk);
> +	if (!ret && blk_queue_is_zoned(ns->queue))
> +		ret = nvme_revalidate_zones(ns);

This is a nifty trick: 'nvme_revalidate_zones' is declared but undefined
for !CONFIG_BLK_DEV_ZONED, and the compiler doesn't care because patch 1
makes it known that the symbol is unreachable.

I'll remember that for future use to avoid implementing empty stub
functions.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
