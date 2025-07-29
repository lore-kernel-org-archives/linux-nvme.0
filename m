Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90816C87FCB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kKf3Ld7GMpkyIUFZbTHgf11MFWoxhHkxt7VOXonGCy4=; b=tRgUuEXfCNXNN6Ajd/ScpUolSP
	zHbjQey07IWSoJuoAu1CZzSwbWn5J/fETBm0Z/MFBoJOWlye656CxJZe/sd3kWpOjSDbq1+185gYi
	f0duxYf1rEkWf97BFqOv7aFjPkizmy6/rxu5d/baBvjCbcimUnTnC5WD2+1miyelgScIKND3Uv8Gc
	F4VNHIksnyopk29miqkgVoauRtsiosusM8Y8LcrHvVbn43jvJPbdBzqvMt5kbMFe+zN4X5845EW95
	soi9BdtxiqzwX6OJbAj0fka6d8loFtsm2YnrJhOt9qzeGQcUD++kG0+siEEVMcMlL6+5p/mxSRZ7a
	SCoxp0fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh94U-00000001sVH-0csk;
	Wed, 30 Jul 2025 15:50:26 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugfVG-0000000GEPZ-2lCq
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 08:16:08 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C3081F80B;
	Tue, 29 Jul 2025 08:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753776965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKf3Ld7GMpkyIUFZbTHgf11MFWoxhHkxt7VOXonGCy4=;
	b=GJ0c3WD4kjLuIp2C32cnvYy6mc2r0HmUpXAFCsclXR0Nw0uHyFXZRPgP/YJ7RvII12oDHW
	g2fQ6k8TZHOxlVap6cYYgZPATK6i4Ioc2kwTPaY26uiyPoFXa0LuJg7sky/PNikyC3GZcD
	UzZO4MoPgZ8/hd8zm9xuVZkRFoZdKCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753776965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKf3Ld7GMpkyIUFZbTHgf11MFWoxhHkxt7VOXonGCy4=;
	b=olujNJvSHCBAEP88q7DrAIervIA4Ranlw/EzJJYWgigy7qG+ub8cBnyQIXpwxZBBIacQvD
	Vwcpd+rwbFqpdSAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753776964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKf3Ld7GMpkyIUFZbTHgf11MFWoxhHkxt7VOXonGCy4=;
	b=0intH50C/KDxShfyGFUJh9wpBFKFW7iTucCxAf6wja7RCXAmR9XKLIndfz8gNDx3kYabQd
	fMsos368oBLBzSDMuHkx0V7KwDSypuH69CCROo4Jn/SrTpL11PayW9jnzm6ua+HqO/Rp+R
	zH+orCiuImHHx9hMvNN0/mN4+5OPn5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753776964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKf3Ld7GMpkyIUFZbTHgf11MFWoxhHkxt7VOXonGCy4=;
	b=0gyD29RHT9Qr1JcIysSgnO/ifhMy2hcAt4uB183ZFZ6iDgR1phPROOkuPXw0o5AjgtvelO
	gP2Z1IkstBjFHXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2503A13876;
	Tue, 29 Jul 2025 08:16:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sJhKCEODiGj7NgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Jul 2025 08:16:03 +0000
Message-ID: <7e18e224-ba9f-420d-ad2e-e349d25b58e0@suse.de>
Date: Tue, 29 Jul 2025 10:16:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/4] nvme/host/tcp: set max record size in the tls context
To: Wilfred Mallawa <wilfred.opensource@gmail.com>, alistair.francis@wdc.com,
 dlemoal@kernel.org, chuck.lever@oracle.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, borisp@nvidia.com,
 john.fastabend@gmail.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
 anna@kernel.org, kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
 <20250729024150.222513-6-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250729024150.222513-6-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLh3g55kcpku8oef9ktzra4k57)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,wdc.com,kernel.org,oracle.com,davemloft.net,google.com,redhat.com,lwn.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,talpey.com,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,wdc.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_011606_853174_D3D66306 
X-CRM114-Status: GOOD (  21.83  )
X-Mailman-Approved-At: Wed, 30 Jul 2025 08:35:22 -0700
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

On 7/29/25 04:41, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> During a tls handshake, a host may specify the tls record size limit
> using the tls "record_size_limit" extension. Currently, the NVMe TCP
> host driver does not specify this value to the tls layer.
> 
> This patch adds support for setting the tls record size limit into the
> tls context, such that outgoing records may not exceed this limit
> specified by the endpoint.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>   drivers/nvme/host/tcp.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 65ceadb4ffed..84a55736f269 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1677,6 +1677,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
>   			      size_t tls_record_size_limit)
>   {
>   	struct nvme_tcp_queue *queue = data;
> +	struct tls_context *tls_ctx = tls_get_ctx(queue->sock->sk);
>   	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
>   	int qid = nvme_tcp_queue_id(queue);
>   	struct key *tls_key;
> @@ -1700,6 +1701,20 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
>   			ctrl->ctrl.tls_pskid = key_serial(tls_key);
>   		key_put(tls_key);
>   		queue->tls_err = 0;
> +
> +		/* Endpoint has specified a maximum tls record size limit */
> +		if (tls_record_size_limit > TLS_MAX_PAYLOAD_SIZE) {
> +			dev_err(ctrl->ctrl.device,
> +				"queue %d: invalid tls max record size limit: %zd\n",
> +				nvme_tcp_queue_id(queue), tls_record_size_limit);
> +			queue->tls_err = -EINVAL;
> +			goto out_complete;
> +		} else if (tls_record_size_limit > 0) {
> +			tls_ctx->tls_record_size_limit = (u32)tls_record_size_limit;
> +			dev_dbg(ctrl->ctrl.device,
> +				"queue %d: target specified tls_record_size_limit %u\n",
> +				nvme_tcp_queue_id(queue), tls_ctx->tls_record_size_limit);
> +		}
>   	}
>   
>   out_complete:

Why do we need to do that?
This value is never used in that driver, so why can't the TLS layer 
handle it?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

