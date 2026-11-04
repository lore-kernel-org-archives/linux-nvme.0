Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031A606A31B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Edm/2sKX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tF7vb/+2HH4RmBCXbbqowPNtOVRRuqzpLV5QvncfGo0=; b=Edm/2sKXNhxcHmwy+ev4KiJ1X8
	rs5z38tF1V2NxqljmosbpOTXoeqhYfmskUTR63JnZjCOGhsi5Lxcd7LRA8tlLsiL0OATD6qOyW1Jg
	10Cnvf+63oJCpL8n0dh+xHEFuWp8czVvvevZSoEir5CAlzwbEB8pxTsZM+/sTOYyFnJGM2nFEUrWe
	GX1ydnvByu+8If9ZlNo8a2Vxa1qhBukyFs0o4DuBazRqmDP8/AmFDwhygF7MXwiTEBarL2WNtMlts
	4Wzrk1gfw9CW+jtHmWMF1YwnxLsr3U+UfjdwvuQ/2SfBCnYgn8/C/ueXke4dGtSn9aw4EtBGt6vm5
	P9nwg2gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOWgG-00000004lEt-35NZ;
	Wed, 04 Nov 2026 08:49:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOWgE-00000004lBi-1JgN
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 08:49:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3AAE168BEB; Wed,  4 Nov 2026 09:49:09 +0100 (CET)
Date: Wed, 4 Nov 2026 09:49:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Omar Alzand <omaribrahimfadel@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Bean Huo <beanhuo@micron.com>
Subject: Re: nvme-pci: Micron 2200 (1344:5410) needs
 NVME_QUIRK_DMAPOOL_ALIGN_512
Message-ID: <20261104084908.GA30548@lst.de>
References: <CALJMncxA-=OFc05Ht74hWnia8-sCd5yLn5hK+KfnoHMO_sbzSQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALJMncxA-=OFc05Ht74hWnia8-sCd5yLn5hK+KfnoHMO_sbzSQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_004914_506219_FAC14E90 
X-CRM114-Status: UNSURE (   9.55  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Can you send an actual patch for this, please?


