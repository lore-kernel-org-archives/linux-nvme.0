Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5C7CA0ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 14:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dYgRIvxhgQ9HCB25wkduiasp17FHQMerfEPYfWkM8W4=; b=BhnQzF9puxXfiv6TIzLyO+X1tg
	qiyD62puWb7f+n7eLShVzfBE9XiM9ukulEp9ElOwN4gNf296eG/6ERiYw7xySJt4ptxiVsFAGsh5y
	dOhIWC8CDMQix12zEAkC2Tu9HIn3Q0npH1zp8S1xcTsTERKOvGP+iJlAkVPsXZ74qVOtA9IDR7YXm
	/gY3MiyPezgTIUnd3NW3RVAewGTFoUWiJPkCs6i2SkkGEklqLXxzV0ggJ68qcCJtHX8wOyeIhpwU/
	6GnvNHp1VAJk03+m8EihZM/ezW+EMZjFSGdIDclpEZm3CZoRcZSFhyZNdTlEDq+xmJt/Rew9W1pa5
	w9x8uTRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo1Ar-00000007pVT-3XGQ;
	Mon, 18 Aug 2025 14:49:25 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unzLW-00000007NZg-2EmD
	for linux-nvme@lists.infradead.org;
	Mon, 18 Aug 2025 12:52:19 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A37E51F44E;
	Mon, 18 Aug 2025 12:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755521535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYgRIvxhgQ9HCB25wkduiasp17FHQMerfEPYfWkM8W4=;
	b=AvhKbEy19hKEV2FFEiHgKDM8P8hVYDU59C7pdywm8+FgDQ6VNld014PFPF2qu77nm40k0j
	lmwGJ5rbhFW6V5LnOTOvG9SaayZGPNcSqstuc/4Csq6U9Utx3HdUQJhOwJJFU1kcNFxxnU
	7+sJ7fwbqe/cfEuQTzVq3bd26gZqN7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755521535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYgRIvxhgQ9HCB25wkduiasp17FHQMerfEPYfWkM8W4=;
	b=c7DKhGrXdg8go5WZN1alZFwPx+wb0ZMA03t7v79QmYiQB705wP187YVYmqgVrBDYcQ7fIs
	mUMxMzl4zH+kpAAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AvhKbEy1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c7DKhGrX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755521535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYgRIvxhgQ9HCB25wkduiasp17FHQMerfEPYfWkM8W4=;
	b=AvhKbEy19hKEV2FFEiHgKDM8P8hVYDU59C7pdywm8+FgDQ6VNld014PFPF2qu77nm40k0j
	lmwGJ5rbhFW6V5LnOTOvG9SaayZGPNcSqstuc/4Csq6U9Utx3HdUQJhOwJJFU1kcNFxxnU
	7+sJ7fwbqe/cfEuQTzVq3bd26gZqN7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755521535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYgRIvxhgQ9HCB25wkduiasp17FHQMerfEPYfWkM8W4=;
	b=c7DKhGrXdg8go5WZN1alZFwPx+wb0ZMA03t7v79QmYiQB705wP187YVYmqgVrBDYcQ7fIs
	mUMxMzl4zH+kpAAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92BEC13686;
	Mon, 18 Aug 2025 12:52:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kwDmIv4ho2ilewAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 18 Aug 2025 12:52:14 +0000
Message-ID: <107506e2-7870-45df-b595-583b57137a29@suse.de>
Date: Mon, 18 Aug 2025 14:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] nvme-tcp: Support KeyUpdate
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20250815050210.1518439-1-alistair.francis@wdc.com>
 <20250815050210.1518439-7-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250815050210.1518439-7-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,ietf.org:url,wdc.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: A37E51F44E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_055218_717894_CFE05D95 
X-CRM114-Status: GOOD (  24.64  )
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

On 8/15/25 07:02, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
> EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
> on an KeyUpdate event.
> 
> If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
> allow the NVMe layer to process the KeyUpdate request and forward the
> request to userspace. Userspace must then update the key to keep the
> connection alive.
> 
> This patch allows us to handle the NVMe target sending a KeyUpdate
> request without aborting the connection. At this time we don't support
> initiating a KeyUpdate.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   drivers/nvme/host/tcp.c | 63 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index cc3332529355..0c14d3ad58af 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -171,6 +171,7 @@ struct nvme_tcp_queue {
>   	bool			tls_enabled;
>   	u32			rcv_crc;
>   	u32			snd_crc;
> +	key_serial_t		user_key_serial;
>   	__le32			exp_ddgst;
>   	__le32			recv_ddgst;
>   	struct completion       tls_complete;
> @@ -1313,6 +1314,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   	struct nvme_tcp_request *req;
>   	unsigned int noreclaim_flag;
>   	int ret = 1;
> +	enum nvme_ctrl_state state = nvme_ctrl_state(&(queue->ctrl->ctrl));
>   
>   	if (!queue->request) {
>   		queue->request = nvme_tcp_fetch_request(queue);
> @@ -1347,6 +1349,29 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   done:
>   	if (ret == -EAGAIN) {
>   		ret = 0;
> +	} else if (ret == -EKEYEXPIRED &&
> +		state != NVME_CTRL_CONNECTING &&
> +		state != NVME_CTRL_RESETTING) {
> +		int qid = nvme_tcp_queue_id(queue);
> +
> +		dev_dbg(queue->ctrl->ctrl.device,
> +			"updating key for queue %d\n", qid);
> +
> +		nvme_change_ctrl_state(&(queue->ctrl->ctrl), NVME_CTRL_RESETTING);

Rah. Don't do that.
The 'resetting' state is tied to the resetting mechanism
(LIVE->RESETTING->CONNECTING->LIVE) and is being relied on
for the timeout handler. Setting it manually will confuse error
handling.

And really, having the key update in two places is a bit ... odd.
I'd rather stop the I/O queue in nvme_tcp_io_work() once a
EKEYEXPIRED error has been hit, and start the key update via
nvme_tcp_start_tls() function directly from there.
No need to change the controller state.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

