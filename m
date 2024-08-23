Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C70AC531DC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 06:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O76gv6Qm5vxd2udzUhSMYLJpK7PFfsoQ6kT5Sis+XBY=; b=LScNNuhlRzUkQXeErL7wRfyQsB
	zKAI6eKaB5hjBhMcCs3XfOK7RYzbvios9YXC3QxURQv/6nhfZRjPRICJIzB7sZ96NRweB53Qu38r7
	CuyC7Deqnq7rdAq1KvcFTXKFfE1TxF8+69M7AwgMAo8FkJ9BnSLTL8yt0gn4+j1CNIK+90R7w+XPY
	3G30VdvPo3E8dX3HQJbMwCji5/pUFUxgTX7TuK6HsVPnIQFldQipAZq4lTMPNrr/H3YpXQNSaTVFn
	6o6nDfuoVqjZWS+KPSHk8hMkJzeaBjUJ7kHivHWNIiiDBbcmO7qDAF19xRzli7Uo/hWQ4NDuLpf+3
	lcDusYEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shO04-0000000FUro-0Uiq;
	Fri, 23 Aug 2024 06:42:20 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shNzm-0000000FUnn-4AsA
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 06:42:04 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A3B6422604;
	Fri, 23 Aug 2024 06:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724395320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O76gv6Qm5vxd2udzUhSMYLJpK7PFfsoQ6kT5Sis+XBY=;
	b=ghtvD1RCQxUMGQ+XwwMoWWbzcjbyagAY1AIYWJgjgLsjG9VGM2A24gHDxlu93zFSYsfGTz
	ZiYjZBClNKO45U35oDtzn62XP12fUad0y1iD76dzrSueLYRpv8QD7rlOqyDCWB6zjPyX56
	bd8IbkccP7Hl+vAkLR6I6RHv9ddhQSE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724395320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O76gv6Qm5vxd2udzUhSMYLJpK7PFfsoQ6kT5Sis+XBY=;
	b=ghtvD1RCQxUMGQ+XwwMoWWbzcjbyagAY1AIYWJgjgLsjG9VGM2A24gHDxlu93zFSYsfGTz
	ZiYjZBClNKO45U35oDtzn62XP12fUad0y1iD76dzrSueLYRpv8QD7rlOqyDCWB6zjPyX56
	bd8IbkccP7Hl+vAkLR6I6RHv9ddhQSE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67ABF1333E;
	Fri, 23 Aug 2024 06:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wHxaFzgvyGZWagAAD6G6ig
	(envelope-from <mwilck@suse.com>); Fri, 23 Aug 2024 06:42:00 +0000
Message-ID: <1106fb07918468cb8cacb35ef0448573ec7be156.camel@suse.com>
Subject: Re: [PATCH 1/3] blktests: nvme: skip passthru tests on multipath
 devices
From: Martin Wilck <mwilck@suse.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni
	 <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Date: Fri, 23 Aug 2024 08:41:59 +0200
In-Reply-To: <d1282549-f037-4556-93f7-adb3d890db82@flourine.local>
References: <20240822193814.106111-1-mwilck@suse.com>
	 <d1282549-f037-4556-93f7-adb3d890db82@flourine.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_234203_245755_72E7D294 
X-CRM114-Status: GOOD (  12.16  )
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

On Fri, 2024-08-23 at 08:35 +0200, Daniel Wagner wrote:
> On Thu, Aug 22, 2024 at 09:38:12PM GMT, Martin Wilck wrote:
> > +_require_test_dev_is_nvme_no_mpath() {
> > +	if [[ "$(readlink -f "$TEST_DEV_SYSFS/device")" =3D~ /nvme-
> > subsystem/ ]]; then
> > +		SKIP_REASONS+=3D("$TEST_DEV is a NVMe multipath
> > device")
> > +		return 1
> > +	fi
> > +	return 0
> > +}
>=20
> Just a nit: what about _require_test_dev_is_native_multipath?

The intention was to require a device that is _not_ a native multipath
device. Change it to "_require_test_dev_is_not_native_multipath"?

Thanks,
Martin


