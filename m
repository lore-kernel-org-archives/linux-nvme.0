Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF90C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 10:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OPSci3SSiFUMY2LOtKm5BJYDkCUFT8X6gjtkSGypczE=; b=5CwwE4j8NYMIySSoCRa2f1XOZk
	iDJbJHMvXsI/IWlZDzLTT37AiPh+CuAf3Es9tEoR0TdEZkC1ALe/eXjCFeHEmRNSgVXzh+kphm4DQ
	F11Cj3S8C8zx6QH7ipWeWiEVHTLIoGMHd8oKesLzbfMkjE8img9ro+SxNvTQmEZ8luLdhAXfBgcIF
	NdfKyphY33Z9ndrMjXoImF3Y3HJPAvib8pufJ98cpXBYxaUFktHJ6LCbF/wEuK5zkf0nULRsWAj+H
	d6IZutSt9LnHVTIv343oe3hUpnRTQftkCvI08aGuKHbcuHKxUHJ9SruRRKr10/bw3aPKOelS/Kt7T
	YzUX4Ybg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBFr-000000049Ae-406l;
	Thu, 07 Mar 2024 10:45:39 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBFk-00000004981-23kE
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 10:45:37 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ECD1560FBF;
	Thu,  7 Mar 2024 10:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709807545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPSci3SSiFUMY2LOtKm5BJYDkCUFT8X6gjtkSGypczE=;
	b=w5jWu8N/pUOOiZHcEgB4PHWETywTU1eRPKdHVLc3VN+gaAtyZ6Z3PjIhQlYiORteThoX1l
	qHk8aBywXlLB8EBgTJyAyMaDfe+zSn5ozsw9zYfqV09OhJmZC9KkmaOkVw/y9wmYy/aboi
	wDHIqedXIADnEyIrZc61ilusArYFMnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709807545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPSci3SSiFUMY2LOtKm5BJYDkCUFT8X6gjtkSGypczE=;
	b=G8QqWJVIXLKMlWiMj8/fxOb46AH3paKg6oa45cGzj+oaAtyzZFtTfkrjzj50QVLY7Z9qcL
	uBt1DmohmVwvRvCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709807544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPSci3SSiFUMY2LOtKm5BJYDkCUFT8X6gjtkSGypczE=;
	b=rT3FWCMK+ncNX2NqYYvPzUsziDQL1vqli8kzYHmkDhBjMn8e4hwuj+L515IzlcMSWc/Vj2
	MC+iu5aY9/Vr0i7tLkLmFb7qKpdE3vzLhyTSqAF4IYBr87wX1WWASGYEpB43x+6yau1tc7
	rLF+4TW3rMPcijHa05Er7odIkkeKsuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709807544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPSci3SSiFUMY2LOtKm5BJYDkCUFT8X6gjtkSGypczE=;
	b=l2CEliAteT/9rj8VcrpbX7zWHz+jCl8rdxS4Tx3TxvkQ9Kx4OAbi5BK9IQPg1f4TGbxZsU
	+tW1oDyLZVd0UkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAF85136BA;
	Thu,  7 Mar 2024 10:32:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cgL9NLiX6WXNKQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 07 Mar 2024 10:32:24 +0000
Message-ID: <20531716-b18d-4ab6-91e8-2ac0ea745343@suse.de>
Date: Thu, 7 Mar 2024 11:32:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvme: authentication error are always non-retryable
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240301112823.132570-1-hare@kernel.org>
 <20240301112823.132570-2-hare@kernel.org> <20240301131208.GA3586@lst.de>
 <f511975a-822e-470a-a3a2-d7ed652e3cfc@suse.de>
 <868727ce-5970-4296-9fc7-a431dccc8a63@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <868727ce-5970-4296-9fc7-a431dccc8a63@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rT3FWCMK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=l2CEliAt
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: ECD1560FBF
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_024532_751721_2F6608F0 
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

On 3/7/24 09:51, Sagi Grimberg wrote:
> 
> 
> On 01/03/2024 17:26, Hannes Reinecke wrote:
>> On 3/1/24 14:12, Christoph Hellwig wrote:
>>>> -    if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
>>>> -        return AUTHENTICATE;
>>>> -
>>>>       if (blk_noretry_request(req) ||
>>>>           (nvme_req(req)->status & NVME_SC_DNR) ||
>>>>           nvme_req(req)->retries >= nvme_max_retries)
>>>>           return COMPLETE;
>>>>   +    if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
>>>> +        return AUTHENTICATE;
>>>
>>> This part looks fine (although I'd word the commit message
>>> differently for it).
>>>
>>>> @@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl 
>>>> *ctrl)
>>>>           if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>>>>               dev_warn(ctrl->device,
>>>>                    "qid 0: secure concatenation is not supported\n");
>>>> -            ret = NVME_SC_AUTH_REQUIRED;
>>>> +            ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>>>               goto out_free_data;
>>>>           }
>>>>           /* Authentication required */
>>>> @@ -475,14 +475,16 @@ int nvmf_connect_admin_queue(struct nvme_ctrl 
>>>> *ctrl)
>>>>           if (ret) {
>>>>               dev_warn(ctrl->device,
>>>>                    "qid 0: authentication setup failed\n");
>>>> -            ret = NVME_SC_AUTH_REQUIRED;
>>>> +            ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>>
>>>
>>> .. but the others should never use nvme status codes as they never
>>> go out onto the wire.
>>>
>> Would love to, but to my knowledge we have the convention that NVMe 
>> status codes less than 0 should _not_ be retried.
> 
> What nvme status code is less than zero?
> 
Not the NVMe status, but the 'ret' value containing either a (positive) 
NVMe status or a (negative) errno.

>> NVMe transport errors,
>> OTOH, _should_ be retried.
> Yes.
>> 'connect_admin_queue' and 'connect_io_queue' now straddles the 
>> boundary: technically it's an NVMe command, but in
>> practice it's a transport command as there are quite a lot of steps
>> before we even can send the 'connect' command.
>>
>> So, how do we handle the return codes from 'connect_admin_queue' ?
>> The NVMe core style (with not retrying negative errors) or the NVMe
>> transport style (with always retrying until we run out of retries)?
> 
> Not exactly sure what is the question here. I am still going over emails 
> so there
> may be some discussion around this, but it is unclear from the patch 
> description what is the issue this is solving.

The question is what to do if nvmf_connect_admin_queue() returns with a 
status with the DNR status set.
In TCP the status is carried back to the return value of 
nvme_tcp_setup_ctrl(), which is called during reset, reconnect, and 
initialisation.
For the first two the status is simply ignored, and always retried
(ie every error is treated as retryable). For the latter, we will always 
abort the initialisation (ie every error is non-retryable).
Either way, we're completely ignoring the DNR bit in the NVMe status.

Daniel has sent two patches on my behalf, trying to evaluate the DNR
status during reconnect and reset. With them it suddenly matters how
the return value from nvmf_connect_admin_queue() is to be interpreted.
With my original idea of retrying authentication errors we will keep
on retrying, even though the authentication settings won't change,
and consequently each retry will fail. So in effect we go through
pointless retries, and only abort the test case once the retries
are exhausted. By making authentication errors non-retryable we
can terminate the testcase directly.
The only way I could think of to signal a non-retryable error
is to return an NVMe status with the DNR bit set; every other error
will cause a retry. But this will require us to fabricate an NVMe
status code, which Christoph objects to.

Cheers,

Hannes


