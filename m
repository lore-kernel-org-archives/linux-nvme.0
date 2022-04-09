Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DDFC433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Apr 2022 04:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ILhffjMUCzYdQ+02dvNKKcwdXgD0jfwALeTOOtNvKn8=; b=am6cWfiC/IwJf9R/CNxZIi4u9C
	JeDVcgVfXteCjlJA/28g8TrUjY4rFIEea67PnwuksyivlPP/qbt/8fYy0JJzBGTNnF4mLMtmrcC1T
	4IIGKWhoDZPljYCWmaHLCy5mtS5TWvA0ZY3roWsfbv8pUai1KzM+88cVocnuz8xFiWQ8F36NrYuGc
	bPimRUC0WYeZ5ukX9CyZsAM7alCgWaWIAvaVXYRTlcbC1b9/d4lAo/hN7SnRC/DVXavjyTNzxvtOJ
	BCYlFe0siJzU8H3bcRSDkT4Pjggoa5PtnaSst+Q37ZpdWiAFeEosOssNKVWoHdtV/dSpqglLIDYMy
	NNcEhDTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nd2x6-001zqb-Md; Sat, 09 Apr 2022 04:44:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nd2x3-001zqG-OM
 for linux-nvme@lists.infradead.org; Sat, 09 Apr 2022 04:43:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C50DA68AFE; Sat,  9 Apr 2022 06:43:51 +0200 (CEST)
Date: Sat, 9 Apr 2022 06:43:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tao Jin <me@kingtous.cn>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, axboe@fb.com, sagi@grimberg.me,
 kingtous <kingtous@qq.com>
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even
 if nvme_ms_ids_equal return false
Message-ID: <20220409044351.GA17212@lst.de>
References: <20220408051915.GA31955@lst.de>
 <ABwAxgCYBwe5Iq2fM1-8qqrc.3.1649398333597.Hmail.me@kingtous.cn>
 <20220408062210.GA410@lst.de>
 <7b59552e-196e-d06a-f057-aaa3e9432841@kingtous.cn>
 <20220408080721.GA2888@lst.de>
 <YlBSO/vH7DjE6kC9@kbusch-mbp.dhcp.thefacebook.com>
 <20220408160424.GB27746@lst.de>
 <21ac620f-d234-13a1-0de7-e3ec1b3272db@kingtous.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ac620f-d234-13a1-0de7-e3ec1b3272db@kingtous.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220408_214357_984043_6A6E0561 
X-CRM114-Status: GOOD (  12.68  )
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

On Sat, Apr 09, 2022 at 08:58:27AM +0800, Tao Jin wrote:
> Note that I'm using the kernel which customed by myself, which comments out 
> "goto out_free_id". It means "nvme_update_ns_info" will be called even if 
> invalidate ids failed. Because I can't do suspend operation if using 
> official kernel, which will cause my SSD directly invisible in Linux and 
> trigger ext4 error, freezing the laptop.

Thanks for the update.  This proves two things:

 a) the device is completely broken in reporting IDs
 b) the reason why the eui64 changes after each suspend is because the
    kernel is inconsistent in how it queries for the eui64

I'll prepare patches to fix both issues over the weekend.

