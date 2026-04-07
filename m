Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46776FB519A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 05:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N/9NLOV0POsOQQ/G7IpqQzcj6yWajgHljM0UnkhueCE=; b=uEHMpN+S8nv7d2LNbyMFe9hvVy
	cJhsHE50xhtEQo8F/NNDgrRXjaaL/dy2yUsM8NsWL8GUt/Uob8FHLNHxKCMG3ZXtLLzdhalxBaWEj
	+yoNvJ9Uc/4gRb2EjJBZSODfKBeQg21g3Op877LLORhbVAVetrZRpNN6Jqog1jV4EZNism8phX2rB
	ad4Cn4SrDQglzNp5j+8Dyqer2O4G877IyyEhFdpglQfQK0tJgWhneO6qPwiBda4xNMIdXBlXQcWQ4
	ZoZ+bPLB52Yr8lIFyb9Bx3tNAuDeWWlElfW0GISCXlDfRTCeKehq0XX2vMW+/wJDeKPFGeclS2IYR
	V2ywnS2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zJ2-00000005wn2-2pSR;
	Tue, 07 Apr 2026 05:48:56 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zJ0-00000005wmQ-0GOY
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 05:48:55 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 885925BDB5;
	Tue,  7 Apr 2026 05:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775540931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/9NLOV0POsOQQ/G7IpqQzcj6yWajgHljM0UnkhueCE=;
	b=v/2rvFA8XJI8GjOj03KHfqTBt7Aro/KvmVO6ecxuAqVRSbGHcI8orDYlFh3H4J7AVKaPxS
	V7LrDjaJXLByiG6mbNZukjfwiLa+kqR66Fjt8jAkuv35iHQkrLXdZHd81pF2SEHUHFb8gQ
	xEy+cx3UFw+8CULLwcViXPHEAGCIvZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775540931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/9NLOV0POsOQQ/G7IpqQzcj6yWajgHljM0UnkhueCE=;
	b=GXWpj9zymx+qjGKrftw07jr1jbxuam7+FCyQEcsPpJvNJNl/Rrfiy7cIyt1AavqzbutQbu
	yEBu6aTcy1qEsWAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="v/2rvFA8";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GXWpj9zy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775540931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/9NLOV0POsOQQ/G7IpqQzcj6yWajgHljM0UnkhueCE=;
	b=v/2rvFA8XJI8GjOj03KHfqTBt7Aro/KvmVO6ecxuAqVRSbGHcI8orDYlFh3H4J7AVKaPxS
	V7LrDjaJXLByiG6mbNZukjfwiLa+kqR66Fjt8jAkuv35iHQkrLXdZHd81pF2SEHUHFb8gQ
	xEy+cx3UFw+8CULLwcViXPHEAGCIvZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775540931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/9NLOV0POsOQQ/G7IpqQzcj6yWajgHljM0UnkhueCE=;
	b=GXWpj9zymx+qjGKrftw07jr1jbxuam7+FCyQEcsPpJvNJNl/Rrfiy7cIyt1AavqzbutQbu
	yEBu6aTcy1qEsWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 358FB4A0B0;
	Tue,  7 Apr 2026 05:48:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id beroC8Oa1GnabwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Apr 2026 05:48:51 +0000
Message-ID: <019cf04f-8988-46fd-aecd-0f77ac5f8b8a@suse.de>
Date: Tue, 7 Apr 2026 07:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/15] nvme: Implement cross-controller reset
 completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260328004518.1729186-10-mkhalfella@purestorage.com>
 <73a9c0e2-ecd0-4170-8723-259529617ec0@suse.de>
 <20260331165510.GD2861-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260331165510.GD2861-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,nvidia.com,kernel.dk,kernel.org,grimberg.me,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 885925BDB5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_224854_307161_6C8FCAB6 
X-CRM114-Status: GOOD (  23.53  )
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

