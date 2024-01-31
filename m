Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8E5C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 14:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K6WdwCjsEwj7/GxFe3trEfSFrL5jFiBpY4LXMYlnNwo=; b=L/gei93MIIir37r7w6DuGWOjKu
	IUeI0oBh2vT20G7/iY7Nin1hi3qd9MxZniTWWDOGFJm91rNDl1B1l3P9dsp68JsFktLeBi9WXPtqQ
	CS5FXglA0KDVmEnjV2AXWF3Brh/IZL1cBkcOENi271LnuevjFqrAyqVGFpQVZnbxT5zmliFnwqBdR
	PAYwOQzU38S50qfu3xHM8utDmrM6HLjE9S+ntvQ7w99gLe2XGJchG5VIooQpfXs7x889A5bvpNsjn
	f95x+annxva8DOcAZcmC0PK1KeLqIW4Nv1g/4IIJ86nJP+G/J2eKU+Ty00dtlfqDP2oCE2+GwHyl8
	JS8XQcfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVBfY-00000003v3l-2O5q;
	Wed, 31 Jan 2024 14:34:28 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVBfU-00000003uyC-2uCy
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 14:34:27 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEB2D21E96;
	Wed, 31 Jan 2024 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706711655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6WdwCjsEwj7/GxFe3trEfSFrL5jFiBpY4LXMYlnNwo=;
	b=0Dcvt+WqTV7bg615JoHaIsvGp28c+pk0HsF6nUosB0kfhl+uYlO1l4FpCoQZQrGcB/SQnX
	r44/U3pURqcTfEH9Ih8/VKs4r4kKJwSy/w8Efazg8BfSpXCLowihj4MvuJlYekHLAHO02d
	ZU1QZVOkBCD21++UXdgP3bb4Y9ZKTtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706711655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6WdwCjsEwj7/GxFe3trEfSFrL5jFiBpY4LXMYlnNwo=;
	b=/5M+yyfubk8BrsLvPeyJ9VGeKLhe65Wv3Yy9tV8BlcmRn37ewG9lBb/9/4t2HRlFmigldk
	IY9nkK4GFbcLvjCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706711654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6WdwCjsEwj7/GxFe3trEfSFrL5jFiBpY4LXMYlnNwo=;
	b=xbf8FM4Zy+fmervEwJUjagXufwwKvg/hUxFGUj1cztXZVFYGuMPt9Sr36KnMISt7n9SSzQ
	crbxMcSjvezrB0m2thKGxrwMSSlNeJeRQL2qhb1BG7EebGKs+8d4hzgzNlzBq2EjN/XwRT
	eTdozaRIlH6TaEokAv3Frif8YVm1KSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706711654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6WdwCjsEwj7/GxFe3trEfSFrL5jFiBpY4LXMYlnNwo=;
	b=Cx4YnD34ir28ZFcXmVjy8AvSZ1M3wjKNRpOa0TDDd8tJppDdv7FX2N1c/GH/5ChdmZER6O
	7+GwvcMhszPNqMAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DB244139D9;
	Wed, 31 Jan 2024 14:34:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id JQgJNGZaumXNbwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 14:34:14 +0000
Date: Wed, 31 Jan 2024 15:34:14 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH blktests] nvme/046: change nvme io-passthru command
 option from -o to --opcode
Message-ID: <rbpa7bx5rfhnlhnrzucz5hi5szflkvihdtdmuksuccekwy53qf@nbotapgudm6r>
References: <20240126061037.2169224-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126061037.2169224-1-shinichiro.kawasaki@wdc.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xbf8FM4Z;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Cx4YnD34
X-Spamd-Result: default: False [-5.94 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.63)[98.38%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EEB2D21E96
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_063424_919204_F9DF86D5 
X-CRM114-Status: GOOD (  10.41  )
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

On Fri, Jan 26, 2024 at 03:10:37PM +0900, Shin'ichiro Kawasaki wrote:
> A recent commit in nvme-cli v2.6 changed the single letter of the
> --opcode option from -o to -O. This caused the failure of nvme/046. To
> make the test case work regardless of the nvme-cli version, replace -o
> with --opcode.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Sorry about this. We introduced a couple of global flags, -v (verbose)
and -o (output) and this changed a bunch commands. This was done in the
quest to add JSON output format support add to all commands.

I will refrain from doing more like this for the 2.x cycle.

Thanks for the fix!

Reviewed-by: Daniel Wagner <dwagner@suse.de>

