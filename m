Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C01F54AC5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d9gbb6OEK32xGLciOtIsfGMH5Tr3SGzQb/01QJISOKQ=; b=f+KtDeu5WlqhTOr0d4BcWdcShJ
	+wSWNhzvITlF5edNmcBM4gejmtMAXFEkZqTrxJsQAGrQjbzN1aog54UVVrJrZB8qQpntzCxt9Yb12
	gtrSu/Ajy3+FEbBhz6fzFyMOiwkZmFvqT7UE8zoVXy11yxuelceu44X9t6G/m+RhnsFKjg/kxo8aN
	IfFW49ScToqO5ClVySAzg2r3SiN87544rP+mPyBWYbPOv8BRN80NY4lw8hiK2e5xid8StzFOOChtj
	bB7XhvUXHZQ7WhIGoqiKnM3sLj7S+nSvxB/I3SCOIbrwH0e72NwdHwwP3tgkLsNPTieTLQEtWoWN4
	zHOr8lDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w53KK-00000001icF-29Tu;
	Tue, 24 Mar 2026 15:05:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w53KH-00000001ibY-2zU6
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 15:05:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 15E5E40538;
	Tue, 24 Mar 2026 15:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D306C19424;
	Tue, 24 Mar 2026 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774364749;
	bh=5hFAGOIzp/eMo2BkSnj3ruVd7WQWbN7gZFXvH2KCv+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElhEJc243dMRGNhh5WR3M6+3lYx8CnlrfHG+ghChZamKkWoPDQTO8mDTNXbRSn+Fi
	 Jyr7agja58P1NlLahPI91zRrfVd9dxvRY+tiNS1QtfmW7ruOF1uw+UuBo3FJMRDM1T
	 M+nLih80AFFJ2fN9TferKAiM/QvyaKNdEkIdWIxtJQkt91chTTAE9FVcqlJkMJ5/WR
	 UkiQMy0r5A2y1HOxMnXifQG34eVN3HN4wCEYj1QFqXmt6uMHHH1vAkbXAzNClTHxbH
	 ZAoxmXMXwrWyAImGq3OH0zZxusWTaq6eYoDSW9cQ+M8HxTXwkUmLZ57v281NAEl13u
	 Or+9f1wZ2RE0Q==
Date: Tue, 24 Mar 2026 09:05:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bob Beckett <bob.beckett@collabora.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, kernel@collabora.com,
	stable@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: respect NVME_QUIRK_DISABLE_WRITE_ZEROES when
 wzsl is set
Message-ID: <acKoSnQ4p8rhBe4P@kbusch-mbp>
References: <20260320192217.365936-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320192217.365936-1-bob.beckett@collabora.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_080549_770061_463E3E71 
X-CRM114-Status: GOOD (  16.13  )
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

On Fri, Mar 20, 2026 at 07:22:08PM +0000, Bob Beckett wrote:
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 766e9cc4ffca..ce25c8a4e84b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3388,7 +3388,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
>  
>  	ctrl->dmrl = id->dmrl;
>  	ctrl->dmrsl = le32_to_cpu(id->dmrsl);
> -	if (id->wzsl)
> +	if (id->wzsl && !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
>  		ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);

Interesting. This is from a more recent identification that I would have
hoped devices going through the trouble of implementing it would have
figured out by now how to report write zeroes support correctly.

Patches applied to nvme-7.1, thanks.

