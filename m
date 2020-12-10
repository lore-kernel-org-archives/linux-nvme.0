Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0D9C4361B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 15:05:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0823523BAB
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 15:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0823523BAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OxA0+HhDCjq84EbNNNssFbfD/PV3k/dU6gzGoZG+N44=; b=qGsWllqpeKmwlAQb/138pbWpw
	G01N1z0REEs4NmUZ3gjiU7oD8xaXpHsT6b27GCair8Lzv17r1JCe5ubXeq9gFr5Hv3yQzmNrW/Gt3
	cNoZAGaT31n41MB8F7qhdea5H986snM67/YjRRMN0lde1bvj4S+x6CLS1SyXFBQws+wQJRNBXl7yv
	1RwhDYKrd9ZYW5QX1f+jAWaNos0tqhtIY/VT8p4JyHvoK/uxc51kMYcmpYDDHsrafS0iXQP9aW1mu
	al0YebRhrNhRIsZP+9hzH4m0C8nlaclKigxd5wmAdEhF++p1dtNw0m4TiVWpcBnSy+zuQu2+mXNbm
	Aw0tGX7UQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knNVp-0001qC-Oh; Thu, 10 Dec 2020 15:05:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knNVm-0001pR-RX
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 15:05:43 +0000
Date: Fri, 11 Dec 2020 00:05:34 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607612741;
 bh=rUc8kAAzgIPOPqDkqYodpVmwWA4T53QTUItA9JEQX1E=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=BBRxezUJnM3zNgdAvq4O81fM22NGLO6WD4VT4KIBL45R0sAi6OJNS5aU0RPJuKDht
 zzn76UtpaSkcsrialYwyBtsugPN0m2FGjEW6Bg3PEEputq613IEZ6C00i6HBRvQQTu
 Xl8Q8m1RlIt6NIVK11t2rQ5d9D/dZ3ahieMLgTbQ5nquTo9T6DmbRQNLfVBR7yv3Wc
 82UE48MhuNU8JLDo/FT4F6W3uGJ1mLrJPdnlmLE5TxuWxHjlhxNPNPZPkddcDd2G9e
 /hi5QTxQoauLWg9L20PsRjHYiojVHlpsPchoTH/bhE0kIrYwLqaBJ9LbjaPLLsKoqZ
 A8buRGoPAyJvg==
From: Keith Busch <kbusch@kernel.org>
To: Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
Message-ID: <20201210150534.GB3645@redsun51.ssa.fujisawa.hgst.com>
References: <20201209213228.5044-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209213228.5044-1-ematsumiya@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_100542_981250_B47021DD 
X-CRM114-Status: UNSURE (   8.03  )
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
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 09, 2020 at 06:32:27PM -0300, Enzo Matsumiya wrote:
> +void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
> +{
> +	hwmon_device_unregister(ctrl->dev);
> +}

The hwmon registration uses the devm_ version, so don't we need to use
the devm_hwmon_device_unregister() here?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
