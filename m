Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8B4C54E5D
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Mar 2024 07:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G+Ja9W+RUHHdDTUkOUHKu9U222Z4cTsyc6Dx3Tjdl5Y=; b=bZK/m8arv8w4+QmhMy2wLpbY8f
	eA1mIT3pLKLc6Yf+SDMFJ5RXQSHbBBB8k1huC1HJvrzyihO5BMS+7wmlVKEfV4onCnsj2NbtqtiLS
	kKZ3/N+LApMaFrSBmfGBd4luoefgc1Svf60jkxshA5egZUnNAKj56BVeNIc4gCwcOJ4G+YWQwsscd
	8ikbMAkQz9X3QnV3HqCLnyEAppywM2str7/cW0eoZgAksqsW4r9+Up9908/P43X3IiTJyE2H5soaw
	MxZ90T8lpPa7irEiN/o2kahXLddLFFTE4PSnMZ+Yh57jwcK6dhPzOHKZfygapCyJ4OHR7vgMu8J7o
	MkP6jY3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmTz2-0000000Bihr-1DHX;
	Tue, 19 Mar 2024 07:34:04 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmTyu-0000000BigZ-3fr3
	for linux-nvme@lists.infradead.org;
	Tue, 19 Mar 2024 07:34:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2675E37478;
	Tue, 19 Mar 2024 07:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710833634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+Ja9W+RUHHdDTUkOUHKu9U222Z4cTsyc6Dx3Tjdl5Y=;
	b=ELNNgdXF5JxwX7O63ymqyvJ6kSsZMnz49ohXvnR4yXt7VgOlpAwwD9GxTFnHeNPipfCJvh
	RXLNP8jvtyRr18YlySpi58DEjeUhbP9gcp7j6YJpfXH3jJlxsom5CxfnTkPGrrws/p803n
	OV0Rs6Rf/AoxqmtkrGMs9Smq9lhs4DQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710833634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+Ja9W+RUHHdDTUkOUHKu9U222Z4cTsyc6Dx3Tjdl5Y=;
	b=e2cKpJvZKos3HQ0b9WMq0Br7nhFQTnvt+kNAIYqBENrWs+LSNhnxL6hc5Yhtf1OBv8tJUz
	ZYyTyYNEY9hPHLAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710833634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+Ja9W+RUHHdDTUkOUHKu9U222Z4cTsyc6Dx3Tjdl5Y=;
	b=ELNNgdXF5JxwX7O63ymqyvJ6kSsZMnz49ohXvnR4yXt7VgOlpAwwD9GxTFnHeNPipfCJvh
	RXLNP8jvtyRr18YlySpi58DEjeUhbP9gcp7j6YJpfXH3jJlxsom5CxfnTkPGrrws/p803n
	OV0Rs6Rf/AoxqmtkrGMs9Smq9lhs4DQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710833634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+Ja9W+RUHHdDTUkOUHKu9U222Z4cTsyc6Dx3Tjdl5Y=;
	b=e2cKpJvZKos3HQ0b9WMq0Br7nhFQTnvt+kNAIYqBENrWs+LSNhnxL6hc5Yhtf1OBv8tJUz
	ZYyTyYNEY9hPHLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 145E0136A5;
	Tue, 19 Mar 2024 07:33:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r4V/A+I/+WXcagAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 19 Mar 2024 07:33:54 +0000
Date: Tue, 19 Mar 2024 08:33:53 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: blktests failures with v6.8 kernel
Message-ID: <ohqhycsnk5rdvo6uxbdfgi2w2vx2qhusvip2emkf7w5pydj7nt@yhyqhib47fo3>
References: <nnphuvhpwdqjwi3mdisom7iuj2qnxkf4ldzzzfzy63bfet6mas@2jcd4jzzzteu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nnphuvhpwdqjwi3mdisom7iuj2qnxkf4ldzzzfzy63bfet6mas@2jcd4jzzzteu>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.13 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.12)[66.92%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ELNNgdXF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=e2cKpJvZ
X-Rspamd-Queue-Id: 2675E37478
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240319_003357_116884_7C678E95 
X-CRM114-Status: UNSURE (   9.32  )
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

On Tue, Mar 19, 2024 at 06:45:14AM +0000, Shinichiro Kawasaki wrote:
> #2: nvme/041,044 (fc transport)
> 
>    With the trtype=fc configuration, nvme/041 and 044 fail with similar
>    error messages:
> 
>   nvme/041 (Create authenticated connections)                  [failed]
>       runtime  2.677s  ...  4.823s
>       --- tests/nvme/041.out      2023-11-29 12:57:17.206898664 +0900
>       +++ /home/shin/Blktests/blktests/results/nodev/nvme/041.out.bad     2024-03-19 14:50:56.399101323 +0900
>       @@ -2,5 +2,5 @@
>        Test unauthenticated connection (should fail)
>        disconnected 0 controller(s)
>        Test authenticated connection
>       -disconnected 1 controller(s)
>       +disconnected 0 controller(s)
>        Test complete
>   nvme/044 (Test bi-directional authentication)                [failed]
>       runtime  4.740s  ...  7.482s
>       --- tests/nvme/044.out      2023-11-29 12:57:17.212898647 +0900
>       +++ /home/shin/Blktests/blktests/results/nodev/nvme/044.out.bad     2024-03-19 14:51:08.062067741 +0900
>       @@ -4,7 +4,7 @@
>        Test invalid ctrl authentication (should fail)
>        disconnected 0 controller(s)
>        Test valid ctrl authentication
>       -disconnected 1 controller(s)
>       +disconnected 0 controller(s)
>        Test invalid ctrl key (should fail)
>        disconnected 0 controller(s)
>       ...
>       (Run 'diff -u tests/nvme/044.out /home/shin/Blktests/blktests/results/nodev/nvme/044.out.bad' to see the entire diff)

FTR, https://lore.kernel.org/linux-nvme/20240221132404.6311-1-dwagner@suse.de/

Hannes has told me he has another idea how we could solve this problem
and he wants to post some patches.

