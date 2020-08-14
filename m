Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E13C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:45:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1993220774
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NAvL0BUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1993220774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6cc9J9qs1r6ZBiuUh7QVHPFgG0PUI67t7cFT+kdYi1k=; b=NAvL0BUuq/n3uJ3uKu4+IbiBR
	86siX8Fkbk9HLyOrM+mCE2lvWINb1hf61W16FypEQZ/+HKTTlKLeA+FmC8A8kaeu/O/WQmc7hHJK2
	PaWNypu0yVQndeodQHFr0TOxSo2fCr8LwC2QC2gkbgjh65S1iERqQihDF5NQ/oJAcYWBWsSt7IlY6
	ODC6XLqs/p9Mefyv+bxs/1UBo3aPEN2oe7ujqKkaDIMeWRXGWt4zpk3MkklvjOhgxNfQaXMn/gO9x
	LvLqWEOkLxW7ROHtwk051ZH7ekXPxittVBynlTyDPy/RnG70hJ4rSmZ3jTpYIKQC8hkrNep/0EXR2
	fLNWi9oew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6TSh-0005T5-HJ; Fri, 14 Aug 2020 06:45:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6TSf-0005Sa-Ih
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 06:45:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EF30868CEE; Fri, 14 Aug 2020 08:45:07 +0200 (CEST)
Date: Fri, 14 Aug 2020 08:45:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 2/8] nvme: have nvme_wait_freeze_timeout return if
 it timed out
Message-ID: <20200814064507.GB1719@lst.de>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-3-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200806191127.592062-3-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_024509_738434_ED08E817 
X-CRM114-Status: GOOD (  10.85  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 06, 2020 at 12:11:21PM -0700, Sagi Grimberg wrote:
> users can detect if the wait has completed or not

Please capitalize the first word in a sentence and end it with a
punctuation.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
