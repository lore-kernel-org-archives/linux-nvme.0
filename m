Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87868CFD2F6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 13:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RMTVveMh5YfenpE8iMkQrTizREiFLrVIWd+fohp24gE=; b=vMkBaX3QP6azh4JfsJ0SI5WFJ8
	p63QYmgXoTD8QZal/o8hgRyzkFusqbcPxuA0CATH3ajou/PCLO/5sKY9+z6h2/4NZ0JQoSz54Ib+N
	V58VZLYTYN3P65nppGusBSUs6P9/Eqg9IUmgu5cLnwX3Ef9ab3FqaCKeqE1VDxe70otQAPA6ShGJb
	qGR3iw5/wQMXOggqqjGw+WWhYdVRU+f6AsRXlDXAK0HXXrKlqA8Gc0Q4KYZlCENh6r9/jGSs3KWMg
	fFdQRY5W3hZ4ql7NL8iYa0JvxplNH9sBPqEJj4v+8IsxHlrTGV9X1Twe+fFmuccDovWMahfTbRp0w
	/4xERutg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOc5X-0000000GgrV-2uX2;
	Thu, 27 Nov 2025 13:31:11 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOc5V-0000000Ggqe-1dWg
	for linux-nvme@bombadil.infradead.org;
	Thu, 27 Nov 2025 13:31:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=RMTVveMh5YfenpE8iMkQrTizREiFLrVIWd+fohp24gE=; b=nFCGUFIId8PM6vyliS5syDDtNu
	SFxiRtMbHTgmdCrVdssR9sRg/qFOjufAEFZJoiLZOTiC0gIpg8NlDBNMuoUgWXqsCSUbG6HKXJmfr
	RjXrOl0vWXa3ItZgmRllr6nEPNoCeE46wY8RjuFbrIEGafF6yw1AwuqJbgI1NZ+kyLcwKz8hso5SO
	rxa6UMEpQtsrhELWJKu9TTCFcolwqXJwStdS4qFRQvABXq3jHWcbmyNfORMzGTOqQMG0d7OaAxLaV
	sKga/X4pyoCMVepJUyMleeytXTxr/WvYK85MJBMqr7cyC1Dj73YruMS4xyWwvxmPeUBmxeKapZJBF
	Z6pqHG1Q==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vObDr-0000000AA8p-0WMK
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 12:35:45 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A824F3374C;
	Thu, 27 Nov 2025 13:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764250262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMTVveMh5YfenpE8iMkQrTizREiFLrVIWd+fohp24gE=;
	b=rh8dnYFmP9bqVzCOiQwcKgNVs6Dl7jD229uCl0x+P0gxdZlFDIwhfdOWWTXadOBAHNADdC
	ngg1SvfhxHtUo7ofE4DoKiRMD/pimJfkVNcVQyQSAO0pTVWll/ZH8vydyCs9yxfZNrqUIx
	6NTX2kS3MTvXcpmIrI1PSdaB1Fa4Dhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764250262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMTVveMh5YfenpE8iMkQrTizREiFLrVIWd+fohp24gE=;
	b=OmQlmb6Nk7C39zzgoo28LC+n97DjqOJ+t4DU3OllM45dWpjQccrnsGqPSVxt+AZtiAYY54
	rlNvhJftA3cuxqAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=166tjX+O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PS1WAt3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764250261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMTVveMh5YfenpE8iMkQrTizREiFLrVIWd+fohp24gE=;
	b=166tjX+O8IPVTHmzP2K2Rui8g5AUAtGZIa5izr2ZMc++1oa+ad6e3WRR4j49t1Z/sgEqrZ
	hhXziLVBxDKYmRBr1sj5EDQXoSF2QdQcFFTIDhNthIe7mM9onMZG4Ex0BmUoZACiLRm242
	C13aLS+HXMv0xhe1cNrvlmSCjT9+b78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764250261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMTVveMh5YfenpE8iMkQrTizREiFLrVIWd+fohp24gE=;
	b=PS1WAt3E1C/zR0Wj3qXvCoyWz1TXUCN36K09vXwdqXwT1KnTU+CVRSpCXahWfNCfJcskHP
	SiE9oLkGcuEv8WBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C2DB3EA63;
	Thu, 27 Nov 2025 13:31:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /OvDGZVSKGk6UQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Nov 2025 13:31:01 +0000
Message-ID: <f7a91a49-9f82-492a-8bf9-520ee1c832ba@suse.de>
Date: Thu, 27 Nov 2025 14:31:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-6-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251112042720.3695972-6-alistair.francis@wdc.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,wdc.com:email];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A824F3374C
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_123543_524126_E374CAAD 
X-CRM114-Status: GOOD (  37.20  )
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

