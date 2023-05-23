Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE9FC77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 23 May 2023 06:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V+qLYdBaiPi/bApGRjANXn8jOYJa0cEutkJ37I5h56w=; b=1kRNbuv0FDOPZsNbSlUsrSYoEk
	PZF9UnciByajHv/W1mrP06v0XdRt8856hxti72VsgGoaIzkbzA3OA4N/wyNcuijJaVP5ohmTtyrnG
	jb1m4+Y+1jtt/jtSdGwWeUyvdZh1TWNCcuWmTIr53EoNad+DDGl8PREvS930oQPx+VeyinIuitWgq
	WkiM49zA8DcIMC7Zu7BnQRuJfS1l9CTT43xqZSm4QjtDzIKZcB/Hn2MCWmnRt2UEj0GMr071Rp0AE
	A4CmY2IT5L65Jf3Ep/NLsjk4WRc50xKxniJ619FAWmD8GKlQj0QBU7OKjc6OwC2DWnkD3581EuHnF
	DZmRRW4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1LyF-0098fc-0H;
	Tue, 23 May 2023 06:58:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1LyC-0098e5-18
	for linux-nvme@lists.infradead.org;
	Tue, 23 May 2023 06:58:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B44CB67373; Tue, 23 May 2023 08:58:05 +0200 (CEST)
Date: Tue, 23 May 2023 08:58:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hare@suse.de, linux-nvme@lists.infradead.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme-core: init auth ctrl early
Message-ID: <20230523065805.GA8411@lst.de>
References: <20230522090813.135540-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522090813.135540-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_235808_536275_120A03BF 
X-CRM114-Status: GOOD (  12.09  )
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

On Mon, May 22, 2023 at 02:08:13AM -0700, Chaitanya Kulkarni wrote:
> Ideally, we should avoid adding anything after device's addition to the
> the system that could result in failure, since current position of the
> nvme_auth_init_ctrl() adds more code in the error unwind path that can
> lead to potential bugs which can be avoided.

Yep.  Can you or some just wade through the other calls as well?

