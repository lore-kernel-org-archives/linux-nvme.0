Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BE1C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 06:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=cxG+IZ3PwjXgtQwJaOePY/qSHP
	vbduaVa3xhJjumPF6XvE4suEsxuBPMLfOX95Hq7Gp+2TA65tp6ohPNO0UeSFrqJ7INAo4HtWQVU93
	JsUOzKxcsJehWZPplJlQiLcxktdGzbcOsZQi6GIihtoCotFw/DpoebXDlw+QPf5yoQk459TVRFVgQ
	TPMA9w3LjbVXQAYy+CecVdFVlsAE8mT+Dy2Jyd9siJCdjk+R2+0eP7LgHyGQv+Orycyvcnam/Bjqw
	SLqsqUVZybTNG8VhSVBmMs5Wiam+1mirgqWDdNN8Rs8gONhj1WTDi7F5tqE+2N5kQRMtSxFfCmupS
	5GsqN+xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noJDi-0007b2-ET; Tue, 10 May 2022 06:19:42 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noJDg-0007a5-MS
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 06:19:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0C09168AFE; Tue, 10 May 2022 08:19:38 +0200 (CEST)
Date: Tue, 10 May 2022 08:19:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: set dma alignment to 3
Message-ID: <20220510061937.GC11094@lst.de>
References: <20220504184325.1439476-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504184325.1439476-1-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_231940_926609_B517E4F9 
X-CRM114-Status: UNSURE (   7.82  )
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

Thanks,

applied to nvme-5.19.

