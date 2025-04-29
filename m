Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A33FC3ABA5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 14:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D3++h0pDGnu4p6eFdOQ16NLPTUz6uA0sGHFpiQTU/AQ=; b=FBeWLXuQuJAPNif//tcwZdtuRg
	QbcVkFYBPQZzItnALYvw6K7B3tWG2l6A4idkwoP9sAY/atDyfwheWZ1pwFLuJ2xV0gDiQlaJKURFa
	zy6meQnwoyz5B5YGFidlV4O1OVMElE9X07Cs4rXnHXrwmvkimi4I6OGH6QwKOCZOnRpSYwbOPYrI6
	kHcbpLlMPA2q0jBDebaMHz6q9v4p71s89yS+oOS0aiqAdd5vDnhB4F3vRk+KG2An+tZAAmfRCK6WT
	6e4bP1RCjcw0ibRtzmb5aMDb2qGG7kN5FdYj7keVYytsCk/zRasNuX9FtVO5zQ1uHPhWMOM0OGytq
	1Y05Gy4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9lht-00000009s0i-2YOu;
	Tue, 29 Apr 2025 14:13:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9jq7-00000009cdE-1J2e
	for linux-nvme@bombadil.infradead.org;
	Tue, 29 Apr 2025 12:13:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D3++h0pDGnu4p6eFdOQ16NLPTUz6uA0sGHFpiQTU/AQ=; b=an0kt+LWEc6yVH7tgzju+FK/6V
	CJu7EpBwLa+JobOm5M8CqdGQLF00qnMC0bUXXqtVpwHNTWi0DoRh/b9j68w5YWevqkMLCcVFxJkAM
	aEMEdQ/+UG8ogY2isNX2dedIYJycJAVypBdm8feVZOwaTchCFX0rnubevC0VdBvjhvabFYJpZeaes
	MtGeZHaRS7Uh7TPP6lFInIMLIzWq5xOp9mNkOfcVrP1sy7Pz6tGO2CGhy27F0qyMiHvVqtZPNB36H
	KzO60zI8fe2hqhxrwfgjRdvOAbH/71ao1UtyjnR2UuUlCTlnPz0CEXen5F/4ebzU1V7ov2Ea4mOEW
	fh0cN68w==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9jq4-0000000DJvp-0jEj
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 12:13:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2072568AA6; Tue, 29 Apr 2025 14:13:21 +0200 (CEST)
Date: Tue, 29 Apr 2025 14:13:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org,
	Dhankaran Singh Ajravat <dhankaran@meta.com>
Subject: Re: [PATCH] nvme-pci: fix queue unquiesce check on slot_reset
Message-ID: <20250429121320.GA12411@lst.de>
References: <20250424171801.2300390-1-kbusch@meta.com> <20250425131935.GA5460@lst.de> <aAudOMQi05je8ADN@kbusch-mbp.dhcp.thefacebook.com> <aA-dT-iVfnSVx_6u@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA-dT-iVfnSVx_6u@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_131328_337180_607B16A0 
X-CRM114-Status: GOOD (  16.41  )
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

On Mon, Apr 28, 2025 at 09:22:55AM -0600, Keith Busch wrote:
> > > Sounds like this code path isn't get teste all the much if this stuck
> > > around for so long..
> > 
> > The conditions that trigger pcie errors were the primary concern. Of
> > course you'll get IO errors, right? The pcie connection is flakey! But
> > we are supposed retry IO's after recovery, which we weren't doing, and
> > that was a secondary concern I embaressingly overlooked for many
> > reports.
> 
> We can still take this right?

Absolutely.  Just wondering how this managed to slip through.


