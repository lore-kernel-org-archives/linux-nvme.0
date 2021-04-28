Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E770C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 06:46:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD52610FB
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 06:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD52610FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BhcWLq4Rabi8a99uouzOw2hOcLWudIzv+usSWbzE3I4=; b=W/5pugAw1ED7sEcFADCjxXPHT
	yYUFeP/RO9A8CapWwJOHRHsIiieoFO7c4nx7tUIvXJsosnSyA6RX8SqLWqgFYg0MDdFl8MUrzNIaI
	kHOLCesJ/lUTik6oHhBR1uFGWzF1OeXEbmZS1Of8rg8wy9TUnktvC0v/LKdA67p2NgPEEQKp8dDXS
	DNtw0VtcRLvSZCdfrRLe1nHdjBHX8dKEr4RG6Mat7nD7HO+GGM9JlCJEOOlo5QWX1PtK5Pygev4pQ
	s5jWPw8k0yyQhUJioKLeNM86sDDhNypZ9RXbsx2G50k9yicfRrOP5SDJVLjcdKwoSfgq2wQ3Pd/Gm
	5WYme3yIQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbdx4-002xRj-Gf; Wed, 28 Apr 2021 06:45:38 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbdwN-002xJP-FH
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 06:44:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=aGTAAuyzYl3y4fhovvUUY+JJEM
 0632cphWmHPPWjc3YQqWETFH3avWuTyuFu4mMXqphtoNdqs8t2o79XBUZsudgw/LYVOHAOjexKUJZ
 +PjKblkPJSkO/WklExHNbEhJjcaVh0Du1fW4KUSrHdtQ2mIaGYki9qHaCn1NtMT7ViaQLQHluV56A
 4/boxvbRAzaLdI4eIWZJfMEqo6KALTv9dA5DGw6HtPGmom13sUBhSSx8xCTsg/SidEgfpPRc6yM8i
 9tDbL1h4JvPefHcINwidZHzaQYtG5Tk3+5Uz65RZ9ATRlKJhIE6wZapuFeRYByXJAaJzRlieI3jfv
 uB4YS0dA==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbdwK-00HDqh-Ro
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 06:44:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9DFD968B05; Wed, 28 Apr 2021 08:44:46 +0200 (CEST)
Date: Wed, 28 Apr 2021 08:44:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 0/1] nvme: fix controller ioctl through ns_head
Message-ID: <20210428064446.GA5988@lst.de>
References: <20210422080407.62999-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210422080407.62999-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_234453_062932_A7D796E8 
X-CRM114-Status: UNSURE (   8.68  )
X-CRM114-Notice: Please train this message.
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

Thanks,

applied to nvme-5.13.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
