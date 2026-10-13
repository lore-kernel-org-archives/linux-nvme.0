Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC93CC6B08
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=OSV2Jow6k7ZXBazvOenlN/AK5T
	DZov3DrW6yCia2gfF/BWVEwlaN51/lDT9OYa6rp2EDT+8SZIA0NH0z48u6KDc66jdyLHJS+SsL8AH
	98PDoOLGMoTG/mBFPGGH2vq9HhsT7CB9GrS+Y1YDHRXwzAIz3d0ibeSQN3HN6c8rN2tBoZPezcB2N
	E+QzwKZUDAFLvxqwEMTUK87Wl7Mi5G81kBiLfaRtHrN7of/RjsELPJSdvsFfQKz9YXAArjHuTWvkw
	cBqFtTFLZIMF0HVWbe+cXK75DUMZBEk81NqUfzuqBQplkQRJ4/UmBKjwSqXSYNxBsuGKwASlBsvun
	R7wUbTsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdQz-0000000D581-1KdS;
	Tue, 13 Oct 2026 14:24:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdQw-0000000D57Q-0zvx
	for linux-nvme@bombadil.infradead.org;
	Tue, 13 Oct 2026 14:24:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=qz8NqK6b2I2parvq8E3+7zIkfM
	TkQzfTvE+ull8ASgmpyLdEwmp9ozPy9wymXljlftyFLmNofP3Fl0Vh2hLurY5gKc6d13jJyAmrAH+
	uzxXwxb9f93G4II6OSdaAL0L9NQFW5MD+sexn5EQnafZwgESlpcefTeU4DPsRtElnUsVDMP1k9l7P
	QMJtziegtmPRLAonpmwynkER3kOKxFAAvRUmerxBZi2aC9zb87C+hideyqNvNQA4haydelYT1CZsW
	yISRYt5Q6e2aU2XGvEeHAIxOQlVJNVcWmUohDVFWmspKpD7ymX36wN3b3LSoKtWPtXooTff4bG2E0
	LNzvk1LQ==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGdQt-0000000Fde4-0rCW
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:24:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E5F75227A88; Tue, 13 Oct 2026 16:24:40 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:24:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: tjdqudcks0424@naver.com
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-auth: reject undersized AUTH_SEND payloads
Message-ID: <20261013142440.GA14759@lst.de>
References: <20261008183810.10455-1-tjdqudcks0424@naver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008183810.10455-1-tjdqudcks0424@naver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_152447_479912_FA91BFC4 
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


