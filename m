Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4169EB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 10:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SOsaScKd9SMh70juut5I+aHhYcS6w4wo9p7C867jJig=; b=orvXJ/YK0Yww8PW4SjbrU35/EH
	7TG837zTKFemuHMS/ppCjDOz1NlLfKhOuD6hVEQR8ogQ6u1SUiMcS8BpyC4JexTItweCjChiRUtJz
	R2xVI0PHADykjoKGrvbIRkeLZJHdRzRtVnvl2xqwIi7JbcTI6e5mDWpVSuQoQ8r59BlHMIASqTHG/
	ycGNoalSMdM2XmS2x29TvDKQgPEsDo7nhwpLcXDdx5CQyMyCZyvvXX+7zLNApHYMljjt+pj+S1Ya+
	Q3J9jg0ME76sKpSmJTrHfKdJDb5z7HGG5qhN+7AupUHZvtG/c8kbYciWZXDyusEGN49vKrSM3vEC2
	ced1y9CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTfzi-004UIf-2G;
	Wed, 09 Aug 2023 10:00:46 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTfzf-004UHv-2P
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 10:00:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C26401F38A;
	Wed,  9 Aug 2023 10:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691575240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOsaScKd9SMh70juut5I+aHhYcS6w4wo9p7C867jJig=;
	b=c1BhqCkdQy87ARLs8jf5fWSmnIRDswuuE8c1P5kP4BA3yJb+AsNyf+hR7W5cZtRb0Ht3vJ
	7kqlBfqB0yz8VKaYD12kGQ/0bDvaBJMK3jmUd8ubfE2qUS++KAihzCRklawM728YPSGj+A
	zCYatK0r9REH//JcF4FYIrp+Pa33ev8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691575240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOsaScKd9SMh70juut5I+aHhYcS6w4wo9p7C867jJig=;
	b=zb+aTAtAkPw1lCY8PBg098qr13P/XFGsry2dZEAyhuupyeAQhl+xvs4UdIwh1JJvJSfl4/
	dDLvYQ8TBH0zfPAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEC84133B5;
	Wed,  9 Aug 2023 10:00:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id s4IeKshj02R5IgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Aug 2023 10:00:40 +0000
Message-ID: <113ae2a5-c5f7-3c1f-4bc7-e6db9681eb3f@suse.de>
Date: Wed, 9 Aug 2023 12:00:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-9-hare@suse.de>
 <8f7dd2b5-bc7d-5c2f-a807-ee18e809b3a7@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8f7dd2b5-bc7d-5c2f-a807-ee18e809b3a7@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_030043_948600_80C7EDE5 
X-CRM114-Status: GOOD (  17.16  )
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

On 8/9/23 11:47, Sagi Grimberg wrote:
> 
>> @@ -1802,9 +1922,17 @@ static int nvme_tcp_alloc_admin_queue(struct 
>> nvme_ctrl *ctrl)
>>   static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>>   {
>>       int i, ret;
>> +    key_serial_t pskid = 0;
>> +    if (ctrl->opts->tls) {
>> +        if (!ctrl->tls_key) {
>> +            dev_err(ctrl->device, "no PSK negotiated\n");
>> +            return -ENOKEY;
> 
> This is really unexpected. its not that no PSK negotiated, something
> went awfully wrong if the psk wasn't negotiated and we still end up
> being here... Or there is a flow that can make this happen?
> 
Yeah, it _is_ unexpected.
But we're having two conditions here (->tls and ->tls_key), and we need 
to check for both to be true.
Although, truth to be said, we might get away with just checking for 
->tls_key; I'll check.

>> +        }
>> +        pskid = key_serial(ctrl->tls_key);
>> +    }
> 
> newline missing.
> 
> key_serial can operate on null.
> 
>>       for (i = 1; i < ctrl->queue_count; i++) {
>> -        ret = nvme_tcp_alloc_queue(ctrl, i);
>> +        ret = nvme_tcp_alloc_queue(ctrl, i, pskid);
>>           if (ret)
>>               goto out_free_queues;
>>       }
> 
> Perhaps do:
> -- 
> @@ -1793,7 +1793,7 @@ static int __nvme_tcp_alloc_io_queues(struct 
> nvme_ctrl *ctrl)
>          int i, ret;
> 
>          for (i = 1; i < ctrl->queue_count; i++) {
> -               ret = nvme_tcp_alloc_queue(ctrl, i);
> +               ret = nvme_tcp_alloc_queue(ctrl, i, 
> key_serial(ctrl->tls_key));
>                  if (ret)
>                          goto out_free_queues;
>          }
> @@ -1812,6 +1812,9 @@ static int nvme_tcp_alloc_io_queues(struct 
> nvme_ctrl *ctrl)
>          unsigned int nr_io_queues;
>          int ret;
> 
> +       if (ctrl->opts->tls && !ctrl->tls_key)
> +               return -ENOKEY;
> +
>          nr_io_queues = nvmf_nr_io_queues(ctrl->opts);
>          ret = nvme_set_queue_count(ctrl, &nr_io_queues);
>          if (ret)
> -- 
> 
Yeah, might be simpler. I'll give it a go.

Cheers,

Hannes


