Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84102CA0FFE
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 07:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=URGa8t5drl+ELX2V8kqt0UagmCmmkJrjqls7W38gxrM=; b=nMBiB2ZlztLgUYkOTBf9AOiLYc
	6IQX+zzzpGWlN14erhmBVxh2BZ3O4kwmWZh/+QNT01Iwqs6oWGqfCAqxsXNzKbE6utsCZ47NOupcp
	cJFwL+2+1AN9jUvzcPiFpFv2VNYG8P6nuMYGzNzadVK9NIk1PXsPYwQwt16Bqr5D2P9fnyVdh4A4A
	C3+37jJbEV9ZWl/xaespP6EyH8DIE0doS3y8oiyk9rd778v4mLyBs3fnQQVOf+4dSNBSq1V7E3HJU
	GjnPKT1XBL/geRyUH0KfBGIT7G7yCN/a9Kv14ugkB8oV5uLz5S4lGTuRQP9D6lVQaCDgGBFLXV+c1
	1PYgcAYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utLiK-0000000FoNW-2wyb;
	Tue, 02 Sep 2025 07:46:00 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utLhR-0000000FoCS-1KU6
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 07:45:06 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E52B1F445;
	Tue,  2 Sep 2025 07:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756799103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=URGa8t5drl+ELX2V8kqt0UagmCmmkJrjqls7W38gxrM=;
	b=t6pCIJSQX3mRgy/0TSyST+5JYrWpXjgi5574pSBZgKMcrtNnjsTjWtq1cVf6idynlI7Fb6
	99KlqZHp2vszrSz9i8XJ9GeQSXCB6IWgH8zgTMEoA8wseOUBVc2UtdzZR2gIR2SPzkQheI
	iVxa0N2FDt7xEWElf9DNRjkWg/18O3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756799103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=URGa8t5drl+ELX2V8kqt0UagmCmmkJrjqls7W38gxrM=;
	b=hYZJUdCz5rX52fRxqzTQTdPMhgyUUPyEMnzxUd18ameGZ+O/DZXPMlWrVXpO/0m6voEC6X
	HeGjl2xFHUqRybAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=t6pCIJSQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hYZJUdCz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756799103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=URGa8t5drl+ELX2V8kqt0UagmCmmkJrjqls7W38gxrM=;
	b=t6pCIJSQX3mRgy/0TSyST+5JYrWpXjgi5574pSBZgKMcrtNnjsTjWtq1cVf6idynlI7Fb6
	99KlqZHp2vszrSz9i8XJ9GeQSXCB6IWgH8zgTMEoA8wseOUBVc2UtdzZR2gIR2SPzkQheI
	iVxa0N2FDt7xEWElf9DNRjkWg/18O3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756799103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=URGa8t5drl+ELX2V8kqt0UagmCmmkJrjqls7W38gxrM=;
	b=hYZJUdCz5rX52fRxqzTQTdPMhgyUUPyEMnzxUd18ameGZ+O/DZXPMlWrVXpO/0m6voEC6X
	HeGjl2xFHUqRybAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C98913882;
	Tue,  2 Sep 2025 07:45:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +DEhHn+gtmhLZwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 02 Sep 2025 07:45:03 +0000
Date: Tue, 2 Sep 2025 09:44:55 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.17-rc1 kernel
Message-ID: <9eef8b8a-a186-4619-91e3-e888d1530c17@flourine.local>
References: <suhzith2uj75uiprq4m3cglvr7qwm3d7gi4tmjeohlxl6fcmv3@zu6zym6nmvun>
 <ff748a3f-9f07-4933-b4b3-b4f58aacac5b@flourine.local>
 <rsdinhafrtlguauhesmrrzkybpnvwantwmyfq2ih5aregghax5@mhr7v3eryci3>
 <6ef89cb5-1745-4b98-9203-51ba6de40799@flourine.local>
 <u4ttvhnn7lark5w3sgrbuy2rxupcvosp4qmvj46nwzgeo5ausc@uyrkdls2muwx>
 <629ddb72-c10d-4930-9d81-61d7322ed3b0@flourine.local>
 <7a773833-a193-4243-80f4-fc52243883a9@flourine.local>
 <ldr3xa4muogowu2xeh3uq3xcifljfftssydgnhjdarfre4kg4p@midqloza2ayz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ldr3xa4muogowu2xeh3uq3xcifljfftssydgnhjdarfre4kg4p@midqloza2ayz>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Queue-Id: 8E52B1F445
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_004505_875479_D1A6E500 
X-CRM114-Status: GOOD (  12.68  )
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

Hi Shinichiro,

On Tue, Sep 02, 2025 at 06:00:17AM +0000, Shinichiro Kawasaki wrote:
> > I'll to reproduce it and see if this patch does make a difference.
> 
> I applied the fix patch above together with the previous fix patch on top of
> v6.17-rc3, then I repeated nvme/061 with fc transport hundreds of times. I
> did not observed the KASAN suaf. The fix patch looks working good. Thanks!

Thanks for testing. I was not able to trigger the bug. Let me cleanup it
and post it.

Thanks,
Daniel

