Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49068EA794E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 00:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+hPL76f51r1zpGqT8L7AfPxwJYgMyGZBMSugqV/MMt0=; b=yG3ZpqTOq8Dicz98fNZt47HWRi
	S5H470SBDp+leDWBgftwoPH85Y5Z0+RamMLPT2Ywif/6Zm9DES6gUBnwALd03cNvHijU/wDupa4Tf
	JB2jr7ZUZ965Np4p1zNAO1cRZrq5soe0PGTu+kAFbOhdslyrQFD+5EC9ljQBQvNSSd6cUu92qN8p5
	F9SEaminFEW2uMyhNaplFcAyPCxemCaZ5+jIA/ddSL4+VoDJoyfFP5CDNOj8/5fL5N8/PJrcwGMlT
	iyqrg7J8brtKI09/GJ9e3k/IqmHEdykKvMYPhLeWqqZ7KpX2Za10kddxBYVm4dT79nxMjSTAG9SjN
	MyuxRQOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnmux-00000009CxD-2UgI;
	Thu, 05 Feb 2026 00:08:19 +0000
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnmuu-00000009Cws-3pW8
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 00:08:18 +0000
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-11f36012fb2so561132c88.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Feb 2026 16:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770250095; x=1770854895; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hPL76f51r1zpGqT8L7AfPxwJYgMyGZBMSugqV/MMt0=;
        b=bE/GRSMDryIIAWvsNID8V9taZ8hfJPlZzljixRPKU9h+oR2M1EAowJnrRFAV2rySU4
         k+TliNBEBOTdwVe61sDKcWpmExLZMb4BP11znmcrSCLUbTUk7gMfqf9pVOTIyvFVPJJ7
         7s2bBDuFnWStBrk22zEW6m8x3r1SXrTweNyI4Wu0etLxpWrPS4l0GyMX1beYkXDhNCpP
         cVZ1VpdWfrhd/wpyWrHiB92a5HsDW+GiSTzvd+nS6cOh0/CyV+XC94DfMtQCDosURtlS
         mBqCD+eL+wDwho5ryu/IPRgpjcDnMyu2U2gYkKqPLgtQMSdKreWhTM6LU6KaFkcRwdmw
         905Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770250095; x=1770854895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hPL76f51r1zpGqT8L7AfPxwJYgMyGZBMSugqV/MMt0=;
        b=I4f826BEmm58QIyEiAsv+k8g0GQl/ATJEUcQqfeTMG3Iae/iE3N7JHKgDZKusn5p0N
         Buw+M4E3fUFVj4wIFgx21UBbtZu4wtH0qExsVpoozayCKiePSkmzJ3Bn75qcOJfUUJg/
         SU+IVDw9s+T2xMIwUBUIoL0yNdwthukwWk8BD6viVCh2xTHbTmvTEpJ24L/r75Hl0lrW
         gm62b9PyeUfssww3kpLVt9oLx25t2JPvn3sxdt90ZtWRG78GigPKdpg8bPeYvWDW81ns
         6+6xiwZIOi2r7dYsVpMTomb1ldmXP6CCl6dh5k2Ucjs9+2ASu0Dv0TamZ3dN2DypJFcZ
         t3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVd99uevuJW/ROzwEMXlBLLbsY2u9bI2kjQZdysCmWlpx5ataqiSn6mNxrExpkVY3aGitHWsU0vneCg@lists.infradead.org
X-Gm-Message-State: AOJu0YxN2mN9O3pIqzpvl7iWYX+62BML2knwE3edAsFSxNK5zBc/L18g
	fi2eARBMnzktXutYXKQyd+cdbc3Q/KyskuhlpLoalOimPNCXiKqirLfk
X-Gm-Gg: AZuq6aLm9KTan91EwolKhkkuiWu4aU6t1PeKjppOZqgYku8A19OdkcZdM6yaDqkoGyp
	OhT3INi49AFmhQmITnQq/t9uP3LhvL/R4tU36/+3x8sGQkJlqjg9pz8MqhCRA3e9oSohZx6q2fy
	DGloV+n4uUOR5JgIWPSkUgzBkA4x/8FlJzvsa0Q/O76ngHJq2MmaE1ry5HqNZPEXAuS07rUnIDB
	t6+LmMDJ3C6NBQOqGNRBHWt++URIk7aDZkhhUhUW/U8vHs7Jl50ulWc/A1hFq5t0bP8NdSTqkU9
	s9+So3QGSidYi9ZgZeT+6tgdVqfgN3U46K8/HwB21kKaZ78SK/UArUsPztoTZBg2whTcCAvcRZb
	RsJz9SaSAM/sQuDInBh0UAzhcfHfNinjoKx1lJJlFYOSSF5eUbweTcv3JZ4qq6fM1bEMhFV9KYb
	Etd60eFw4kGYaaAeklyDDIogSbiCOAiAY=
