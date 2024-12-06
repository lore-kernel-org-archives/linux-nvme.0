Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B04E77173
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Opx75M/IMrKIxj9wm41c/ykwrTrUTKFBGpIzszTlX6k=; b=tSRrT+Wqi3Y/ckh4w7g1Puok43
	kjuvb1w/JybLaQx83tSnfhQmx4VKrdqH9Szi7T85gsLLGZqfg+KjVul8dwZvIU3g5ahBWpxmFMheA
	GLxGquB3qotY7EUH5Ny+Ikou2zEcAuZSIdc9CpBtSpole5kHaeuHOPaIFMIEof3wyn68J7lcwyEaT
	7CO4bjhBJX9+TMSx7cxc4xaP1kb9YAyqrDsCSEvrDHoktLXBpUe2pZx7Bmz2TKCI3ZIDmjByJ6Jx0
	EeIgk6Oxf9yDn/kxoEzz5cefH80hYhe0usZjeMz5/bdPfXa+3FWB/tmnarulQRBQzc7swrGMuy9sW
	Vk1krrUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJXQs-00000001Yka-0rqd;
	Fri, 06 Dec 2024 12:27:42 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJXQp-00000001Yin-0N9L
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 12:27:40 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B878521191;
	Fri,  6 Dec 2024 12:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733488055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Opx75M/IMrKIxj9wm41c/ykwrTrUTKFBGpIzszTlX6k=;
	b=Fieh2MPVGIv4RH6WexXEvMopN8qlqXF9QpCiqcQ+ny2uGuthPuDjuYS6apiJchB70JAKYE
	iZgbVh/wQos2s5il8MNgxroKG6+ibl2eR4badAVmXVEk+SqcHn5HiXIL5w+II4UnVBcC0p
	ng94V+3l7YbOdrLPirlHaAxkWxb6DJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733488055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Opx75M/IMrKIxj9wm41c/ykwrTrUTKFBGpIzszTlX6k=;
	b=7/LrWVskKNM3xnoMntyKKVhUgYJplFUqXmb+9DWmVnjDA1tXwFxMa+jsR0/2xRTbds+7n7
	jeSr/01KV04IZLBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733488055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Opx75M/IMrKIxj9wm41c/ykwrTrUTKFBGpIzszTlX6k=;
	b=Fieh2MPVGIv4RH6WexXEvMopN8qlqXF9QpCiqcQ+ny2uGuthPuDjuYS6apiJchB70JAKYE
	iZgbVh/wQos2s5il8MNgxroKG6+ibl2eR4badAVmXVEk+SqcHn5HiXIL5w+II4UnVBcC0p
	ng94V+3l7YbOdrLPirlHaAxkWxb6DJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733488055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Opx75M/IMrKIxj9wm41c/ykwrTrUTKFBGpIzszTlX6k=;
	b=7/LrWVskKNM3xnoMntyKKVhUgYJplFUqXmb+9DWmVnjDA1tXwFxMa+jsR0/2xRTbds+7n7
	jeSr/01KV04IZLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8DBB138A7;
	Fri,  6 Dec 2024 12:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u79DKLftUmdWQwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 06 Dec 2024 12:27:35 +0000
Date: Fri, 6 Dec 2024 13:27:35 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com, 
	chaitanyak@nvidia.com, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, 
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv3 1/2] nvme/052: move nvmf_wait_for_ns() to common/nvme
Message-ID: <f8bacd12-8ed4-45d9-9d70-eecb0b6964ae@flourine.local>
References: <20241206111812.489140-1-nilay@linux.ibm.com>
 <20241206111812.489140-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206111812.489140-2-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_042739_270095_69C336DA 
X-CRM114-Status: UNSURE (   6.73  )
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

On Fri, Dec 06, 2024 at 04:48:07PM +0530, Nilay Shroff wrote:
> In a preparation for the use of nvmf_wait_for_ns function from
> other nvme test script, move nvmf_wait_for_ns from nvme/052 to
> common/nvme file so that we can reuse the nvmf_wait_for_ns from
> multiple test scripts.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

