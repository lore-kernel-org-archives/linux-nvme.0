Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D2DC624D3
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 13:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Wh2NXwEvdcAr21ypRcmb8fNNLy
	kyvLON3gMKyN7uOhH+rBTGOElb/cDprF+kpWTVW48Ror8wyEWYioHvFp1sM6K7tbRQ7hMtevt95wJ
	mdJUzVQcuLDSgAYXev9JFNq6AUQ7lKhYeAk+an/4fKXD7JJHd/qyVzviYq7Ft5cPamLXFC1jnVgTN
	3qojpGHu892AtykK0teARAFiaHiY0TAlUSbNmE+GeCEA2FCJSh4epWPdZ9J0uOW3b74CUebDMQbxK
	Ghweob+gPccieOdLQWftwbo5I/EhAxplOFE+UbT5ENjmwlkFp6blNP+N5Ixkg8Nc6QKNAff6w3ELi
	5E9pZhVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1l5l-0000000Eon7-0tod;
	Wed, 02 Sep 2026 13:33:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1l5i-0000000Eomc-2fyI
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 13:33:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3001B6732A; Wed,  2 Sep 2026 15:33:23 +0200 (CEST)
Date: Wed, 2 Sep 2026 15:33:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH nvme-7.3 v3 2/4] nvme-fabrics: add helper for owned
 string options
Message-ID: <20260902133322.GB21167@lst.de>
References: <B1A2864319EA3B6C+20260831070557.631487-1-raoxu@uniontech.com> <9910C0FE65DE86BB+20260831071105.638107-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9910C0FE65DE86BB+20260831071105.638107-1-raoxu@uniontech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_063326_862700_79258E41 
X-CRM114-Status: UNSURE (   9.67  )
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

