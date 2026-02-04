Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34554E8B364
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 02:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9IWiKbE6cJTBVaa+480dfdPNb/egc8AygC/qhDUu/tE=; b=m1ysN20FN+CgNdMraO7rm+Fm0+
	XEB3me/yhQgHG2Om/X22cC3lynZeyPzMHC87FNVMVYSgLTCeHDfQbh2N3+bG2rwJqjw5iyc9FXhpP
	ab+C4fhb06e6zBkqarIbH/WhMrNl2psoo61b59aj7S7J9T/RmUqNUrN6Oe0aBAVyZia3KkvToXBJR
	WZmSTiWzIeVkmOPRCuCaTeE2DxWWRTZGR2NaMHYTkwdgklD71QDsOGySBrpGQXf+yrIMhzF0ra11q
	5rDj5bnUbvoKvw/1ElnWGGYlmd2TWS4BUFOmrocQ/zygBps/7y5FRRYbvwOqFeAzFQfp91rkLnusk
	qgebbihw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnT5D-00000007ncN-0VEt;
	Wed, 04 Feb 2026 02:57:35 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnT5A-00000007nbS-3jQZ
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 02:57:34 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2E933E6D1;
	Wed,  4 Feb 2026 02:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770173850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IWiKbE6cJTBVaa+480dfdPNb/egc8AygC/qhDUu/tE=;
	b=lYkfK/cy5cXTdMaIjmfrQ/LsseuqwQ13sm6DnKGeRfBOWyt0rVkkmEvTV0btdW/GPTOZqt
	KyNDtw69AsWEK4H4Quaf0vhG5Gnvo6c6KtHSZ+lBC1vpWQzLTgXBSwK3tycQJNJPWMJOgs
	xU6WVGdnrs/bunpizSYRrwLnda1XgvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770173850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IWiKbE6cJTBVaa+480dfdPNb/egc8AygC/qhDUu/tE=;
	b=eGUiGkF9QtNX5/5b6Sc6fYZ2Qyz9+7/IR1D/qhiDg1kebFr7kyKYuCMQ1srLHIG2Q0Vv4/
	JzUWbWghtrsnwNDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770173850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IWiKbE6cJTBVaa+480dfdPNb/egc8AygC/qhDUu/tE=;
	b=lYkfK/cy5cXTdMaIjmfrQ/LsseuqwQ13sm6DnKGeRfBOWyt0rVkkmEvTV0btdW/GPTOZqt
	KyNDtw69AsWEK4H4Quaf0vhG5Gnvo6c6KtHSZ+lBC1vpWQzLTgXBSwK3tycQJNJPWMJOgs
	xU6WVGdnrs/bunpizSYRrwLnda1XgvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770173850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IWiKbE6cJTBVaa+480dfdPNb/egc8AygC/qhDUu/tE=;
	b=eGUiGkF9QtNX5/5b6Sc6fYZ2Qyz9+7/IR1D/qhiDg1kebFr7kyKYuCMQ1srLHIG2Q0Vv4/
	JzUWbWghtrsnwNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C16973EA63;
	Wed,  4 Feb 2026 02:57:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5DoaIJa1gmnxSgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Feb 2026 02:57:26 +0000
Message-ID: <2c35f0df-5ef3-4919-9f65-3b67eaf8c823@suse.de>
Date: Wed, 4 Feb 2026 03:57:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] nvme-tcp: Use CCR to recover controller that
 hits an error
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
 <20260130223531.2478849-11-mkhalfella@purestorage.com>
 <48a05027-9ca2-4e84-a7ac-946391ed1e26@suse.de>
 <20260203212409.GG3729-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260203212409.GG3729-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[purestorage.com:email,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_185733_236452_EFF69330 
X-CRM114-Status: GOOD (  47.35  )
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

On 2/3/26 22:24, Mohamed Khalfella wrote:
> On Tue 2026-02-03 06:34:51 +0100, Hannes Reinecke wrote:
>> On 1/30/26 23:34, Mohamed Khalfella wrote:
>>> An alive nvme controller that hits an error now will move to FENCING
>>> state instead of RESETTING state. ctrl->fencing_work attempts CCR to
>>> terminate inflight IOs. If CCR succeeds, switch to FENCED -> RESETTING
>>> and continue error recovery as usual. If CCR fails, the behavior depends
>>> on whether the subsystem supports CQT or not. If CQT is not supported
>>> then reset the controller immediately as if CCR succeeded in order to
>>> maintain the current behavior. If CQT is supported switch to time-based
>>> recovery. Schedule ctrl->fenced_work resets the controller when time
>>> based recovery finishes.
>>>
>>> Either ctrl->err_work or ctrl->reset_work can run after a controller is
>>> fenced. Flush fencing work when either work run.
>>>
>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>> ---
>>>    drivers/nvme/host/tcp.c | 62 ++++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 61 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 69cb04406b47..af8d3b36a4bb 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -193,6 +193,8 @@ struct nvme_tcp_ctrl {
>>>    	struct sockaddr_storage src_addr;
>>>    	struct nvme_ctrl	ctrl;
>>>    
>>> +	struct work_struct	fencing_work;
>>> +	struct delayed_work	fenced_work;
>>>    	struct work_struct	err_work;
>>>    	struct delayed_work	connect_work;
>>>    	struct nvme_tcp_request async_req;
>>> @@ -611,6 +613,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
>>>    
>>>    static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>>>    {
>>> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCING)) {
>>> +		dev_warn(ctrl->device, "starting controller fencing\n");
>>> +		queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->fencing_work);
>>> +		return;
>>> +	}
>>> +
>>
>> Don't you need to flush any outstanding 'fenced_work' queue items here
>> before calling 'queue_work()'?
> 
> I do not think we need to flush ctr->fencing_work. It can not be running
> at this time.
> 
Hmm. If you say so ... I'd rather make sure here.
These things have a habit of popping up unexpectdly.

