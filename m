Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E9B606A31D
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bwGPJe7T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=bwGPJe7TUhhIzpTJcsIrNMgT6J
	tSEuDT2OsOP8XdDJb3pcJ3yWK2GSdILxv3yQYW2JFlTKRJ19D8lQh2ObDguzjD2Q5CsmRHAeGyr/P
	xFMJiPRoSd5NGdUoS08QYAGi15doWviiVB43cY0/3GJvNsLohbhmbisF61Y9iUgWt7ol5fOedQeZX
	G8czd1S/NljegorWgeZj8qOQ/GNlt+JVYGu2PwihxBG6AajKsiogt7ilWeQUvKD+PVUDc6+4B0KPB
	8/ag8ZXph6iEdUAgCWGo0eYu5nCisieAMSL2yxJ/anMmg7Yd0SOeaWDJaES+zfJKZx/W3nBkWpQlx
	8Fv50U6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5I8-00000007JJC-2ORA;
	Wed, 28 Oct 2026 15:10:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5I4-00000007JHp-3rUc
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:10:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4BB8268D07; Wed, 28 Oct 2026 16:10:09 +0100 (CET)
Date: Wed, 28 Oct 2026 16:10:08 +0100
From: "hch@lst.de" <hch@lst.de>
To: =?utf-8?B?546LIOmiluadsA==?= <x-professor@outlook.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 4/4] nvme: harden local IOPOLL user copyback
Message-ID: <20261028151008.GE16374@lst.de>
References: <cover.1792118770.git.x-professor@outlook.com> <c8989c0d71a640349f4dc483aff0a3de6731aba7.1792118770.git.x-professor@outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8989c0d71a640349f4dc483aff0a3de6731aba7.1792118770.git.x-professor@outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_081013_121595_3E880CC7 
X-CRM114-Status: UNSURE (   7.88  )
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
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


