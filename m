Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD59C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 14:10:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D248E611AD
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 14:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D248E611AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iuktLIzarvHjEJlKtxuBEUVUXP0f2R+/dgHk/7kC0YA=; b=L1SMV6KEcyujMe
	nW5RCLKnMdzRruHxM9Quln/Ll8hbyxVmM6tI7x0wBGytz8klQ9VOw0qhXTyoKnxYOPR7I4GQ83Y1Q
	EsWR+TELhzu709u1ZsI35BpY37VkywxAPkiobOLaJ6DfgAp/CGY67roAsqKUGGr7+X9xgrFPPNMvm
	mPbfmA3mWL1JPBm5/xrrKBgX85bUb6DU0cDZb33RFO5Ly0APpXdgPhSS1+k9KyrnZOcQdc8Z4QIEj
	ChqTm+uhZvjMl372tRdVZuS6rrsd5uZd2ehIyCW/ZQyXulTKAi7gJLz1TV9Qz+htNlsdN/VkzMUE1
	v3ogAcjZuLsV2AgW0KIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOKkg-00A6Yh-SE; Thu, 09 Sep 2021 14:10:06 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOKkf-00A6YN-H3
 for linux-nvme@bombadil.infradead.org; Thu, 09 Sep 2021 14:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=L3qmcK3XkQzX1OlMFGFtDWNbY0
 qtI15ELaCsKkWGvpAawroOS6JWsTTbdothZBIAW16MUTesRG9wc3t8+CsoJbjj+fv5DTfAURJATGC
 QNFw6OQCyckTlyzl9EAgo3rLY4SsSEkBEQVQQlEisIZxq+szABZGxXFbntoXHkdyAE1pDZT7o15rW
 9+3P5kEHN9Pt8HA9VqlXtxWp09Ts6hinVhGam9dgcOh0yKyQP8lGgFI6tM3ae0OKdGFj3yQxJ8DH/
 HuoQodL2pGqH51vOBL7AuWROIQYrbISCmzLd49a4TLR9YvjAMwoT6yVLhbsB5izvD+nW0Aca/2gKO
 Tkm2/hfw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mOKk3-00A2rp-B6; Thu, 09 Sep 2021 14:09:49 +0000
Date: Thu, 9 Sep 2021 15:09:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2] nvme: avoid race in shutdown namespace removal
Message-ID: <YToVl5VTLwPkHkpO@infradead.org>
References: <20210902092002.67614-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210902092002.67614-1-dwagner@suse.de>
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

Thanks,

applied to nvme-5.15.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
