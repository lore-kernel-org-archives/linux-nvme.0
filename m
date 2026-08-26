Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3CFC5DF97
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2026 09:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pNxMjLPO76h5bxoa30u6dOxMm1uZchy18/VFt56AInQ=; b=AlW7Wq1NthDl33KdugkYIX5Xqn
	+aJA5s1iRMaDYVNfLQtJNbcJDUC9GGWdTqOdJHctvXnNvStVQCunx1mTjAUuk0rZ3V4WDEpHi4/Va
	esTR5wtV17b97C7YGUbXRrRidf4/L1rDkeFD7nbhDK0mPiP4T9454n6Wd6I7KQBUKcc/nsLup8dTQ
	ys3vDkbIoVQtZIPw3uk/upQZMWChrjWkmXstIN0qY5rAAhyHg1Lgc3XTHA30MjqOV6TkBFkw8Tgyx
	SEh7ZrxXzUtHITAk6KIRCoLdEjRH8Z2iE50BxPrM86hsEaj8lNVw5G9bWW7GYxHIHjQvxe/c0iigi
	97VXFs5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzA6l-00000002Djw-3ySH;
	Wed, 26 Aug 2026 09:39:47 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzA6i-00000002Di9-2mZg
	for linux-nvme@lists.infradead.org;
	Wed, 26 Aug 2026 09:39:46 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69F4E872CF;
	Wed, 26 Aug 2026 09:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787737178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNxMjLPO76h5bxoa30u6dOxMm1uZchy18/VFt56AInQ=;
	b=YWZUviugy2nuAZ8BwC9mjjmc9/xBGgcmC9roWIqbThj9R5YjcOMkTDPQ0TcOXlBiR0ixJ6
	ZWBLxvTLJ9QNA46y5oogNqAXuzJyXDJnl81aCIH73ckd2rtxWSRa4rdE9FJeQOf1t1uB0x
	xns5eh6PwK+WdfFXciQAAKOIGBDI3kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787737178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNxMjLPO76h5bxoa30u6dOxMm1uZchy18/VFt56AInQ=;
	b=F8ezkbx/L8b9O517C9taZ5IT04pFFlIe5sUA/BzytcZmuCSxZ4tYSjR622Lhb09A3o28sF
	RC+FHwzjrEX8/SAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Xs+kaB8r;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=veP9+mOX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787737174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNxMjLPO76h5bxoa30u6dOxMm1uZchy18/VFt56AInQ=;
	b=Xs+kaB8rF8fs/b+eoaN0pSKFXrcrUvNbHtv8kXeo0iVJDOXiSUIMrL/Ja26ECFiK7Mi8jW
	WuOKvWaLgxqFWd1SFQHVE6hPiHIKLvdKLGQwrYcGlm8bInXRUuXy5olgnB0t4RNpQumL1d
	MEGSUAsboH2fil+kdUirIaKqVZ9lzK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787737174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNxMjLPO76h5bxoa30u6dOxMm1uZchy18/VFt56AInQ=;
	b=veP9+mOXEZ0f4I8vBphhGfzdyGUHebJD+Crf2BHvM0W1zh3DHuSJxieb9wApDh8f3Vxjga
	8I9pq1RHftyranBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 567001361C;
	Wed, 26 Aug 2026 09:39:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d4uyFFa0jmreegAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 26 Aug 2026 09:39:34 +0000
Message-ID: <22ddb116-840d-4d6b-ae2a-5bdb755273df@suse.de>
Date: Wed, 26 Aug 2026 11:39:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] nvme-tcp: fix wrong status on deferred digest
 error
To: Xixin Liu <liuxixin@kylinos.cn>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 dwagner@suse.de, linux-kernel@vger.kernel.org
References: <cover.nvme-tcp-req-status.v1.git.liuxixin@kylinos.cn>
 <1.nvme-tcp-req-status.v1.git.liuxixin@kylinos.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1.nvme-tcp-req-status.v1.git.liuxixin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 69F4E872CF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_023944_893345_C478378B 
X-CRM114-Status: UNSURE (   9.96  )
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

On 8/26/26 3:30 AM, Xixin Liu wrote:
> A C2HData digest error stores a host status code in req status. Without
> DATA_SUCCESS the request is completed later from the rsp path, which
> passed that value straight into complete and could report the wrong
> status code.
> 
> Keep req status as a host status code. On the rsp path, shift left when
> a host error was already stored, otherwise use the completion status
> field.
> 
I really don't see it. Where is the issue?
AFAICS we're just changing the type of 'status' from holding the
wire-value to the host value.

Can you make the patch simpler by just keeping 'status' as __le16?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

