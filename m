Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CDBC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 06:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VaFGpSV9rTg+DvnC3WZtuQIZUPfcp6fvoQpNSdImkNU=; b=CmxRBsDYiyCBDid5wmPEVQPpMD
	BI2znoCXs9cMcNNMfP8YOJU++lu19lD2onC2/mWQ/UrM/sgXNrLkSYe0KVkbzO+CN9lE0kRFSTS+b
	RYX7MqeJdinr1Q0gQUp3YrQ/RkjMK0d/euQqcnunN+JCgM0kYY7elz7/3olyt1PW94eBAC2w8n48+
	XO+JA/gUEBsIbvg/pP+tenuCe/Eyv7b/imREmCLOC2HHCdsLkeV1mBpRQ9EiTpngQrMOwHPVrGSYc
	l9yzO/3ZgQUjaBEOdiKtDtCw6ImaZCEUtcr/IZBz1pW+r9N1Ryl0ZYvhfGtglWDvUA49xduD09plP
	geySYfdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSZ54-00FGeG-DL; Fri, 11 Mar 2022 06:48:54 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSZ51-00FGdR-P8
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 06:48:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8B72F68AFE; Fri, 11 Mar 2022 07:48:47 +0100 (CET)
Date: Fri, 11 Mar 2022 07:48:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com,
 logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
 mcgrof@kernel.org, a.manzanares@samsung.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
Subject: Re: [PATCH 12/17] nvme: enable bio-cache for fixed-buffer passthru
Message-ID: <20220311064847.GA17728@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152718epcas5p3afd2c8a628f4e9733572cbb39270989d@epcas5p3.samsung.com>
 <20220308152105.309618-13-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308152105.309618-13-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_224851_986612_9CBA7965 
X-CRM114-Status: UNSURE (   8.84  )
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

On Tue, Mar 08, 2022 at 08:51:00PM +0530, Kanchan Joshi wrote:
> Since we do submission/completion in task, we can have this up.
> Add a bio-set for nvme as we need that for bio-cache.

Well, passthrough I/O should just use kmalloced bios anyway, as there
is no need for the mempool to start with.  Take a look at the existing
code in blk-map.c.

