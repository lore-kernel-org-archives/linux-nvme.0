Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B985C83030
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 08:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bFMLsYx9yg/hn/nQJiMEvuhnsiGy591NtU5BpNmy/po=; b=E1OFVH3vom/BD44PZYW9+0ANtr
	Z2aoTD4MrFi1YbaDjRthYlQI21S2LJtPBthRT7++OSaufVDicxlMIgZ8hqZJxdRo/f48Xo7mCX80J
	8vTnh3Enf7ujYP3Ve2XIuaISB46B5nlhdhIiQE0MOA6DSvPwIciiQjHGNdKg2Fggbxnm8exPNzpRE
	NfMkHqMVZOrcN9NnOCtF2vOhoPFU1Y7AVJmoKAK6vjnS/Pq8mRJNAa+OAQGSjL9EM00pwhwdr03SL
	hBv1MQ/jn9uj1hEF+FbqrdyGKyAHOZlFQiuPixvJP8s19hNCfn2xs5b1kQdqzu/V0dP/U97HRo07y
	qsye03vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXF4j-0000000AdVt-3GKu;
	Thu, 03 Jul 2025 08:13:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXEvW-0000000Abv2-0pkO
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 08:04:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E7D168B05; Thu,  3 Jul 2025 10:04:00 +0200 (CEST)
Date: Thu, 3 Jul 2025 10:03:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: alan.adamson@oracle.com
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [bug report] nvme4: inconsistent AWUPF, controller not added
 (0/7).
Message-ID: <20250703080359.GA365@lst.de>
References: <CAHj4cs_Ckhz4sL5k5ug_Dc5XfjSo9QDRSrHMfBj2XYGm_gb2+g@mail.gmail.com> <6e74e9a8-2dbb-4ad4-a48b-9af40d6af711@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e74e9a8-2dbb-4ad4-a48b-9af40d6af711@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_010414_390083_181EF050 
X-CRM114-Status: GOOD (  11.27  )
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

On Wed, Jul 02, 2025 at 09:33:32AM -0700, alan.adamson@oracle.com wrote:
> Looks like the device isn't reporting AWUPF after the format/reset.

The other option would be that the format changed the value.

The mess NVMe creasted with the totally un-thought out atomics is
beyond belive :(

I wonder if we should just back out the whole thing and wait for the
working group to come up with something that can actually safely work.


