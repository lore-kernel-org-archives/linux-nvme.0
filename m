Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69828C636D6
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Feb 2023 14:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lZnAibGvBZUSdsRc+gyHZnZ2bjXIXW7E6CZE7QOc2dg=; b=sESfBcOD6ON18ewCoNXTrCRrAm
	nHteQ8bBISjsJHYyXHHC4ACJPC4RYDZ9aSpSbCOJL1D9X8OS3bGo0Ug8zFpvOi9ShwqDjfHTsTtMS
	p9TZalBcWNWaTFg/kIBG1gzcQFbqnxJgjUnQ0w1fNVabOjGjY6/XW17v4Y7mUoKIqCTcP45w5F4Pt
	aQc7pq6qh7pVawdASZQDQpTGeEHAc4Lqq/mMrfdZ5pG1JPhDLmizLkxl5o31pN+/c5VR6A2jIea+H
	a7l7l5XUNKXW1RC/4rejS2JVZoaF/IsMcgdF/hz7hBg1SqBTsiThE6/pNWo1nAx7Oej1MkIoKqkh0
	1iyGsZfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVCyj-00GtAv-NG; Thu, 23 Feb 2023 14:53:49 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVCya-00Gt7q-Qr
	for linux-nvme@lists.infradead.org; Thu, 23 Feb 2023 14:53:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD87B20C72;
	Thu, 23 Feb 2023 14:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1677164016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZnAibGvBZUSdsRc+gyHZnZ2bjXIXW7E6CZE7QOc2dg=;
	b=CDfi/ohnQ776UwyVwUBB5aQ89c0SxndO+pxiJ+a+aOLJiybXanMh53TeZhKfdnAvlUr+x+
	GO+4J241QlNOfd6CkqagGU7m5oidihZjQNwbHukrX3kHi9zRAadBgkKq6rHdYRlnLtCSIx
	pKhF6OKjR08OtUII2AF5UPwlGTPLx0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1677164016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZnAibGvBZUSdsRc+gyHZnZ2bjXIXW7E6CZE7QOc2dg=;
	b=h/bQGKLIS6HIZoZOJbApvOgIJp/gawOmzdMmNLawyYXFRHhBcguWWACSWPb3JHNqg67CF7
	Y/pZI+ctvdb1K2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E557139B5;
	Thu, 23 Feb 2023 14:53:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id o6WYJvB992PzKQAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 23 Feb 2023 14:53:36 +0000
Date: Thu, 23 Feb 2023 15:53:36 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add quirk for ADATA SX6000PNP
Message-ID: <20230223145336.lulowpv3vlr65lwu@carbon.lan>
References: <87ff6272-2cfe-6b54-864e-71951118c43a@riseup.net>
 <4b824085a2f4987f4682e3602a0e1a96@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b824085a2f4987f4682e3602a0e1a96@riseup.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230223_065341_046019_A6522FF1 
X-CRM114-Status: UNSURE (   8.71  )
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

On Fri, Feb 17, 2023 at 01:28:42PM +0000, Ivan Rubinov wrote:
> Ivan Rubinov писал(а) 2023-02-10 15:10:
> > From 5a8f4f54c85ccb8e06b41b27bcaf19ec4f4d7c85 Mon Sep 17 00:00:00 2001
> > From: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
> > Date: Fri, 10 Feb 2023 14:59:41 +0300
> > Subject: [PATCH] Add quirk for ADATA SX6000PNP
> > 
> > Signed-off-by: Ivan Rubinov <linuxkernelpatch8234@riseup.net>

Can you post the output of 'nvme id-ctrl' for your two devices?
Because the ones in

  https://bugzilla.opensuse.org/show_bug.cgi?id=1207827

clearly have clearly different subnqn.

Although, I have to admint they look suspicious but they are not the same:

subnqn    : nqn.2018-05.com.example:nvme:nvm-subsystem-OUI00E04C2K2129Q696LA
subnqn    : nqn.2018-05.com.example:nvme:nvm-subsystem-OUI00E04C2J4120007707

