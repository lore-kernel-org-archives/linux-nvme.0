Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC34C5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xf869Ir6xzy85BoPj0YomLdvYtgla7eQT/1UGeREOqg=; b=OW+BUrchUMGR5S4ch3Jw1HAMHE
	mIW36JGCQtTeGPN8xE/YnImJ44g4QgzxpGNhftJ9OFvnpZc5dM5QjgbQQ0RcBZ+UFqECLOJ8kBrjr
	yIDK2PFt5NzNZdHrX8KvPC5tXVTiwWCR+J8skynVyS30vUZsxHwVowwqK/wtntT2FIdbaxSo87Ak0
	CN8VpqSdcXovDXFyoYLm+3aj/kn4gHGN1gAtrYJYl2si4zUfwHQpNR2i+SF0keCwwMYDs7GTcUNFt
	UxArTQRevOiMpA3dX7rLvofuspIEY4dtWD6F3DJ+l53br+27snV5k3vifKIBnJ2sOt6+76XHy77/D
	DWAnKG4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiD7-0000000A5Qf-2bjB;
	Wed, 19 Aug 2026 15:28:13 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiD5-0000000A5Pp-1BTG
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 15:28:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4C5EF61836;
	Wed, 19 Aug 2026 15:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8946C1F000E9;
	Wed, 19 Aug 2026 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787153290;
	bh=xf869Ir6xzy85BoPj0YomLdvYtgla7eQT/1UGeREOqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DTRMWj+JvfKr+0W/2aIbf6vFKQ3T2gtQ+ahLpUW1bMzo7stuVSVeoTPATG5TGqxAA
	 VD9J8sByu0ibyB7n5jHseFpUm85DMHY42E57EvkcT88dgyNInyEfL6e4tAAT19ZBsH
	 /g3hbG2lhxHeXl6SfGrbqLIIY7aAJZ7SKoPxGY6/DJSKrx7Hhl7/7poMstU/MCSdVm
	 RXJ0InrVh8nS42wwgId+HiyFPalTfK+WfQ8bzG0ktGZDoVh3zv1JDzk9tuDtbTxXRz
	 VyU0EDdCX3KhN4FquH0iebu1YIcY90LI3KIEmplVTigkII0s+DUGjN8uC0qyPDBy60
	 nBqkZSFf1Gm+A==
Date: Wed, 19 Aug 2026 09:28:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Rihyeon Kim <rihyeon8648@gmail.com>, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <aoXLiFruG5s1nKch@kbusch-mbp>
References: <20260814143833.1953415-2-cassel@kernel.org>
 <20260817061815.154794-1-rihyeon8648@gmail.com>
 <aoMkX_davK7TWlaj@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoMkX_davK7TWlaj@ryzen>
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

On Mon, Aug 17, 2026 at 05:10:23PM +0200, Niklas Cassel wrote:
> It seems like Keith did prefer your patch, but as you said, your patch does
> not avoid a NULL pointer dereference in nvme_auth_free().

But you're replacing a NULL pointer dereference to a derefence to freed
memory. That should be fixed too, and I'm just saying checking a pointer
for NULL before dereferencing it is more clear than checking if a list
is empty.

