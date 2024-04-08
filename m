Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90389C67861
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=odx3BkUAFMZtmr0jpc77WjKFWucjcAlRqB7jBHtkTEk=; b=nGf+l1Hm3elzinoGgJm3EdogEw
	gEfOGTRb7BHx6S4Sodp5/f/PgCmw+wXENyCPlu0mUEU3kJH4jLM3Pu5xtmLnbCWDpP/dn+PerGbDT
	WUEYNpFyxqylk4PB7FebCTLbGu86zRTL+39xGzZRXBygnQKrFNq6R7PYaTRASWqDVFvXgLSjAkTvX
	JE1Bq0Jpk/a5PS1++UrRt+snjynvVTZVzQ0tSeMq4nVejnyk3FgrrvlIZ00vUBWcQpwwhP5HpqRak
	UMwFfsz0hBiDybfOt55+/M0jGbtZuisovY8703fYLuo/2jGA4zw/YT/2sMNj8mi+ocwr/AAfog0em
	NctImQsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rttvH-0000000GW7a-1Y3v;
	Mon, 08 Apr 2024 18:40:51 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rttvC-0000000GW54-2vIy
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 18:40:49 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E25D4204EF;
	Mon,  8 Apr 2024 18:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712601643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=odx3BkUAFMZtmr0jpc77WjKFWucjcAlRqB7jBHtkTEk=;
	b=rBcYyEmwzUo1qFfqE5zBZi8uOG1o5zWGv1swMsc2KeJvnv8/M323P1Xkjf9K1IIVI1hLWv
	B6mNb7ZHtELATXWzesws8wdD7V7cUZwSEzU0IQkh47Q7xotvWKPZE9rk62N78keKtYFa5F
	cfHmyPfLa/iLX5C4idpU/ZXutzYQLYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712601643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=odx3BkUAFMZtmr0jpc77WjKFWucjcAlRqB7jBHtkTEk=;
	b=E2+Swa1iYd/ahBCRwp1SGtwyu6mo0FxuA5VtC1YhJiFp8PvW4YmpZiuNF2qtRdH7eb82/r
	6HUa4ONOHKO3+7AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712601643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=odx3BkUAFMZtmr0jpc77WjKFWucjcAlRqB7jBHtkTEk=;
	b=rBcYyEmwzUo1qFfqE5zBZi8uOG1o5zWGv1swMsc2KeJvnv8/M323P1Xkjf9K1IIVI1hLWv
	B6mNb7ZHtELATXWzesws8wdD7V7cUZwSEzU0IQkh47Q7xotvWKPZE9rk62N78keKtYFa5F
	cfHmyPfLa/iLX5C4idpU/ZXutzYQLYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712601643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=odx3BkUAFMZtmr0jpc77WjKFWucjcAlRqB7jBHtkTEk=;
	b=E2+Swa1iYd/ahBCRwp1SGtwyu6mo0FxuA5VtC1YhJiFp8PvW4YmpZiuNF2qtRdH7eb82/r
	6HUa4ONOHKO3+7AA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CDF301332F;
	Mon,  8 Apr 2024 18:40:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wHXSMCs6FGZsJgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 08 Apr 2024 18:40:43 +0000
Date: Mon, 8 Apr 2024 20:40:43 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv4 0/7] nvmet: debugfs support
Message-ID: <3iyuxoky4kai5ee2vakatdfnq6fx6exxpsy2pet7wpj7fodo5l@g76mlabqvjps>
References: <20240326120342.105740-1-hare@kernel.org>
 <d434d186-bfa1-4b44-a9aa-e268b2d41d75@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d434d186-bfa1-4b44-a9aa-e268b2d41d75@nvidia.com>
X-Spamd-Result: default: False [-3.73 / 50.00];
	BAYES_HAM(-2.93)[99.72%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_114046_920415_CBE7A727 
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

On Mon, Apr 08, 2024 at 06:29:10PM +0000, Chaitanya Kulkarni wrote:
> Since it does touch all the transport and writes the controller
> state transport independent blktest would be very useful to trigger
> nvmet_fatal_error_handler() while I/O traffic is running from host ?

Absolutely, this is one of the test I want to add, obviously with a
multipath setup.

