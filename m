Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9045C5321D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 07:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mpl+4dk1lTIMG1sUQ9PCAlKzWtVwLt3AQ/wWblfdjUo=; b=dk7ZAW4HvG1lAfZfZUBIAPo3+J
	0wIR7VrIjvDks/HgaACOB0t/B8s0HL53ZtPlNxnafM968ozodq2zQecUlXhmedlRB+caTXezB18iG
	qdwypboN/EFCECR/hMQJr2YvCk/C9ijiRPyZa7COmX7zg/fPV2vb/wUMSyonEykA4opVW1yiltdn5
	f0PGo0N2MMrBHv+bRYXnPn5gunbRHp3Sc3hkftwE3GbK8Ph0i4u4IaIOzSiObx9K1O7o1WR8uXIfA
	4vX5yPVUIl5+GYbuU/0dqfrM53G0BHdrHclqi7AyBbtCFMY3OO5Dh2TGAYbnZIcqCIvU1A0U0+qR5
	+RUi66rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siUd1-00000006Mn5-47WR;
	Mon, 26 Aug 2024 07:59:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siUd0-00000006Mlg-0LMK
	for linux-nvme@bombadil.infradead.org;
	Mon, 26 Aug 2024 07:59:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=mpl+4dk1lTIMG1sUQ9PCAlKzWtVwLt3AQ/wWblfdjUo=; b=m6XSkX63oWoHdXcRw20pvLgfAE
	SXokxw04puIa1ckQRm8QuiP4Dr3D3xk76czL31lVXIpsbo6GBrroTi41i9GVzFmtaoEMa8zKtwK5D
	bjjMJS1dZSKqXCGnz1qEyGKo/yUwCJABlvuzgZd3fBUThtMCBOSW2v4Wv8WOJqia79iOcMg+I4Vyw
	w/hiJBn2LPTsGq8yZwN5KyR7Tu331SHlmPSRstgbdD5R/LfiKZP97ESuE9h+LAqOvC0XtQFzi4A8Z
	Vw9x6HD/Pu3FjpAKTBNP51rS+v+2pve5WVie7NgrIXOtB9hYF8tCsEOLlGXoTPS0vx6mQ6yx1BC/f
	e97ygezA==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siUcw-0000000AbCe-0Ueo
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 07:59:04 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 136521F842;
	Mon, 26 Aug 2024 07:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724659139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpl+4dk1lTIMG1sUQ9PCAlKzWtVwLt3AQ/wWblfdjUo=;
	b=YRBXdrIcgiGQUV7IV/Spqygo9MS0w1xp1sh9UpfkC1Sww12hNwu8vY5gWVHFSxHKd0jQX+
	/YyMJ5FqfWmNhpQPhfhiYKI2EDdxRNHe76RqgllPl81uUHQjITeBIrxQ8muPD/39Tuq9Gg
	NnHl35j3p+NrPqrPByJqhIoErSrZnng=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YRBXdrIc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724659139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpl+4dk1lTIMG1sUQ9PCAlKzWtVwLt3AQ/wWblfdjUo=;
	b=YRBXdrIcgiGQUV7IV/Spqygo9MS0w1xp1sh9UpfkC1Sww12hNwu8vY5gWVHFSxHKd0jQX+
	/YyMJ5FqfWmNhpQPhfhiYKI2EDdxRNHe76RqgllPl81uUHQjITeBIrxQ8muPD/39Tuq9Gg
	NnHl35j3p+NrPqrPByJqhIoErSrZnng=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C71341398D;
	Mon, 26 Aug 2024 07:58:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P6EFL8I1zGajUgAAD6G6ig
	(envelope-from <mwilck@suse.com>); Mon, 26 Aug 2024 07:58:58 +0000
Message-ID: <3be250bbaede895861092d055d9f49a71566a78f.camel@suse.com>
Subject: Re: [PATCH v2 3/3] nvme: add test for controller rescan under I/O
 load
From: Martin Wilck <mwilck@suse.com>
To: Nilay Shroff <nilay@linux.ibm.com>, Shin'ichiro Kawasaki
	 <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke
 <hare@suse.de>, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Date: Mon, 26 Aug 2024 09:58:58 +0200
In-Reply-To: <2a550653-89b4-4c3c-840a-a905152adb5f@linux.ibm.com>
References: <20240823200822.129867-1-mwilck@suse.com>
	 <20240823200822.129867-3-mwilck@suse.com>
	 <2a550653-89b4-4c3c-840a-a905152adb5f@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 136521F842
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_085902_528541_ABF4A153 
X-CRM114-Status: GOOD (  11.87  )
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

On Mon, 2024-08-26 at 11:07 +0530, Nilay Shroff wrote:
> >=20
> The "rand()" function in 'awk' returns a floating point value between
> 0 and 1 (i.e. [0, 1]). So it's possible to have sleep for some cases
> go
> upto ~5.1 seconds. So if the intention is to sleep between 0.1 and 5=20
> seconds precisely then we may want to use,
> =C2=A0
> sleep(0.1 + 4.9 * rand());
>=20

Yes, I know. I thought it didn't really matter as the 5s limit was
arbitrary anyway.

> However this is not a major problem and we may ignore.=20
> Otherwise, code looks good to me.
> =C2=A0=C2=A0=C2=A0=20
> Reviewed-by: Nilay Shroff (nilay@linux.ibm.com)
>=20

Thanks!
Martin


