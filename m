Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3562CFD5F6E
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 06:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uHjEzV3f75lJN9aC9ZKFYrHk6/GO3/TKMwOQY6GYtUw=; b=A2hshqbjabUX4GqBbBnfD47yoO
	zxXKhL4xPFnp5L/JofN5pMK6Brb2cxHmJyS7HIh+GFdA5t2Bb0Pq3f81kuPLg7gZ9FS5/eJTb8YYE
	OY00JH1cvTMgyGC+5HfHH+R3oTUnM1D6j4uC84/ZB5ffeISgB7HKxsKltXfAZkCZx4E1sVhnK0v0T
	E7SU9s/wsbOb1LvlsBlcj8h1xgyk7Cp6X2IKW9LIW+9gE0vKCS7s0rAdtpDyeX9pzVU5K4cgogYgR
	yFLHuMNaoAX8N/zb/2fx474zwXr3mT+gbtxWqF/EUwVfibmQ0ppU5uWlkewLKr0e8+HlXGTMB47xV
	RKCLaaig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAM7b-00000008KCT-2HkO;
	Wed, 08 Apr 2026 06:10:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAM7Z-00000008KBt-169A
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 06:10:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F16268C4E; Wed,  8 Apr 2026 08:10:28 +0200 (CEST)
Date: Wed, 8 Apr 2026 08:10:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geliang Tang <geliang@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: add missing MODULE_ALIAS for fabrics transports
Message-ID: <20260408061028.GA24559@lst.de>
References: <e3076c80ee2e0c4a2cae0374afb617a3365946ea.1774944415.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3076c80ee2e0c4a2cae0374afb617a3365946ea.1774944415.git.tanggeliang@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_231037_444210_5F915B42 
X-CRM114-Status: GOOD (  15.48  )
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

> Recently, I've been working on adding MPTCP support for NVMe over TCP, so
> I added a new transport called "nvme-mptcp". The AI review in [1] reminded
> me that I should add MODULE_ALIAS("nvme-mptcp"). Then I checked the other
> transports and found that they were all missing the MODULE_ALIAS as well.
> I felt it was necessary to add them, so I sent this patch.

As a reminder:  if you want that to go anywhere you need to engage with
the nvme technical working group, which requires a nvme membership
first.  There will be no point in posting or even discussing this on
Linux mailing lists if it isn't approved by nvme.


