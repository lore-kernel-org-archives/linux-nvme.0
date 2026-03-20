Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E511093182
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 07:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RRujDutYVALvYPggb0Z4EFfSLAtVV7P1KozZLGNmeLM=; b=u8vVs+G/q/ZnOI97va22huQ2qN
	0N4g3U911LRx9HcAUsDZPIGvzLmMcDYC7iSOeHtu/aJDeLWsrYmz6lvRlQpH2g3fTfi/nSl86DUHY
	AU+j42q5zxDpzIt0etVD7Kno2idqBnr3DizrdXeSbCGLlFZby+5mKJmGFu4VHrd0fkpqOqPpNsxvU
	3IkH/hMPd+SFm7OM3uh7QZdxZBmgFnkktvPff6zctqSA2qc1j59KmjhjMu986PcbOHxXl2+CJnig/
	IiVbQq1Fk3/koD1aAB8RZd6qptwoPEsMtiepq0ZgzLmpB6c9qHrXFNdIuXp1t6MqPiJzw2QDIhhOE
	vq3L5kNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3UZO-0000000CHci-3ieO;
	Fri, 20 Mar 2026 07:46:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3UZN-0000000CHcE-0cP5
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 07:46:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 82C166732A; Fri, 20 Mar 2026 08:46:52 +0100 (CET)
Date: Fri, 20 Mar 2026 08:46:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: gregkh@linuxfoundation.org, security@kernel.org, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: check INIT_FAILED before nvmet_req_uninit
 in digest error path
Message-ID: <20260320074652.GA14485@lst.de>
References: <2026031827-carving-overdrawn-5b1f@gregkh> <20260318225658.1760759-1-kumar.shivam43666@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318225658.1760759-1-kumar.shivam43666@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_004657_328245_14849489 
X-CRM114-Status: UNSURE (   8.32  )
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

Looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although I'd prefer if someone more familiar with the TCP code could
also look over it.


