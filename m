Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E560CFD31C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 06:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GHhDYs/NbfrX1QvsfomErwc0XKBw2q5enlKAIz7GdiM=; b=JLchohZ8yM2otPeBVsB6nbBP5e
	RfIF2yjMyNbu4NoKrxWzvfIqUlQNMFCaMMmHdlUggnopyQQsA8Gr5TFOCLv4n7edYE+5GTmPtx/gx
	jP1DtlFy9WhsNIJufTPVSfJi1a7ipmYlHD0IaGhrnDN4GPRqhY8ccbeQwJkJnt5sPJLlUpg+dw04/
	iD3bJx/fiuiOmwSdr93GhV1JuvK+kNs4iyd11tmzXNI1g8THURqqbgctCsZAFDJksYI/IBzYtuioD
	t9e15nhNqKteiSyfL3pRyy6nz+YWB23VQiH/cjX9ZVZ6xlYFMFK41oNviYhBGL+USTO3FYJwrtQsH
	o2QbClqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNQ01-0000000B9Eh-22fc;
	Mon, 24 Nov 2025 06:24:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNPzz-0000000B9Du-0jXz
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 06:24:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6533D68B05; Mon, 24 Nov 2025 07:24:27 +0100 (CET)
Date: Mon, 24 Nov 2025 07:24:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH BUF FIX 1/2] nvme-tcp: use __fput_sync() to avoid
 use-after-free on reset
Message-ID: <20251124062427.GB16614@lst.de>
References: <20251123191858.69957-1-ckulkarnilinux@gmail.com> <20251123191858.69957-2-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123191858.69957-2-ckulkarnilinux@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_222431_357825_1990C018 
X-CRM114-Status: UNSURE (   9.35  )
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

Please add a comment why you need the sync variant.  Otherwise this
looks sane to me.


