Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394CCC83F1B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 13:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BH/BFS4DBD/MyEOZSB2vsiZjeO/geaFzg1v7t3pZn2g=; b=KgubF733dj7ldsTSuyWjcoYxq8
	1wTbomwOetWME0nfy2tB1AwNpUGh+OHiJsa/bmMF2ZofFgWM+BBfMBbcA+jT/gKZwDYrB7ZUknssf
	AAld8tJJatA0Tps3ZpesrVcyDJpV2ElUqV1eu9YiCZK6qpJ89pYbYWyeq6pPiubX0t0xtwBWKSaZs
	8hux82BZnOYb8SrnGxih1LXRkFcrUjy4qtwr89TazEF+3S89fx6ig+t8fDO6RtJlgqhRlA7I+Q7Kp
	r+5gsiKBk3ZMYhAAESNojRHVpBST6XkRBo+k6z+RaFDnQMIqXONwYwapQ4P6S1reqx0QICLkcInBA
	BoBd9MQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJfN-00000002Ns5-33sz;
	Mon, 14 Jul 2025 13:56:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJbz-00000002N8V-3rJR
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 13:52:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DC075227A8E; Mon, 14 Jul 2025 15:52:50 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:52:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, hare@suse.de, mlombard@bsdbackstore.eu
Subject: Re: [PATCH] nvmet-tcp: fix callback lock for TLS handshake
Message-ID: <20250714135250.GC11944@lst.de>
References: <20250704144455.244359-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704144455.244359-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_065256_091104_4C56C249 
X-CRM114-Status: UNSURE (   7.90  )
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

Thanks, applied to nvme-6.16.


