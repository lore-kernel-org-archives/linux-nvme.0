Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59CDC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XgqfYYwmF5XIYdn8ZxGxoruKzy9WDoYMyiA9lbLXwis=; b=YjRcgCaWb8nbiiYsGw/sYzqrbE
	t9b7J1Uroj74kqgiNZLqWXkpGmyRAhigf4yLKpHLJokBgR/U08Gb6HlQVilACAjnS6kQf4k+896Tg
	zsAjA/+BbUOU7G87mFp3fw0QqsUr+a92GJw8bfxmbGYYgTa3yMNEdNSaLZVKYMu3BwhPX76JIooVW
	YqwCfSk5Ao3Shdi8xw19S8mT1BUvAPPkGbDyP8IqmgieDutaMACYo571ez/WzaTtHNFwLEZ1AfZkc
	MuqMKkHK68XjoUuuH4O2XqrvewS6UdLflB+IkNWzTFPE05zdk1kqVhmBguR04DZzRzRgIQz6YCuKn
	mcpdTxBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBZQT-002eD2-SZ; Wed, 13 Jul 2022 10:17:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBZQQ-002eBG-KE
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 10:16:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DA33967373; Wed, 13 Jul 2022 12:16:55 +0200 (CEST)
Date: Wed, 13 Jul 2022 12:16:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Joel Granados <j.granados@samsung.com>,
	kbusch@kernel.org, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	k.jensen@samsung.com
Subject: Re: [PATCH 3/5] nvme: refactor namespace probing
Message-ID: <20220713101655.GA27936@lst.de>
References: <20220713054914.1888305-1-hch@lst.de> <20220713054914.1888305-4-hch@lst.de> <a09f1d0d-09de-6dd6-3810-d6fd5e11f63d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a09f1d0d-09de-6dd6-3810-d6fd5e11f63d@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_031658_831391_10166FC5 
X-CRM114-Status: GOOD (  12.64  )
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

On Wed, Jul 13, 2022 at 12:21:51PM +0300, Sagi Grimberg wrote:
> Maybe nvme_ns_info can have a id reference such that 
> nvme_update_ns_info_block can reuse it?

I thought about it and, and it does seem doable.  But it just seems
like an awful lack of abstraction, all for avoiding a single command
on some setups.  True, those are the absolute majority right now, but
with more and more information going to go into the comman set
independent identify page it will become less and less so going
forward.

