Return-Path: <SRS0=7iC9=EJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22599C2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 18:42:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F8420786
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 18:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kVJG7Hu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F8420786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4rZMnQp7I/bRonoKv4QplWSj2m5EUYEmwwF+0QIHey8=; b=kVJG7Hu5nDfMryOBo180GcuxR
	qRJ299sLeosDK07Vho7euLQZJmWmJA1Opr9BR51SdH59kVR2ZFB/UPxgX8K0fm0EXhTRNu4X2BWJz
	R4Z7PeC2wKuHCimWERODNVyBhF4dPTNhJn/wtlcaSDgEKQYVyLHyqrXussHlpvNfMkaol+x4H1z0w
	lvsjvYufxvvtjH/g5ZN3eX7ora4coiguYhFhnsT1L+TyoV2oSYwvK6GQkQJY3o9tjNA4rqIDkTS3v
	laiJhcopv5DVvFnOUNRfuNZCWfOw6HCK7yB2kVecwRuqRgwdDBEyMBbsMUBFRfGr0JBcpV9TnaYcu
	4qoCXjnHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ka1Fp-0008Jn-D8; Tue, 03 Nov 2020 18:42:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ka1Fn-0008It-1E
 for linux-nvme@lists.infradead.org; Tue, 03 Nov 2020 18:41:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8B5296736F; Tue,  3 Nov 2020 19:41:57 +0100 (CET)
Date: Tue, 3 Nov 2020 19:41:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V5 7/7] nvme: use consistent macro name for timeout
Message-ID: <20201103184157.GC23697@lst.de>
References: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
 <20201029234739.21266-8-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201029234739.21266-8-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201103_134159_181874_2E0107F7 
X-CRM114-Status: UNSURE (   6.20  )
X-CRM114-Notice: Please train this message.
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
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

And once nvme_alloc_request sets a default timeout all callers of
nvme_submit_sync_cmd and friends can pass a timeout argument of 0,
and we remove most instances of ADMIN_TIMEOUT and NVME_IO_TIMEOUT.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
