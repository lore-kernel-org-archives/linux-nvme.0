Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68E5C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 12:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qvX6rH0pkljDUwUMsIyxIci4p1n6qg/XubZcJ1g3AwM=; b=0oZRab7e/VcpEZ5TIhJ+QfjkKK
	ka+pcdNHhv+UZf11vxsS/usFNHJ7DEm7A3aTofgLn5VVtYVdhMI/matcd5x5IbOSjlXd42tH8tSbX
	xoSaxif8K48P94bomc7SF9MWizMg6HhCQgehyoteQlxZYbi/sOQZq5+ttqwVW20wwekinp8V+WhR+
	VC7OINXieBDmN+r6zg8bNDeINpEe4GKHS3UdYJmhCccoZNJB2d5enKbQNqPz08uW/vOONtluK9/n5
	YoApu0duoZRXhOv1cfNWyuRF7V00bhKs4bhjZXH7/s0XlHrRKyf03jUuYnCogA8m7yMwNWf7Q77EW
	DBhMmV+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHMyX-0000000CYu1-1Kky;
	Wed, 12 Jun 2024 12:21:13 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHMyT-0000000CYsv-1hvP
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 12:21:12 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E08625C1BF;
	Wed, 12 Jun 2024 12:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718194866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvX6rH0pkljDUwUMsIyxIci4p1n6qg/XubZcJ1g3AwM=;
	b=OzMbKuABKKp8eEenmZY3/W/U/R097LIAnM/aC/M0ga4PDa5apls60PdPk3yV+7SfGBeknp
	ObyMPdxTvDs5wCG05SrnZgzERaFieT/vptbO8ozavosVC1sUp0kYjlkQGp/JmsHatAosLg
	oGpnH0BM7UwxmT6k8qGUDj0X3GfGUKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718194866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvX6rH0pkljDUwUMsIyxIci4p1n6qg/XubZcJ1g3AwM=;
	b=g+O9ZL+iTX4Bi64mmZS9gp1uRrOKmfIBRPC0Af/KmDZG+EZX8a9EmUqoIEgBvKZG0JJa+l
	F61tkGcAyoJ/a6Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718194866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvX6rH0pkljDUwUMsIyxIci4p1n6qg/XubZcJ1g3AwM=;
	b=OzMbKuABKKp8eEenmZY3/W/U/R097LIAnM/aC/M0ga4PDa5apls60PdPk3yV+7SfGBeknp
	ObyMPdxTvDs5wCG05SrnZgzERaFieT/vptbO8ozavosVC1sUp0kYjlkQGp/JmsHatAosLg
	oGpnH0BM7UwxmT6k8qGUDj0X3GfGUKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718194866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvX6rH0pkljDUwUMsIyxIci4p1n6qg/XubZcJ1g3AwM=;
	b=g+O9ZL+iTX4Bi64mmZS9gp1uRrOKmfIBRPC0Af/KmDZG+EZX8a9EmUqoIEgBvKZG0JJa+l
	F61tkGcAyoJ/a6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D62CA1372E;
	Wed, 12 Jun 2024 12:21:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nG5BNLKSaWZYJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 12 Jun 2024 12:21:06 +0000
Date: Wed, 12 Jun 2024 14:21:06 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [RFC blktests v2 3/3] contrib: add remote target setup/cleanup
 script
Message-ID: <36n7xm55qnlht6mc6n7qgqneugzbepsqcrq22lspalqxfsar3j@l4uukejcfupf>
References: <20240612110444.4507-1-dwagner@suse.de>
 <20240612110444.4507-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612110444.4507-4-dwagner@suse.de>
X-Spamd-Result: default: False [-3.79 / 50.00];
	BAYES_HAM(-2.99)[99.95%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_052109_623693_122799AB 
X-CRM114-Status: UNSURE (   9.72  )
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

On Wed, Jun 12, 2024 at 01:04:44PM GMT, Daniel Wagner wrote:
> +# blktests calls this script to setup/teardown remote targets. blktests passes
> +# all relevant information via the command line, e.g. --hostnqn. The interface
> +# between blktests and this script is 'documentent' here in build_parser
> +# function.

I just had an offline discussion with Hannes. This script is setting
up/tearing down the targets on demand. This is fine for a remote Linux
box the soft target running use case.

Hannes' idea/requirement that it should also support static setups. E.g.
the admin setups the real remote target and provides the ns uuids, which
test should run against (this is very similar to TESTS_DEVS). Thus the
tests should only operate on ns uuids and through this script blktests
can ask for the ns uuids.

