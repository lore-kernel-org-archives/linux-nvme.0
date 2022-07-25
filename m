Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C535C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jul 2022 05:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=bf3TqM/nLMGWa87BigWw9sA+mT
	ezP0dgnwXXsaGT37YJhO+VKvZlMr8AYgrAJCDIeUFapz6SUZr+tM/3qhdkU5zs3xbqSjMnr1kLBrs
	qn03Yw88lZO+yhwzGQxFJ+An6f5HV09j2fkVXLJvUNyeCz86Bp26SflfuaWKenwucx5l/vlrnnWpV
	mWu+cojKYgXQAGynHdVEYjCCrVIzTQyeuWc9/YyBjb+KKOxvkqkefobQB+Ktrv5c8SrZAL71iIr47
	ovbRvxLGrvDMYNdyBbrsjoTh0Q4vTxsGYQAK/+eO0sToXkHO/AYsMXJPst4x+3WgobdvW6qI7x/Ub
	1M0EA8QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFqmS-004ZRG-LJ; Mon, 25 Jul 2022 05:37:24 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFqmP-004ZQs-NJ; Mon, 25 Jul 2022 05:37:21 +0000
Date: Sun, 24 Jul 2022 22:37:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tobias Gruetzmacher <tobias-git@23.gs>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: Crucial P2 has bogus namespace ids
Message-ID: <Yt4sEcEqwetmeT3z@infradead.org>
References: <20220722170557.m4kah3xm3zgumnbz@23.gs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722170557.m4kah3xm3zgumnbz@23.gs>
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

applied to nvme-5.19.

