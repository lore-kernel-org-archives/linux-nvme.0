Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905B8C369CB
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 05:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KNu7DhymbP4x1FoxV0iB/rSavOQf8haeZ0AZ30PYHsQ=; b=GIYWlmDuw0fizCmBEL1NwB4q6k
	lXQn1waMHWeez7yYJrBs9tjXpCJGLyu9JcFi8/zRBJZlsacspPsBQbZGKvyggD0E4plXGCfS4nbI7
	l22N4ONGi+79h1rJDXTOjVVJDUNOXaIZXs41u7TyvM8Jt8pdsWwraO8mNzifYBfZeMVUoQ7+CUm+H
	4l5kUbyhsXMYYhJxruQ2VMiAodEfJCLItqUFRFwdjJ51guqgEKJ74/qAZN4sItJ2bcXnMjwAUAYm7
	C81HpTQ0Pn4mm0cULiIJI6kuGDUGys5VP8QbmSLEMrwlGYD2FpTIpyPj1TYnEJplXa0kdNuwOOPIR
	bOysAJaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9dyL-00000008SK3-1sMo;
	Tue, 29 Apr 2025 05:57:37 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9dxS-00000008SEk-0DeI
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 05:56:43 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4BC0D1F7CB;
	Tue, 29 Apr 2025 05:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745906200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNu7DhymbP4x1FoxV0iB/rSavOQf8haeZ0AZ30PYHsQ=;
	b=m06Lf6fAbJzrRkGWAwkKsLimZC48QT075fvSjjyqFvUx5JT+jgL1ay+MC5L51UIofyq3cv
	cBn4qTTEWmiv7tRrP1FzL49Kl1HPba9/lkGuW0J2HjgOaGHdlue5SlLuL0kAvw5tCnxP+V
	2AO+cqqoP9X3x8QxgazfNnyepL6Iz+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745906200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNu7DhymbP4x1FoxV0iB/rSavOQf8haeZ0AZ30PYHsQ=;
	b=9o6oWDKHgPr97DHOA8lM7z5yGLDttWTlSnHSUIccXr9r/ogm0Hb2ryc3qHNiYTs8LLG72g
	oQHix0nPj7WxJKDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745906200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNu7DhymbP4x1FoxV0iB/rSavOQf8haeZ0AZ30PYHsQ=;
	b=m06Lf6fAbJzrRkGWAwkKsLimZC48QT075fvSjjyqFvUx5JT+jgL1ay+MC5L51UIofyq3cv
	cBn4qTTEWmiv7tRrP1FzL49Kl1HPba9/lkGuW0J2HjgOaGHdlue5SlLuL0kAvw5tCnxP+V
	2AO+cqqoP9X3x8QxgazfNnyepL6Iz+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745906200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNu7DhymbP4x1FoxV0iB/rSavOQf8haeZ0AZ30PYHsQ=;
	b=9o6oWDKHgPr97DHOA8lM7z5yGLDttWTlSnHSUIccXr9r/ogm0Hb2ryc3qHNiYTs8LLG72g
	oQHix0nPj7WxJKDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9A5613931;
	Tue, 29 Apr 2025 05:56:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z3szNxdqEGiqVwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Apr 2025 05:56:39 +0000
Message-ID: <ea2ee5cf-c995-47d1-8920-82c055b071af@suse.de>
Date: Tue, 29 Apr 2025 07:56:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] fc_els: use 'union fc_tlv_desc'
To: Justin Tee <justintee8345@gmail.com>, hare@kernel.org
Cc: Justin Tee <justin.tee@broadcom.com>, James Smart <jsmart2021@gmail.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250428063635.125879-1-hare@kernel.org>
 <20250428063635.125879-2-hare@kernel.org>
 <CABPRKS-xkcB8mv0huFkOqC10T1Pw2io_GAvfDA2+a6z8rUSDqw@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CABPRKS-xkcB8mv0huFkOqC10T1Pw2io_GAvfDA2+a6z8rUSDqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,lst.de,kernel.org,grimberg.me,lists.infradead.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_225642_234742_A0B50C6C 
X-CRM114-Status: UNSURE (   7.43  )
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

On 4/29/25 02:32, Justin Tee wrote:
> Hi Hannes,
> 
> May we also update lpfc’s function header argument’s description name as well?
> 
Sure. I'll fold it in.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

