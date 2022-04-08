Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D50C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 08:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ATvZj93w6fSJ7ZzQ1Q5BzVJlUmVpa/opiig/k9rnpBo=; b=SbWfapcCtRLBDw1Jjq9D72dnbZ
	vHSy2sX9VFoFUQi9YHtV5YBHPBeCyi6McCsui287ADNYi6P46eXfnTW90x0Hphzf/DoROQ+EuSUZA
	TwBL1AAT8jqJ8l75U+h9dMnwg4DK0LJWNpnwSSjWOk55la/sUD+TPNtx2U0jL6OnGSWX5HC44IvdO
	L4pgRBsqQ+EigapmZM4jO+c8jDSnpWxpT58zo+6IGEfHnf0vCo451n92277RrT4eHoz2nakPxfTZu
	rg13whsr7bL8f1/gG5KmSbN5hiIcgEcodTFIEAd0SjX9z2vWc8D9emWmLlEKQxEMisLv0LXNDLtQJ
	uHOCXm1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncjf6-00FjkZ-Dl; Fri, 08 Apr 2022 08:08:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncjeU-00FjQu-I9
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 08:07:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A163D68BFE; Fri,  8 Apr 2022 10:07:21 +0200 (CEST)
Date: Fri, 8 Apr 2022 10:07:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: =?utf-8?B?6YeR6Z+s?= <me@kingtous.cn>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, sagi@grimberg.me,
 kingtous <kingtous@qq.com>
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even
 if nvme_ms_ids_equal return false
Message-ID: <20220408080721.GA2888@lst.de>
References: <20220408051915.GA31955@lst.de>
 <ABwAxgCYBwe5Iq2fM1-8qqrc.3.1649398333597.Hmail.me@kingtous.cn>
 <20220408062210.GA410@lst.de>
 <7b59552e-196e-d06a-f057-aaa3e9432841@kingtous.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b59552e-196e-d06a-f057-aaa3e9432841@kingtous.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220408_010730_823853_6990865B 
X-CRM114-Status: GOOD (  11.02  )
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

On Fri, Apr 08, 2022 at 03:56:49PM +0800, 金韬 wrote:
> This is output from dmesg. Seems that "eui" has changed.
>
> [    2.086226] loop0: detected capacity change from 0 to 8
> [   26.577001] eui changed from 0100000000000000 to 0000000000000001
> [   26.577003] nvme nvme0: identifiers changed for nsid 1

Ok, looks like the device is broken and changes the EUID after power
cycles.  Can you send the output of lspci -v?

Also just out of curiousity, does the ID keep changing if you do more
suspend cycles?

