Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CF2D2E9D3
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 10:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6NoM7fq5BZzZxXdf4LoVy60o0+mo069Ub9ClC0d4Ftw=; b=g6xiEsuZSTqRJPocnM6w/jev0B
	neAWnXoprIQG4OgYLdv0fxa2KhLHPmeSausCYlP3x26RHn3JN1xJSDEyQK//H+aV4L6MhDWOJk0K3
	PkrvmVnlf4yIqc9S8wo/wDofoetTgGCUoKAM1rW9mCsHZc1tZ+uWGFw3AA67oAjcIOM0e6lR8gkzY
	OiJhowjhUlZCL9FKisxYIGjnuG9jQyKxcDGuuqpGbQSMrJI5827YFzhv5SnE0IemkLdpneWXYXLlP
	dFmxgLUU8Zcm4nXmSfToqEnQjte6PJweUxlnu2ntXsAGutNvurONwTzP5xLS2/KdoBOrRnD4edBE7
	d0ZbRU+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tARhs-0000000HHnd-0XLn;
	Mon, 11 Nov 2024 10:31:40 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tARgq-0000000HHUl-03zO
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 10:30:40 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 361B8218A1;
	Mon, 11 Nov 2024 10:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731321034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6NoM7fq5BZzZxXdf4LoVy60o0+mo069Ub9ClC0d4Ftw=;
	b=F8exc/kYhvfTXiK+zNiMUQjWz8CELCct2pkVMOLLvQSKRUJiFVwH3wA5mwAEtQu13rdnlP
	126D/kV5zragMU2qBshkSq27J3WKD8O4u8/KQES/G/xH8QaT8Uvacs901aonOi2+Ypwmk4
	QUrR7n7Bmfv7/yXcaGyJ7ig6lc/pwlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731321034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6NoM7fq5BZzZxXdf4LoVy60o0+mo069Ub9ClC0d4Ftw=;
	b=xs3zesEsFK80i8oMiXt5qLihsUOPPzn3YrjMLrLDPHR7k54b9QFkBrTt2rf5XjVKFB33dO
	/hPJ4yELzKdYU3Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731321034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6NoM7fq5BZzZxXdf4LoVy60o0+mo069Ub9ClC0d4Ftw=;
	b=F8exc/kYhvfTXiK+zNiMUQjWz8CELCct2pkVMOLLvQSKRUJiFVwH3wA5mwAEtQu13rdnlP
	126D/kV5zragMU2qBshkSq27J3WKD8O4u8/KQES/G/xH8QaT8Uvacs901aonOi2+Ypwmk4
	QUrR7n7Bmfv7/yXcaGyJ7ig6lc/pwlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731321034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6NoM7fq5BZzZxXdf4LoVy60o0+mo069Ub9ClC0d4Ftw=;
	b=xs3zesEsFK80i8oMiXt5qLihsUOPPzn3YrjMLrLDPHR7k54b9QFkBrTt2rf5XjVKFB33dO
	/hPJ4yELzKdYU3Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CDA313301;
	Mon, 11 Nov 2024 10:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T3+iBMrcMWeRGQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 11 Nov 2024 10:30:34 +0000
Date: Mon, 11 Nov 2024 11:30:33 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 2/8] nvme: move _nvmet_target_setup() to
 common/nvme
Message-ID: <a239ae5a-d024-48cd-b2cb-6d820191e249@flourine.local>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
 <20241107111354.80606-3-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107111354.80606-3-shinichiro.kawasaki@wdc.com>
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
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_023036_366701_3042F994 
X-CRM114-Status: UNSURE (   9.94  )
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

On Thu, Nov 07, 2024 at 08:13:48PM +0900, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> _nvmet_target_setup() is in tests/nvme/rc, but _nvmet_target_cleanup()
> is in common/nvme. So move the former into common/nvme to have both
> functions in the same place.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [Shin'ichiro: rebased on the commit e3fe06e and resolved conflicts]
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