On 3/31/26 18:55, Mohamed Khalfella wrote:
> On Mon 2026-03-30 12:53:07 +0200, Hannes Reinecke wrote:
>> On 3/28/26 01:43, Mohamed Khalfella wrote:
>>> An nvme source controller that issues CCR command expects to receive an
>>> NVME_AER_NOTICE_CCR_COMPLETED when pending CCR succeeds or fails. Add
>>> sctrl->ccr_work to read NVME_LOG_CCR logpage and wakeup any thread
>>> waiting on CCR completion.
>>>
>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>> ---
>>>    drivers/nvme/host/core.c | 49 +++++++++++++++++++++++++++++++++++++++-
>>>    drivers/nvme/host/nvme.h |  1 +
>>>    2 files changed, 49 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 5603ae36444f..793f203bfc38 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -1920,7 +1920,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>>>    
>>>    #define NVME_AEN_SUPPORTED \
>>>    	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
>>> -	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
>>> +	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
>>> +	 NVME_AEN_CFG_DISC_CHANGE)
>>>    
>>>    static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>>>    {
>>> @@ -4873,6 +4874,47 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
>>>    	kfree(log);
>>>    }
>>>    
>>> +static void nvme_ccr_work(struct work_struct *work)
>>> +{
>>> +	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ccr_work);
>>> +	struct nvme_ccr_entry *ccr;
>>> +	struct nvme_ccr_log_entry *entry;
>>> +	struct nvme_ccr_log *log;
>>> +	unsigned long flags;
>>> +	int ret, i;
>>> +
>>> +	log = kmalloc(sizeof(*log), GFP_KERNEL);
>>> +	if (!log)
>>> +		return;
>>> +
>>> +	ret = nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
>>> +			   0x00, log, sizeof(*log), 0);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	spin_lock_irqsave(&ctrl->lock, flags);
>>> +	for (i = 0; i < le16_to_cpu(log->ne); i++) {
>>> +		entry = &log->entries[i];
>>> +		if (entry->ccrs == NVME_CCR_STATUS_IN_PROGRESS)
>>> +			continue;
>>> +
>>> +		list_for_each_entry(ccr, &ctrl->ccr_list, list) {
>>> +			struct nvme_ctrl *ictrl = ccr->ictrl;
>>> +
>>> +			if (ictrl->cntlid != le16_to_cpu(entry->icid) ||
>>> +			    ictrl->ciu != entry->ciu)
>>> +				continue;
>>> +
>>> +			/* Complete matching entry */
>>> +			ccr->ccrs = entry->ccrs;
>>> +			complete(&ccr->complete);
>>> +		}
>>> +	}
>>> +	spin_unlock_irqrestore(&ctrl->lock, flags);
>>> +out:
>>> +	kfree(log);
>>> +}
>>> +
>>>    static void nvme_fw_act_work(struct work_struct *work)
>>>    {
>>>    	struct nvme_ctrl *ctrl = container_of(work,
>>> @@ -4949,6 +4991,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
>>>    	case NVME_AER_NOTICE_DISC_CHANGED:
>>>    		ctrl->aen_result = result;
>>>    		break;
>>> +	case NVME_AER_NOTICE_CCR_COMPLETED:
>>> +		queue_work(nvme_wq, &ctrl->ccr_work);
>>> +		break;
>>>    	default:
>>>    		dev_warn(ctrl->device, "async event result %08x\n", result);
>>>    	}
>>> @@ -5144,6 +5189,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>>>    	nvme_stop_failfast_work(ctrl);
>>>    	flush_work(&ctrl->async_event_work);
>>>    	cancel_work_sync(&ctrl->fw_act_work);
>>> +	cancel_work_sync(&ctrl->ccr_work);
>>>    	if (ctrl->ops->stop_ctrl)
>>>    		ctrl->ops->stop_ctrl(ctrl);
>>>    }
>>> @@ -5267,6 +5313,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>>>    	ctrl->quirks = quirks;
>>>    	ctrl->numa_node = NUMA_NO_NODE;
>>>    	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
>>> +	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
>>>    	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
>>>    	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
>>>    	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>> index f2bcff9ccd25..776ee8aa5a93 100644
>>> --- a/drivers/nvme/host/nvme.h
>>> +++ b/drivers/nvme/host/nvme.h
>>> @@ -419,6 +419,7 @@ struct nvme_ctrl {
>>>    	struct nvme_effects_log *effects;
>>>    	struct xarray cels;
>>>    	struct work_struct scan_work;
>>> +	struct work_struct ccr_work;
>>>    	struct work_struct async_event_work;
>>>    	struct delayed_work ka_work;
>>>    	struct delayed_work failfast_work;
>>
>> Hmm. The 'nvme_fence_ctrl' operation introduced in the previous patch
>> is synchronous, yet in this patch we're looking a a log page to figure
>> out if the cross-controller reset is complete.
>> Which is slightly irritating.
>> Wouldn't it be better to make the 'nvme_fence_ctrl' operation
>> asynchronous, and then have a separate function to wait for the fence
>> operation to complete (which then could look at log pages etc)?
> 
> True nvme_fence_ctrl() is synchronous, but it runs in from ctrl->fencing_work.
> What is it that you find irritating about nvme_fence_ctrl()?
> 

Thins is, in order to make nvme_fence_ctrl() synchronous we have to
wait for the operation itself (which is asynchronous) to complete.
And that wait in itself is implemented by a wait queue.
So we're having a wait queue calling nvme_fence_ctrl(), which calls
another wait queue waiting for a completion.
And then (if the IRS bit is not set) calling another waitqueue for
checking the log page.

I think we could simplify this by simply making nvme_fence_ctrl() 
asynchronous, which could do away with all the workqueue handling.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

