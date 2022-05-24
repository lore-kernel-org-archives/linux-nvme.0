Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E64C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 09:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4x/LgjJulZhqYx0fEl6jnh4utU0yMEuGDJI2kvryC4E=; b=zLytHgK8bkm/6gquRj0WhpAy6R
	sCfk1eiQ6WCT0LobR5zcA3KRAqbqp6ihMMMrpCu5kjnM+HmZ9igZN5GivHeJOmeDgcsCaGylmMgnj
	prCKtchfRfEapK3XS722Za2Qh2Bmjlv4UR502SJWl1pvcvnsD2dkoT+ZFI6imWpHRo9udLiI49CAy
	rO5x8YSkmbR017mVaGRga1XDszh43jkMNmAz3XZUhmWWVpIzBzrOCMxhZD/0u5nPMA5ydpfhcfcmO
	6bztaPmSaaGtKaH5p9zgCDLx5obRCsZjpI5P09W1/xiYxYcMI+qXlkyv2sBLUeR6zFJyJBzQLLbPP
	AKmB64NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntQw7-007QT0-EP; Tue, 24 May 2022 09:34:43 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntQw5-007QSb-4K
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 09:34:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A5E2F21A0D;
 Tue, 24 May 2022 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653384877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4x/LgjJulZhqYx0fEl6jnh4utU0yMEuGDJI2kvryC4E=;
 b=Lb6Xydl+2D3Z5Rs5QtvsBb/vWw77fq2c48Jm3BfeaLhVvhqVEsUzbxLAitEaSQXe/I3fDN
 3oBiVypv5f4HTgJipjJPmTI7jWGl9xWuoa/G0LzgthibrIIiF2Cy+KmaXoPzsS0EkkM85X
 85606qDB/zqeEi7gLDlfRP5SZOj+HIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653384877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4x/LgjJulZhqYx0fEl6jnh4utU0yMEuGDJI2kvryC4E=;
 b=NI+NjVtO6VX8XbVORk2NhTpm2lGh4K7HV7tALtFYMvg/dpJCXG3U1EvUC/Iz8DcJCgpqL8
 9z61ALZfuzu6TaAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A40E13ADF;
 Tue, 24 May 2022 09:34:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ggwKIa2mjGJHBwAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 24 May 2022 09:34:37 +0000
Message-ID: <582f08b6-ac55-b857-6a38-675b0b5810c8@suse.de>
Date: Tue, 24 May 2022 11:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/3] nvme-tcp: spurious I/O timeout under high load
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220519062617.39715-1-hare@suse.de>
 <20220519062617.39715-2-hare@suse.de>
 <7827d599-7714-3947-ee24-e343e90eee6e@grimberg.me>
 <96a3315f-43a4-efe6-1f37-0552d66dbd85@suse.de>
 <96722b37-f943-c3e4-ee6a-440f65e8afca@grimberg.me>
 <e749bb3e-2ff7-23f5-9f5f-974c986845b6@suse.de>
 <7ec792e3-5110-2272-b6fe-1a976c8c054f@grimberg.me>
 <919bfaa2-a35d-052a-1d35-9fdd8faa0d3f@suse.de>
 <02805f44-6f2d-b12e-c224-d44616332d5a@grimberg.me>
 <76475e4f-13c7-2e0c-8584-f46918f5cefa@suse.de>
 <ec08bc32-3ad3-fade-0acd-ae5d5ca3812f@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ec08bc32-3ad3-fade-0acd-ae5d5ca3812f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_023441_355049_EFF51923 
X-CRM114-Status: GOOD (  30.46  )
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

On 5/24/22 10:53, Sagi Grimberg wrote:
> 
>>>>>>>> I'm open to discussion what we should be doing when the request 
>>>>>>>> is in the process of being sent. But when it didn't have a 
>>>>>>>> chance to be sent and we just overloaded our internal queuing we 
>>>>>>>> shouldn't be sending timeouts.
>>>>>>>
>>>>>>> As mentioned above, what happens if that same reporter opens 
>>>>>>> another bug
>>>>>>> that the same phenomenon happens with soft-iwarp? What would you 
>>>>>>> tell
>>>>>>> him/her?
>>>>>>
>>>>>> Nope. It's a HW appliance. Not a chance to change that.
>>>>>
>>>>> It was just a theoretical question.
>>>>>
>>>>> Do note that I'm not against solving a problem for anyone, I'm just
>>>>> questioning if increasing the io_timeout to be unbound in case the
>>>>> network is congested, is the right solution for everyone instead of
>>>>> a particular case that can easily be solved with udev to make the
>>>>> io_timeout to be as high as needed.
>>>>>
>>>>> One can argue that this patchset is making nvme-tcp to basically
>>>>> ignore the device io_timeout in certain cases.
>>>>
>>>> Oh, yes, sure, that will happen.
>>>> What I'm actually arguing is the imprecise difference between 
>>>> BLK_STS_AGAIN / BLK_STS_RESOURCE as a return value from ->queue_rq()
>>>> and command timeouts in case of resource constraints on the driver 
>>>> implementing ->queue_rq().
>>>>
>>>> If there is a resource constrain driver is free to return 
>>>> BLK_STS_RESOURCE (in which case you wouldn't see a timeout) or 
>>>> accept the request (in which case there will be a timeout).
>>>
>>> There is no resource constraint. The driver sizes up the resources
>>> to be able to queue all the requests it is getting.
>>>
>>>> I could live with a timeout if that would just result in the command 
>>>> being retried. But in the case of nvme it results in a connection 
>>>> reset to boot, making customers really nervous that their system is 
>>>> broken.
>>>
>>> But how does the driver know that it is running in this environment that
>>> is completely congested? What I'm saying is that this is a specific use
>>> case that the solution can have negative side-effects for other common
>>> use-cases, because it is beyond the scope of the driver to handle.
>>>
>>> We can also trigger this condition with nvme-rdma.
>>>
>>> We could stay with this patch, but I'd argue that this might be the
>>> wrong thing to do in certain use-cases.
>>>
>> Right, okay.
>>
>> Arguably this is a workload corner case, and we might not want to fix 
>> this in the driver.
>>
>> _However_: do we need to do a controller reset in this case?
>> Shouldn't it be sufficient to just complete the command w/ timeout 
>> error and be done with it?
> 
> The question is what is special about this timeout vs. any other
> timeout?
> 
> pci attempts to abort the command before triggering a controller
> reset, Maybe we should also? although abort is not really reliable
> going on the admin queue...

I am not talking about NVMe abort.
I'm talking about this:

@@ -2335,6 +2340,11 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
                 "queue %d: timeout request %#x type %d\n",
                 nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);

+       if (!list_empty(&req->entry)) {
+               nvme_tcp_complete_timed_out(rq);
+               return BLK_EH_DONE;
+       }
+
         if (ctrl->state != NVME_CTRL_LIVE) {
                 /*
                  * If we are resetting, connecting or deleting we should


as the command is still in the queue and NVMe abort don't enter the 
picture at all.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

