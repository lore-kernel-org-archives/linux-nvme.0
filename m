Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A4EC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 04:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=0SzGwOXKkPUni4w0+jtA7KiH69
	MC5DgBC+LGiCPRYE8y+p2pxscdOqfatbwHbC2moRUO5X6HVe2Bfuv36WumrEIlE4iUeAz8iZycrOs
	jgHDSL2vKQBZJR2M61AEWT38fDIv7RrwCPIoo1VjcKVtMAGL+fIXdUmBUz7EGHOzT2jV09o7ZJjCp
	Y/ZRL4ojcG0cs3NbwwFeoQn61L/vPZenIHXmOPq02Z1MIQTaM87IAy+JXrSqMjW7TE/RC4uYIn8D7
	jmKeyCvTj/L69ieGN2gHnui0cwK0LW2eCLPLD6B3UF9p2MnXMlsB2aV4RJeTtsFZrSkOHAw08V2xl
	9NlbdL8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRgX-00CmYG-23;
	Tue, 19 Dec 2023 04:26:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRgU-00CmW8-2L
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 04:26:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C06B368AFE; Tue, 19 Dec 2023 05:26:11 +0100 (CET)
Date: Tue, 19 Dec 2023 05:26:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	james.smart@broadcom.com, Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Michael Liang <mliang@purestorage.com>
Subject: Re: [PATCH] Revert "nvme-fc: fix race between error recovery and
 creating association"
Message-ID: <20231219042611.GA30580@lst.de>
References: <20231218162410.1087788-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218162410.1087788-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_202622_922446_316DE0D1 
X-CRM114-Status: UNSURE (   8.67  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

