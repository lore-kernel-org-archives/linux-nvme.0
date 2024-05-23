Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E21DC25B79
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 13:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/G2KLtgiZL8qql2Fp2lSyGSjOlj5QeCxmiY5oQ43buk=; b=HRdmXUbKDEo3rraP+SStZd5LLw
	FmZZBlJXyn30cynpVsDBYVW60p4huifQz92Jhbx54/nCaJQVg2LzlvmNX1O3qy2dFEtFp6nmXiZKT
	4kIN2h6Xng+S/iXG2dbzga9wJqRu/I70BcB2TQcQSkOJhB6ZqVrAM+FNs0Q1nZfUOG4dFJ34YTZIH
	DG5YeZ7U6IGO2wRbxH5Qpq3qbu+4a70GvPG4zJlKzdJ2Z+b9sLeWDQKynBGmzvu948PLilQOFoxf3
	xC7HG+CFnIYBBYrZkZ1qxIEqq6795UgmbxPEEX4iNpDOtRfhXZL7e6LGK5TEYRMtJnUucZiXPN3aB
	Skq/sLfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA8M8-00000006LK0-1Vn2;
	Thu, 23 May 2024 13:19:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA8M5-00000006LJV-2EmW
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 13:19:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0D86168BFE; Thu, 23 May 2024 15:19:34 +0200 (CEST)
Date: Thu, 23 May 2024 15:19:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: silence a lockdep complaint
Message-ID: <20240523131933.GA23660@lst.de>
References: <20240522091534.472449-1-sagi@grimberg.me> <vjurqn5g6k5fkzqo6iz2rzkxlljrjfna3efgub3o24ol2yv55u@lx77me5f47gm> <Zk4ZY2n7dSztQ4Xs@kbusch-mbp.dhcp.thefacebook.com> <20240522162845.GA16783@lst.de> <a0657f0a-44af-4765-abe3-acc8a1017b40@grimberg.me> <Zk5lU1IqmLAhhSCX@kbusch-mbp.dhcp.thefacebook.com> <20240523065412.GA29137@lst.de> <a643075c-a51a-413a-a0a0-7954049ad918@grimberg.me> <20240523123949.GA20758@lst.de> <4509c11d-b3ae-4be9-9904-5aaf2628f7f2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4509c11d-b3ae-4be9-9904-5aaf2628f7f2@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_061937_736645_FF1DA0F9 
X-CRM114-Status: GOOD (  14.21  )
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

On Thu, May 23, 2024 at 04:02:43PM +0300, Sagi Grimberg wrote:
>
> I just want to have good testing before we touch these areas that
> are all done in ctrl reset and error recovery which historically manifest
> most of the issues...
>
> and all this because lockdep complains on false-positives...

I still haven't seen any proof that it is a false-positive.


