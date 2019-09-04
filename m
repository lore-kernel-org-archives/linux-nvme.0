Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B529AC3A5A7
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 15:19:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F0621883
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 15:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f5RPvJTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F0621883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jsaBsXZq/PydShw4eJ+zjnrtdbhcWeBMC1BQEwRReCo=; b=f5RPvJTqSfzRNT
	6YrhuuSLutMUsRzL73sOxRt6YNuKeJQ7fXbin4Rxig9rKlQJmnR2IyqCzxooJFrWNV/lq4W+cnJh+
	yIb6LwH2LY6aCnoeDrrwX+q3tQXAc45k+/5g0Ae4OM6IYWaCyhpFu6JQt5YVYdTLjSysOV7oAV9vB
	rK1a9nrd/O/LjwGgUMpX53cV8UFWsWwk4nBKAjYBPyc0ghlX90if6VMskPW3jJ9blVzElYZ5qWajl
	0I6D97KV+Ab86xxJIBxNMNUtuNhthvrNTpZJOKG9v4lybLSWsVE4WUJxbG+CvNXWdfafdPdSB7RLX
	jMj4D36RuVv1UYwJ3CTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5X4X-0002sY-O5; Wed, 04 Sep 2019 15:19:49 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i5X4V-0002sE-9u; Wed, 04 Sep 2019 15:19:47 +0000
Date: Wed, 4 Sep 2019 08:19:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Engel, Amit" <Amit.Engel@dell.com>
Subject: Re: [PATCH] nvmet: fix a wrong error status returned in error log page
Message-ID: <20190904151947.GA11034@infradead.org>
References: <20190831185006.119748-1-amit.engel@dell.com>
 <20190904131447.GA9892@infradead.org>
 <8739B0CD2FC2DC40AF691A1CCBB9896034610E40@MX302CL04.corp.emc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8739B0CD2FC2DC40AF691A1CCBB9896034610E40@MX302CL04.corp.emc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: Christoph Hellwig <hch@infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 04, 2019 at 02:05:16PM +0000, Engel, Amit wrote:
> Should I provide a patch according to your suggestion?

Yes, please do.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
