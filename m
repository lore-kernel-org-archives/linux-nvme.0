Return-Path: <SRS0=CVBY=5U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC36C2BA18
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2020 07:04:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01FCA206F5
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2020 07:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G7TDm/Rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FCA206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5bvRvskzsanTRmtsT3kyoOn3s0XT+6JZq9VN7Fle10E=; b=G7TDm/Rnc45qas
	iAfrwCIDOjFUCko4otkMfxuVxT4YGJ5kC7doWErKcjj10eawlXnoWnilhiRdoJN2Bs959agf6sLol
	zMXU34dEwQ1cfWdKCHRvB4CQPdQJlFnEZnXAauL2XVe46tbdUDdH7GCkwqn7FJSJ2/2OvC3h8I2DB
	ErpRezxjvjG2qcjGHVwRnCXneyjQt/glcvL4RYk43QnVSWKRaKENBJK1+d1Ei2b0Rd/0nXK6lNHb8
	+9arVQHdrPquov+0BB52Kot5lzmSOcmSoIN/O5/nGELXcOpDg+EWGKO8dQtxYhNQ3G0iaYjIYQXaI
	axgZ+8kdWdiv9BLPmffw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKcrE-0004Vd-61; Sat, 04 Apr 2020 07:04:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKcrC-0004VJ-3K
 for linux-nvme@lists.infradead.org; Sat, 04 Apr 2020 07:04:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 736A868C4E; Sat,  4 Apr 2020 09:04:37 +0200 (CEST)
Date: Sat, 4 Apr 2020 09:04:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: define constants for identification values
Message-ID: <20200404070437.GA14423@lst.de>
References: <20200403175346.1571822-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200403175346.1571822-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200404_000442_287880_104F1834 
X-CRM114-Status: UNSURE (   7.45  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Apr 03, 2020 at 10:53:46AM -0700, Keith Busch wrote:
> Improve code readability by defining the specification's constants that
> the driver is using when decoding identification payloads.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

I can't say I find this an improvement - the bit values allow you
to jump straight to the spec, while the names need a translation
(either to the actual bit or the spec name without underscores and co
first).

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
