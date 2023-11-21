Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E658FC5ACB3
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Nov 2023 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iGM3BkDXI2WBcWy9TXRPOvDWNhVerJSmvZBTSTVVML8=; b=idmx928WTPiHcOl08MweL9foHY
	I/AUz3izcfe9tc+j4gYcm4bv4xH5dGrObT9uljm1sDCKxjSsWYlfIeE9fzN58+4Ax8LV2Gw7901IR
	feOSDOxLs8hg6ih2Eivf+uvBMfBdfQ26prLcA5J7J5c948uwI2Poiurzb3pAvbkhb8ohpzjsboZ4h
	4g2wYdoGY+IVvXmAIlXtIiepRjfGOqpzk2kcGCyjacfySN1v0E5mjUQQw1gBkY/gWQjHl0E34fVpX
	1myxGDtQ396kHKMFm3gm7Vj3XqNCQhSu08WD7BPTKsmc2iay/rVOZRbCO8uSqcsFqDEkWIIH4kIuE
	vI7xEXFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5LC4-00FtLu-1v;
	Tue, 21 Nov 2023 07:29:12 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5LC1-00FtLS-2M
	for linux-nvme@lists.infradead.org;
	Tue, 21 Nov 2023 07:29:11 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF2AA1F8A8;
	Tue, 21 Nov 2023 07:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700551745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGM3BkDXI2WBcWy9TXRPOvDWNhVerJSmvZBTSTVVML8=;
	b=ESr5jJgKeETKaLh3L0UjasBou+4CPt1Pz0v5vdSJHuZ7AhOP4xQDNJuO13WoGKSLO5bWfO
	SqHJpgqsehyn+2C1Wgb4bMo/59NqgYo2uuw8Qz2O9vj6qziL4oc6GTcAhRN0PB+J0CijPT
	Aj2PkqZtr0/N2zopIWhg1wEQUenRzYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700551745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGM3BkDXI2WBcWy9TXRPOvDWNhVerJSmvZBTSTVVML8=;
	b=4f/7JwUa2dDYpVhXBE9eWOAJtZLWuIBrM/FZAEqgeaZ9fy1J25BaqbvtJptMp7vtvJcNQY
	3i4hPLsGmyotb+Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D18B138E3;
	Tue, 21 Nov 2023 07:29:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id idbRIEFcXGUbagAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 21 Nov 2023 07:29:05 +0000
Message-ID: <c4539237-0740-4f92-a7d6-eebf825a66b0@suse.de>
Date: Tue, 21 Nov 2023 08:29:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: start keep-alive after admin queue setup
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20231024061337.35621-1-hare@suse.de>
 <20231024061337.35621-4-hare@suse.de>
 <a1ce2c2e-4f67-4271-ac67-5a1e8c5ebfb1@grimberg.me>
 <337014e5-f564-4f0e-8c3c-298156aa82f3@suse.de>
 <7401e53a-59b8-41d5-8055-600725ecee06@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <7401e53a-59b8-41d5-8055-600725ecee06@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
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
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_232910_070845_D16A66A1 
X-CRM114-Status: GOOD (  21.23  )
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

On 11/20/23 20:05, Sagi Grimberg wrote:
> 
> 
> On 11/20/23 18:01, Hannes Reinecke wrote:
>> On 11/20/23 14:39, Sagi Grimberg wrote:
>>>
>>>> Setting up I/O queues might take quite some time on larger and/or
>>>> busy setups, so KATO might expire before all I/O queues could be
>>>> set up.
>>>> Fix this by start keep alive from the ->init_ctrl_finish() callback,
>>>> and stopping it when calling nvme_cancel_admin_tagset().
>>>
>>> If this is a fix, the title should describe the issue it is fixing, and
>>> the body should say how it is fixing it.
>>>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>> ---
>>>>   drivers/nvme/host/core.c | 6 +++---
>>>>   drivers/nvme/host/fc.c   | 6 ++++++
>>>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>> index 62612f87aafa..f48b4f735d2d 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -483,6 +483,7 @@ EXPORT_SYMBOL_GPL(nvme_cancel_tagset);
>>>>   void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
>>>>   {
>>>> +    nvme_stop_keep_alive(ctrl);
>>>>       if (ctrl->admin_tagset) {
>>>>           blk_mq_tagset_busy_iter(ctrl->admin_tagset,
>>>>                   nvme_cancel_request, ctrl);
>>>
>>> There is a cross dependency here, now nvme_cancel_admin_tagset needs to
>>> have the keep-alive stopped first, which may be waiting on I/O, which
>>> needs to be cancelled...
>>>
>>> Keep in mind that kato can be arbitrarily long, and now this function
>>> may be blocked on this kato period.
>>>
>>> I also think that now the function is doing something that is more
>>> than simply cancelling the inflight admin tagset, as it is named.
>>>
>> I am having a hard time following this reasoning.
>> While I do accept that nvme_stop_keep_alive() might trigger I/O
>> (ie if the work queue has just been started when calling 
>> cancel_delayed_work), nvme_tcp_error_recovery_work() has this:
>>
>>      nvme_stop_keep_alive(ctrl);
>>      flush_work(&ctrl->async_event_work);
>>      nvme_tcp_teardown_io_queues(ctrl, false);
>>      /* unquiesce to fail fast pending requests */
>>      nvme_unquiesce_io_queues(ctrl);
>>      nvme_tcp_teardown_admin_queue(ctrl, false);
>>
>> and nvme_tcp_teardown_admin_queue() calls nvme_cancel_admin_tagset().
>> So by your above reasoning this code should be wrong, too.
>> What am I missing?
> 
> Need to dig through the history, but it can most definitely move to
> after the teardown. It could be from the earlier days where the
> transport fencing was not as reliable particularly for admin requests.

Ah, no. We are both wrong. Colophon of cancel_delayed_work():

  * Note:
  * The work callback function may still be running on return, unless
  * it returns %true and the work doesn't re-arm itself.  Explicitly 
flush or
  * use cancel_delayed_work_sync() to wait on it.

Hence we won't be blocked by running I/O when calling 
nvme_stop_keep_alive().
So the correct syntax would indeed be calling nvme_stop_keep_alive()
first, and then disable/cancel the admin tagset (which will terminate
any outstanding keep-alive requests).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


