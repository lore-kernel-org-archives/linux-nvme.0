Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654EFC2BB3F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 14:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gCuPJjzpPmiccRYhpMz3GqHbebrcoVxyKxHO4eMF/l4=; b=fIVUsf5qTodMx4VOBYnUP9GdEM
	lnCSIbTTOqpBrd7i2L8OXEkp7vcVT+wdJ541075RnR8o0zVhO52zq6D7UCG8+9nsoTki/hSyTa6FV
	jb2Dsq4WA/Gjw+nYQsHyPhKyBs/wt5QP5rcfLShyiL6aKyvdKZATc7nL1IH7kJeBJsO+Z8gFdCV6V
	o7vP+rMCbGFptpd9sa4xA3sPbyGfI7l+oOrFOBklBjpG6d2O9y6ucmN6OJGKjTbJFdNneCJRixJi1
	V/Ns2XbLNBzU5N5aSQ5JuwZdxPoZEtIUFFNa1iLu057jSXaHJSFMRuOD53MKfaKe+qNG6Ve0gkOSO
	nwWa2WBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r557S-00CGLR-0d;
	Mon, 20 Nov 2023 14:19:22 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r557K-00CGJD-0L
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 14:19:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F422C218CE;
	Mon, 20 Nov 2023 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700489951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gCuPJjzpPmiccRYhpMz3GqHbebrcoVxyKxHO4eMF/l4=;
	b=zaf5Bv2RCjXfFfwT3YIemfYpsmgBTN6r18ww75KdG7D7E7DUqSzuUDR9RvXN7OxcfAKaa+
	tCk2QHK16g/ieLo+sexHIukB63aGmO/5klaPONqkrilzHcVK9ruQWFuL8TeVt1FZjHN+wA
	+Xt4zNe0x1YL/tVXOFyc04Pd+g//wwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700489951;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gCuPJjzpPmiccRYhpMz3GqHbebrcoVxyKxHO4eMF/l4=;
	b=XWu+/cHVnPBWc5K0qzdVY668X5w0m+CgalWNJ+aUikVzwu0jIfpVmEmOR/hJdd6spwFsP/
	Bs8xURWV2WKcasCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCEC613499;
	Mon, 20 Nov 2023 14:19:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xfmYNd9qW2WtHAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 20 Nov 2023 14:19:11 +0000
Message-ID: <3b2164c7-961e-4cfb-bff9-517e7b77fd61@suse.de>
Date: Mon, 20 Nov 2023 15:19:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: start keep-alive after admin queue setup
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20231024061337.35621-1-hare@suse.de>
 <20231024061337.35621-4-hare@suse.de>
 <a1ce2c2e-4f67-4271-ac67-5a1e8c5ebfb1@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Autocrypt: addr=hare@suse.de; keydata=
 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
 YwtooKEemPj2lg==
In-Reply-To: <a1ce2c2e-4f67-4271-ac67-5a1e8c5ebfb1@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 BAYES_HAM(-3.00)[100.00%];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_061914_551188_A4050916 
X-CRM114-Status: GOOD (  26.35  )
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

On 11/20/23 14:39, Sagi Grimberg wrote:
> 
>> Setting up I/O queues might take quite some time on larger and/or
>> busy setups, so KATO might expire before all I/O queues could be
>> set up.
>> Fix this by start keep alive from the ->init_ctrl_finish() callback,
>> and stopping it when calling nvme_cancel_admin_tagset().
> 
> If this is a fix, the title should describe the issue it is fixing, and
> the body should say how it is fixing it.
> 
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/core.c | 6 +++---
>>   drivers/nvme/host/fc.c   | 6 ++++++
>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 62612f87aafa..f48b4f735d2d 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -483,6 +483,7 @@ EXPORT_SYMBOL_GPL(nvme_cancel_tagset);
>>   void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
>>   {
>> +    nvme_stop_keep_alive(ctrl);
>>       if (ctrl->admin_tagset) {
>>           blk_mq_tagset_busy_iter(ctrl->admin_tagset,
>>                   nvme_cancel_request, ctrl);
> 
> There is a cross dependency here, now nvme_cancel_admin_tagset needs to
> have the keep-alive stopped first, which may be waiting on I/O, which
> needs to be cancelled...
> 
> Keep in mind that kato can be arbitrarily long, and now this function
> may be blocked on this kato period.
> 
> I also think that now the function is doing something that is more
> than simply cancelling the inflight admin tagset, as it is named.
> 
Hmm. I could move it out of cancel_admin_tagset(). It means that I'll
have to touch each transport driver, but as I have to touch at least
fc anyway I guess it's okay.

>> @@ -3200,6 +3201,8 @@ int nvme_init_ctrl_finish(struct nvme_ctrl 
>> *ctrl, bool was_suspended)
>>       clear_bit(NVME_CTRL_DIRTY_CAPABILITY, &ctrl->flags);
>>       ctrl->identified = true;
>> +    nvme_start_keep_alive(ctrl);
>> +
> 
> I'm fine with moving it here. But instead, maybe just change
> nvme_start_keep_alive() to use a zero delay and keep it where it
> is? will that help?
> 
Not really. We still will fail if setting up I/O queues takes longer
than the KATO period.

Will be updating the patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


