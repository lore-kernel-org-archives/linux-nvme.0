Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CD9C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Dec 2022 08:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kY1qM93yDstKjbr+gOwtTkC4uYsBrlv6z/23hM2xfaM=; b=2/mdnLj8UdI8989Pv3dFDFY+W/
	26xmJss3lszmqJi9RbY9e2hrMrOmiU71hpojIJKRdNV+1wGt08OzlvKPlOyoKYzY0DBBHwUxMIQSw
	v64dIaJ/SwYGmzv9ylXyozn3JqPpYOcFzbsJLNxxjyccIPeOtyKcQ6lBoLI/i5Ep+2Mc/JYOm9Gd0
	w/mN7bQpRuBsj915bqxTiyJQFWPcygamvHSp6ThXuDi8ZrQeO41/Ws/SVWKEQ5Dia6/CHymjO+ecD
	cPB3Bef6bhTa3LPZ7D8cKCepLGr7vsaPwWtvcWDr5K8luOJt0tf/tlMg1WapHm9FlN8MCl9nWGXna
	nm3Hp0Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7u71-00BwNH-5F; Wed, 21 Dec 2022 08:06:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7u6C-00Bvo0-6u
	for linux-nvme@lists.infradead.org; Wed, 21 Dec 2022 08:05:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6460B68BEB; Wed, 21 Dec 2022 09:05:09 +0100 (CET)
Date: Wed, 21 Dec 2022 09:05:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/3] nvme-pci: Fix page size checks
Message-ID: <20221221080508.GB23327@lst.de>
References: <20221219215457.711617-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219215457.711617-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_000512_624355_8685560A 
X-CRM114-Status: UNSURE (   7.90  )
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

I've applied just this one to nvme-6.2.  The others looks sensible,
but not critical enough for 6.2.

