Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC6CD1038C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 08:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hmp7Bf14JrjCza+81dFJ7uau3glMxs5otPf+R7hEmoM=; b=xs8wENWY3WIDbHMGcIDyhGkwhq
	hf0Fr9m08YhiH8i1dCn+K+7L2olm10sGNRzsabVPsnZq+B+bk3Y//XpELrty/PNuT171+v8CAg5Ho
	i1z4NpJeFspr2JJHSH7/FMEuIZMiHrXSCG3w4OLFqPe+RrV+AgzMizD9oqR0xIDj3bmwqr2hA/g9B
	3R1CyblIXfpNlPJBzXZP5aSGGF57Vmfsvyojn6GNty53o7UFXB1BhKj2HiAfZkDc6S0jXnE49aq9T
	LtzdlvzG7e1L2hCjlvwEM/DQJPwQ3WkwyaqizHljVTWQRzm5kdgYu+pCJo1NH6TNZ/Waaqf32JgYp
	c/o6wiDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOAdk-0000000EaUr-0k5M;
	Wed, 26 Nov 2025 08:12:40 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOAdh-0000000EaTm-2nFa
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 08:12:39 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B686A22C45;
	Wed, 26 Nov 2025 08:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764144755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hmp7Bf14JrjCza+81dFJ7uau3glMxs5otPf+R7hEmoM=;
	b=NRJvcDgug5+dGJcnbBZ5o1yznzrTp//J92UIoYaYjchKeCI4beh31m4BgGVsAaHdlcpx9O
	4tkItIl5sFKvVgNbcUu9lTUrz7rxeEU9zxmEOhCIWeJks/aD3bj5Xn+c21t/4WD5Rlpegh
	do5oPTFqM12OvdEGOe4HcMVLrvzcw70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764144755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hmp7Bf14JrjCza+81dFJ7uau3glMxs5otPf+R7hEmoM=;
	b=1Hgs/5rqkj1jmie/vLv3i+KXX36rmivYTyMfY+AFsHhjTTM648vtWaktn4Cia3RcrKJyHu
	WGb5UwyYhv7e0NAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764144755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hmp7Bf14JrjCza+81dFJ7uau3glMxs5otPf+R7hEmoM=;
	b=NRJvcDgug5+dGJcnbBZ5o1yznzrTp//J92UIoYaYjchKeCI4beh31m4BgGVsAaHdlcpx9O
	4tkItIl5sFKvVgNbcUu9lTUrz7rxeEU9zxmEOhCIWeJks/aD3bj5Xn+c21t/4WD5Rlpegh
	do5oPTFqM12OvdEGOe4HcMVLrvzcw70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764144755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hmp7Bf14JrjCza+81dFJ7uau3glMxs5otPf+R7hEmoM=;
	b=1Hgs/5rqkj1jmie/vLv3i+KXX36rmivYTyMfY+AFsHhjTTM648vtWaktn4Cia3RcrKJyHu
	WGb5UwyYhv7e0NAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A861A3EA63;
	Wed, 26 Nov 2025 08:12:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p1ghKHO2Jmk6SQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 26 Nov 2025 08:12:35 +0000
Date: Wed, 26 Nov 2025 09:12:31 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Justin Tee <justintee8345@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, jsmart2021@gmail.com, justin.tee@broadcom.com, 
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH 1/1] nvme-fabrics: add ENOKEY to no retry criteria for
 authentication failures
Message-ID: <3ac161db-5be6-4edf-b392-6769dc507e60@flourine.local>
References: <20251117184343.97605-1-justintee8345@gmail.com>
 <c2b9fb9c-440d-4e41-b4e8-7428fcf9c2ca@suse.de>
 <de42309a-8103-457c-a150-402488b36ede@flourine.local>
 <CABPRKS-YF66xeYpsKsw40F3Rs7YJHaEdm=BgkS+pzQYwMaccJQ@mail.gmail.com>
 <788c2c3e-1293-447d-a43b-17d5026ce1db@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <788c2c3e-1293-447d-a43b-17d5026ce1db@flourine.local>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,lists.infradead.org,vger.kernel.org,gmail.com,broadcom.com,kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_001237_846355_7D1DF57C 
X-CRM114-Status: UNSURE (   9.87  )
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

On Tue, Nov 25, 2025 at 11:34:40AM +0100, Daniel Wagner wrote:
> As I said your fix is good and addresses the reconnect with an invalid
> key problem. Though it doesn't address the issue that 'nvme connect'
> will still return success.

To my surprise this is not happening. nvme/041 is behaving for all
transport the same. I've extended blktests to check the return code for
'nvme connect'

  https://github.com/linux-blktests/blktests/pull/216

So your patch fixes this problem completely. Nice!

Thanks,
Daniel

