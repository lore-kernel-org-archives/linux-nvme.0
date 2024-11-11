Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FE4D2E9D6
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 10:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IeS9CQ8HPyb6zDP21QQlzkASSpcX/dU39q0LBP9iJNU=; b=oPSUcU2H8jiCkY63I41giATkUa
	/fMJbbCKF2TTRck0LzOpopQRd47TNOTfg+xVv0yB9Wvle/dLtPxJEHlfYl+wN6GI3Ose+sR+fBI4X
	fHDUzKXoK/CZ8yPW+JGqNs9yL2iV4jeMJ/1MYxULQ2nyz8LK+oaaO2ZhNwfFVQneHUa9vNiEAInou
	RYugBsdyOY1T0IvJBaWtARqSgWTxZ4oBAfiHYG6JObdFDO6GSXsozYF/ybroi3dvBkqm50RZ+KOnO
	rgyshP/OLz0am/rRYopON6hAy/x5n6cIyj27KqkrZ1rMGHPLLA6zoPKXLE+zpyEUS5m/hri9qQ3yD
	UtIO6fKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tARpA-0000000HJbP-2LO5;
	Mon, 11 Nov 2024 10:39:12 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tARoz-0000000HJZ4-3TBw
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 10:39:05 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21B991F460;
	Mon, 11 Nov 2024 10:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731321540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeS9CQ8HPyb6zDP21QQlzkASSpcX/dU39q0LBP9iJNU=;
	b=DU0MsI4gKKpfaZSQfqc9g8rOCAM0J23VXDaJ1p3lx9ZPltMy1gixHqHyqr+FGj7FLQtKlD
	5nLKs6tOzDSWZk4TF+wO4psHnMW99S9c02vbXFf4qW87xwSfThhf5usdgqBtzZjYP1hpoC
	mWsvOa2pnhMMe3508lZpZ65JVsJnGtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731321540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeS9CQ8HPyb6zDP21QQlzkASSpcX/dU39q0LBP9iJNU=;
	b=9Zg7ZtbkBzX+NLIMlcOzKxvY7LVZg1XptDFL3RPGN7/BdClJNqQl69EJwhC8I7M9cre2Eu
	+GGjR+8DgI97/ZAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731321540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeS9CQ8HPyb6zDP21QQlzkASSpcX/dU39q0LBP9iJNU=;
	b=DU0MsI4gKKpfaZSQfqc9g8rOCAM0J23VXDaJ1p3lx9ZPltMy1gixHqHyqr+FGj7FLQtKlD
	5nLKs6tOzDSWZk4TF+wO4psHnMW99S9c02vbXFf4qW87xwSfThhf5usdgqBtzZjYP1hpoC
	mWsvOa2pnhMMe3508lZpZ65JVsJnGtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731321540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeS9CQ8HPyb6zDP21QQlzkASSpcX/dU39q0LBP9iJNU=;
	b=9Zg7ZtbkBzX+NLIMlcOzKxvY7LVZg1XptDFL3RPGN7/BdClJNqQl69EJwhC8I7M9cre2Eu
	+GGjR+8DgI97/ZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFCC213301;
	Mon, 11 Nov 2024 10:38:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id erAkOMPeMWdlHAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 11 Nov 2024 10:38:59 +0000
Date: Mon, 11 Nov 2024 11:38:59 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 3/8] nvme/016: do not create namespace when
 setting up the target
Message-ID: <585ab80b-7a7b-4493-94fe-9b9cfdae75cf@flourine.local>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
 <20241107111354.80606-4-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107111354.80606-4-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_023902_034156_5D2C4DF0 
X-CRM114-Status: UNSURE (   6.16  )
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

On Thu, Nov 07, 2024 at 08:13:49PM +0900, Shin'ichiro Kawasaki wrote:
> -	_create_nvmet_subsystem --blkdev "${loop_dev}"
> +	_create_nvmet_subsystem

After reading patch #5, should this be

  _create_nvmet_subsystem --blkdev none