>>
>>>    	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>>>    		return;
>>>    
>>> @@ -2470,12 +2478,59 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>>>    	nvme_tcp_reconnect_or_remove(ctrl, ret);
>>>    }
>>>    
>>> +static void nvme_tcp_fenced_work(struct work_struct *work)
>>> +{
>>> +	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
>>> +					struct nvme_tcp_ctrl, fenced_work);
>>> +	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>>> +
>>> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
>>> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>>> +		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
>>> +}
>>> +
>>> +static void nvme_tcp_fencing_work(struct work_struct *work)
>>> +{
>>> +	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
>>> +			struct nvme_tcp_ctrl, fencing_work);
>>> +	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>>> +	unsigned long rem;
>>> +
>>> +	rem = nvme_fence_ctrl(ctrl);
>>> +	if (!rem)
>>> +		goto done;
>>> +
>>> +	if (!ctrl->cqt) {
>>> +		dev_info(ctrl->device,
>>> +			 "CCR failed, CQT not supported, skip time-based recovery\n");
>>> +		goto done;
>>> +	}
>>> +
>>
>> As mentioned, cqt handling should be part of another patchset.
> 
> Let us suppose we drop cqt from this patchset
> 
> - How will we be able to calculate CCR time budget?
>    Currently it is calculated by nvme_fence_timeout_ms()
> 
The CCR time budget is calculated by the current KATO value.
CQT is the time a controler requires _after_ KATO expires
to clear out commands.

> - What should we do if CCR fails? Retry requests immediately?
> 
No. If CCR fails we should fall back to error handling.
In our case it would mean we let the command timeout handler
initate a controller reset.
_Eventually_ (ie after we implemented CCR _and_ CQT) we would
wait for KATO (+ CQT) to expire and _then_ reset the controller.

>>> +	dev_info(ctrl->device,
>>> +		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
>>> +		 jiffies_to_msecs(rem));
>>> +	queue_delayed_work(nvme_wq, &tcp_ctrl->fenced_work, rem);
>>> +	return;
>>> +
>>
>> Why do you need the 'fenced' workqueue at all? All it does is queing yet
>> another workqueue item, which certainly can be done from the 'fencing'
>> workqueue directly, no?
> 
> It is possible to drop ctr->fenced_work and requeue ctrl->fencing_work
> as delayed work to implement request hold time. If we do that then we
> need to modify nvme_tcp_fencing_work() to tell if it is being called for
> 'fencing' or 'fenced'. The first version of this patch used a controller
> flag RECOVERED for that and it has been suggested to use a separate work
> to simplify the logic and drop the controller flag.
> 
But that's just because you integrated CCR within the current error 
recovery.
If you were to implement CCR as to be invoked from 
nvme_keep_alive_end_io() we would not need to touch that,
and we would need just one workqueue.

Let me see if I can draft up a patch.

>>
>>> +done:
>>> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
>>> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>>> +		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
>>> +}
>>> +
>>> +static void nvme_tcp_flush_fencing_work(struct nvme_ctrl *ctrl)
>>> +{
>>> +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
>>> +	flush_delayed_work(&to_tcp_ctrl(ctrl)->fenced_work);
>>> +}
>>> +
>>>    static void nvme_tcp_error_recovery_work(struct work_struct *work)
>>>    {
>>>    	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
>>>    				struct nvme_tcp_ctrl, err_work);
>>>    	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>>>    
>>> +	nvme_tcp_flush_fencing_work(ctrl);
>>
>> Why not 'fenced_work' ?
> 
> You mean rename nvme_tcp_flush_fencing_work() to
> nvme_tcp_flush_fenced_work()?
> 
> If yes, then I can do that if you think it makes more sense.
> 
Thing is, you have two workqueues dealing with CCR.
You really need to avoid that _both_ are empty when this
funciton is called.

