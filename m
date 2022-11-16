Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC57C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HOYyuQTl9qwdTIb7642XkGhp9TidcSk0CdQiN9GbvmA=; b=SRKWnhxB+IbRyHpTVhGcskqCVe
	PHGvrrcBWYoDlEiseyHSdw8dMBpm5X6pUnhXTLPryIBVIT9DcMYmMHzUCIjiBZYZCp5MBUUtVFNq4
	Ro8/sdDEXzySaz8V1bQJkSx1JgFQPki7jlFrQhOWBNTmAHZv/rn3Fc4bjE5bTQHAlYHrB34QbPFlj
	mFMvZ4h1XbZh1YTfUSIUjPanxr0wl8Wc54zeTy5kU0a7BMv5RYJvakvZmyVA0z6j9cTz9VM767r0G
	szLZI57DxsykRZdbs13xEfEy0VcOgzfJ6stnBhb87qLVQdFfr0vXloZAL4UjDkfODUZA7g8Uqfo+m
	Wlez6OdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovIcp-0043Um-8F; Wed, 16 Nov 2022 13:38:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovIcn-0043QW-8W
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 13:38:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C06968AA6; Wed, 16 Nov 2022 14:38:40 +0100 (CET)
Date: Wed, 16 Nov 2022 14:38:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: block dangerous passthrough operation
Message-ID: <20221116133839.GA9364@lst.de>
References: <CGME20221116130636epcas5p39a586e15d27045752f18d022f4efd74a@epcas5p3.samsung.com> <20221116130104.2186334-1-hch@lst.de> <20221116132502.GA5094@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116132502.GA5094@test-zns>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_053845_462025_92AFE3C2 
X-CRM114-Status: GOOD (  11.96  )
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

On Wed, Nov 16, 2022 at 06:55:02PM +0530, Kanchan Joshi wrote:
> Sorry to hear about the trouble, but I am confused how did this
> happen.
> The old code also did not allow fabrics command and any other
> admin command except id-ns variants. Yet this series had to
> explicitly disallow admin cmds such create/delete sq/cq and
> set-features.

This is not a regression in your code, sorry if I made that
impression.  This is a long-standing issue since these ioctls
were originally added.

