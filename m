Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD84C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 20:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gujZTJEOqOVDu1JEDbMqwCgGnWsRjlXpLWTJjpR5FHE=; b=Lo9NQKqZJH5WRl/L3j8XyHIom7
	PzzC4ey5cmxJJbD1Btrdqq+3IRr0EJ+C+C/ificjgQyc2y/CdW6Ie2SCEGAyDDr6iIHrNYm3wMnNd
	bDzNVklk4DrQZFGgmlnBa5hP4tNJNuZW+QVeqQ+P6Nd1DHjm0MZFuz08NfAqL3cRdM0ooVcQ6iAPa
	8jZIgIBdlJAfVH0iUdA0YcS8g+v7ruI35TX5w2B3s4Kkui15YQyfAvX6W/+ZJEnr1BLrUJrXZgJIe
	BJMSrsBiBTJYpwqMvzlBfTyUYB8gQxpnpwDQhIrKMKfVbfKsaF/C+PvFl9L6xTCIvyh8s0tqeAwRf
	MfYbRDNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r84wo-006HXk-1K;
	Tue, 28 Nov 2023 20:44:46 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r84wm-006HXL-0B
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 20:44:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A3D15CE1A7F;
	Tue, 28 Nov 2023 20:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB62C433C7;
	Tue, 28 Nov 2023 20:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701204280;
	bh=gujZTJEOqOVDu1JEDbMqwCgGnWsRjlXpLWTJjpR5FHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+qMno4csqle4TXHx08uNVbgRGQCDIl71EpbeKpRfrNkZg+aV2F4TLidMnKyUI197
	 85BrWL4oxRsWoKyeRPSDanNQ/Hbhh9HXBVCXcoJI29VhaAZdLYxCF8s+WUsQpIZlg4
	 4wEcFsxfAyEDy//BQCH4+QX+RyLwiQyCWN690VMYSSywvG9AOCU93ZPP8uPVKx83WG
	 uEW+aXvdIGeLDk6L1lueIcTU2mium24P93NNRiG8bVKFjcC2tKYC3KJdVF9vGMSlGY
	 6/1ETJ62zn/6GXJYV2dpfsVOV9thVU4Tt+onMXxfENzsBP27UvrZ3fa/zM3j0j+lm1
	 dV2UF+6vNvFkA==
Date: Tue, 28 Nov 2023 13:44:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme-core: check for too small lba shift
Message-ID: <ZWZRNpx4DoH5MxHb@kbusch-mbp.dhcp.thefacebook.com>
References: <20231128173955.339941-1-kbusch@meta.com>
 <276e4ae6-a591-43d1-a80e-e07dc72b33d4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <276e4ae6-a591-43d1-a80e-e07dc72b33d4@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_124444_351287_E1814931 
X-CRM114-Status: UNSURE (   4.52  )
X-CRM114-Notice: Please train this message.
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

Applied for nvme-6.7.

