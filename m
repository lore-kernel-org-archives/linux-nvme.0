Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DDDC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HqZOfmor5NqVcKizrVNquDxO3/cE7Duj6ik/S3nYDoQ=; b=WJnsz3QBcG4bgAzplhPeGlQJ1L
	kNQL15dYY1UTRCTDuQcIwLmGk3Lcu0cxpaTjC36LSvZ2utbwFvr89PEHRN3zOTDcJrb3y3Ue5fFI3
	P7Oq4Q3Kk2+gCOaawK5iQy2VagiK6WxFR2/KDU9PFmQkb0B8LrDgLGd5oklwVv5jp+MsXRSXF9SV5
	9JxGuGB5qr3pY5S3pnh20f+ALBWRbFKWlxrib2+mxjn+Yb/Ub/JdO9l72GpvbKuuPWUoNxcHdhU3l
	d4r2q4W2L7SfjM71Cvk3xpSmErVTqyjUq2B7/akUL0tE1n+ARvenPZkAb/1rwdMgxnnOQeGXmWgcl
	wer5guXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA7jj-00000006DHT-1qy6;
	Thu, 23 May 2024 12:39:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA7jg-00000006DGp-0xnp
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 12:39:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3A91868BFE; Thu, 23 May 2024 14:39:50 +0200 (CEST)
Date: Thu, 23 May 2024 14:39:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: silence a lockdep complaint
Message-ID: <20240523123949.GA20758@lst.de>
References: <20240522091534.472449-1-sagi@grimberg.me> <vjurqn5g6k5fkzqo6iz2rzkxlljrjfna3efgub3o24ol2yv55u@lx77me5f47gm> <Zk4ZY2n7dSztQ4Xs@kbusch-mbp.dhcp.thefacebook.com> <20240522162845.GA16783@lst.de> <a0657f0a-44af-4765-abe3-acc8a1017b40@grimberg.me> <Zk5lU1IqmLAhhSCX@kbusch-mbp.dhcp.thefacebook.com> <20240523065412.GA29137@lst.de> <a643075c-a51a-413a-a0a0-7954049ad918@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a643075c-a51a-413a-a0a0-7954049ad918@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_053956_432484_D9C144B7 
X-CRM114-Status: GOOD (  16.11  )
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

On Thu, May 23, 2024 at 01:04:13PM +0300, Sagi Grimberg wrote:
>
>
> On 23/05/2024 9:54, Christoph Hellwig wrote:
>> On Wed, May 22, 2024 at 03:36:19PM -0600, Keith Busch wrote:
>>> The below patch is what I'm messing with. I have a CMIC PCI NVMe and
>>> nvme native multipathing enabled, and that can recreate the lockdep
>>> splat 100% of the time. It goes away with this patch. Non-multipath
>>> devices are harder to hit the lockdep splat for a different reason.
>> I much prefer the srcu locking as it has real benefits as well over
>> a global-ish rwsem.  I'll try to get to a real review in a bit.
>>
>
> Can you explain what are these benefits?

No having a global lock taken for namespace lookups. 

