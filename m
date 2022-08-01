Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E84C00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hN/5+SWmvgVN8C3iRAYk7A37AonKcCHjR+aMzCAxnRw=; b=aeCTlZ6BeI5q12kDxPLvs9vDQi
	fnkiKilkrCFXFVlGXTIHesn/EXOVVQu7WzAswrEwudPcS7/laMbk3PRgjQpygV+7YgIxckWxGOH1r
	N6qouSUoevexl5AowzYaT2eSTN4Kvzl9M7KBxNwgpp74R9LNCgXADMOzbEgvpkskMBqPXxIf93FIe
	sUu1X9Z1T/oAhLrrGDmbEITNQyTHmH4hI/v0Ak9Iyw/jRDMogwhqFN53gLOaesvCm/QCFtjyMId9D
	qLp2P2kcWKrAZVfN/YR7I8w7gXKR17f1mm/Gk3VfA2RlG0zoCTuh4lRde2+PvkSIlltH7bbmvkVEi
	o+z0ZWkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIaNC-009FPz-No; Mon, 01 Aug 2022 18:42:38 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIaNB-009FN7-Ai; Mon, 01 Aug 2022 18:42:37 +0000
Date: Mon, 1 Aug 2022 11:42:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: amit.engel@dell.com
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@infradead.org
Subject: Re: [PATCH] fabrics: parse nvme connect Linux error codes
Message-ID: <YugeneJZJ/ZWPTV3@infradead.org>
References: <20220801184039.17593-1-amit.engel@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801184039.17593-1-amit.engel@dell.com>
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

I'd drop the Linux error code and just say "error: %d", but otherwise
this looks good to me.  If everyone agrees to one form or another of the
message I can fix it up when applying.

