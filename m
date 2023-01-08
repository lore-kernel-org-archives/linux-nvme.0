Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C01C54EBE
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Jan 2023 18:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2hgrkPgfB3GRsCK3NmF2r7zO75FK/ebcJiITpxQa4w=; b=WNH4eAUd99XS4alaDfH9ALU0++
	NmI35Q4zj6+YTVDpxSIDq3RZGv01UgviFW9pEcyuEtJUXTvejzbI1gZXyo4XijzTFQOx03wmT9WNo
	9l0iTSMPJbVpnKxOXCLW9RDduc8fxxk2G0MbP+fx2YR3jkEcxnngYVncZC+bLM/7pvuG2t6SticXU
	DsqfeGURYkJzZ29cesjYr+NfaFDxoN+PTfDq3bvr97b/UZFeTN2XnkrBVO39dKApnjnv73J7Vo6Kl
	L8Tme8ih3cw5YHAKzBhKGVoFAeDzuMFpLoQ9rkM1J+WvLWNpH4pHyc/xphJ3lc30vad9zVCIfrGnH
	2IUAyhbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEaIf-00F9Rk-Uo; Sun, 08 Jan 2023 18:21:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEaId-00F9Qb-Db
	for linux-nvme@lists.infradead.org; Sun, 08 Jan 2023 18:21:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2A8168D06; Sun,  8 Jan 2023 19:21:36 +0100 (CET)
Date: Sun, 8 Jan 2023 19:21:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Mark Lehrer <mark.lehrer@wdc.com>
Subject: Re: [PATCH] nvme-fabrics: clarify AUTHREQ result handling
Message-ID: <20230108182136.GB25544@lst.de>
References: <20221208074920.43828-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208074920.43828-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_102139_621974_C5889B37 
X-CRM114-Status: UNSURE (   8.14  )
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

applied to nvme-6.3.

