Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C935C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 12:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hIBCglsQwuObrzOZH+UpF+xbmS0ZBIdkfohwacMwsL0=; b=5GIVSMrYnkuAz/2n2oQrFGxth4
	whQ7RsGZAz7aecPyVAK6AiYSngKBxk2DrlfKPCnHe/bRr9xa0yKBvIwwqbyc9mQS4ukFTUKNS5SfD
	jEB9RHFMrELuLVDOecahJ4Qnscg6grgRtGLPNrfeh1iX+FV+pmZHhgp7D69vr0O4QS1tf7f/xwJrf
	TiJ7lF6HOG7q6puQePO8dU/waq897zlyWfLCjSIvZOrklWP9UKPgmwNTFLqeXTGASatZyGWXvsVUY
	bufhaeQ1dwgYEdTJzVVyfKXTHYxzHOJBQA69E+t6dwIYoXGuCgnWxh5lm3EZTnlY7AxmSsMqXUXZ4
	+GRC4OCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxRNY-003Knq-2u;
	Mon, 30 Oct 2023 12:28:24 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxRNV-003KnJ-2P
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 12:28:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CB32219CD;
	Mon, 30 Oct 2023 12:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698668897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=hIBCglsQwuObrzOZH+UpF+xbmS0ZBIdkfohwacMwsL0=;
	b=p69UvGD0K9XJIdlpru7q4NfAYuM5dfTU6RuUAy9fq9+dzcWQjofvgfEVXruP2VVZpr0UWs
	jA9XzPBCr1x/qYy6XvCv+itv2n3mRXzz1v1+imcAVgG09HMYpJiIeJPSxP6AJ3EDIohaS1
	aZHK87Ih3GvIusuE35n+BXRtkZvbkr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698668897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=hIBCglsQwuObrzOZH+UpF+xbmS0ZBIdkfohwacMwsL0=;
	b=x9GhGrbtNW6REUAvIse9iPrAy/fOgzioz1uvsmO8m1s8wnKPNiaa5eJUE0S2B9J1pUEIV/
	IVt95LQChVpf/aBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F32E138F8;
	Mon, 30 Oct 2023 12:28:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xROSB2GhP2WqcgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 30 Oct 2023 12:28:17 +0000
Date: Mon, 30 Oct 2023 13:29:52 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: nvmetcli release?
Message-ID: <uvqke5sw2nqf63vuwypemyrllpr7h4le3jjzcxsbuavja6xhbn@tpqilzrlwh7a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_052821_950568_D94D8B6E 
X-CRM114-Status: UNSURE (   7.57  )
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

Hi Christoph,

Would it possible to a new release of nvmetcli? Just asking because I
was asked to update our downstream package to latest version. It would
make it slightly simpler if there is a new release.

Thanks,
Daniel

