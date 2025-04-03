Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D9DC3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 04:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ApcdTXU8noqvEHL8TmokNvDKKue7lSHehf4idoqbia4=; b=JNLrSE4xB1hnF1PpEipWnFgmLV
	rA58byZAlVrgbrOzEXLA7ySSGqNfEFkfmhxajaJCKTFvAs1FQoy9H0n3wI8wnd3vLrjeNNIRqtqyR
	X2C34NrK0wJ+pLQ4AO8UE8gmC5J7xZHprVgp1iVoeSbv1SzGf9a/JVDHhOkCvJ4qD8WPQwXppI2oG
	KRLuM7YLjKJbaxs3lpvChRst77n5hQlwZ12Nz2rSqKZFyMG/s62H9YIF/V2xxh4dAPq3e2G0VpptZ
	deRMavA+Aomp7vsrMhhNm+ApBCv8T/4c2talcRWw5U68e3t82tDbV//hOXJ12MoB3svevmYpKIidR
	d1V41+xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CQL-00000007lTy-0AmC;
	Thu, 03 Apr 2025 04:43:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CQH-00000007lTa-3nb0
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 04:43:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0FB3C68D09; Thu,  3 Apr 2025 06:43:21 +0200 (CEST)
Date: Thu, 3 Apr 2025 06:43:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, kuba@kernel.org,
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com
Subject: Re: [PATCH v27 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer
 registration
Message-ID: <20250403044320.GA22803@lst.de>
References: <20250303095304.1534-1-aaptel@nvidia.com> <20250303095304.1534-16-aaptel@nvidia.com> <20250304174510.GI3666230@kernel.org> <253jz8cyqst.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253jz8cyqst.fsf@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_214326_109292_E2C34237 
X-CRM114-Status: UNSURE (   7.95  )
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

Btw, just as a reminder nvme code has to go through the nvme tree, and
there is absolutely no consesnsus on this feature yet.


