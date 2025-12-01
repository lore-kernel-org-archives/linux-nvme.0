Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49C2D116F1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0+/sBb0QuFPKiwbZo1c3rhA705+/7SgQwHsuzeJjY4s=; b=utOSIXylBIdgsf7GOX2pmDa20j
	FZPaZkLsdR/fG39fWQZFIxMDe83gzvf6I1O9dihdFiperAlfKLELmcbcnTJZR0EtZ8/4vNMzdsjdD
	db2M/WCtnJaKswrdEgoxSPTkny855N5ToQYdsM7NM860NEprKc2Pg493L6XQ299E1MPlNe2fLTjdN
	aSNwbH8b9diAkR82gxA6DOhtl1DQoi/RmDyHHC3W9z3vh6tFmFnqc4yrAOTYGx5RE7R2iNS0rV2o+
	YHAf8nMllNeaiEdLeceCnEFQySl4uFpyvh5/ryKdh1R3rIT/JukS0GHGNXMaKi+/2DHpU3Sy0uZiE
	2A/YBe1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ5Qv-000000049AI-2zaN;
	Mon, 01 Dec 2025 15:03:21 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ5Qt-0000000499o-0K4h
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 15:03:20 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C3905BCDD;
	Mon,  1 Dec 2025 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764601397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+/sBb0QuFPKiwbZo1c3rhA705+/7SgQwHsuzeJjY4s=;
	b=Otz3ol7hVL8dgj8XwQYLS4O6ThG2gWzgCBKzHplfr548Z0GwOiQ7RUeM+4AFTtSaJ7O1OV
	1B7c0MU8E9XkFav/+g7/aN7BeEr3xOY+sEOQXMTnLRMeDM/FVA0YwJCRfrtcFS7UUSbAwW
	OS1irsFYL3YNtDGsDGjsjajHWEJmJBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764601397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+/sBb0QuFPKiwbZo1c3rhA705+/7SgQwHsuzeJjY4s=;
	b=aCvFk72a4UJMMiP7SsjIh4U6awDUrdO93fG7cbYDxCO3QMCpDKpotBppgSMD5q3hyNF2Er
	vufwKCdAFSqtceDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764601395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+/sBb0QuFPKiwbZo1c3rhA705+/7SgQwHsuzeJjY4s=;
	b=wZPKoFuWgwWvWE4shtxgbCb1NteX1v/h+KdXbKw6U3gS8tNH8iIZVrzBJNVegrDDK2sLMT
	9rLaIyRvt6HuWT5NfyFG1hpC0HG2AgPDh1eBoUI8PtxHcgAOBQiSdTMEahT9UA3p4xgoo6
	psiBCMOVO4VgrCNQa17iTpbiea0yFZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764601395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+/sBb0QuFPKiwbZo1c3rhA705+/7SgQwHsuzeJjY4s=;
	b=kOFl22MPnxm3PjeqizEhyy8ohZZ0GTujtGKwpV1xj6FpzEdAOdbOjea1aLnd95iRLVRRQR
	2REoCoiUqU4k/8AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF5BE3EA63;
	Mon,  1 Dec 2025 15:03:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1smHOTKuLWkFCgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 01 Dec 2025 15:03:14 +0000
Message-ID: <61eb76df-ae82-4078-87a9-5d170c99d245@suse.de>
Date: Mon, 1 Dec 2025 16:03:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
To: Alistair Francis <alistair23@gmail.com>
Cc: chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-6-alistair.francis@wdc.com>
 <f7a91a49-9f82-492a-8bf9-520ee1c832ba@suse.de>
 <CAKmqyKPU2w2GrzdMtMn1rO8auOpDCTovQH04P8RxptA45Oy6XQ@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKPU2w2GrzdMtMn1rO8auOpDCTovQH04P8RxptA45Oy6XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.981];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,wdc.com:email];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_070319_280932_182197E0 
X-CRM114-Status: GOOD (  14.06  )
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

On 12/1/25 05:18, Alistair Francis wrote:
> On Thu, Nov 27, 2025 at 11:31 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 11/12/25 05:27, alistair23@gmail.com wrote:
>>> From: Alistair Francis <alistair.francis@wdc.com>
[ .. ]>>> @@ -976,10 +986,26 @@ static int nvme_tcp_recvmsg_data(struct 
nvme_tcp_queue *queue)
>>>
>>>                ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
>>>                if (ret < 0) {
>>> -                     dev_err(queue->ctrl->ctrl.device,
>>> -                             "queue %d failed to receive request %#x data",
>>> -                             nvme_tcp_queue_id(queue), rq->tag);
>>> -                     return ret;
>>> +                     /* If MSG_CTRUNC is set, it's a control message,
>>> +                      * so let's read the control message.
>>> +                      */
>>> +                     if (msg.msg_flags & MSG_CTRUNC) {
>>> +                             memset(&msg, 0, sizeof(msg));
>>> +                             msg.msg_flags = MSG_DONTWAIT;
>>> +                             msg.msg_control = cbuf;
>>> +                             msg.msg_controllen = sizeof(cbuf);
>>> +
>> This is not correct; reading the control message implies a kernel
>> memory allocation as message buffer, not an interator (as it's the
>> case here).
> 
> I don't follow what you mean
> 
Ah, right. My comment refers to users of tls_alert_recv(), which we
don't do here.
Sorry for the noise.

You can add my:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

