Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2D8D0C61F
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 14:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NL94qGhWTdBDYiX4zab5ekXBKUhkNNqflhfE/pRxg/8=; b=pRhKaDVSI7xvZPsEtHmMXF07WK
	W9xZIi4Glf8k78QU3b515+AZWpd6yjwXz+pYW+g5tNm7r2Agsn920jJ1UQ3J+hBo+clrOtDY326Sp
	bFMet4phCKT5JNsTlLpXqiHGl3zDdCi+NFK78oBMW7nqw2SDkepdSruLtE4RsRpKrcHNTDtNRVUTR
	x8s0YyLU0M5QbS1kswM1dYuWBjvzgA8ji6kSdLFNHILBOkEBDhhyMS6v6W6eI6xmW4C/1mFVuN/c1
	UXfHxsnzEk6l0bCh8+YmZtvdm788cvB1pjGNQyUZbgZIULzNj1+HehKaTJGwQ34yGcV2in72hCB5K
	ofcPmDdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4LYn-00000004404-3yKz;
	Fri, 25 Oct 2024 14:45:05 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4LJl-00000004192-0W8T
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 14:29:39 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D12F21CA6;
	Fri, 25 Oct 2024 14:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729866571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NL94qGhWTdBDYiX4zab5ekXBKUhkNNqflhfE/pRxg/8=;
	b=Q15xD3EzCp8+1iWeYeiksysw7ue/SZ31AtSLanYtIFpH3JVzqTOdTbQG55p6iTgPlIJ8wK
	WHH2buEX6UTyGPnl5w2A0nEn3zovCATYLEv9mbwEiFskoLMo+XpB52NXBsXV51h2Atet5f
	dmwgSvmKGB6DY2HJca9nCyLlEVj7in0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729866571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NL94qGhWTdBDYiX4zab5ekXBKUhkNNqflhfE/pRxg/8=;
	b=WEzQFEaDOZYKeEo+wXJwzC7skt2KFnCZc+iRKxnIj19Fkj0ju+8P1vntBWGf+Uw7/HxRbY
	qldbzy4HKSwPmqAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729866571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NL94qGhWTdBDYiX4zab5ekXBKUhkNNqflhfE/pRxg/8=;
	b=Q15xD3EzCp8+1iWeYeiksysw7ue/SZ31AtSLanYtIFpH3JVzqTOdTbQG55p6iTgPlIJ8wK
	WHH2buEX6UTyGPnl5w2A0nEn3zovCATYLEv9mbwEiFskoLMo+XpB52NXBsXV51h2Atet5f
	dmwgSvmKGB6DY2HJca9nCyLlEVj7in0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729866571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NL94qGhWTdBDYiX4zab5ekXBKUhkNNqflhfE/pRxg/8=;
	b=WEzQFEaDOZYKeEo+wXJwzC7skt2KFnCZc+iRKxnIj19Fkj0ju+8P1vntBWGf+Uw7/HxRbY
	qldbzy4HKSwPmqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74AAC136F5;
	Fri, 25 Oct 2024 14:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wNGQFUurG2fzWwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 14:29:31 +0000
Date: Fri, 25 Oct 2024 16:29:30 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 08/15] nvme: simplify _get_nvmet_ports()
Message-ID: <1e1041eb-63fd-48fc-b7ff-b65135968376@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-9-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024010025.2216242-9-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_072933_351643_93722A72 
X-CRM114-Status: UNSURE (   8.32  )
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

On Thu, Oct 24, 2024 at 10:00:18AM GMT, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Rework the loop to iterate over ports, and check for the correct
> subsysnqn afterwards. With that we can drop 'sed' calls and simplify
> the loop.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de.
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

