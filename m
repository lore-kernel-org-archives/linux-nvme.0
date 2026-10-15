Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7547CCA464
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 19:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v9hDISTkD44YeGplpGIGuc0gOeozoIU4hdy1VINfeOQ=; b=fvO1dQZfBkKloAT6MSOnYdnCaf
	0fgbURZIYe1vjbPT14+JvnFsRBfDdEpTkY+LHyU9VSXFqy5UCgYwN7/eBs3NKdOBgns5i0w9EPfgQ
	QaYU8uf+DjSZN3gAxT1l9AQUhByeMOAq9CaIV8Z5+kUuvOALIwTI/QupncDnnJJttb7nPqomRvhJu
	8qfPqeVztgSTVdDI3j+W1DL3FNxpEOdwJRjABS9U2ChifrAN1n9uh8+kIOonUz7nKiuTTY8KQx0Sk
	Z5PN/QRntGDB49tayMxg+7hI2wea8BEPKTHSZjH7j4Nncq58r+Pl/eENIaeKCOLuZgNkXbNuu9ahZ
	rYHyfvmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHRFc-00000001G0i-1pNg;
	Thu, 15 Oct 2026 19:36:28 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHRFa-00000001G05-21CW
	for linux-nvme@lists.infradead.org;
	Thu, 15 Oct 2026 19:36:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D91FA43F57;
	Thu, 15 Oct 2026 19:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DDA1F000C7;
	Thu, 15 Oct 2026 19:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792092985;
	bh=v9hDISTkD44YeGplpGIGuc0gOeozoIU4hdy1VINfeOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fehQpOdxJ92zBZnAMvWcvMcU7Tk99+PiXNAJl37SR4ISj+meCRk80MOU2i0r1E0qY
	 idy0lVBW/b2B41jQJcKKPkFwYAss5swT9LHvgv+d8ea6MAPTYScFCxlYL2SCHyWDp2
	 reVokB79b4A8q/zBOkF2LqLHF9a8EGKMbqqgtKDjISrUKEA9PmIqgdA0OmBKGTwOV4
	 KVsNIGQTMVnAPwEyyS43RD1OnzzMZIiYnzbuOcsbJ/l+uck4z7i9Qqp3MgIdur2EpX
	 kEoiMYS3NBgZKkgS3v/jI+ySW6TI8CvtMp/Ig/AVbGjzx0NjhO+MZKhyouNnfO3u8x
	 /Q2O+Wr7utxHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	axboe@kernel.dk,
	cel@kernel.org,
	hare@kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	neil@brown.name,
	sagi@grimberg.me,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y 0/2] CVE-2025-38264: backport fix series
Date: Thu, 15 Oct 2026 15:35:47 -0400
Message-ID: <2026-10-15-1-daily-reply-0004-cve-2025-38264-nvme-tcp-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014191236.23696-1-artem@trailofbits.com>
References: <20261014191236.23696-1-artem@trailofbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

> Please consider this backport series for CVE-2025-38264 to 6.6.y.

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha

