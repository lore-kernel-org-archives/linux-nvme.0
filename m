Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38D1CA9EC5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 14:29:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D6020656
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 14:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ey+7eE/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D6020656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7iu3zgUxz0WLdas2D+W1JBKLVfj2Pyk/+i6TIMtbmxQ=; b=Ey+7eE/BU/xGjj
	2nnYhgEz4jDlP09A/+EqyA7idw4qkFShrdulOvLQt1u0ji1yH0wvEii1DVgLAFVy/BFeqPkVqxDSs
	l04BLS41gJoeSmZmhV5zeKwVisUv+0d9WnGiYDPiERFBNRroYDzhlVB1dPgX4mJCBckJHjd+kjBwL
	Hc/qDzSwT0CQwH64Zg15yh2hptQk9QuNCemPx7MS8vUyOXupvgXafUK+wdMxv364I38HcYv7ehl9z
	6mwf4SkbiNx/QNSRbShKmnl1dlpLnSOHB3gst6ZJ+LNvxlA4uzRA2GuNISmywZg9UOlSYvlX4Hs77
	IV6mwR01trWlg6sTDRBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPoyH-0004tm-Lv; Wed, 30 Oct 2019 14:29:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPoyF-0004tR-Oz
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 14:29:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 231FC68B05; Wed, 30 Oct 2019 15:29:09 +0100 (CET)
Date: Wed, 30 Oct 2019 15:29:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Prabhath Sajeepa <psajeepa@purestorage.com>
Subject: Re: [PATCH] nvme: Fix parsing of ANA log page
Message-ID: <20191030142908.GA14551@lst.de>
References: <1572303408-37913-1-git-send-email-psajeepa@purestorage.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1572303408-37913-1-git-send-email-psajeepa@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191030_072911_965829_927F99F4 
X-CRM114-Status: UNSURE (   5.78  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The only thing this changes is that we now also execute the check
for the first entry parsed.  But the log size should never be so small
for this to matter.  Can you explain what problem your are trying to
solve?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
