Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DF8C3064D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jun 2024 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VjZDIayh6/TZRdInMusXNeKuRzRsJ0NplLQuSxJFviw=; b=l/RhPt48HshqlqywacXHwsT5oh
	qXqKHljwhdMFWP1h+g3LnN84UdApEvN09psZ/ahCF8DF9RmtagRTYwtE5zdnEwAHXq3H+axN36ogV
	AGWASzvZ5mFBMY2et4uyQNOANcABsQNCvng3NUgKx4xJ+fqpnlteIJjdIDKgqWeoeocoBO4FSjBF7
	z1j7/JpqdLedyyPTLYUNmiIKzPmnD3O3DYZgZ0bqUKCbXhSLD3pdS+HsGK42cnPqxjmjpnwdI4U/a
	/h6jQL/jeNdTbSlUfdAqS9IXFLS9tluJAS3Cwvi5zIIQx3FldIJhTHK1+04jr8lxr6FJPd7WSRDY2
	MR3Q23Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM7j2-00000003MKi-1UaF;
	Tue, 25 Jun 2024 15:04:52 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM7gD-00000003K1d-25Cv
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jun 2024 15:02:40 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D39A421A76;
	Tue, 25 Jun 2024 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719327714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjZDIayh6/TZRdInMusXNeKuRzRsJ0NplLQuSxJFviw=;
	b=yqyj9ThbWIHHEO/eC4VYWWJJmsOJdccIVDMxJyeQ0T/Lr4pFobpiwYGN7ZoUzHcPsYyzDl
	Om+4fGjFnPQO6i3WFnTCy318gTQBcue9DqXr/anKiqGmBoDUHbxriDCLc1hfbkvcmC9knI
	qN4lKhoUPiBoASr0PIBC/rxwZhV6qhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719327714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjZDIayh6/TZRdInMusXNeKuRzRsJ0NplLQuSxJFviw=;
	b=j0FrsEWu1Xcf70dRtbcije90VywZHgqFgCrtMdWLSYRCXoDZCNN5UQalc5MNYPXHU1AYk8
	W8b0Y/cSsvdyLHDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719327714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjZDIayh6/TZRdInMusXNeKuRzRsJ0NplLQuSxJFviw=;
	b=yqyj9ThbWIHHEO/eC4VYWWJJmsOJdccIVDMxJyeQ0T/Lr4pFobpiwYGN7ZoUzHcPsYyzDl
	Om+4fGjFnPQO6i3WFnTCy318gTQBcue9DqXr/anKiqGmBoDUHbxriDCLc1hfbkvcmC9knI
	qN4lKhoUPiBoASr0PIBC/rxwZhV6qhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719327714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjZDIayh6/TZRdInMusXNeKuRzRsJ0NplLQuSxJFviw=;
	b=j0FrsEWu1Xcf70dRtbcije90VywZHgqFgCrtMdWLSYRCXoDZCNN5UQalc5MNYPXHU1AYk8
	W8b0Y/cSsvdyLHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C59721384C;
	Tue, 25 Jun 2024 15:01:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hIhAL+LbemZqNwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 25 Jun 2024 15:01:54 +0000
Date: Tue, 25 Jun 2024 17:01:46 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Ofir Gal <ofir.gal@volumez.com>
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, chaitanyak@nvidia.com
Subject: Re: [PATCH blktests v2 2/2] md: add regression test for
 "md/md-bitmap: fix writing non bitmap pages"
Message-ID: <wgza656pr5scdqiaxi4vekoffp42jvzao5kcxy7zptdgwstyik@zfcgftuzn6pf>
References: <20240624104620.2156041-1-ofir.gal@volumez.com>
 <20240624104620.2156041-3-ofir.gal@volumez.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624104620.2156041-3-ofir.gal@volumez.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240625_080158_344650_F65E32ED 
X-CRM114-Status: GOOD (  11.82  )
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

On Mon, Jun 24, 2024 at 01:46:18PM GMT, Ofir Gal wrote:
> +#restrict test to nvme-tcp only
> +nvme_trtype=tcp
> +nvmet_blkdev_type="device"
> +
> +requires() {
> +	# Require dm-stripe
> +	_have_program dmsetup
> +	_have_driver dm-mod
> +
> +	_require_nvme_trtype tcp
> +	_have_brd
> +}
> +
> +# Sets up a brd device of 1G with optimal-io-size of 256K
> +setup_underlying_device() {
> +	if ! _init_brd rd_size=1048576 rd_nr=1; then
> +		return 1
> +	fi
> +
> +	dmsetup create ram0_big_optio --table \
> +		"0 $(blockdev --getsz /dev/ram0) striped 1 512 /dev/ram0 0"
> +}
> +
> +cleanup_underlying_device() {
> +	dmsetup remove ram0_big_optio
> +	_cleanup_brd
> +}
> +
> +# Sets up a local host nvme over tcp
> +setup_nvme_over_tcp() {
> +	_setup_nvmet
> +
> +	local port
> +	port="$(_create_nvmet_port "${nvme_trtype}")"
> +
> +	_create_nvmet_subsystem "blktests-subsystem-0" "/dev/mapper/ram0_big_optio"
> +	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-0"

Use the defaults from blktests, e.g. ${def_subsysnqn}"

> +
> +	_create_nvmet_host "blktests-subsystem-0" "${def_hostnqn}"
> +
> +	_nvme_connect_subsys --subsysnqn "blktests-subsystem-0"
> +
> +	local nvmedev
> +	nvmedev=$(_find_nvme_dev "blktests-subsystem-0")

here too

> +	echo "${nvmedev}"
> +}
> +
> +cleanup_nvme_over_tcp() {
> +	local nvmedev=$1
> +	_nvme_disconnect_ctrl "${nvmedev}"
> +	_nvmet_target_cleanup --subsysnqn "blktests-subsystem-0"

same here

> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	setup_underlying_device
> +	local nvmedev
> +	nvmedev=$(setup_nvme_over_tcp)
> +
> +	# Hangs here without the fix
> +	mdadm --quiet --create /dev/md/blktests_md --level=1 --bitmap=internal \
> +		--bitmap-chunk=1024K --assume-clean --run --raid-devices=2 \
> +		/dev/"${nvmedev}"n1 missing

Instead hard coding the namespace ID, this should be made a bit more
robust by looking it up with _find_nvme_ns.

