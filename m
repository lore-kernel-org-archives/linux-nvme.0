Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD15BC4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 12:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/1Puqtj1n4xO6momR1+NGyVJ2loesQ7WnPW5GUvesu8=; b=j47aB0YG/b5NIzuYju3osGeZKF
	L8mS+WzmHGDDDvCk4f75N/lz9KeXX6SL7lUoxVE9ei3d76/RITHIiuzG/krJExpuQCTUd/TaXvJ2U
	veiAHDHyURsHoFlnzrFZDDe1tnn8Lu+yF0bYzm4KQ9hY0KsY5N/9gmdqUJUyKx7CF7LZXG4aXVOuV
	iclpc/XaaixC0oOp3neURjtcxGp5e53ZLN2T39Jkx9gh9VXoKC/KBqwMuEXCVhcqMMdMaSZ8CnJM6
	2ozeNflhJYm5CVSgfMY6SrCgE9qdDEk+QAG0eYzNlSbjjf8w/scCDzTGxXbKHcTXTYtPoE35fqnXN
	QjNN1/JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzblq-0000000454H-0ku3;
	Wed, 24 Apr 2024 12:30:42 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzblk-0000000452R-2D2V
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 12:30:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8AC6966D87;
	Wed, 24 Apr 2024 12:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1Puqtj1n4xO6momR1+NGyVJ2loesQ7WnPW5GUvesu8=;
	b=Pc0Fwl6Lep2XdJoc49lu+ig2pAMvoGP/DVU46ALoSVV8GRxgtSDbHgonyhTseL1uI1yhZx
	5zNTOvjZ2pqgfLbVTzzw9+AzTquIqt03n0lpOmxjTRW0gY4HTTZFwrrgIVe830mwtYIqqZ
	k8Nxy5P8fNoBSmZZSdHGidMH6hCBeGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1Puqtj1n4xO6momR1+NGyVJ2loesQ7WnPW5GUvesu8=;
	b=LmdV69A+KtCqCqscvp//9CCKmiEAoMgcntcI9QHqo5jTzD5sr9RQ8qbcC5Z4A+CEnbuZkI
	1xYvJJbT2XvUkbAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Pc0Fwl6L;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LmdV69A+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1Puqtj1n4xO6momR1+NGyVJ2loesQ7WnPW5GUvesu8=;
	b=Pc0Fwl6Lep2XdJoc49lu+ig2pAMvoGP/DVU46ALoSVV8GRxgtSDbHgonyhTseL1uI1yhZx
	5zNTOvjZ2pqgfLbVTzzw9+AzTquIqt03n0lpOmxjTRW0gY4HTTZFwrrgIVe830mwtYIqqZ
	k8Nxy5P8fNoBSmZZSdHGidMH6hCBeGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1Puqtj1n4xO6momR1+NGyVJ2loesQ7WnPW5GUvesu8=;
	b=LmdV69A+KtCqCqscvp//9CCKmiEAoMgcntcI9QHqo5jTzD5sr9RQ8qbcC5Z4A+CEnbuZkI
	1xYvJJbT2XvUkbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DFDD1393C;
	Wed, 24 Apr 2024 12:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7mO8HWn7KGaJbwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 24 Apr 2024 12:30:33 +0000
Date: Wed, 24 Apr 2024 14:30:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v3 14/15] nvme/{rc,016,017}: rename
 nvme_num_iter to NVME_NUM_ITER
Message-ID: <ljpi2xof7o6n43x5shi3expzvxs3jpryeddxe3ure7yzaud366@rfoom5xvdsjo>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-15-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424075955.3604997-15-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8AC6966D87
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_053036_833442_0A6A63DC 
X-CRM114-Status: UNSURE (   7.58  )
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

On Wed, Apr 24, 2024 at 04:59:54PM +0900, Shin'ichiro Kawasaki wrote:
> To follow uppercase letter guide of environment variables, rename
> nvme_num_iter to NVME_NUM_ITER.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

