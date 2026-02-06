Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850B2EB28CE
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Feb 2026 06:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nynzcfS7MasplNB7RGsAdkvWNLf0TUyxxntbHb8CW2w=; b=xIe7FZXjv3dyHZxyy419t92Dmv
	xmyZgRTaCTCvN0GVlxZDievULRg6GxRL8897oph5XpiWH0KYy3Al55KFJLhGUoiBBLHAYLqxXC8Wn
	jROCp1wd2AeUUdMY1BUGnaDH79KMeMMcCFCJqad5O0o6d44Ao5Bkp+3r8MrRy+39RoBnMbJdOVWUP
	9VuIfF4rXn7O/D5lXELJ6sMwlGQAET3ytMGVmNr+N0z45d6JqJ340CDUgjUUlmMv/bXHiz0ovlzD5
	hZfdH3k3c70QI6nGHucuBVf+2RGOBB+LAC4H+amHjI7VgOzBoPthzpO1weyPWE+qk0Kilzur8g1eX
	VVLQRodw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voF6n-0000000AvzX-3ODV;
	Fri, 06 Feb 2026 06:14:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voF6l-0000000Avz6-3H6a
	for linux-nvme@lists.infradead.org;
	Fri, 06 Feb 2026 06:14:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 49AF268D0F; Fri,  6 Feb 2026 07:14:20 +0100 (CET)
Date: Fri, 6 Feb 2026 07:14:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: stop setting namespace gendisk device driver
 data
Message-ID: <20260206061420.GB25563@lst.de>
References: <20260205171115.2610321-1-john.g.garry@oracle.com> <20260205171115.2610321-3-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205171115.2610321-3-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_221423_958050_26F16750 
X-CRM114-Status: GOOD (  13.66  )
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

On Thu, Feb 05, 2026 at 05:11:15PM +0000, John Garry wrote:
> Since commit 1f4137e882c6 ("nvme: move passthrough logging attribute to
> head"), we stopped using the namespace to hold the passthrough logging
> enabled attribute. There is now nowhere now which looks up the gendisk dev
> driver data, so stop setting it.
> 
> Incidentally, it would have been better to set this before adding the
> disk.

I could also not find any other user of this drvdata field, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>


