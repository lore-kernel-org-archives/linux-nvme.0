Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778AEC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Dec 2021 17:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ma181nMi04246giqstgKAPOwL2WXmaojP0F8tcdGeHo=; b=crSh22wyddua9J2vjqjf1P4wh2
	/Yl/gLtKdFpQ7xIKVP6T9eVPJj/AcSWmOTaNZLCMLEOT/PR0t7F7olI+KYaQcqV/Fiz/0VYJfKhKp
	jhGXUHQu3RE6oX5XDdTel51zMLzRJQEkDIGSZY7PtWpRQPj9c7svqBOY5wNHF0uLGhD/L2eGnf1Tp
	H82NX+lVQtuzjQHS5t46u7DLkjc4+ZNV+36jXEQ6savp5yaWcLf7/UXgP5meWzXYi1T0QUboO9WbZ
	LTZ/4uMkpMeaXBlYFLKcE5J5OxTvC19RXprhurYQqm8VITvROw89EYRZ9xuv5drFVOm46Qz26kSBF
	UKRRreWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mueBq-009Xbk-Ox; Tue, 07 Dec 2021 17:23:42 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mueBq-009Xar-2g
 for linux-nvme@bombadil.infradead.org; Tue, 07 Dec 2021 17:23:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Ma181nMi04246giqstgKAPOwL2WXmaojP0F8tcdGeHo=; b=ggt3y6kwiBoOAEYFeXlsplnu50
 eZtbwThRaDVZ62ASwy01WjjV3yqblL85DPS4RLIIx0LDBbI928dy5H4Lr8yUfv+asz61jfmQ7A6rO
 H+syY1Hia0tl0LzDRv8jATpRSi1ThpYHwJHX3kjqhuyc49cvvK+a7YgTA3bX59elwsco/W+PN4+9a
 e/yNSJmd7WVxt+UxjhMnI3mtcrygWoyE6nt2wvgKsKJrVXHQIwsTpsJGoOzuadXgt7sf3f+O46wnU
 2QOrxE79shcT3yPvfxLP0VADWA7kQMyf9OrGYYrGo4Re4KFKSa9ZDJicX+RpJRUizsj/6nFC/OjgH
 6tbgldvQ==;
Received: from verein.lst.de ([213.95.11.211])
 by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mueBi-007aRG-Uk
 for linux-nvme@lists.infradead.org; Tue, 07 Dec 2021 17:23:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 73C1368AFE; Tue,  7 Dec 2021 18:23:26 +0100 (CET)
Date: Tue, 7 Dec 2021 18:23:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: liruozhu <liruozhu@huawei.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/1] nvme: fix use after free when disconnect a
 reconnecting ctrl
Message-ID: <20211207172326.GA3193@lst.de>
References: <20211104071332.28952-1-liruozhu@huawei.com>
 <20211104071332.28952-2-liruozhu@huawei.com>
 <9db489fc-ecdd-e1d7-cce1-78d47dfb44fb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9db489fc-ecdd-e1d7-cce1-78d47dfb44fb@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211207_172335_758337_4A7B810A 
X-CRM114-Status: UNSURE (   5.53  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sorry, the original mail somehow never made it to my inbox.
I've picked it up from the list and applied the patch.

