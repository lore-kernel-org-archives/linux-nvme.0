Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4E3C28B2E
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2m9Ggudy4Qp+EEaiaMQ7gJhh+KC2it+KPuJQePTT0BA=; b=VPAlYeMU5bi4qmsjPpe+II91LY
	oqDfN+Rzr6HkqMxCBrkvaU6ManRwCdyQwhsG1rK4lcMpXCKhQZsFZN6BHXFdAyBSAsQmun6ZeekJw
	sf8ZNDBemdHiEEG52KhybAMQS/+dSf50nvBvMThETUVi36++H9U4PlU1Gn2yar4nHKOXukKnfDr2U
	iQSLtJ0E+85iAtCQ7bDbAmzaynOsnT4zrPNTlZ4fhyqy1QkkPEjS2fb6IUSoaMi2pDeUsk6Ti/oz3
	k1/D6CX2z/GHXggGWaGWWUflmsGhmOkhEWNoCrDvfEWZU3ZA8HzgKwgUvnb5Ltc+osMG5nyTzyzRt
	wNQNcTEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsQNa-00000009CZs-3Mhu;
	Wed, 12 Mar 2025 18:00:30 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsQL2-00000009Bqs-3uq4
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 17:57:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E45B3A47139;
	Wed, 12 Mar 2025 17:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA1DC4CEDD;
	Wed, 12 Mar 2025 17:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741802271;
	bh=uDUiE+/yp8r2k4rZuqZa/OaVgNzl8I5iP3BEroop3Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEXS6+/f9QzmcumVO2J/iKyttAupTIFwPauJ+sQ78K9XxXXooMpY4CMKgndSlygvn
	 fR2SnRCvRiGTTvJ19NS7H7RZajnPwAfNTx1fuSVFqC/lhuzr+avZxwgjoKBSlOZE3W
	 3pLB/SjdbGq/GSllSewVdLlzzQdwtArBvCLMZi2+mLAgseKD/NIpno79F/Bu6lTrRG
	 6rFgV7lvwLFCNBJRaPkMueID/1oZM7weIIHIIiXMoVaNItR15+JrX11pUSzbLsqCZr
	 IlUOhepp/PhgVuznsJi/NMXis2q/GVUJMYofKpbrVO3fE2YdcNc9eZLA2s1UO2E6uM
	 Sd4KpUYE0Ae6w==
Date: Wed, 12 Mar 2025 11:57:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: pci-epf: Remove redundant 'flush_workqueue()'
 calls
Message-ID: <Z9HLHHpdbDUgEhb2@kbusch-mbp>
References: <20250312085625.1624394-1-nichen@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312085625.1624394-1-nichen@iscas.ac.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_105753_041525_36A1D551 
X-CRM114-Status: UNSURE (   7.58  )
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

On Wed, Mar 12, 2025 at 04:56:25PM +0800, Chen Ni wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.

Thanks, applied to nvme-6.15.

