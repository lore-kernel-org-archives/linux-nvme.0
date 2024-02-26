Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A96C54E41
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 14:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O/ayIvjjD1eW87t48Jwb2eZn99ydHsLs34cpxCaFY3I=; b=cO1y1bb0LGEhrOrNScc6kafa6a
	4qS0jYJIelLukuUSCKwYlwkR9+KRGvNfXpiWqGJ5YJaWBPFYnfZ0HXS3Ap/fPDHml/33vt1TPdsE7
	FwshzyjLp1QeNNFTwp/waxTyeZ3egUqGZsJSIZcyhgYJjTTfZzh+rJ2z91JIu7rmI7Quh9BzBX5/K
	qSDne0pXSvP3/AAg6FjRnctuJUDhX+Nt7irzY/MUPM/PFeV5nJe2qAa3jo8wMT/3QgnGJmtj6TI2r
	NXPDkWfjkIjGq5livm9JoBxSilNUZJxG8NTNHn4vTss3xwZCJXbCeMFIV6EReMFyXhcs5ctMRCpIx
	mDJkJ/+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rebdD-000000010vG-3DiL;
	Mon, 26 Feb 2024 14:06:59 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rebZe-00000000z5R-412u
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 14:03:31 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 562861FB55;
	Mon, 26 Feb 2024 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708956196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/ayIvjjD1eW87t48Jwb2eZn99ydHsLs34cpxCaFY3I=;
	b=qhcAFLjqThD/MQTBkNRVpCVPHlQ59jdjB74VwZRRwkWE33wwu36viKgO3FI68pja9qRfXY
	m3rbmR4/FrUEYPJGcrrlHqolJStgcFN8Duq76xMv/xpIgvomeVUkQ7ms7wXL3Cn8AKfcuC
	Go5WOhUgp8SPbiS1n9Jgl/Epf4RJK58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708956196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/ayIvjjD1eW87t48Jwb2eZn99ydHsLs34cpxCaFY3I=;
	b=fNFyp3BHOxKrvLDmd2zDJO39qcmDyEbGHYKbw7xVhO94Tj9ed6qkO1atriRxrGSiU64rwX
	OuWDeZ/dhRD14kCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708956196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/ayIvjjD1eW87t48Jwb2eZn99ydHsLs34cpxCaFY3I=;
	b=qhcAFLjqThD/MQTBkNRVpCVPHlQ59jdjB74VwZRRwkWE33wwu36viKgO3FI68pja9qRfXY
	m3rbmR4/FrUEYPJGcrrlHqolJStgcFN8Duq76xMv/xpIgvomeVUkQ7ms7wXL3Cn8AKfcuC
	Go5WOhUgp8SPbiS1n9Jgl/Epf4RJK58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708956196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/ayIvjjD1eW87t48Jwb2eZn99ydHsLs34cpxCaFY3I=;
	b=fNFyp3BHOxKrvLDmd2zDJO39qcmDyEbGHYKbw7xVhO94Tj9ed6qkO1atriRxrGSiU64rwX
	OuWDeZ/dhRD14kCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 440321329E;
	Mon, 26 Feb 2024 14:03:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Z3uiDySa3GXSWwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 26 Feb 2024 14:03:16 +0000
Date: Mon, 26 Feb 2024 15:01:01 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2] nvme: authentication error are always non-retryable
Message-ID: <22csajx7e5g6rwwhzsn5a5sq566jsigp2oqpqb7yewkqgemshu@4nnt2lt4277x>
References: <20240226080628.21220-1-hare@kernel.org>
 <g3rnirwykldnoved2rojfkf3xrhkv4hai46m3b45kt4tzxpvyx@gqhr3v2l33ea>
 <dx2l57pk5mncqduqu7l36grz4uwlu4k6wcb6gfwaiqxt66itja@rl7kb3ittvb4>
 <99094fa7-35d4-4ae4-bf36-f3c4a346dc61@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99094fa7-35d4-4ae4-bf36-f3c4a346dc61@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.32 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.08)[63.67%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_060319_247399_720E375C 
X-CRM114-Status: UNSURE (   9.06  )
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

On Mon, Feb 26, 2024 at 11:54:13AM +0100, Hannes Reinecke wrote:
> Maybe this?

nvme_uninit_ctrl already puts the ref, thus the nvme_put_ctrl in
nvme_loop_create_crtl is one too much:

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index de2ff7ed0657..bcda781e52f2 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -615,7 +615,6 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
        kfree(ctrl->queues);
 out_uninit_ctrl:
        nvme_uninit_ctrl(&ctrl->ctrl);
-       nvme_put_ctrl(&ctrl->ctrl);
 out_free_opts:
        nvmf_ctrl_options_put(opts);
 out_free_ctrl:


This leaves us with -111 (-ECONNREFUSED)

[  274.702672] nvmet: ctrl 1 fatal error occurred!
[  274.704673] nvme nvme2: qid 0: authentication failed, error -111
[  274.706212] nvme nvme2: NVME-FC{0}: create_assoc failed, assoc_id 2334a5aaec310000 ret -111
[  274.711653] nvme nvme2: NVME-FC{0}: reset: Reconnect attempt failed (-111)
[  274.713119] nvme_fc: nvme_fc_reconnect_or_delete:3356 ctrl 000000009ff229b7 status -111
[  274.714719] nvme nvme2: NVME-FC{0}: Reconnect attempt in 2 seconds

