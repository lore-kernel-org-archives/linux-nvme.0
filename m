Return-Path: <SRS0=wn7D=EC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757D3C4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 09:07:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED481206DC
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 09:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vT6JwJaL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VeSOYT2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED481206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tVmJpHih2quVJrI90sfe/vidfieqA/mfCyWUEgzl2Ao=; b=vT6JwJaLJ5vwkyHaekKUrNdOQ
	6PCwwoRtw/yB8MvqBJqhyEzU3d9JPzxhJO+vqLZ+D6k4nEvv2BPOG8XpZS9CXYmHniXmQH7dQHAUQ
	ssJd6MoRQXWMllXAj7T/lhb2E1+F6FYQMaI9Q/TkHmuVmCKMkWYJ+d0zeudXhfSZr73CL2Bg9pE4I
	RAtqAICFps0w2fuT3uqjx4+CtQe3+4+vUW65z7QZRnhMSn+9e8ZCGdkdkqdMHbXEftHUSwfJvEaeH
	RfkQDl/K6UkwP9vWZZcMyVymjL0dgFkkti70OjL9W2kvS6kAd2e4JgACuDZyn/CEQQ1Nl1qHgoJPP
	L5CFmYASg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXKwh-0007LF-Sx; Tue, 27 Oct 2020 09:07:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXKwg-0007L5-9j
 for linux-nvme@merlin.infradead.org; Tue, 27 Oct 2020 09:07:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JCXyOa5uxUpAjzOJP2AX3oeKCJVkWYZ6cJtg6FEK9aA=; b=VeSOYT2nlVYfPAWhlOrQL6LS32
 m8RIAFzdLSsgDRcYlKJygBgbKJefGVAB5X3lu+DxeyStE1NEV5ejaSDn2+kjhJqGL7640BaKPLauz
 oTpebne8qCbM4D3KZW4udwXSIzCLB1yK5kV46K1UMq+prcQKPzz46YK7PSiPsdI4M5K3GZBoDmiLI
 3M0HNyZpGZRjALv//gTWkVs96m72409hu7cBjzGYS5GgQ5MMuSmFjPFAtY3FQtkgdD7pcaLrOVW0O
 YWdEz1hdQ5Cf/Oo07irA+7C7LcnptQPzDCFzqjNB9fHd3Af5UP3xgOo1ZhUUJdD+x1lmXAbXblBrg
 Lv8Lu/Pg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kXKwY-0004UY-18; Tue, 27 Oct 2020 09:07:02 +0000
Date: Tue, 27 Oct 2020 09:07:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme_fc: track error_recovery while connecting
Message-ID: <20201027090701.GA17222@infradead.org>
References: <20201023222604.90435-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201023222604.90435-1-james.smart@broadcom.com>
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

Thanks,

applied to nvme-5.10.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