X-Received: by 2002:a05:7022:6ba2:b0:11b:923d:773f with SMTP id a92af1059eb24-126f4781428mr2103565c88.5.1770250095006;
        Wed, 04 Feb 2026 16:08:15 -0800 (PST)
Received: from [10.69.37.27] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e4d18fsm2276944eec.13.2026.02.04.16.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 16:08:14 -0800 (PST)
Message-ID: <8487298a-ea00-4c3e-a882-bfdf97021a1f@gmail.com>
Date: Wed, 4 Feb 2026 16:08:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] nvme-fc: Decouple error recovery from controller
 reset
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jsmart833426@gmail.com
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-13-mkhalfella@purestorage.com>
 <383bbbe9-6cf5-465c-8811-0dddce34f883@gmail.com>
 <20260204001128.GI3729-mkhalfella@purestorage.com>
Content-Language: en-US
From: James Smart <jsmart833426@gmail.com>
In-Reply-To: <20260204001128.GI3729-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_160817_001282_BAE0C05D 
X-CRM114-Status: GOOD (  61.34  )
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

On 2/3/2026 4:11 PM, Mohamed Khalfella wrote:
> On Tue 2026-02-03 11:19:28 -0800, James Smart wrote:
>> On 1/30/2026 2:34 PM, Mohamed Khalfella wrote:
...
>>>    
>>> +static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
>>> +					 char *errmsg)
>>> +{
>>> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
>>> +		return;
>>   > +> +	dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error
>> recovery %s\n",
>>> +		 ctrl->cnum, errmsg);
>>> +	queue_work(nvme_reset_wq, &ctrl->ioerr_work);
>>> +}
>>> +
>>
>> Disagree with this.
>>
>> The clause in error_recovery around the CONNECTING state is pretty
>> important to terminate io occurring during connect/reconnect where the
>> ctrl state should not change. we don't want start_ioerr making it RESETTING.
>>
>> This should be reworked.
> 
> Like you pointed out this changes the current behavior for CONNECTING
> state.
> 
> Before this change, as you pointed out the controller state stays in
> CONNECTING while all IOs are aborted. Aborting the IOs causes
> nvme_fc_create_association() to fail and reconnect might be attempted
> again.
> The new behavior switches to RESETTING and queues ctr->ioerr_work.
> ioerr_work will abort oustanding IOs, swich back to CONNECING and
> attempt reconnect.

Well, it won't actually switch to RESETTING, as CONNECTING->RESETTING is 
not a valid transition.  So things will silently stop in 
start_ioerr_recovery when the state transition fails (also a reason I 
dislike silent state transition failures).

When I look a little further into patch 13, I see the change to FENCING 
added. But that state transition will also fail for CONNECTING->FENCING. 
It will then fall into the resetting state change, which will silently 
fail, and we're stopped.  It says to me there was no consideration or 
testing of failures while CONNECTING with this patch set.  Even if 
RESETTING were allowed, its injecting a new flow into the code paths.

The CONNECTING issue also applies to tcp and rdma transports. I don't 
know if they call the error_recovery routines in the same way.

To be honest I'm not sure I remember the original reasons this loop was 
put in, but I do remember pain I went through when generating it and the 
number of test cases that were needed to cover testing. It may well be 
because I couldn't invoke the reset due to the CONNECTING->RESETTING 
block.  I'm being pedantic as I still feel residual pain for it.


> 
> nvme_fc_error_recovery() ->
>    nvme_stop_keep_alive() /* should not make a difference */
>    nvme_stop_ctrl()       /* should be okay to run */
>    nvme_fc_delete_association() ->
>      __nvme_fc_abort_outstanding_ios(ctrl, false)
>      nvme_unquiesce_admin_queue()
>      nvme_unquiesce_io_queues()
>      nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)
>      if (port_state == ONLINE)
>        queue_work(ctrl->connect)
>      else
>        nvme_fc_reconnect_or_delete();
> 
> Yes, this is a different behavior. IMO it is simpler to follow and
> closer to what other transports do, keeping in mind async abort nature
> of fc.
> 
> Aside from it is different, what is wrong with it?

See above.

