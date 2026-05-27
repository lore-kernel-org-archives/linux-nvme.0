Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853BBCD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yhRH8G6+EsA/W9fSxr5C2XFKrvx1155gwm4IxMdIpBc=; b=uOa6ygeSf0N2dtQvnQZ9oTjLZ7
	cuvq2yWLAxeV8Sl25Nty/Sj/jmXQRnJSBaPbd9NOu0gzF+XjUFCZV8CbcENCqZPdIjsksDXohAPmp
	oHPTD00Ok1o9bPLkZZaHg8LzO6/sJZMrplkAQJqdbF7hjA1sHgwyMWHwSVxAvm9h/Op+g+RyfwrOd
	YGufIH4N+Fh6QZR6sbfuBVhFo2Jh5LWZw28S1ZekTTBlnJhPcbCI1U/dP9ekDUZcBMPTxCAOhEZdo
	PLCYjytQQ0OkVd5CWW3FxleQj7qZVaHLah0WFTxyWoh+IRpR1CT+RsWaTjs6Z2SGWiUO4a6t3Y3tn
	tVfmJQlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEbR-00000004ETz-369h;
	Wed, 27 May 2026 13:47:21 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEbO-00000004ETW-3c9v
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 13:47:20 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFFAA678DB;
	Wed, 27 May 2026 13:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779889637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhRH8G6+EsA/W9fSxr5C2XFKrvx1155gwm4IxMdIpBc=;
	b=NMbx2UvT/9Fy2igZOMhrUdotzXY/EyG3y0hjkfUW/qFUaEcKO402CKfdmPBb3sjb4HrLUJ
	DHlEpcrkOA0HF9cQew4YNUYeOutsUmcORFw0an1y1u/8Z1A9EjgtWt/ZosIRDoawr/DxBn
	JWwGnqNgrpbeCiPSYn6UNrcf6KYmi1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779889637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhRH8G6+EsA/W9fSxr5C2XFKrvx1155gwm4IxMdIpBc=;
	b=bsTcGt/R5ssj4uR6GkzTt0LTkIjQCThe6zFFa3Sn7FQ0bJq2sIdjMgpwl5dNwUL6CtnZni
	QprSyNLHEw1F8nAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cWFktdgV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=X5JYzyGD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779889636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhRH8G6+EsA/W9fSxr5C2XFKrvx1155gwm4IxMdIpBc=;
	b=cWFktdgVae9wG++Rcn5fQkTAtF3NUNFBN9e0mwSN1SnkFdToui3PxJtYivq3EE+jU+IU94
	9LNpHVifa7zhb85QxnHioISmIK+EV43iJVsQChsQh+Ux10PtHZahzrhOYTfDMn7nYE3bvY
	CLs2znu7eWNvhQJxyY/3k4kqPOi1E5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779889636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhRH8G6+EsA/W9fSxr5C2XFKrvx1155gwm4IxMdIpBc=;
	b=X5JYzyGDTbt0ZsCxA44dIfNODlkQW/GUHpHUn9gC9c6tqK8a5+UsW0s2vsdO3ISQFJWsl9
	gobkewNLtzUHrhCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB6CD5A869;
	Wed, 27 May 2026 13:47:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0O6pL+T1Fmr9OQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 27 May 2026 13:47:16 +0000
Message-ID: <4a5ce927-7ea4-46ce-b8aa-910db2dc13cd@suse.de>
Date: Wed, 27 May 2026 15:47:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/tcp: handle rejected keys for secure concatnation
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 alistair.francis@wdc.com, Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20260511005454.2486599-2-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260511005454.2486599-2-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EFFAA678DB
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_WP_URI(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_064719_051154_6EAEFF85 
X-CRM114-Status: GOOD (  24.04  )
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

On 5/11/26 02:54, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> The NVMe-TCP specification [1] states that if the PSK retained or
> generated is not available on the subsystem, the TLS 1.3 handshake shall
> be aborted with an unknown_psk_identity alert and the connection be
> closed.
> 
> Currently, when an unknown_psk_identity alert is sent from an endpoint,
> tlshd returns EACCES as the TLS error. On subsequent reconnection
> attempts, we fail with the same error because we keep attempting to
> connect with a stale key. This may occur if the endpoint experienced a
> full reset and lost its PSK.
> 
> With support in tlshd to return -EKEYREJECTED when an unknown_psk_identity
> alert is received, the kernel can now detect this condition and revoke the
> current tls_key. This allows the subsequent reconnect to perform
> re-authentication via DHCHAP to generate a fresh PSK.
> 
> [1] https://nvmexpress.org/wp-content/uploads/NVM-Express-TCP-Transport-Specification-Revision-1.1-2024.08.05-Ratified.pdf
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>   drivers/nvme/host/tcp.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 15d36d6a728e..eff68eb7a5fe 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1767,6 +1767,17 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   			dev_err(nctrl->device,
>   				"queue %d: TLS handshake complete, error %d\n",
>   				qid, queue->tls_err);
> +
> +			/*
> +			 * Key maybe stale, revoke it such that on a subsequent
> +			 * reconnect, we will generate a new PSK.
> +			 */
> +			if (queue->tls_err == EKEYREJECTED && qid == 0 &&
> +			    nctrl->opts->concat && nctrl->opts->tls_key) {
> +				nvme_auth_revoke_tls_key(nctrl);
> +				dev_warn(nctrl->device,
> +					 "qid 0: revoking stale key\n");
> +			}
>   		} else {
>   			dev_dbg(nctrl->device,
>   				"queue %d: TLS handshake complete\n", qid);

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

