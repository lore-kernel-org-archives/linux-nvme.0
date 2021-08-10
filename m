Return-Path: <SRS0=1Q2H=NB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B566C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 16:20:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBCD0600CC
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 16:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EBCD0600CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iuktLIzarvHjEJlKtxuBEUVUXP0f2R+/dgHk/7kC0YA=; b=0sR6UqnPiSFGcp
	ZomYLK83XQayucYohuL+34pvj+4NlnFbLGP7zfepQ9s5Bq6cvEg+y5u/KIQyTQS8awwqcy9x6+ACu
	FZQ/WZzm3r7EiOJb/984K5Y8R5H1WHRqNG1AzvaJYFhiQG9kPG57TPxYBa44ZfNR7qT08pTexQqtx
	JyzYb3+oqRDjuZFK9De7fDPpsP0dbRSkFHMhKlEU1T5YbovGco5j1TbL/rnULiqdL5+acuGRdtYAA
	3xnu1CMUfJjsP0CxC5SVmKVJ4wWQyHPrP0jqgj+D85YPsdPMR8ob8fd8vtwO8gV2y+Hyr9ImaggCg
	FhwmMf7p63Imf45LgfXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDUUD-004R7A-Qw; Tue, 10 Aug 2021 16:20:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDUUC-004R6v-9P
 for linux-nvme@bombadil.infradead.org; Tue, 10 Aug 2021 16:20:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=ooMF3WAZM4xri/O0xaqk6bwFvM
 5rJkyDG5rwMoL0MHCwZCt83kJ4EyH/RqiLu+w8U2zS8BbOZIw/1CUgpvsORYLhGeFNas1WpCnTTok
 CJ1HCRgHhFTqldxyq9RsQevwvks589/PDURIwEm5pWhuxT90U73iLeghswWDWL8PqfF+c71MtPn9P
 xp/xE04r1iP0e29MFmHXZK3BvZRk/85tV+zlKuhmgtKU+7WomNjQ2KcblzpigA6NfhSH1TWSTjhIU
 52oJ3HYfBRDinTowvII9nYIQTRlDu4TlVJaHZo3hbXwZIY60TePJin17npG0qMdGREHmsWgG+fR1E
 U46/WwZA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mDUT5-00CKNn-Pu; Tue, 10 Aug 2021 16:19:32 +0000
Date: Tue, 10 Aug 2021 17:19:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: amit.engel@dell.com
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Subject: Re: [PATCH] nvmet: avoid duplicate qid in connect cmd
Message-ID: <YRKm+1ZxLmuTYK8H@infradead.org>
References: <20210808150615.22853-1-amit.engel@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210808150615.22853-1-amit.engel@dell.com>
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
