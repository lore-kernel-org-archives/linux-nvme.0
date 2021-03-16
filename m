Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51CCC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 07:31:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192AD64FA7
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 07:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192AD64FA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1uhEyfPW0DpXQELeKp3wZip5gHGu/FidJdXWXZIgOjE=; b=Pzxa39nS1lpn6u1Og5Xg7Lmsl
	6uSfWBICauZlRzaI/sMzyeIVtAT35Dt1r9zoC9oEomyASDpnLeEQNMgk1gjrA2JeXjeD1FWzaWZbf
	eYM65OKjPpzN9Xdtgi6MDLoXQrtCOJw4ahCn6AZFPcVKu+mYlcHqsx9aXzycQj+EGqqVp+LWMLuaO
	acLeC0gBNxyKZ2u4LSAKVsUnCAw0lziAc3kOzwvbL+LuYN5h80ZHt8vzaQTnVKmB6vHQYIRzEkbUN
	OIxCwXzNg0gkEflTHH+xqW91aR88v4X9BMT9zZuUcF9K6sbD5mHRNT1WBVxmxYBAO4TQHPmX0LZjY
	k6OGk+wtA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM4AM-0000tw-SO; Tue, 16 Mar 2021 07:30:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM4AJ-0000tn-83
 for linux-nvme@desiato.infradead.org; Tue, 16 Mar 2021 07:30:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nP2ky0cJZrcBitotbCzkJZKqlXEsOJ9QHgaMd4RKqYA=; b=DxPpeUdTRK6HQmEUoewtaGgWG9
 MoaYHWY3poXv8KXcaPr7WWO4BgmpOy36swJmcQT2cPmBGyReXby8mYCKRfv1FXBPpkr6mJUozcFTP
 D9VQvmTU4/wax9hTLeckcHTcnYoDedDC00MCe09Fq9icgp3FKK3+P9zEt8aZAEsObUNpu23VnO+2Y
 HY5IRn3RrEmNn9dzjnRZEIkTOTKZVV7XF81T0L98ljvoPNNHr1yF8cjkZcZfDwgese+2CsdHZMhCS
 99IfTMo4kdOGHBuc/9UOOEgnC+wCCW5zA1iNaHc+Kvb+If0qDh3I7YqKl0CIeP2P0uHwKZJOT9YaH
 kt6+IgsQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lM4A6-001a9S-Is; Tue, 16 Mar 2021 07:30:45 +0000
Date: Tue, 16 Mar 2021 07:30:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Zheng Wu <wu.zheng@intel.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 Ye Jinhe <jinhe.ye@intel.com>
Subject: Re: [PATCH] nvme-pci: add another device ID with stripe quirk
Message-ID: <20210316073042.GA376417@infradead.org>
References: <1615864938-6757-1-git-send-email-wu.zheng@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1615864938-6757-1-git-send-email-wu.zheng@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 15, 2021 at 11:22:18PM -0400, Zheng Wu wrote:
> From: Wu Zheng <wu.zheng@intel.com>
> 
> Adds the Intel controller of P5510 which has the "stripe" quirk.
> 
> Signed-off-by: Zheng Wu <wu.zheng@intel.com>
> Signed-off-by: Ye Jinhe <jinhe.ye@intel.com>

I'm pretty sure we said we're not going add more of these years after
there has been a standard way to communicate this performance preference
using the noiob field.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
