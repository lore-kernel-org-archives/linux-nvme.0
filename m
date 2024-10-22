Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B99D1CDA1
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 06:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cnqrnj9aJWJgVt2IKOPriKtqVY/Q8zP9dbwJ6qeQsw8=; b=r2ru7YeCYyc/F0Pt3/QoUHXkPu
	fMKaYy4c8E67otF1a8gSaHxX+sindFRRXGRm/PCQ/HXBeNNGobK43zeS9AtS/UiTRAHaXRC6koVYN
	6CSwzw1E72uqjNN3+Vp1yqklrj/8A7wkkKT5gc3dHvZnH8SsYkxgunVR/TVfjMu2G5AbZY4k5lh70
	QIm+tIi3JdFlE/4GSCfYg6mt9E1FJSzFoTiUTiCcnTqhCNizyTtHProC/1Xew/pOX8yY0sfwWJcNF
	ZC45ZkhA2IBDDUwzh434+Ae3X78VeWCE6rTXPxhcIV3KM+iioGqBXjR6ZIze9z42zzpEToPMcrKXN
	USEtfE+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t38NM-00000009oCG-4B7K;
	Tue, 22 Oct 2024 06:28:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t38NK-00000009oBk-32gM
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 06:28:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D46D227AA8; Tue, 22 Oct 2024 08:28:10 +0200 (CEST)
Date: Tue, 22 Oct 2024 08:28:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] nvme-loop: set blocking flag
Message-ID: <20241022062810.GC10573@lst.de>
References: <20241017172052.2603389-1-kbusch@meta.com> <7846e57b-fb03-42ed-af8e-0df88cc566a4@kernel.dk> <ZxFRpdU-GI76uetA@kbusch-mbp.dhcp.thefacebook.com> <20241018051056.GC19831@lst.de> <64f4d599-3261-4544-90c2-4cb3e1ad96fb@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f4d599-3261-4544-90c2-4cb3e1ad96fb@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_232814_930764_2772469B 
X-CRM114-Status: GOOD (  12.47  )
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

On Mon, Oct 21, 2024 at 12:35:17AM +0300, Sagi Grimberg wrote:
>> Let me see what I can do.
>
> Note, the search is ONLY in the error case, i.e. when nsid is not found in
> subsys->namespaces.

Which kinda makes it worse as we use an unusual context just from
that rare error path.


