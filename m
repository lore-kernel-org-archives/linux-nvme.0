Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEC9CD98C7
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Oct 2023 06:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vfTMZUd0PpGkbaW7eWIxBY9y+wSQG6Gj4/RCsM2MUhI=; b=13+npX0kfIcJ/fNVW6bpP5xTUF
	PVlh7iiEehsoOL8LGqd6EaUReCOkzMkQrOrJgXeVFQieHlcHRjwdq5EfbqIR0vrRPEx13Fls0HkJG
	7HNF1H0k7wiX9cSgzr6EYGZuSgFrRt99ImuGZzGU/sZOD7BiPksF0J+I8L4olA3Wdt+7D2yRYoosN
	gE+TEedeje+FtzD4TKcTC9TZK3NHlXL3A+14IQS+VHlnnZbNGwK748NwHnhtuYUID0In1csEoHQSX
	npA3McTZKHMA7m+Oq/I54x8kci8vqHuPnb5jZfLvCuerWa89cuKutpAjHQ284zUiHjo52SAA3Tnyt
	YselyIOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqSpY-00Ezpe-2B;
	Wed, 11 Oct 2023 06:36:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqSpV-00Ezoy-16
	for linux-nvme@lists.infradead.org;
	Wed, 11 Oct 2023 06:36:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 779CA6732A; Wed, 11 Oct 2023 08:36:15 +0200 (CEST)
Date: Wed, 11 Oct 2023 08:36:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshiiitr@gmail.com>,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, cpgs@samsung.com, stable@vger.kernel.org,
	Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <20231011063615.GA2323@lst.de>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com> <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de> <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com> <20231011050254.GA32444@lst.de> <1296674576.21697005984297.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1296674576.21697005984297.JavaMail.epsvc@epcpadp4>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_233625_526196_35AE7DD7 
X-CRM114-Status: GOOD (  11.77  )
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

On Wed, Oct 11, 2023 at 10:56:44AM +0530, Kanchan Joshi wrote:
> > Fixing just a subset of these problems is pointless.  If people want
> > to use metadata on vendor specific commands they need to work with
> > NVMe to figure out a generic way to pass the length.
> 
> Do you suggest that vendor specific opcodes should be blocked here?

We have to block everything that we can't calculate the length for.
Otherwise you still leave the hole open.

