Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926F4E8B387
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 00:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=74cwG94kBnJ8TPZg2f1lTg5soXJ34/5BzPUaaMbnpFg=; b=g7m+dlwS3X9UpzvoQtrGs4bPpK
	BPpSPcQfWbc2RDW/7ELtCk9OMyvg1t9858AVHTeLO5qq+qphzqopeSjpCiZz6HQm7IShBLDPjzqS0
	FnDPbMGGB1v6V9d7ceWfwFgOuSqpSAFYGwz0AGJIn/hbs8G0SXCD/bq5MqLnEUEJmBp2DCWzXgTpq
	6AtSihFoodlbLiID5D+SAs6T77nmRZMz/9ez2eZXtJhVNYRFZK546bSP3D+3MMxBYKTZqFuyTo9aB
	akDkv5ayuD50nMxEOGGPK6tp4kBC/ia/onkoE6LdVPWKmSD+g+0RiV6g93lOmtjgij49ZUvFC0liA
	oKin8IKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnQzJ-00000007e6A-3xcj;
	Wed, 04 Feb 2026 00:43:21 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnQzG-00000007e5l-2kh1
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 00:43:20 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9FE853E6CF;
	Wed,  4 Feb 2026 00:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770165796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74cwG94kBnJ8TPZg2f1lTg5soXJ34/5BzPUaaMbnpFg=;
	b=wdkQJ9pCmNU3AwC6Z/GoOT23Ch+gMfgHKfHdt56Ih8zZ0mUmrXDG7RnWSYk6vASG2fRy0V
	woeAU1LhVXbLJLgViMWXIRcm2dcdSZxaMk2iLr7zIkViz2thktAuccxFkLvXXqHCmyzNfu
	76jD4K5uvP9dv6vi8nb8uMNnG9cFQiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770165796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74cwG94kBnJ8TPZg2f1lTg5soXJ34/5BzPUaaMbnpFg=;
	b=p24s1hb83KXwKMRydktbwIBvhh2WZgDUunlt0cOfqLpdzCxW0oYPAuENCsf6IJv2QcRIzy
	4es4QqFpAx+sxgCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wdkQJ9pC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p24s1hb8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770165796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74cwG94kBnJ8TPZg2f1lTg5soXJ34/5BzPUaaMbnpFg=;
	b=wdkQJ9pCmNU3AwC6Z/GoOT23Ch+gMfgHKfHdt56Ih8zZ0mUmrXDG7RnWSYk6vASG2fRy0V
	woeAU1LhVXbLJLgViMWXIRcm2dcdSZxaMk2iLr7zIkViz2thktAuccxFkLvXXqHCmyzNfu
	76jD4K5uvP9dv6vi8nb8uMNnG9cFQiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770165796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74cwG94kBnJ8TPZg2f1lTg5soXJ34/5BzPUaaMbnpFg=;
	b=p24s1hb83KXwKMRydktbwIBvhh2WZgDUunlt0cOfqLpdzCxW0oYPAuENCsf6IJv2QcRIzy
	4es4QqFpAx+sxgCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1318F3EA63;
	Wed,  4 Feb 2026 00:43:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BmwcLh+WgmkILwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Feb 2026 00:43:11 +0000
Message-ID: <90199dd3-86f2-4cab-9ac0-1dffe82cea43@suse.de>
Date: Wed, 4 Feb 2026 01:43:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] nvmet: Send an AEN on CCR completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-6-mkhalfella@purestorage.com>
 <3e5a7153-662d-479f-8205-c17cd3f35455@suse.de>
 <20260203184802.GC3729-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260203184802.GC3729-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me,purestorage.com,lists.infradead.org,vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email,purestorage.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9FE853E6CF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_164318_992143_2CE214EA 
X-CRM114-Status: GOOD (  18.59  )
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

On 2/3/26 19:48, Mohamed Khalfella wrote:
> On Tue 2026-02-03 04:27:39 +0100, Hannes Reinecke wrote:
>> On 1/30/26 23:34, Mohamed Khalfella wrote:
>>> Send an AEN to initiator when impacted controller exists. The
>>> notification points to CCR log page that initiator can read to check
>>> which CCR operation completed.
>>>
>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>> ---
>>>    drivers/nvme/target/core.c  | 25 ++++++++++++++++++++++---
>>>    drivers/nvme/target/nvmet.h |  3 ++-
>>>    include/linux/nvme.h        |  3 +++
>>>    3 files changed, 27 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>>> index 54dd0dcfa12b..ae2fe9f90bcd 100644
>>> --- a/drivers/nvme/target/core.c
>>> +++ b/drivers/nvme/target/core.c
>>> @@ -202,7 +202,7 @@ static void nvmet_async_event_work(struct work_struct *work)
>>>    	nvmet_async_events_process(ctrl);
>>>    }
>>>    
>>> -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>>> +static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 event_type,
>>>    		u8 event_info, u8 log_page)
>>>    {
>>>    	struct nvmet_async_event *aen;
>>> @@ -215,13 +215,19 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>>>    	aen->event_info = event_info;
>>>    	aen->log_page = log_page;
>>>    
>>> -	mutex_lock(&ctrl->lock);
>>>    	list_add_tail(&aen->entry, &ctrl->async_events);
>>> -	mutex_unlock(&ctrl->lock);
>>>    
>>>    	queue_work(nvmet_wq, &ctrl->async_event_work);
>>>    }
>>>    
>>> +void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>>> +		u8 event_info, u8 log_page)
>>> +{
>>> +	mutex_lock(&ctrl->lock);
>>> +	nvmet_add_async_event_locked(ctrl, event_type, event_info, log_page);
>>> +	mutex_unlock(&ctrl->lock);
>>> +}
>>> +
>>>    static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
>>>    {
>>>    	u32 i;
>>> @@ -1788,6 +1794,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>>>    }
>>>    EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
>>>    
>>> +static void nvmet_ctrl_notify_ccr(struct nvmet_ctrl *ctrl)
>>> +{
>>> +	lockdep_assert_held(&ctrl->lock);
>>> +
>>> +	if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_CCR_COMPLETE))
>>> +		return;
>>> +
>>> +	nvmet_add_async_event_locked(ctrl, NVME_AER_NOTICE,
>>> +				     NVME_AER_NOTICE_CCR_COMPLETED,
>>> +				     NVME_LOG_CCR);
>>> +}
>>> +
>>>    static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
>>>    {
>>>    	struct nvmet_subsys *subsys = ctrl->subsys;
>>
>> But what does the CCR command actually _do_?
>> At the very lease I would have expected it to trigger a controller reset
>> (eg calling into nvmet_ctrl_fatal_error()), yet I don't see it doing
>> that anywhere ...
> 
> [PATCH v2 03/14] nvmet: Implement CCR nvme command
> is where impacted controller is told to fail. It does exactly what you
> mentioned above.
> 
> +out_unlock:
> +       mutex_unlock(&sctrl->lock);
> +       if (status == NVME_SC_SUCCESS)
> +               nvmet_ctrl_fatal_error(ictrl);
> +       nvmet_ctrl_put(ictrl);
> +out:
> +       nvmet_req_complete(req, status);
> 
> I refactored the error handling codepath into success codepath. That is
> why I think it is kind of hidden. If this is not obvious I can separate
> the two codepaths. What do you think?

Ah. Indeed, cleverly hidden.

So ignore my comment.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

