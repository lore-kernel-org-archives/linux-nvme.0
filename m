Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D4AD0E6E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 10:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uDApOiblqEXpE0biS9lTEMi2EP/ROzB7iSp7yQRtuOI=; b=RXfXdz2AcDM9n0vMpAEeWP7Ece
	IYQ/Io7SedoEe91kSvFEQyyToqZkvrWQ89N2xmU3a84ebC69L6PtDvMvDnBLTsP6LHg5qXwzivdE8
	IxhympZ/CZgDWhtBAf8r6wVxQeTYk8owzUkPyUddzbWB1CZdgI+uG1iqnNgcD5jsAYxHHTkQ2uakF
	IpQjERsoWvn7Grh3O3abW+wBvZDpDIaPN/G3KtH1vnXsBzo5yavUYU0C3vWmPbHD8VR/oKkU4SqVF
	5EQ7fRGCquCyKHZuNX7hVyirRWddZdn1BEF3vrWWUtBp8MT4HNop0O9WPbiiN9JlgBcuBqO1r5pYS
	J2NIxjvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2paI-00000006sJT-2fwy;
	Mon, 21 Oct 2024 10:24:22 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2paE-00000006sIN-0SNF
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 10:24:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69F6521F90;
	Mon, 21 Oct 2024 10:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729506256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDApOiblqEXpE0biS9lTEMi2EP/ROzB7iSp7yQRtuOI=;
	b=PqIzROkijR6gQcuhIaeKMxAF6R85nFyhoLurx6cCFiQgiRBgJ6lU6SHTwy5A9se+mMFvqy
	lDvtmKKr6a2saDfxmxB+Zr1O5e4BYt6N6jfq8cdOEvszc8coq6qQV1V0qayEcrcFI3KFTH
	WOhIjAWC5FWfWxeAYFqiMwEaK6xS4q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729506256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDApOiblqEXpE0biS9lTEMi2EP/ROzB7iSp7yQRtuOI=;
	b=pQRy3+g0zzOSFadqjzG5uEu7oTNJwzYsbsCnyxpejhNnnsItTIOgUOA475nhUxVSR3nI3T
	xdmdmrWQrbiO1VDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PqIzROki;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pQRy3+g0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729506256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDApOiblqEXpE0biS9lTEMi2EP/ROzB7iSp7yQRtuOI=;
	b=PqIzROkijR6gQcuhIaeKMxAF6R85nFyhoLurx6cCFiQgiRBgJ6lU6SHTwy5A9se+mMFvqy
	lDvtmKKr6a2saDfxmxB+Zr1O5e4BYt6N6jfq8cdOEvszc8coq6qQV1V0qayEcrcFI3KFTH
	WOhIjAWC5FWfWxeAYFqiMwEaK6xS4q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729506256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDApOiblqEXpE0biS9lTEMi2EP/ROzB7iSp7yQRtuOI=;
	b=pQRy3+g0zzOSFadqjzG5uEu7oTNJwzYsbsCnyxpejhNnnsItTIOgUOA475nhUxVSR3nI3T
	xdmdmrWQrbiO1VDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53B5F139E0;
	Mon, 21 Oct 2024 10:24:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hc7uE9ArFmfRCAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Oct 2024 10:24:16 +0000
Message-ID: <10f7a8c0-67e6-4af1-88be-61a5386a3b13@suse.de>
Date: Mon, 21 Oct 2024 12:24:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] nvme-tcp: forward context to teardown admin queue
 function
To: Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20241014165329.639998-1-dwagner@suse.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241014165329.639998-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 69F6521F90
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_032418_319639_CA91D223 
X-CRM114-Status: GOOD (  17.40  )
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

On 10/14/24 18:53, Daniel Wagner wrote:
> nvme_tcp_setup_ctrl is called from different contexts. If the function
> is called as part of the initial controller creation, the argument 'new'
> is set to true. This tells the function to free all resources when an
> error occurs.
> 
> Thus nvme_tcp_teardown_admin_queue should also be called with 'new' and
> not always with 'false'.
> 
> Fixes: fd1418de10b9 ("nvme-tcp: avoid open-coding nvme_tcp_teardown_admin_queue()")
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 89c44413c593..c31434b4da73 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2278,7 +2278,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   	}
>   destroy_admin:
>   	nvme_stop_keep_alive(ctrl);
> -	nvme_tcp_teardown_admin_queue(ctrl, false);
> +	nvme_tcp_teardown_admin_queue(ctrl, new);
>   	return ret;
>   }
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

