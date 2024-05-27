Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD6EC25B74
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 13:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SemSzp9jB8vK31tZ73jANFq30GpIr955Q1/0SQsFGdM=; b=Qs8ww2quTixW7vrv+O2Sc2TIy5
	Qg9ibzksDBeDONVtatZl+uIwIDBu4qMf2BBWCr1+yJwFsWTDorzN6zcVoUnCtmYFZZkp3BPcluUGN
	hnMf395DOm5leBxtZcNoNjC5vymh8M85Vi7RxxUmuc45aEv6PoB0JuvUN9Fpahl8/JzdpzdDMExpB
	i2absWDDgvXoPJkypDifaXGLJQGhNbw0pzmXgITqWml7cv1kheMgibfUknTOcgmzxnoK58Ni3IfPv
	f/HsAWcxJEw6OBidPIBq0Di4nfT3/HceMkc73+tiScHwAwuaTSOaUnsMzIPIDq8VQ2qFjXUqijWiP
	GR1cPWmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBaXF-0000000F84C-0IvH;
	Mon, 27 May 2024 13:37:09 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBaX9-0000000F80M-3Zzv
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 13:37:07 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A767221F1A;
	Mon, 27 May 2024 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716817017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SemSzp9jB8vK31tZ73jANFq30GpIr955Q1/0SQsFGdM=;
	b=2VwNdJ3/6KxuB+uyuSt5Mv7OAXYNc+YKKomWXib7Fvfz4pbShKwBcGi3BuovSPUaT6WYvj
	yGmRUW2fgDgpzHUem1TU/+dC53S99/3HdVy4O89FtcbdomUqx5rruY7xtuDXURlJf0tnEF
	vuXvDtedjbrh295+XV/LbwIkbt79JPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716817017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SemSzp9jB8vK31tZ73jANFq30GpIr955Q1/0SQsFGdM=;
	b=C9X4yi7RNOzIihe/wEUI9hiP1BMVRLyUveTlH5f4S2HM2BBQg2j6IVJzhZSjKto0stTrXd
	QbZeL1XexuJYRVDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="2VwNdJ3/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=C9X4yi7R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716817017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SemSzp9jB8vK31tZ73jANFq30GpIr955Q1/0SQsFGdM=;
	b=2VwNdJ3/6KxuB+uyuSt5Mv7OAXYNc+YKKomWXib7Fvfz4pbShKwBcGi3BuovSPUaT6WYvj
	yGmRUW2fgDgpzHUem1TU/+dC53S99/3HdVy4O89FtcbdomUqx5rruY7xtuDXURlJf0tnEF
	vuXvDtedjbrh295+XV/LbwIkbt79JPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716817017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SemSzp9jB8vK31tZ73jANFq30GpIr955Q1/0SQsFGdM=;
	b=C9X4yi7RNOzIihe/wEUI9hiP1BMVRLyUveTlH5f4S2HM2BBQg2j6IVJzhZSjKto0stTrXd
	QbZeL1XexuJYRVDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BA0F13A6B;
	Mon, 27 May 2024 13:36:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id meaCJXmMVGaARwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 May 2024 13:36:57 +0000
Date: Mon, 27 May 2024 15:36:47 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Gregory Joyce <gjoyce@ibm.com>, Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>, 
	"axboe@fb.com" <axboe@fb.com>
Subject: Re: nvme-cli : attaching a namespace to an undiscovered nvme
 controller on multi-controller nvme disk
Message-ID: <i2pwif6tfqt4cuodue7bs2lrithuxplmtwmsgwioraih4h3ppd@krnf2pxuijet>
References: <f1a7c1e2-3203-4b7a-a922-82fa812455bd@linux.ibm.com>
 <yhvmfctxhfzrcsq4lx6nr3f5n67kegrixtthh3pals7vn5qr26@k5as5whcdrum>
 <dfb2488a-6275-4822-94ec-07a575cbf09c@linux.ibm.com>
 <88f230c4-e16e-4a16-a4e6-a48e605147f1@linux.ibm.com>
 <56198b02-b8fa-4afc-8405-5232d1bf23ab@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56198b02-b8fa-4afc-8405-5232d1bf23ab@linux.ibm.com>
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A767221F1A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240527_063704_062004_06B036B7 
X-CRM114-Status: UNSURE (   8.24  )
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

On Mon, May 27, 2024 at 04:50:34PM GMT, Nilay Shroff wrote:
> A gentle ping, if the proposed patch looks good then may I send a formal patch?

Sorry for the delay, very busy month. I'll look into it next week.

