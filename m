Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577C9C43381
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 09:22:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E876A64EA4
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 09:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E876A64EA4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oIHj+15EGG4aEq1n11DEcwjZNI+IXIWkw3i457hUitc=; b=ycV58AQOdtB2OWRTR0g6MQlqv
	aEj+R1ZJV62BD3rVtntMXXkZnbRHVLTYuBzS3elmhBkFTxAnzIysVynRPYsPh6lFEBtXp6ZCRvXeM
	XUO17okyHifaRop/hpQNYJR84h20ses+lMsUG1cd2azQT9MRTvx4k7DfasWQkFYXDa1sKW3eCY5L0
	qZHA0voNM1s+KPj9wJI9rtEHYbJtGhTBxoVI2gOEM3FvCsp4K3zHmidEs9xnuM5gBnnMQs8za0USu
	HA3DzsYrxv/Gvt3CF8Bb16CWh/5zVJ+ofhrlM18FsxqvOyq2tbgUUiOXBNdMp6eEzL46z5Zpq5S8t
	1m3ycWGDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEqMo-000236-EG; Wed, 24 Feb 2021 09:21:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEqMn-00022p-7J
 for linux-nvme@merlin.infradead.org; Wed, 24 Feb 2021 09:21:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=LnC78rRFwYXha2A89WIY21clC903narLTQ/sLlCefJM=; b=WD2W8prenuH+yHXDGqbLdu1ZZT
 otBSrR7ATr0PGbP8PJ6qhEge9KpnySJpTkrNMq97RReCYMVsyo8ahKyFxxRDrw3zDC2YpZC6Mr281
 m48LVqMI8CYMZNs58Zc6TcjM7A3WJkdhJKCR8zINf0OoLjQX2PcD2FEoVSl63xa9YsG+c6lxtjPWW
 W48qWxT+8cIQMBOry4OzlAJXQw/okWOo90OjyQ9v3zElfSo51N5G6bdSjZnSSbFUSggAn1vjf5RZa
 8oiLf494wUEwb9WLDfrstlkc9MnTOrr3Vxw9U1McVMV/kni2bbdMta1mCYoNW8yhMlHZq36TEhcyh
 wd91u1jQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lEqMd-009DRH-Cb; Wed, 24 Feb 2021 09:21:51 +0000
Date: Wed, 24 Feb 2021 09:21:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pascal Terjan <pterjan@google.com>
Subject: Re: [PATCH] nvme: Add quirks for Lexar 256GB SSD
Message-ID: <20210224092147.GA2195892@infradead.org>
References: <20210223221046.3367795-1-pterjan@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210223221046.3367795-1-pterjan@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 23, 2021 at 10:10:46PM +0000, Pascal Terjan wrote:
> Add NVME_QUIRK_NO_NS_DESC_LIST to Lexar 256GB SSD to allow it to
> work again, and add NVME_QUIRK_IGNORE_DEV_SUBNQN to avoid a warning.

Why again?  The drive has always been broken since the desc list has
been a mandatory feature since NVMe 1.3..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
