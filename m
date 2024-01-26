Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF137C47422
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 13:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=beuE58S3O/qmXDluX8oVhwQudK
	vIQ/U6h+p4160rbq2Nzokd8qnUFVmTPJT3E4IDgiDQeA19m6gg4UDiZgV7NWWMEg67s4WSDksW5TV
	CspOgqDlc45wz0T5vMW9N+W7gQX36acPC6jFY5F/qpKBV8+M2m7PQQ9cXR8KRtFK+dYF3n/M+2Sb/
	ZJ1Isxl6OiSg2Erimf2f/swVmS2eFGv3a03ehBLwYAj15K+FmCoBusRScQXXxvIDGEBb8DA8YaZbL
	Duw7DaPndvAbeU9zjLmdBpM6tclSKXiBSWZwDvHTwy8WipGxB4ErM5CHNZuNAH7/FysZXPku9ZfTG
	6Ko8o++Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTMWM-00000004Ewa-2gVR;
	Fri, 26 Jan 2024 13:45:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTMWI-00000004Erg-1AU9
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 13:45:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F165368C4E; Fri, 26 Jan 2024 14:45:10 +0100 (CET)
Date: Fri, 26 Jan 2024 14:45:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: fix nvme tcp ida memory leak
Message-ID: <20240126134510.GB2928@lst.de>
References: <20240126082643.37656-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126082643.37656-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_054522_584831_E0C28351 
X-CRM114-Status: UNSURE (   9.15  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

