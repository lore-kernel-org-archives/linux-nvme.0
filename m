Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7780C5DF89
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 14:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hc3W23XMhYAH031LbqZW55Gyam8qSUinkvhRr0nyNa8=; b=ucJL29U6a9OTHlH/VimXmuNKUH
	Rd+BigubbHwrV1gwoVYki48Iw12rZB20DHky08LvdUEgt3aYajLtgCTdPs/jMTJ8Uo9tryoW3OfAA
	bIquYv31u0bhvIvdwGSg4gL/DgBIKTZshqVNHdkdh77+UoQp+Wp8lXxBKSVjpEQ6niPR3F1Kk5Qpl
	FqWRtPdDsLk5lFsuA03YvmtZrCgSwnrsByDAHTvepPkJXfQX9CDbY8qI1R6jrW8bwUl8HbFsg3Kup
	O0WrbWnhYCdLj36McXUg5UZHp980qiXsDGwMa7JyFuFly6cWtygEksVTavfbtTpe7Xf3OiYFqCo+m
	Ro4oAPWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQLU-0000000DZTB-3J1b;
	Fri, 21 Aug 2026 14:35:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQLR-0000000DZSp-2oel
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 14:35:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 452834344B;
	Fri, 21 Aug 2026 14:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5FB1F000E9;
	Fri, 21 Aug 2026 14:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787322945;
	bh=Hc3W23XMhYAH031LbqZW55Gyam8qSUinkvhRr0nyNa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mO1LUle4AbhIyhVP1dOaWVoCLfghie1JpRjv4L0HqwhC5qKdP6vPueiJxL1IMYWzA
	 P39cDJx+Ws1XpH9rDDHbKIVooh9ZepMboaNt4Zrv23L6qgAzqMyjO0MbwRPDhpzSjD
	 2O4cHFNfawP6PNOl+TZpAAfNNE9YiRunAP1ErmQQzsgbPa0GXpejH5swYChi7qtCQF
	 sJy81kRG63Frt+dtgUkKCJE2mlkFI3NpP9fsYK1qGxS099U6WBMoBrBquKCNXIZ2FC
	 QAo9Zk8AmetU3TfbCa8uFu+toqyW71Y77Je2jZTxMqSD4eJ4o5R2w8ZwdTyBC/6ReK
	 x62fZefA8TQ+A==
Date: Fri, 21 Aug 2026 08:35:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Rihyeon Kim <rihyeon8648@gmail.com>, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <aohiPzxHPKtUT_E8@kbusch-mbp>
References: <20260814143833.1953415-2-cassel@kernel.org>
 <20260817061815.154794-1-rihyeon8648@gmail.com>
 <aoMkX_davK7TWlaj@ryzen>
 <aoXLiFruG5s1nKch@kbusch-mbp>
 <aoX2wcyhpakryWHX@ryzen>
 <aocb3ogg34WWtRSB@kbusch-mbp>
 <aohQ9NcuMtSqWvvd@ryzen>
 <aoheN_L3iJNU3Ji6@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoheN_L3iJNU3Ji6@kbusch-mbp>
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

On Fri, Aug 21, 2026 at 08:18:31AM -0600, Keith Busch wrote:
> I think you're relying on nvme_fc_init_ctrl's nvme_put_ctrl() error case
> to be the final reference, but it might not be if the character device
> was created and someone opened it. If so then:

And a successful open requires the ctrl state is live, which it is not,
so it is always the last reference as needed. Okay, please let's forget
I've said in this thread!

