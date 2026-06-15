Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39C0CD98C7
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2026 12:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BTQvrnxKhhtZNWEla/VowV5jxFxminOHmqm5MvW85rE=; b=UfBN3UuaEVSHGIS+c58tU2Y1//
	qinUEW5JDtCEBOM0x3HvUM/SMrwE9wdv/5l9jPqME5CgmyIWqUnXroQD5QVzmhqAKXYSeyl9PlBc/
	oPrwagjTL8WbTSGgEK8i1gv9PaEz/Vgf516ZlF8PZbiHf3hkdcLaFRQWUHZcQnHls3yDjcpmBK0u7
	EXVbSthGj5R7X3ME7V9/+4m5/exqY2jzx38eaqcSTRun/MCEXA5NLWsY3S7Hc3PA4UJQXjAqZH8GN
	FhLS1UyunM+8BqvrgOxRTHpRtwz1Y/vDg1FnV0/nq4W/TwSmwedkWxGfgKE8ZFshbI2m3VHUuZQ6E
	vc9d6/kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ60H-0000000E8W7-2Gsc;
	Mon, 15 Jun 2026 12:01:21 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ60E-0000000E8Vk-2AFh
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jun 2026 12:01:19 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95C7E759D6;
	Mon, 15 Jun 2026 12:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781524876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BTQvrnxKhhtZNWEla/VowV5jxFxminOHmqm5MvW85rE=;
	b=J9cJFGoVj6OAZDHpJyi463tcGDz/UKGuJ+IyxLWk741Wm8OBJhhGg6h8OlG7jqoXPhlrqk
	uS2QShPFYtK2lWaK4VT8hTdt0gF+OV18qsFttdxj3wbpttVjukRU7tbXb0Jro2EFXsSoGS
	boMarOT2FlYNxN/Bx2fX4mWPnecB2kE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781524876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BTQvrnxKhhtZNWEla/VowV5jxFxminOHmqm5MvW85rE=;
	b=VXKRpnazoJNw8bt7WxPX4Foq0LTjF+5/T0oa3QsqxV8MJ/bEWxKLpuoKCQcXt//Q3blnpq
	23c2FXsntHDPgODA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781524876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BTQvrnxKhhtZNWEla/VowV5jxFxminOHmqm5MvW85rE=;
	b=J9cJFGoVj6OAZDHpJyi463tcGDz/UKGuJ+IyxLWk741Wm8OBJhhGg6h8OlG7jqoXPhlrqk
	uS2QShPFYtK2lWaK4VT8hTdt0gF+OV18qsFttdxj3wbpttVjukRU7tbXb0Jro2EFXsSoGS
	boMarOT2FlYNxN/Bx2fX4mWPnecB2kE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781524876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BTQvrnxKhhtZNWEla/VowV5jxFxminOHmqm5MvW85rE=;
	b=VXKRpnazoJNw8bt7WxPX4Foq0LTjF+5/T0oa3QsqxV8MJ/bEWxKLpuoKCQcXt//Q3blnpq
	23c2FXsntHDPgODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 762EC779A7;
	Mon, 15 Jun 2026 12:01:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sMnhG4zpL2rSWAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 15 Jun 2026 12:01:16 +0000
Date: Mon, 15 Jun 2026 14:01:15 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org, hch@lst.de, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix crash and memory leak during invalid cdev
 teardown
Message-ID: <73b9042e-730b-4e94-830b-b61f77337dd2@flourine.local>
References: <20260605151048.354313-1-mlombard@redhat.com>
 <5a393a6c-371a-4c8f-8a90-6736907dccf4@flourine.local>
 <DJ9GTUZ0E8DC.2EYP78213NAX@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ9GTUZ0E8DC.2EYP78213NAX@arkamax.eu>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_050118_709800_06F77354 
X-CRM114-Status: UNSURE (   8.46  )
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

On Mon, Jun 15, 2026 at 10:04:37AM +0200, Maurizio Lombardi wrote:
> Please refer to the latest nvme-7.2 branch.
> Those functions were later modified to not return error codes.

Sorry, I looked at master instead nvme-7.2. My excuse is that I am still
catching up from my vacations :)

