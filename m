Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B344E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 08:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5rh5aIkQz10P6BaSF2ixbO8OktK0osj1muPA/9Of8I4=; b=Et8HBEy9jIRHMOI4nKVv46x+Xt
	pGvdlx8sue3Fv6aPoYUTOcm8KqavKD1qqH/xDRLlOtXZv5rCJtsnpTnphoRuWxjIwFfFNYAY9m+/r
	sjiqCjuQJ7qgSERITIsJEWSLabzJQK9vtO4BkSXn4ABBGHCa/+Aw/vWYo+EPQhkqJ+kMznExAHt5W
	QW7fhnoAAlLKCo3CYJm3jnKLyOue8d40VKUKsNjnn6DDuDQM1NV0H9h41G835SP3jK/FhnxXaubbP
	7OTZUopUWy+0V0U2OoWiBAacQICnUBOZrOTzXJuQ6KrbENY+KtntI8h8rh+N2vgjuSHKQo8qRuP9m
	//q7A4vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOYSV-00000004IIV-3flN;
	Fri, 20 Dec 2024 08:34:07 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOYR8-00000004HmS-0DLl
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 08:32:43 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF1F12111F;
	Fri, 20 Dec 2024 08:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734683558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rh5aIkQz10P6BaSF2ixbO8OktK0osj1muPA/9Of8I4=;
	b=mbC+SXfNIBCbB0fXH6UByZXoQUvaOgktzmww/HvAwNucaWOBdQvUvYGh4CutWmp+BgB5/w
	gRU0TZIbw8fa5YaYnayX6sXW7MIxbyursmqB4Fi4S06sGRcdA/ZKMRASk8G8MmRWVVmxjm
	g7tPOYH07uf2BEKFygMmwlsouNi6r64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734683558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rh5aIkQz10P6BaSF2ixbO8OktK0osj1muPA/9Of8I4=;
	b=gCqIZSzFthockOhXRoK07MO+51tszq9Lz7NJD/992IpT4L7+6DloQ645V4TxWfANmOTx7Y
	BUgs3VnhwscQTKDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mbC+SXfN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gCqIZSzF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734683558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rh5aIkQz10P6BaSF2ixbO8OktK0osj1muPA/9Of8I4=;
	b=mbC+SXfNIBCbB0fXH6UByZXoQUvaOgktzmww/HvAwNucaWOBdQvUvYGh4CutWmp+BgB5/w
	gRU0TZIbw8fa5YaYnayX6sXW7MIxbyursmqB4Fi4S06sGRcdA/ZKMRASk8G8MmRWVVmxjm
	g7tPOYH07uf2BEKFygMmwlsouNi6r64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734683558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rh5aIkQz10P6BaSF2ixbO8OktK0osj1muPA/9Of8I4=;
	b=gCqIZSzFthockOhXRoK07MO+51tszq9Lz7NJD/992IpT4L7+6DloQ645V4TxWfANmOTx7Y
	BUgs3VnhwscQTKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58A3413A63;
	Fri, 20 Dec 2024 08:32:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fjjbE6YrZWfqZQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Dec 2024 08:32:38 +0000
Message-ID: <9ab35631-4df6-495a-8dca-5cb414f17625@suse.de>
Date: Fri, 20 Dec 2024 09:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme: handle connectivity loss in
 nvme_set_queue_count
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Paul Ely <paul.ely@broadcom.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
 <e89d0b3b-e4a1-4ae5-8250-c15e3a843e76@suse.de>
 <bef1a7ac-2614-4a70-945d-e691e9107089@flourine.local>
 <b8dad319-8e6e-40e7-ada3-f50863315614@suse.de>
 <bee71ac4-37bf-4182-ad7e-78efd9baff46@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <bee71ac4-37bf-4182-ad7e-78efd9baff46@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF1F12111F
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_003242_235877_CD066384 
X-CRM114-Status: GOOD (  19.27  )
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

On 12/17/24 15:01, Daniel Wagner wrote:
> On Tue, Dec 17, 2024 at 10:45:45AM +0100, Hannes Reinecke wrote:
>> On 12/17/24 09:35, Daniel Wagner wrote:
>>> On Fri, Nov 29, 2024 at 12:10:33PM +0100, Hannes Reinecke wrote:
>>>>> +	/*
>>>>> +	 * It's either a kernel error or the host observed a connection
>>>>> +	 * lost. In either case it's not possible communicate with the
>>>>> +	 * controller and thus enter the error code path.
>>>>> +	 */
>>>>> +	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
>>>>>     		return status;
>>>>>     	/*
>>>>>
>>>> Hmm. Maybe checking for NVME_SC_DNR, too?
>>>
>>> if no one complains I'll update the check to:
>>>
>>> 	if (status < 0 || (status > 0 && (status & NVME_STATUS_DNR)) ||
>>> 	    status == NVME_SC_HOST_PATH_ERROR)
>>> 		return status;
>>>
>>> okay?
>>
>> Which really cries out for a helper. But otherwise okay.
> 
> As far I remember, Christoph is not a big fan of single users of tiny
> helper functions. Anyway, what about this:
> 
> +static bool nvme_num_queue_updated(status)
> +{
> +       /*
> +        * It's either a kernel error or the host observed a connection
> +        * lost. In either case it's not possible communicate with the
> +        * controller and thus enter the error code path.
> +        */
> +
> +       if (status < 0 || status & NVME_STATUS_DNR ||
> +           status == NVME_SC_HOST_PATH_ERROR)
> +               return false;
> +
> +       return true;
> +}
> +
>   int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>   {
>          u32 q_count = (*count - 1) | ((*count - 1) << 16);
> @@ -1701,13 +1716,8 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
> 
>          status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, NULL, 0,
>                          &result);
> -       /*
> -        * It's either a kernel error or the host observed a connection
> -        * lost. In either case it's not possible communicate with the
> -        * controller and thus enter the error code path.
> -        */
> -       if (status < 0 || (status > 0 && (status & NVME_STATUS_DNR)) ||
> -           status == NVME_SC_HOST_PATH_ERROR)
> +
> +       if (!nvme_num_queue_updated(status))
>                  return status;
> 
>          /*

Naming is terrible. The helper does not check whether the number of 
queues updated, so why the name?

Better keep it inline, then.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