On 11/12/25 05:27, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
> EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
> on an KeyUpdate event as described in RFC8446
> https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3.
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
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v5:
>   - Cleanup code flow
>   - Check for MSG_CTRUNC in the msg_flags return from recvmsg
>     and use that to determine if it's a control message
> v4:
>   - Remove all support for initiating KeyUpdate
>   - Don't call cancel_work() when updating keys
> v3:
>   - Don't cancel existing handshake requests
> v2:
>   - Don't change the state
>   - Use a helper function for KeyUpdates
>   - Continue sending in nvme_tcp_send_all() after a KeyUpdate
>   - Remove command message using recvmsg
> 
>   drivers/nvme/host/tcp.c | 85 +++++++++++++++++++++++++++++++++--------
>   1 file changed, 70 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4797a4532b0d..5cec5a974bbf 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -172,6 +172,7 @@ struct nvme_tcp_queue {
>   	bool			tls_enabled;
>   	u32			rcv_crc;
>   	u32			snd_crc;
> +	key_serial_t		handshake_session_id;
>   	__le32			exp_ddgst;
>   	__le32			recv_ddgst;
>   	struct completion       tls_complete;
> @@ -858,7 +859,10 @@ static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
>   static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
>   {
>   	char *pdu = queue->pdu;
> +	char cbuf[CMSG_LEN(sizeof(char))] = {};
>   	struct msghdr msg = {
> +		.msg_control = cbuf,
> +		.msg_controllen = sizeof(cbuf),
>   		.msg_flags = MSG_DONTWAIT,
>   	};
>   	struct kvec iov = {
> @@ -873,12 +877,17 @@ static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
>   	if (ret <= 0)
>   		return ret;
>   
> +	hdr = queue->pdu;
> +	if (hdr->type == TLS_HANDSHAKE_KEYUPDATE) {
> +		dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
> +		return 1;
> +	}
> +

Errm. 'hdr' is of type 'struct nvme_tcp_hdr', and that most certainly
does not define TLS_HANDSHAKE_KEYUPDATE. I think you should evaluate the
cmsg type here.

>   	queue->pdu_remaining -= ret;
>   	queue->pdu_offset += ret;
>   	if (queue->pdu_remaining)
>   		return 0;
>   
> -	hdr = queue->pdu;
>   	if (unlikely(hdr->hlen != sizeof(struct nvme_tcp_rsp_pdu))) {
>   		if (!nvme_tcp_recv_pdu_supported(hdr->type))
>   			goto unsupported_pdu;
> @@ -944,6 +953,7 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
>   	struct request *rq =
>   		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	char cbuf[CMSG_LEN(sizeof(char))] = {};
>   
>   	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
>   		return 0;
> @@ -976,10 +986,26 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
>   
>   		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
>   		if (ret < 0) {
> -			dev_err(queue->ctrl->ctrl.device,
> -				"queue %d failed to receive request %#x data",
> -				nvme_tcp_queue_id(queue), rq->tag);
> -			return ret;
> +			/* If MSG_CTRUNC is set, it's a control message,
> +			 * so let's read the control message.
> +			 */
> +			if (msg.msg_flags & MSG_CTRUNC) {
> +				memset(&msg, 0, sizeof(msg));
> +				msg.msg_flags = MSG_DONTWAIT;
> +				msg.msg_control = cbuf;
> +				msg.msg_controllen = sizeof(cbuf);
> +
This is not correct; reading the control message implies a kernel
memory allocation as message buffer, not an interator (as it's the
case here).
  > +				ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
> +			}
> +
> +			if (ret < 0) {
> +				dev_dbg(queue->ctrl->ctrl.device,
> +					"queue %d failed to receive request %#x data, %d",
> +					nvme_tcp_queue_id(queue), rq->tag, ret);
> +				return ret;
> +			}
> +
> +			return 0;
>   		}
>   		if (queue->data_digest)
>   			nvme_tcp_ddgst_calc(req, &queue->rcv_crc, ret);
> @@ -1384,15 +1410,39 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
>   		}
>   	} while (result >= 0);
>   
> -	if (result < 0 && result != -EAGAIN) {
> -		dev_err(queue->ctrl->ctrl.device,
> -			"receive failed:  %d\n", result);
> -		queue->rd_enabled = false;
> -		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> -	} else if (result == -EAGAIN)
> -		result = 0;
> +	if (result < 0) {
> +		if (result != -EKEYEXPIRED && result != -EAGAIN) {
> +			dev_err(queue->ctrl->ctrl.device,
> +				"receive failed:  %d\n", result);
> +			queue->rd_enabled = false;
> +			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +		}
> +		return result;
> +	}
> +
> +	queue->nr_cqe = nr_cqe;
> +	return nr_cqe;
> +}
> +
> +static void update_tls_keys(struct nvme_tcp_queue *queue)
> +{
> +	int qid = nvme_tcp_queue_id(queue);
> +	int ret;
> +
> +	dev_dbg(queue->ctrl->ctrl.device,
> +		"updating key for queue %d\n", qid);
>   
> -	return result < 0 ? result : (queue->nr_cqe = nr_cqe);
> +	flush_work(&(queue->ctrl->ctrl).async_event_work);
> +
> +	ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
> +				 queue, queue->ctrl->ctrl.tls_pskid,
> +				 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
> +
> +	if (ret < 0) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"failed to update the keys %d\n", ret);
> +		nvme_tcp_fail_request(queue->request);
> +	}
>   }
>   
>   static void nvme_tcp_io_work(struct work_struct *w)
> @@ -1417,8 +1467,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   		result = nvme_tcp_try_recvmsg(queue);
>   		if (result > 0)
>   			pending = true;
> -		else if (unlikely(result < 0))
> -			return;
> +		else if (unlikely(result < 0)) {
> +			if (result == -EKEYEXPIRED)
> +				update_tls_keys(queue);
> +			break;
> +		}
>   
>   		/* did we get some space after spending time in recv? */
>   		if (nvme_tcp_queue_has_pending(queue) &&
> @@ -1726,6 +1779,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
>   			ctrl->ctrl.tls_pskid = key_serial(tls_key);
>   		key_put(tls_key);
>   		queue->tls_err = 0;
> +		queue->handshake_session_id = handshake_session_id;
>   	}
>   
>   out_complete:
> @@ -1755,6 +1809,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   		keyring = key_serial(nctrl->opts->keyring);
>   	args.ta_keyring = keyring;
>   	args.ta_timeout_ms = tls_handshake_timeout * 1000;
> +	args.handshake_session_id = queue->handshake_session_id;
>   	queue->tls_err = -EOPNOTSUPP;
>   	init_completion(&queue->tls_complete);
>   	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
Cheers,Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

