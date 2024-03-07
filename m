Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B9DC54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MuHl+yvwvpDWRtPWi5LsX8RSltfLC8+rGgxGMpnKPEI=; b=dUIqKimu+3YQed8etoatI4+S0Y
	6f9WRY4cDeflW29pl3XIjDArPUHf/m25Lgs0r7/A4fXomw+R4fC+LcYbSPPEpeBxwZ36BR24O5DjG
	6bTAhGWhDMy4ZzwsQooqCMCHKl07z/3WhOUvpoNv1LCFqm90CfQ+wwG+WzPf6kTgYIIIu8Jj8mA2o
	jX/qbw/LoPw1gbKmobxJyWyd6D3SQKiphjqABy4EADrtg7OhIBaFIFGFMb1FHRxNKH7h5VSAF/lwR
	0h3RwbQ+3BdSBMLze6IJYvLUAfKKljhDIUEEMWkWpEBUXeajDsczw2Vss/U9W0lMguANVS8NLwBF2
	JfpCGDnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCnw-00000004YAU-1ZOG;
	Thu, 07 Mar 2024 12:24:56 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCns-00000004Y95-0mDD
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 12:24:55 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0686A344F5;
	Thu,  7 Mar 2024 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709811796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuHl+yvwvpDWRtPWi5LsX8RSltfLC8+rGgxGMpnKPEI=;
	b=bcuN9gQ9DQQl6cfg6ZTviC/MScZkPoAK+MAunKC4YzgdTQd43AFRutvQQiGsLlqvsEYg+D
	GHNEdT8q+rKPItF/lB8LlbjMPHjlnpWZkuTK5yXOMX/eW8zwPwJFCKA+BqYCFobVjhwCj6
	HZHXwnHzVQvYyiP1E9W8hm0KlJ/sr5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709811796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuHl+yvwvpDWRtPWi5LsX8RSltfLC8+rGgxGMpnKPEI=;
	b=216ePo/9m2w7O/2Im8xNz1keG3gWCq+ey6i08mGzVKa8Tr49+wDLfR7EoAmibgyG+KyIPR
	4hyYPq2sg3lC0HAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709811796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuHl+yvwvpDWRtPWi5LsX8RSltfLC8+rGgxGMpnKPEI=;
	b=bcuN9gQ9DQQl6cfg6ZTviC/MScZkPoAK+MAunKC4YzgdTQd43AFRutvQQiGsLlqvsEYg+D
	GHNEdT8q+rKPItF/lB8LlbjMPHjlnpWZkuTK5yXOMX/eW8zwPwJFCKA+BqYCFobVjhwCj6
	HZHXwnHzVQvYyiP1E9W8hm0KlJ/sr5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709811796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuHl+yvwvpDWRtPWi5LsX8RSltfLC8+rGgxGMpnKPEI=;
	b=216ePo/9m2w7O/2Im8xNz1keG3gWCq+ey6i08mGzVKa8Tr49+wDLfR7EoAmibgyG+KyIPR
	4hyYPq2sg3lC0HAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5D4712FC5;
	Thu,  7 Mar 2024 11:43:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IG4cMlOo6WVrOwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 07 Mar 2024 11:43:15 +0000
Message-ID: <bb805934-4c93-4f5a-b45e-def4798b0844@suse.de>
Date: Thu, 7 Mar 2024 12:43:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] nvme-tcp: combine reset and recovery
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240127093058.15699-1-hare@kernel.org>
 <20240127093058.15699-12-hare@kernel.org>
 <68875550-6bd6-42e6-81b3-a62cb6a920d9@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <68875550-6bd6-42e6-81b3-a62cb6a920d9@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bcuN9gQ9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="216ePo/9"
X-Spamd-Result: default: False [-5.21 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.91)[99.60%];
	 MIME_GOOD(-0.10)[text/plain];
	 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 0686A344F5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_042452_415806_CBCEC655 
X-CRM114-Status: GOOD (  11.80  )
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

On 3/7/24 12:08, Sagi Grimberg wrote:
> 
> 
> On 27/01/2024 11:30, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Call 'connect_work' from reset to reduce duplicate code.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/tcp.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 6c8ca08f2972..a46ab8370007 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2329,14 +2329,7 @@ static void nvme_reset_ctrl_work(struct 
>> work_struct *work)
>>           return;
>>       }
>> -    if (nvme_tcp_setup_ctrl(ctrl, false))
>> -        goto out_fail;
>> -
>> -    return;
>> -
>> -out_fail:
>> -    ++ctrl->nr_reconnects;
>> -    nvme_tcp_reconnect_or_remove(ctrl);
>> +    queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work, 0);
>>   }
> 
> This breaks nvme_reset_ctrl_sync
> 
>>   static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
> 
Okay, let's drop it. I've got another patchset anyway reshuffling the
tcp init sequence.

Cheers,

Hannes


