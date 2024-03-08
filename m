Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F30C5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=edUnCEWtvOg+RoGWpMVbwDRwTn
	3qvYKDByyt66qUtiY/7xxcpJK9Idcav/Ben0mPKYrLnhmqUqXEoEiHQBt3nnDvEFX7mUuBlyTqptn
	+Ukz8eYg/RnMZsyoBG0QmLA3CkaXJwXrXGQHrUHAC4ohMQZ4XkF+3r8wnAaLXGp2N44t5i3ufX7SV
	TEGl4N1Skd+Zlz9Lc6VD3nqTMvOLyRXObFHdhyvyRlgCdMxmAgBtCG+EuvvdYoWoM5O0cR2mL+1/X
	j2v3V8Va05P7Z+Xl94aqSIU1cwkBgWbkhalBjQnuHt/bsb27JoS40YXN93lJL6INX/c0MPIhcf1/7
	BIsZBn1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ribTC-00000009e2c-483B;
	Fri, 08 Mar 2024 14:45:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ribT9-00000009dzg-2z5i
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 14:45:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE44568BEB; Fri,  8 Mar 2024 15:45:02 +0100 (CET)
Date: Fri, 8 Mar 2024 15:45:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] nvme: change shutdown timeout setting message
Message-ID: <20240308144501.GA9575@lst.de>
References: <20240307165933.3718589-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307165933.3718589-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_064507_929537_E5873E51 
X-CRM114-Status: UNSURE (   9.09  )
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