...
>>>    static int
>>> @@ -2495,39 +2506,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
>>>    		nvme_unquiesce_admin_queue(&ctrl->ctrl);
>>>    }
>>>    
>>> -static void
>>> -nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
>>> -{
>>> -	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
>>> -
>>> -	/*
>>> -	 * if an error (io timeout, etc) while (re)connecting, the remote
>>> -	 * port requested terminating of the association (disconnect_ls)
>>> -	 * or an error (timeout or abort) occurred on an io while creating
>>> -	 * the controller.  Abort any ios on the association and let the
>>> -	 * create_association error path resolve things.
>>> -	 */
>>> -	if (state == NVME_CTRL_CONNECTING) {
>>> -		__nvme_fc_abort_outstanding_ios(ctrl, true);
>>> -		dev_warn(ctrl->ctrl.device,
>>> -			"NVME-FC{%d}: transport error during (re)connect\n",
>>> -			ctrl->cnum);
>>> -		return;
>>> -	}
>>
>> This logic needs to be preserved. Its no longer part of
>> nvme_fc_start_ioerr_recovery(). Failures during CONNECTING should not be
>> "fenced". They should fail immediately.
> 
> I think this is similar to the point above.

Forgetting whether or not the above "works", what I'm pointing out is 
that when in CONNECTING I don't believe you should be enacting the 
FENCED state and delaying. For CONNECTING, the cleanup should be 
immediate with no delay and no CCR attempt.  Only LIVE should transition 
to FENCED.

Looking at patch 14, fencing_work calls nvme_fence_ctrl() which 
unconditionally delays and tries to do CCR. We only want this if LIVE. 
I'll comment on that patch.


>> There is a small difference here in that The existing code avoids doing
>> the ctrl reset if the controller is NEW. start_ioerr will change the
>> ctrl to RESETTING. I'm not sure how much of an impact that is.
>>
> 
> I think there is little done while controller in NEW state.
> Let me know if I am missing something.

No - I had to update my understanding I was really out of date. Used to 
be NEW is what initial controller create was done under. Everybody does 
it now under CONNECTING.

...
>>>    static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
>>>    {
>>>    	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
>>> @@ -2536,24 +2514,14 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
>>>    	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
>>>    	struct nvme_command *sqe = &cmdiu->sqe;
>>>    
>>> -	/*
>>> -	 * Attempt to abort the offending command. Command completion
>>> -	 * will detect the aborted io and will fail the connection.
>>> -	 */
>>>    	dev_info(ctrl->ctrl.device,
>>>    		"NVME-FC{%d.%d}: io timeout: opcode %d fctype %d (%s) w10/11: "
>>>    		"x%08x/x%08x\n",
>>>    		ctrl->cnum, qnum, sqe->common.opcode, sqe->fabrics.fctype,
>>>    		nvme_fabrics_opcode_str(qnum, sqe),
>>>    		sqe->common.cdw10, sqe->common.cdw11);
>>> -	if (__nvme_fc_abort_op(ctrl, op))
>>> -		nvme_fc_error_recovery(ctrl, "io timeout abort failed");
>>>    
>>> -	/*
>>> -	 * the io abort has been initiated. Have the reset timer
>>> -	 * restarted and the abort completion will complete the io
>>> -	 * shortly. Avoids a synchronous wait while the abort finishes.
>>> -	 */
>>> +	nvme_fc_start_ioerr_recovery(ctrl, "io timeout");
>>
>> Why get rid of the abort logic ?
>> Note: the error recovery/controller reset is only called when the abort
>> failed.
>>
>> I believe you should continue to abort the op.  The fence logic will
>> kick in when the op completes later (along with other io completions).
>> If nothing else, it allows a hw resource to be freed up.
> 
> The abort logic from nvme_fc_timeout() is problematic and it does not
> play well with abort initiatored from ioerr_work or reset_work. The
> problem is that op aborted from nvme_fc_timeout() is not accounted for
> when the controller is reset.

note: I'll wait to be shown otherwise, but if this were true it would be 
horribly broken for a long time.

> 
> Here is an example scenario.
> 
> The first time a request times out it gets aborted we see this codepath
> 
> nvme_fc_timeout() ->
>    __nvme_fc_abort_op() ->
>      atomic_xchg(&op->state, FCPOP_STATE_ABORTED)
>        ops->abort()
>          return 0;

there's more than this in in the code:
it changes op state to ABORTED, saving the old opstate.
if the opstate wasn't active - it means something else changed and it 
restores the old state (e.g. the aborts for the reset may have hit it).
if it was active (e.g. the aborts the reset haven't hit it yet) it 
checks the ctlr flag to see if the controller is being reset and 
tracking io termination (the TERMIO flag) and if so, increments the 
iocnt. So it is "included" in the reset.

if old state was active, it then sends the ABTS.
if old state wasn't active (we've been here before or io terminated by 
reset) it returns -ECANCELED, which will cause a controller reset to be 
attempted if there's not already one in process.


> 
> nvme_fc_timeout() always return BLK_EH_RESET_TIMER so the same request
> can timeout again. If the same request hits timeout again then
> __nvme_fc_abort_op() returns -ECANCELED and nvme_fc_error_recovery()
> gets called. Assuming the controller is LIVE it will be reset.

The normal case is timeout generates ABTS. ABTS usually completes 
quickly with the io completing and the io callback to iodone, which sees 
abort error status and resets controller. Its very typical for the ABTS 
to complete long before the 2nd EH timer timing out.

Abnormal case is ABTS takes longer to complete than the 2nd EH timer 
timing. Yes, that forces the controller reset.   I am aware that some 
arrays will delay ABTS ACC while they terminate the back end, but there 
are also frame drop conditions to consider.

if the controller is already resetting, all the above is largely n/a.

I see no reason to avoid the ABTS and wait for a 2nd EH timer to fire.

> 
> nvme_fc_reset_ctrl_work() ->
>    nvme_fc_delete_association() ->
>      __nvme_fc_abort_outstanding_ios() ->
>        nvme_fc_terminate_exchange() ->
>          __nvme_fc_abort_op()
> 
> __nvme_fc_abort_op() finds that op already aborted. As a result of that
> ctrl->iocnt will not be incrmented for this op. This means that
> nvme_fc_delete_association() will not wait for this op to be aborted.

see missing code stmt above.

> 
> I do not think we wait this behavior.
> 
> To continue the scenario above. The controller switches to CONNECTING
> and the request times out again. This time we hit the deadlock described
> in [1].
> 
> I think the first abort is the cause of the issue here. with this change
> we should not hit the scenario described above.
> 
> 1 - https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/

Something else happened here. You can't get to CONNECTING state unless 
all outstanding io was reaped in delete association. What is also harder 
to understand is how there was an io to timeout if they've all been 
reaped and queues haven't been restarted.  Timeout on one of the ios to 
instatiate/init the controller maybe, but it shouldn't have been one of 
those in the blk layer.

> 
>>
>>
>>>    	return BLK_EH_RESET_TIMER;
>>>    }
>>>    
>>> @@ -3352,6 +3320,26 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
>>>    	}
>>>    }
>>>    
>>> +static void
>>> +nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl)
>>> +{
>>> +	nvme_stop_keep_alive(&ctrl->ctrl);
>>
>> Curious, why did the stop_keep_alive() call get added to this ?
>> Doesn't hurt.
>>
>> I assume it was due to other transports having it as they originally
>> were calling stop_ctrl, but then moved to stop_keep_alive. Shouldn't
>> this be followed by flush_work((&ctrl->ctrl.async_event_work) ?
> 
> Yes. I added it because it matches what other transports do.
> 
> nvme_fc_error_recovery() ->
>    nvme_fc_delete_association() ->
>      nvme_fc_abort_aen_ops() ->
>        nvme_fc_term_aen_ops() ->
>          cancel_work_sync(&ctrl->ctrl.async_event_work);
> 
> The above codepath takes care of async_event_work.

True, but the flush_works were added for a reason to the other 
transports so I'm guessing timing matters. So waiting till ther later 
term_aen call isn't great.  But I also guess, we haven't had an issue 
prior and since we did take care if it in the aen routines, its likely 
unneeded now.  Ok to add it but if so, we should keep the flush_work as 
well. Also good to look same as the other transports.

> 
>>
>>> +	nvme_stop_ctrl(&ctrl->ctrl);
>>> +
>>> +	/* will block while waiting for io to terminate */
>>> +	nvme_fc_delete_association(ctrl);
>>> +
>>> +	/* Do not reconnect if controller is being deleted */
>>> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
>>> +		return;
>>> +
>>> +	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
>>> +		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
>>> +		return;
>>> +	}
>>> +
>>> +	nvme_fc_reconnect_or_delete(ctrl, -ENOTCONN);
>>> +}
>>
>> This code and that in nvme_fc_reset_ctrl_work() need to be collapsed
>> into a common helper function invoked by the 2 routines.  Also addresses
>> the missing flush_delayed work in this routine.
>>
> 
> Agree, nvme_fc_error_recovery() and nvme_fc_reset_ctrl_work() have
> common code that can be refactored. However, I do not plan to do this
> part of this change. I will take a look after I get CCR work done.

Don't put it off. You are adding as much code as the refactoring is. 
Just make the change.

-- james



