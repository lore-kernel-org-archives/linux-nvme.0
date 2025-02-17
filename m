Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788B9C021AA
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 12:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=50RTflAjI1oQ3UvbxzIHSwhfCRZbjkO+oKW5WUkIEJ8=; b=EVi9eCfAw0F/UKPQi9+jnwpes5
	5zan54haOy56S5LqioF5XhJGrrQob8m+0se/5qQ5UC4DS4J4DjNiIGDcZAH1pLKEA+8+zK973rY+S
	Yj8ZCvC/7LLQPJ/T/ZyQ5iIz455WdNfgBINGIdbULgBCYtyGs5OAx3b6TW4Rs50GwHTO8Ylk2k1Dk
	70eEkNQr1UN1zW7xzb7tZHlJpbsGgtKPsc4BirJVMCbqui8XixI8S+qtxRdxuC2Ow3srqD8Jzm3VB
	ppglmK6WAA+f7mXCXlgNHat2rFfrKwIQR+q0DCRB5KEDHWxEYskVy9Pc5wSWXIBo8hRrhTPzHUUOB
	wFW2Oa1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tk0Fw-00000004SFV-1kwh;
	Mon, 17 Feb 2025 12:29:48 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjynY-00000004E2J-1P9B
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 10:56:25 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A1D8211B2;
	Mon, 17 Feb 2025 10:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739789781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50RTflAjI1oQ3UvbxzIHSwhfCRZbjkO+oKW5WUkIEJ8=;
	b=M4aOqTKnajMDsWjD2SYVfaPUSPmHHtmYOwcg319DXhVj6cS9KnbCbqBhESPFIoDQFJMLvl
	ah/Z5PYSTBdpVHSmMexKv6g6npET9xp38tu3vM/HxWcbjI6k00AvUU6xF5MvxGvkeNVYQp
	1uuLObis7+4JSi9DXZmOBIVOX1UbRiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739789781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50RTflAjI1oQ3UvbxzIHSwhfCRZbjkO+oKW5WUkIEJ8=;
	b=DMvpJOlJFc0mb3832dZMCD0FWMXZ7JTfhNAfedIzHIjR6udjJePbrhOV76fQaJuaK73ias
	uiiuWGkQGgMHjFBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sogz2f6x;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=X5iAvZ8V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739789780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50RTflAjI1oQ3UvbxzIHSwhfCRZbjkO+oKW5WUkIEJ8=;
	b=sogz2f6xf3vgucOFCsFZKRdSuEsUlcEWiPw0D2e2XBYm74W+CkZ2qcOY5s7kx9csCUqWGU
	/L9RQ48u4JbpDhEI12gNI2Y3vZXXHSgQqTXXs177CepmAtfnFwLtr4dpzXHMCY56iZXWAn
	Mgs2gRHYR1fEN+W9zMXfgPJ1mPpwLD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739789780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50RTflAjI1oQ3UvbxzIHSwhfCRZbjkO+oKW5WUkIEJ8=;
	b=X5iAvZ8Vtk8BfrSyCNimcsG+fTHz7A/QEKz5JNr366m6lhHiQsnLlk8ykVgXtc3TTj590P
	hBUbnEFTd5HkMFBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4E581379D;
	Mon, 17 Feb 2025 10:56:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ARpENtMVs2f3WQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 17 Feb 2025 10:56:19 +0000
Message-ID: <91041933-6a18-490c-8090-4e03d15d3cf3@suse.de>
Date: Mon, 17 Feb 2025 11:56:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: add basic support for the C2HTermReq PDU
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, hare@kernel.org, mlombard@bsdbackstore.eu
References: <20250214190012.311960-1-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250214190012.311960-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3A1D8211B2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250217_025624_525435_DBCBB424 
X-CRM114-Status: GOOD (  21.28  )
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

On 2/14/25 20:00, Maurizio Lombardi wrote:
> Previously, the NVMe/TCP host driver did not handle the C2HTermReq PDU,
> instead printing "unsupported pdu type (3)" when received. This patch adds
> support for processing the C2HTermReq PDU, allowing the driver
> to print the Fatal Error Status field.
> 
> Example of output:
> nvme nvme4: Received C2HTermReq (FES = Invalid PDU Header Field)
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/tcp.c  | 37 +++++++++++++++++++++++++++++++++++++
>   include/linux/nvme-tcp.h |  2 ++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 841238f38fdd..8f783185575d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -763,6 +763,40 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>   	return 0;
>   }
>   
> +static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
> +		struct nvme_tcp_term_pdu *pdu)
> +{
> +	u16 fes;
> +	const char *msg;
> +	u32 plen = le32_to_cpu(pdu->hdr.plen);
> +
> +	static const char * const msg_table[] = {
> +		[NVME_TCP_FES_INVALID_PDU_HDR] = "Invalid PDU Header Field",
> +		[NVME_TCP_FES_PDU_SEQ_ERR] = "PDU Sequence Error",
> +		[NVME_TCP_FES_HDR_DIGEST_ERR] = "Header Digest Error",
> +		[NVME_TCP_FES_DATA_OUT_OF_RANGE] = "Data Transfer Out Of Range",
> +		[NVME_TCP_FES_R2T_LIMIT_EXCEEDED] = "R2T Limit Exceeded",
> +		[NVME_TCP_FES_UNSUPPORTED_PARAM] = "Unsupported Parameter",
> +	};
> +
> +	if (plen < NVME_TCP_MIN_C2HTERM_PLEN ||
> +	    plen > NVME_TCP_MAX_C2HTERM_PLEN) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"Received a malformed C2HTermReq PDU (plen = %u)\n",
> +			plen);
> +		return;
> +	}
> +
> +	fes = le16_to_cpu(pdu->fes);
> +	if (fes && fes < ARRAY_SIZE(msg_table))
> +		msg = msg_table[fes];
> +	else
> +		msg = "N/A";
> +
> +	dev_err(queue->ctrl->ctrl.device,
> +		"Received C2HTermReq (FES = %s)\n", msg);
> +}
> +
>   static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		unsigned int *offset, size_t *len)
>   {
> @@ -806,6 +840,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   	case nvme_tcp_r2t:
>   		nvme_tcp_init_recv_ctx(queue);
>   		return nvme_tcp_handle_r2t(queue, (void *)queue->pdu);
> +	case nvme_tcp_c2h_term:
> +		nvme_tcp_handle_c2h_term(queue, (void *)queue->pdu);
> +		return -EINVAL;
>   	default:
>   		dev_err(queue->ctrl->ctrl.device,
>   			"unsupported pdu type (%d)\n", hdr->type);
> diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
> index e07e8978d691..e435250fcb4d 100644
> --- a/include/linux/nvme-tcp.h
> +++ b/include/linux/nvme-tcp.h
> @@ -13,6 +13,8 @@
>   #define NVME_TCP_ADMIN_CCSZ	SZ_8K
>   #define NVME_TCP_DIGEST_LENGTH	4
>   #define NVME_TCP_MIN_MAXH2CDATA 4096
> +#define NVME_TCP_MIN_C2HTERM_PLEN	24
> +#define NVME_TCP_MAX_C2HTERM_PLEN	152
>   
>   enum nvme_tcp_pfv {
>   	NVME_TCP_PFV_1_0 = 0x0,

Can you add support for nvmet, too, such that we can test the patch?
(And maybe even a blktest script for it?)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

