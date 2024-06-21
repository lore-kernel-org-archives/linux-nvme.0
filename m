Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51370C2BB85
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jun 2024 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TxXXG59QMvto5CMfLRIqLMTdm1Pz1K1QN24vGpLQpv0=; b=Vh9zkI0lxF64RP7wmss+IGfR5I
	wR3diqH6lVvzjvxpO4e/Ur4a0vnpsJejhvW6KOPhnCd6qhKiolrrFO77mqFwf7bINurvHcVDf/Y4/
	5De4HYruMU3ImiS9jNZh7FYX32EblWu6vQlmzeco+APdnf/zdcc3cshOfxaoZQcE0PdJsrs54tNND
	k42xrJY7NetThxjtx23hS0h9uTNr2CNuK4nep0F0mZkRe0nJ9Wg4OJqLrx57M2VMhjrq76iS+rrgz
	VX8TYKvZlhxvUXIDMnEngHfnPORyXL1gATWPD6wugQHkJiLhoDyLY+uHbDnSJLflTsYResBO/jvgo
	Ho+nekfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKjHS-0000000AGPx-496B;
	Fri, 21 Jun 2024 18:46:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKjHN-0000000AGOv-4C8n;
	Fri, 21 Jun 2024 18:46:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EBBBB62F31;
	Fri, 21 Jun 2024 18:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE150C2BBFC;
	Fri, 21 Jun 2024 18:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718995592;
	bh=hGWFaeKo6xY0d8c6EUHTKFxGmvR2STDskrDV3QJjCJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RyDOWkzQNhc4cnXSG2+ek5wjUB23AHoh1Ua8eWl/X4+KBDAwZniV3sgHnVFk3ra/h
	 3D+40sNMNRBX7a1L5S+ybM8/mqf+EQl0FhDyXIj9SNtt5Bwv9VRoudFOQyH2DFyanv
	 vRMtNF6QO3NZXIQwx930cKGMkM9hi/zk4l747fxdgIOSBx04HBxK/B8Y68yasRvQ/t
	 hDNPUVKVMpRDXB03G6mo03W6Dc/yBydkk40hHLp9FmEeM2dFzloahpIXpv99c4/OnR
	 UzvxKIl0Mrk+Ma1OV9ahWztP04cuOphcoNqbwDlhMZljBE62Qo+/kpka3ubzqMGZOz
	 YfUxWJlVcC15g==
Date: Fri, 21 Jun 2024 12:46:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Eric Curtin <ecurtin@redhat.com>
Subject: Re: [PATCH v2] nvme-apple: add missing MODULE_DESCRIPTION()
Message-ID: <ZnXKhUMDenD4tnrn@kbusch-mbp>
References: <20240620-md-nvme-apple-v2-1-72e9d7151a1f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620-md-nvme-apple-v2-1-72e9d7151a1f@quicinc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240621_114634_281971_C0EA4A6A 
X-CRM114-Status: UNSURE (   7.57  )
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

On Thu, Jun 20, 2024 at 09:42:18AM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-apple.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.

Applied to nvme-6.10.

