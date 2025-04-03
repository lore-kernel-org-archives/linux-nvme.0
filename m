Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B5FC3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 18:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JbmbZUXc8nXWT1MvSUKykn0ko/8qW8sdf5Cdf5nOn6w=; b=TfuTs+jGqCPWUmCnQf+f14g6UB
	GbBNjJ4Eu4rQ/ZhI/kxOwbTAYxkLOsnrcGCW5fJWiT8mjLLlOSOCTEi/k4CN65LtxLa0K4qA6SX7Y
	LQD21rLBRbZ2T546yZwsSq9OcWM++titC94MlQ2shci68DSM68pGDJ7JyJEwl/2BKBjgeSiPBzbG5
	Li2J/2N3otPokDRqBMHJOKKAYeA5ESPh7bLvB4/y44hsiSNUJ4QKisQczEjJB+m1sMl9VlkmkdN9P
	OLyjcN3Vw/T8NM6v6GbD1ZJmLk8u64ZBWQoq8S4IGqulJeWUOGHKBW1/oftQUOJmimFMjMeFAXV/F
	28uZVL3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0PFe-00000009Yhw-2mdv;
	Thu, 03 Apr 2025 18:25:18 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0PFc-00000009YhE-1YkP
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 18:25:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6923EA45988;
	Thu,  3 Apr 2025 18:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83722C4CEE3;
	Thu,  3 Apr 2025 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743704714;
	bh=nHpHd22Uf9CBgw1cluRB5Tc9Uc69NrRZE5fzI8ZSuZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pW9Qxnda0DT8cN5oaBYb2wGCH1UEFpnH/ltXXBf1px9USGtSGAXeVdl16Q9PgDzAC
	 WTKiQvyRKQj71TLoER3UydGlyQ8ByRf+VzYs+h6B67T52ksooe0/ow6KyvlpM9EmQP
	 H0ZiclKFtS639oyPjwuOnuxGRc9tZ8emA093SfFQ+BS+DjsMKRCF1QqU/od6FIWiPy
	 UYV0YGUkTbzj8l/IC0TwUAsJXig/jHL95QjhFfnBrH4kY6Z37PNDvq/KRodNvS5rpd
	 OkS7Mr3o2r9EFdF5wb3DJP0Koy1aLp9jDcyxvjjXr/EztI67/xubugBWLPk4Vn+tAH
	 z8vETiBHGITMA==
From: Daniel Wagner <wagi@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@meta.com>
Cc: Daniel Wagner <wagi@kernel.org>,
	dwagner@suse.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] libnvme: do not byte swap command dwords
Date: Thu,  3 Apr 2025 20:25:08 +0200
Message-ID: <174370469983.302215.9128483084565195654.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403144315.2576523-1-kbusch@meta.com>
References: <20250403144315.2576523-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_112516_472555_28473EDF 
X-CRM114-Status: UNSURE (   6.72  )
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


On Thu, 03 Apr 2025 07:43:15 -0700, Keith Busch wrote:
> The dwords always need to be set in the cpu native format. The driver
> will handle setting up the SQE in the nvme little-endian order, and big
> endian is never used, so this byte swapping was wrong.
> 
> 

Applied, thanks!

[1/1] libnvme: do not byte swap command dwords
      commit: 89ac31f536baf15c1834f877b4c1fb9aca1cf94f

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>

