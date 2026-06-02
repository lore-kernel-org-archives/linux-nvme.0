Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07381CD6E4A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 13:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GLDBAEw7nKphNuU/SnbyqPGIgnsAKgHLf8878YKhiB4=; b=koULVYo/oVYXBEITWwrTvsGIwm
	4hWgS/gULTpQmCjmYaKz5CJp/OyfA+3vHlYGZxtXK6moL17X0DbpMT6c02Ou3AGOy4zGeh6coIqFg
	j/OSBZ9onBTwmkeLSpOS/Q+u5ggs6t2GA4xtOupi+TQbAddJzKrxUbEnm0umGZL2fD7qWds2C6T11
	yqbHGuUcdgDMrLDsG1lbI2zHhZxGE1c5hYt6nXLukbi3/C4eBXRuzlXBt+Dx44v5ZW0JIr9PEyEbZ
	tZ5Rxy1ovf0MVlQG6/0S2i4AVtTEor8h2fF8HCb74eE+pJX2BhLXWJwa5NK3XY6uradyGr2Q3z0Bn
	/dBGY94g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUOu9-0000000D3FR-1nuU;
	Tue, 02 Jun 2026 13:11:37 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUOu7-0000000D3F3-0pFw
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 13:11:36 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5E456BD89;
	Tue,  2 Jun 2026 13:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780405891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLDBAEw7nKphNuU/SnbyqPGIgnsAKgHLf8878YKhiB4=;
	b=at4MGJtPRY3ZIE9BIO1sccy95hv5OvDBT2teJESXuDfSX4aAkqj4BPRD8xU6yM9fL/D3pv
	pFJIQP03Hiqyvi1HmlZjeRamINmtLgNSRb6ZOvTm3v8rUPoED6xvt9RRO3Ao/EC18XOlAl
	sBIrIFzwgOxDLEtM4LHiq1YLel7OWV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780405891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLDBAEw7nKphNuU/SnbyqPGIgnsAKgHLf8878YKhiB4=;
	b=+CxrNCh7b8V7ZI2vP0X+L1SKu4NULWd2p/eYKcG+JGEQqL0b4ODeMpPrgRnTF2JvuGXqo0
	k/n7tNgUXd3hAeBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780405891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLDBAEw7nKphNuU/SnbyqPGIgnsAKgHLf8878YKhiB4=;
	b=at4MGJtPRY3ZIE9BIO1sccy95hv5OvDBT2teJESXuDfSX4aAkqj4BPRD8xU6yM9fL/D3pv
	pFJIQP03Hiqyvi1HmlZjeRamINmtLgNSRb6ZOvTm3v8rUPoED6xvt9RRO3Ao/EC18XOlAl
	sBIrIFzwgOxDLEtM4LHiq1YLel7OWV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780405891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLDBAEw7nKphNuU/SnbyqPGIgnsAKgHLf8878YKhiB4=;
	b=+CxrNCh7b8V7ZI2vP0X+L1SKu4NULWd2p/eYKcG+JGEQqL0b4ODeMpPrgRnTF2JvuGXqo0
	k/n7tNgUXd3hAeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1874779A7;
	Tue,  2 Jun 2026 13:11:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /VTEJYPWHmoAKQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 02 Jun 2026 13:11:31 +0000
Date: Tue, 2 Jun 2026 15:11:22 +0200
From: Daniel Wagner <dwagner@suse.de>
To: =?utf-8?B?6aG+5rO95YW1?= <guzebing@bytedance.com>
Cc: guzebing <guzebing1612@gmail.com>, 
	linux-nvme <linux-nvme@lists.infradead.org>, Tokunori Ikegami <ikegami.t@gmail.com>, 
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH nvme-cli] nvme: check MUD support before firmware commit
Message-ID: <bb573146-9423-49bc-98ec-26fea8800d7d@flourine.local>
References: <20260519134542.1841435-1-guzebing1612@gmail.com>
 <4b210910448ef2227190f426e97614787d15d32b.e5ce5e1d.af0b.4b3d.a55b.5eff144cf045@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b210910448ef2227190f426e97614787d15d32b.e5ce5e1d.af0b.4b3d.a55b.5eff144cf045@bytedance.com>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_061135_400880_9F508D2F 
X-CRM114-Status: UNSURE (   7.53  )
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

On Thu, May 28, 2026 at 11:48:54AM +0800, 顾泽兵 wrote:
> Just a gentle ping on this patch.

Ah sorry, I missed it. In the meantime the patch is merged.

Thanks,
Daniel


