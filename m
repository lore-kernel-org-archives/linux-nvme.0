Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D8EC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 14:12:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DB6235DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 14:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DB6235DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lTXgRi7SHEw06lkNHBlHqp3VD2fwMBhmy3jWuYn7TPY=; b=yG9GhMcfju5ctZ8Y1HBE9eJ9I
	O+2a85aviT1UeLNMn5bqjeg+u1JwjIac4rT/ZOSZsmON20+Wxp5TRjaOJgDZsNWYy2N8fpYYfmWAU
	M+IMZRbt5TOAiFpNMmMquFTx2ShlTwBZ5NnnBYmTe+VLIAR+NoYLkvYCKaZDtd8MORBINdOOI41OT
	GIX5nBkI5X57h5LOUeC2S812+++3w3dn1DdEcNeN0GY1r0d+DiZbYuhC7wtZnOL1KK8yq5k5h2qTo
	/AI0/omLavTZJLf1eVmF+nT7Kpk9EXZXOowrkIbVMu+iDsG/lZbQzya77SL6ifV0boWGXiU7PWmGF
	I2vC/Wlnw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmHFm-0003ch-Rl; Mon, 07 Dec 2020 14:12:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmHFP-0003P8-UN
 for linux-nvme@merlin.infradead.org; Mon, 07 Dec 2020 14:12:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=XYDpXg9CTQvvO2zGH4cqKQUFyn+zcgg/9AwNB2fd4cw=; b=TrABIU2orDSqQqiOybQ53xNA7g
 DxXG93+MwQUBi7d5vK1xBq37cQopYaqvzQGfUkINHqqkiYkfZnl50vLm8pNrjALTvxCtf6qaMZskm
 gdxF1yK8WmgLhHRFa6uGP3cYnewa/Q79Cg9CmOoomEP/HNeRoOl1N3Z2nRc8ZRnnjQ9Ubvr2BCmHf
 RNSFgqZCZdep/Rd5WfVL9iy32wwmhzaGFiVTBaS0dfI3HWV91bRziQe5QY821bGAOTZcecPLXqbVw
 iIdsVKIX48qrdv/fAHv0i09azE9hBhAnQ+Cb7EiwGs3tifFdGMrsKeLNx/gFyRQBHqmDxT0ddxr03
 ACaK+HzQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kmHFM-00029z-U8; Mon, 07 Dec 2020 14:12:12 +0000
Date: Mon, 7 Dec 2020 14:12:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme-fc: avoid calling _nvme_fc_abort_outstanding_ios
 from interrupt context
Message-ID: <20201207141212.GA8218@infradead.org>
References: <20201202015243.129523-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201202015243.129523-1-james.smart@broadcom.com>
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
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.11.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
