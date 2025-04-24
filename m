Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E27C369D5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 16:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ReI6BV/Os1n35N4HJigsjkOZdspPrQs2j1dzCHpJI+s=; b=kF3ocoeT6ObbeX71v6asi7+Lkr
	jB2auIDFYUWJglOueEDGVdDz19fICB/xLEhRgim2xjUaPao+WzKE11gZr6jrUa9mV4svyTWilUecL
	VP9CqTAi4vKnvODNguK+/srVUgV7jDW7/7+847gOoGnYhxL3Py0tMCDF+YdB7P4sLtgpo1+YS/m/3
	DUqQLSP10SSlz6p3LfzC66MX/QH9j0YDIjLow6sYKCj8aHNjqjK1TNUU1ijSGes9ODbD8TN+c3jG5
	smyi6ZzEdIDMqnPznRlsDmgGKBzlAoXEVCa9ib79lmWWe4dJYeN1aPC7SmphugFCmOengKtubxBSD
	eYVfx+ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7z6G-0000000EeeJ-2c6b;
	Thu, 24 Apr 2025 16:06:56 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7xS6-0000000EMD3-370b
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 14:21:24 +0000
Received: from localhost (<unknown> [193.207.99.4])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 651c5482 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Apr 2025 16:14:38 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Apr 2025 16:14:35 +0200
Message-Id: <D9EXJYETM8DK.1MXQ018Y4BK6G@bsdbackstore.eu>
Cc: <hare@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>, "Keith Busch"
 <kbusch@kernel.org>
Subject: Re: [bug report] nvme_auth: kmemleak observed with blktests
 nvme/tcp nvme/062
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Yi Zhang" <yi.zhang@redhat.com>, "open list:NVM EXPRESS DRIVER"
 <linux-nvme@lists.infradead.org>
X-Mailer: aerc 0.20.1
References: <CAHj4cs-05=-TJAyTVNcf4R9GbnfKVRrEkEVZXEhUACts+WYQYQ@mail.gmail.com>
In-Reply-To: <CAHj4cs-05=-TJAyTVNcf4R9GbnfKVRrEkEVZXEhUACts+WYQYQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_072123_112703_345A3E0B 
X-CRM114-Status: UNSURE (   6.70  )
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

On Thu Apr 24, 2025 at 2:53 PM CEST, Yi Zhang wrote:
> Hi
> I found this kmemleak when running the blktests on the latest
> linux-block/for-next, please help check it and let me know if you need
> any test/info for it, thanks.

I believe the issue lies in the nvmet_auth_insert_psk() function.
The tls_psk  pointer is allocated but only freed in case of an error,
unlike in nvme_auth_secure_concat(), where it is always properly deallocate=
d.

Maurizio