>>
>>>    	if (nvme_tcp_key_revoke_needed(ctrl))
>>>    		nvme_auth_revoke_tls_key(ctrl);
>>>    	nvme_stop_keep_alive(ctrl);
>>> @@ -2518,6 +2573,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>>>    		container_of(work, struct nvme_ctrl, reset_work);
>>>    	int ret;
>>>    
>>> +	nvme_tcp_flush_fencing_work(ctrl);
>>
>> Same.
>>
>>>    	if (nvme_tcp_key_revoke_needed(ctrl))
>>>    		nvme_auth_revoke_tls_key(ctrl);
>>>    	nvme_stop_ctrl(ctrl);
>>> @@ -2643,13 +2699,15 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
>>>    	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
>>>    	struct nvme_command *cmd = &pdu->cmd;
>>>    	int qid = nvme_tcp_queue_id(req->queue);
>>> +	enum nvme_ctrl_state state;
>>>    
>>>    	dev_warn(ctrl->device,
>>>    		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
>>>    		 rq->tag, nvme_cid(rq), pdu->hdr.type, cmd->common.opcode,
>>>    		 nvme_fabrics_opcode_str(qid, cmd), qid);
>>>    
>>> -	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
>>> +	state = nvme_ctrl_state(ctrl);
>>> +	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
>>
>> 'FENCED' too, presumably?
> 
> I do not think it makes a difference here. FENCED and RESETTING are
> almost the same states.
> 
Yeah, but in FENCED all commands will be aborted, and the same action 
will be invoked when this if() clause is entered. So you need to avoid
entering the if() clause to avoid races.

>>
>>>    		/*
>>>    		 * If we are resetting, connecting or deleting we should
>>>    		 * complete immediately because we may block controller
>>> @@ -2904,6 +2962,8 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
>>>    
>>>    	INIT_DELAYED_WORK(&ctrl->connect_work,
>>>    			nvme_tcp_reconnect_ctrl_work);
>>> +	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_tcp_fenced_work);
>>> +	INIT_WORK(&ctrl->fencing_work, nvme_tcp_fencing_work);
>>>    	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
>>>    	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
>>>    
>>
>> Here you are calling CCR whenever error recovery is triggered.
>> This will cause CCR to be send from a command timeout, which is
>> technically wrong (CCR should be send when the KATO timeout expires,
>> not when a command timout expires). Both could be vastly different.
> 
> KATO is driven by the host. What does KTO expires mean?
> I think KATO expiry is more applicable to target, no?
> 
KATO expiry (for this implementation) means the nvme_keep_alive_end_io()
is called with rtt > deadline.

> KATO timeout is a signal of an error that target is not reachable or
> something is wrong with the target?
> 
Yes. It explicitely means that the Keep-Alive command was not completed
within a time period specified by the Keep-Alive timeout value.

>>
>> So I'd prefer to have CCR send whenever KATO timeout triggers, and
>> lease to current command timeout mechanism in place.
> 
> Assuming we used CCR only when KATO request times out.
> What should we do when we hit other errors?
> 
Leave it. This patchset is _NOT_ about fixing the error handler.
This patchset is about implementing CCR.
And CCR is just a step towared fixing the error handler.

> should nvme_tcp_error_recovery() is called from many places to handle
> errors and it effectively resets the controller. What should this
> function do if not trigger CCR?
> 
The same things as before. CCR needs to be invoked when the Keep-Alive
timeout period expires. And that is what we should be implementing here.

It _might_ (and arguably should) be invoked when error handling needs
to be done. But with a later patchset.

Yes, this will result in a patchset where the error handler still has
gaps. But it will result in a patchset which focusses on a single thing,
with the added benefit that the workings are clearly outlined in the 
spec. So the implementation is pretty easy to review.

Hooking CCR into the error handler itself is _not_ mandated by the spec,
and inevitably needs to larger discussions (as this thread nicely 
demonstrates). So I would prefer to keep it simple first, and focus
on the technical implementation of CCR.
And concentrate on fixing up the error handler once CCR is in.

Cheers,

Hannes
>>
>> Cheers,
>>
>> Hannes
>> -- 
>> Dr. Hannes Reinecke                  Kernel Storage Architect
>> hare@suse.de                                +49 911 74053 688
>> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
>> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

