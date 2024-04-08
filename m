Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1FEC67861
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 22:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F45mfqoltKvkMtAvstmXoW6n2EJ7Rn74FDVoK36kPRs=; b=q18Xkzk1IVZ8Wpy33aqGXs6Gq6
	QyH+kBc+nkZo5Jja8ZFoNNL0Dlb6rojO9rt/eQtVBsCDHJtaIvV787ANL2HVARteIhWx9fvB2Eh3f
	WGcvc8JYQVjGEAvHS3fAgd0Q2Gnhqwk0/TUQOEKVU1X0oMSfZbOnU7vBbCsOPkG36Z5FOONEPhVa8
	aF/cKyiI1s+rxbV0ywY8nHRIyVlZOQwuCsVC2pWnk7QRlMue/+Rhk5OlX25NCXdOBNAXvEyRVBEBX
	EZDXPLA7koLE6QqszwoSuAw4235Ftl0pVIVU9bVQ5VNNEynJiCLouo5n7C+O4jS34+W83DrzMDe37
	MlYsaieA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtxCT-0000000GzOV-1Aj5;
	Mon, 08 Apr 2024 22:10:49 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtxCN-0000000GzMI-1Czb
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 22:10:47 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18D73205D6;
	Mon,  8 Apr 2024 22:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712614240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F45mfqoltKvkMtAvstmXoW6n2EJ7Rn74FDVoK36kPRs=;
	b=0iHjc+rkl5DDa8MhHpb/jtV8NXudbHk24Qz7p+x7WW2VziNlnu17PujLdRAwK5XVQZUyrO
	Lm5Ps5TA9fCXrmz36dKRiWTVjbOQ3SubKqANi7MOfWU5xRN9P5T3lLdMnK0Ft48pRuTnk1
	91OEEjjFtST2zHkSVAnIDP19v+I+Gc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712614240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F45mfqoltKvkMtAvstmXoW6n2EJ7Rn74FDVoK36kPRs=;
	b=Q6CwYShFN2j/J+hzNkTzqkJRDYXaHSXFj37eyUX1GbDqERafSLYhp0+LhoVmv/KY/WQTBm
	kRffUDVsv5IVnSDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0iHjc+rk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Q6CwYShF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712614240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F45mfqoltKvkMtAvstmXoW6n2EJ7Rn74FDVoK36kPRs=;
	b=0iHjc+rkl5DDa8MhHpb/jtV8NXudbHk24Qz7p+x7WW2VziNlnu17PujLdRAwK5XVQZUyrO
	Lm5Ps5TA9fCXrmz36dKRiWTVjbOQ3SubKqANi7MOfWU5xRN9P5T3lLdMnK0Ft48pRuTnk1
	91OEEjjFtST2zHkSVAnIDP19v+I+Gc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712614240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F45mfqoltKvkMtAvstmXoW6n2EJ7Rn74FDVoK36kPRs=;
	b=Q6CwYShFN2j/J+hzNkTzqkJRDYXaHSXFj37eyUX1GbDqERafSLYhp0+LhoVmv/KY/WQTBm
	kRffUDVsv5IVnSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF7DC137D4;
	Mon,  8 Apr 2024 22:10:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ucguM19rFGbjPQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Apr 2024 22:10:39 +0000
Message-ID: <44ae1549-9d39-42d5-a6eb-a6700d4ab873@suse.de>
Date: Tue, 9 Apr 2024 00:10:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] nvme-tcp: reset after recovery for secure
 concatenation
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-14-hare@kernel.org>
 <ddee2fd2-584c-42be-af5f-7e002b2d5441@grimberg.me>
 <d055615b-2c41-45cd-8b15-c787eac0dc49@suse.de>
 <4438fdf3-2970-456b-acc6-fe26c355bfac@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <4438fdf3-2970-456b-acc6-fe26c355bfac@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 18D73205D6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_151043_506628_F3775988 
X-CRM114-Status: GOOD (  18.63  )
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

On 4/8/24 23:23, Sagi Grimberg wrote:
> 
> 
> On 08/04/2024 9:25, Hannes Reinecke wrote:
>> On 4/7/24 23:49, Sagi Grimberg wrote:
>>>
>>>
>>> On 18/03/2024 17:03, Hannes Reinecke wrote:
>>>> From: Hannes Reinecke <hare@suse.de>
>>>>
>>>> With TP8018 a new key will be generated from the DH-HMAC-CHAP
>>>> protocol after reset or recovery, but we need to start over
>>>> to establish a new TLS connection with the new keys.
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>> ---
>>>>   drivers/nvme/host/tcp.c | 20 ++++++++++++++++++++
>>>>   1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>> index 94152ded123a..3811ee9cd040 100644
>>>> --- a/drivers/nvme/host/tcp.c
>>>> +++ b/drivers/nvme/host/tcp.c
>>>> @@ -2219,6 +2219,22 @@ static void 
>>>> nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>>>>       }
>>>>   }
>>>> +static bool nvme_tcp_reset_for_secure_concat(struct nvme_ctrl *ctrl)
>>>> +{
>>>> +    if (!ctrl->opts->concat)
>>>> +        return false;
>>>> +    /*
>>>> +     * If a key has been generated and TLS has not been enabled
>>>> +     * reset the queue to start TLS handshake.
>>>> +     */
>>>> +    if (ctrl->opts->tls_key && !ctrl->tls_key) {
>>>> +        dev_info(ctrl->device, "Reset to enable TLS with generated 
>>>> PSK\n");
>>>> +        nvme_reset_ctrl(ctrl);
>>>> +        return true;
>>>> +    }
>>>> +    return false;
>>>> +}
>>>> +
>>>>   static void nvme_tcp_revoke_generated_tls_key(struct nvme_ctrl *ctrl)
>>>>   {
>>>>       if (!ctrl->opts->concat)
>>>> @@ -2321,6 +2337,9 @@ static void 
>>>> nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>>>>       if (nvme_tcp_setup_ctrl(ctrl, false))
>>>>           goto requeue;
>>>> +    if (nvme_tcp_reset_for_secure_concat(ctrl))
>>>> +        return;
>>>> +
>>>>       dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
>>>>               ctrl->nr_reconnects);
>>>> @@ -2396,6 +2415,7 @@ static void nvme_reset_ctrl_work(struct 
>>>> work_struct *work)
>>>>       if (nvme_tcp_setup_ctrl(ctrl, false))
>>>>           goto out_fail;
>>>> +    nvme_tcp_reset_for_secure_concat(ctrl);
>>>
>>> This is really strange. I'd imagine that this would be needed only if 
>>> the derived psk expired no?
>>
>> You are absolutely correct. But once you reset the connection the 
>> derived PSK of the previous connection _is_ expired as DH-HMAC-CHAP
>> generated a new one.
>>
>> Remember: for secure concatenation we _always_ have a two-step 
>> connection setup. The initial connection runs for DH-HMAC-CHAP
>> to generate the PSK, and then a connection reset to start over
>> with TLS and the generated PSK.
>> So upon reset we have to invalidate the generated PSK, reset the
>> connection to run DH-HMAC-CHAP, and reset _again_ to start over
>> with the new PSK.
> 
> So what is the point of setting the derived psk with a timeout?
> 
> Seems rather silly doing that _every_ reset/reconnect... But ok...

Mandated by TP8018. Generated TLS PSK should be renewed after a
certain time. Makes sense in general, but still a pain.

Cheers,

Hannes


