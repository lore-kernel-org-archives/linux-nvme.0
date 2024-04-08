Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40245C67861
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 06:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8+Tvjd3gggxCIR1F6/Bc+VLndri9pFAdEHlXTX1w4/Q=; b=hYyxqUv6zYbw4iDeXed93ZQwvu
	lLwJejaltNUqXomwpXWLJoMgUfFeJtskqZSTeBzRC85tEgqHjJLZIjL7Ab/++hjNVtaVoLtCyTnc0
	G7MLSztgPvTea5zq+3Vua4FtJbkPlQnnIgvYHyJVVVbRejcuiGI70dAQWXnJgF9qx/nE7FUf0Qtlr
	nSdq4HdFzKRTYzIQdFxSaEfh7Cnu6Pl3PTxZ/east5wualDbSRz7kwJekeLfejsiy8tdRV/aiwqQe
	gXPhRzP2STJJfk0FXNQ+EW3tuXLiloWFp+ZZqPpcRdC9TMrKD0EmG24afN9ekiI6YippII+g/Weqo
	+HTg5QTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtiRj-0000000EVZS-0hZw;
	Mon, 08 Apr 2024 06:25:35 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtiRd-0000000EVYE-075P
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 06:25:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED3D920194;
	Mon,  8 Apr 2024 06:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712557527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+Tvjd3gggxCIR1F6/Bc+VLndri9pFAdEHlXTX1w4/Q=;
	b=ABJTcoG1sBMmQcOySVI02w23npaQIbjAtJOkYkpMTbLQlPCvnvpIo0Xuw5T20+D5FHm74g
	cOBNFf7xkr15vt3LOm04vaZhWNILp+5HeqfvhiXlyqao+sMttvXt7vKS5pSdOSUK/QeNMm
	Xb/jDyZLMLUjWCzD008vAGG/tgfwgOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712557527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+Tvjd3gggxCIR1F6/Bc+VLndri9pFAdEHlXTX1w4/Q=;
	b=zHhLoww/43IC5PhaHheoJFqDfyjOffwoCaeelY6I9rO5w51lQbFDsOQVjJ5ZBOQF+p+aRl
	pST/HIxGj0NdXLBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712557525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+Tvjd3gggxCIR1F6/Bc+VLndri9pFAdEHlXTX1w4/Q=;
	b=e0nyj5vVouZ8o318MiYTbsES+AzTuaIazAHq3JIE9U2SSX3/iTnbvMj81rw0WYnAEJ0QkB
	Y5r1Eg2shepJsz348KPKGfqt5Gxrld28nGDBJm8AYmvT9N2t8NLFkLEMs2biOmWuU2By6a
	EjR1LN4arYN+UraI6zfO5qwg4a29VFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712557525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+Tvjd3gggxCIR1F6/Bc+VLndri9pFAdEHlXTX1w4/Q=;
	b=gSK+kKu7nNKS/Np+UaTloQx500Eays5qp53VaxnGIqPFeyVfjc8+g+Mn8uz7dtIXU7Fcbe
	J1lgODFOweBI99Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA9E5137D4;
	Mon,  8 Apr 2024 06:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DnYbJ9WNE2aPRwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Apr 2024 06:25:25 +0000
Message-ID: <d055615b-2c41-45cd-8b15-c787eac0dc49@suse.de>
Date: Mon, 8 Apr 2024 08:25:25 +0200
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
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ddee2fd2-584c-42be-af5f-7e002b2d5441@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_232529_242165_D3370F1E 
X-CRM114-Status: GOOD (  18.60  )
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

On 4/7/24 23:49, Sagi Grimberg wrote:
> 
> 
> On 18/03/2024 17:03, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> With TP8018 a new key will be generated from the DH-HMAC-CHAP
>> protocol after reset or recovery, but we need to start over
>> to establish a new TLS connection with the new keys.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/tcp.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 94152ded123a..3811ee9cd040 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2219,6 +2219,22 @@ static void nvme_tcp_reconnect_or_remove(struct 
>> nvme_ctrl *ctrl)
>>       }
>>   }
>> +static bool nvme_tcp_reset_for_secure_concat(struct nvme_ctrl *ctrl)
>> +{
>> +    if (!ctrl->opts->concat)
>> +        return false;
>> +    /*
>> +     * If a key has been generated and TLS has not been enabled
>> +     * reset the queue to start TLS handshake.
>> +     */
>> +    if (ctrl->opts->tls_key && !ctrl->tls_key) {
>> +        dev_info(ctrl->device, "Reset to enable TLS with generated 
>> PSK\n");
>> +        nvme_reset_ctrl(ctrl);
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
>>   static void nvme_tcp_revoke_generated_tls_key(struct nvme_ctrl *ctrl)
>>   {
>>       if (!ctrl->opts->concat)
>> @@ -2321,6 +2337,9 @@ static void nvme_tcp_reconnect_ctrl_work(struct 
>> work_struct *work)
>>       if (nvme_tcp_setup_ctrl(ctrl, false))
>>           goto requeue;
>> +    if (nvme_tcp_reset_for_secure_concat(ctrl))
>> +        return;
>> +
>>       dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
>>               ctrl->nr_reconnects);
>> @@ -2396,6 +2415,7 @@ static void nvme_reset_ctrl_work(struct 
>> work_struct *work)
>>       if (nvme_tcp_setup_ctrl(ctrl, false))
>>           goto out_fail;
>> +    nvme_tcp_reset_for_secure_concat(ctrl);
> 
> This is really strange. I'd imagine that this would be needed only if 
> the derived psk expired no?

You are absolutely correct. But once you reset the connection the 
derived PSK of the previous connection _is_ expired as DH-HMAC-CHAP
generated a new one.

Remember: for secure concatenation we _always_ have a two-step 
connection setup. The initial connection runs for DH-HMAC-CHAP
to generate the PSK, and then a connection reset to start over
with TLS and the generated PSK.
So upon reset we have to invalidate the generated PSK, reset the
connection to run DH-HMAC-CHAP, and reset _again_ to start over
with the new PSK.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


