Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA6BEB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JFzfHMTqr6YQ8xq2j9uJ0vBBpamU5TelaOrYXjfC+I4=; b=m+Dwg4q3Xh3jIM2RvwUkQ9iUJM
	Ig8un/CbuyNIB6NEy5ee2QB+S2p0gQj+N7Wa7QIld0WzBT7zuWMEFBr+z/Rt5wEgaAExVRbATHB2E
	e1OxeiBAcm6A30ME63B7Qbd8YFhjh+Kiskv059ct2ZpGvCWn0U5Lp2l74SSJzznKfjRRpMLkt+Ijp
	DWkKuLudfQ93E+4/ToHP/AJ0hPOLxP0T8cj3z1sgWPsaBqzpbUestDKeuIg0/23uabTZiuhaan5qk
	XevQ35Zw3pGZL/t8SDqYIDhVgI/mrzaER3Kc9NpeDgl1IWIG2No5HcPZjkhx+6/PiSOxsjPEdIj58
	bEUiicIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTjBI-004zbY-0p;
	Wed, 09 Aug 2023 13:24:56 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTjBE-004zar-30
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 13:24:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB9C81F38A;
	Wed,  9 Aug 2023 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691587491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFzfHMTqr6YQ8xq2j9uJ0vBBpamU5TelaOrYXjfC+I4=;
	b=nHFDdjCSVbx0zDuFcTl39K9sQCJzoQoFLfZS5k6ikrMVzuraI8lkXqCZqqO9hF4OvxF8Xu
	W8D5u1z8FxM14/SP+O62orF4oAMLPs5wMYykkfcyA+7aOu1gZ8/fW7MTTsI0VWt2+a7FCx
	dbX5N8y7/xtptLjhy6iySOlS0KivHLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691587491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFzfHMTqr6YQ8xq2j9uJ0vBBpamU5TelaOrYXjfC+I4=;
	b=gDo+OTwUass6HTSL56cMYU3rZq0txJzZtJncgRSPsFT+GbD7XttpHj92DAuYW7WX7j7jQV
	fwarFbBznbI8qGDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B16313251;
	Wed,  9 Aug 2023 13:24:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NPB3JaOT02TmDQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Aug 2023 13:24:51 +0000
Message-ID: <64acac73-c9a9-b044-8e9b-12f6d9418b2e@suse.de>
Date: Wed, 9 Aug 2023 15:24:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-16-hare@suse.de>
 <e28dffb6-66bd-2724-6c9d-f06e5da75aeb@grimberg.me>
 <9a331c99-a2e3-6c4e-5d4c-a41bfeb8e741@suse.de>
 <7c484503-dc86-e5d2-96c8-e90ec7a1c3bb@grimberg.me>
 <8afb1865-ae77-5fc1-a63b-cc3fda9ffdf8@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8afb1865-ae77-5fc1-a63b-cc3fda9ffdf8@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_062453_110902_0096A5C5 
X-CRM114-Status: GOOD (  13.22  )
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

On 8/9/23 14:54, Sagi Grimberg wrote:
> 
> 
> On 8/9/23 15:51, Sagi Grimberg wrote:
>>
>>>>> @@ -1621,6 +1642,75 @@ static int nvmet_tcp_set_queue_sock(struct 
>>>>> nvmet_tcp_queue *queue)
>>>>>       return ret;
>>>>>   }
>>>>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>>>>> +static void nvmet_tcp_tls_handshake_done(void *data, int status,
>>>>> +                     key_serial_t peerid)
>>>>> +{
>>>>> +    struct nvmet_tcp_queue *queue = data;
>>>>> +
>>>>> +    pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
>>>>> +         queue->idx, peerid, status);
>>>>> +    spin_lock_irq(&queue->state_lock);
>>>>> +    if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
>>>>> +        pr_warn("queue %d: TLS handshake already completed\n",
>>>>> +            queue->idx);
>>>>> +        spin_unlock_irq(&queue->state_lock);
>>>>> +        return;
>>>>> +    }
>>>>> +    if (!status)
>>>>> +        queue->tls_pskid = peerid;
>>>>> +    queue->state = NVMET_TCP_Q_CONNECTING;
>>>>> +    spin_unlock_irq(&queue->state_lock);
>>>>> +
>>>>> +    cancel_delayed_work_sync(&queue->tls_handshake_work);
>>>>> +    if (status) {
>>>>
>>>> I think that after this call, you cannot reference anything
>>>> in queue as it may have been released. Or I'm missing something?
>>>>
>>> I guess I can, as this code is gated by the state change above.
>>> Once we are here the state has been updated, so the timeout work will
>>> short circuit and not delete the queue.
>>
>> But who guarantees that queue->state_lock is a valid dereference?
> 
> The lock acquired in the first line of the function...
> 
> I think we need a reference count here...

Or use:

static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
{
         spin_lock_irq(&queue->state_lock);
         if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE &&
             queue->state != NVMET_TCP_Q_DISCONNECTING) {
                 queue->state = NVMET_TCP_Q_DISCONNECTING;
                 queue_work(nvmet_wq, &queue->release_work);
         }
         spin_unlock_irq(&queue->state_lock);
}

Such that release_queue will be ignored when a socket state change
happens while handshake is in progress.
Handshake will complete with done or timeout, both of which will
call schedule_release_queue() (with the corrrect state) on error.

Cheers,

Hannes


