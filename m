Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823AFC5AD4C
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 15:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6LTZeb1LDAUm8n/XMwcrZoMM17yZ3F6BlGfYIuXeMUU=; b=fjZti1xrPdlfQzvJw4Ai6uuKXw
	SM5EdlbA6x+bOCzWI8h+EGCvqzHpQzhnMbDVgb3uFq3yR2IobNcmwU6VvXOSwiw5cXI3B2yvo07z9
	saKzHJXXaP7Xm6jkgtr4sfuswMt8LxWY3wBth7T6ev+J+ZdifFk6aSOkuohRPLyi4xiEV4UJpntEm
	8KUozuHVo3n2amkr17+qqaPqvGNvUfmGkwbYyxJKL8C49hUMjHOXa7slgJEDNp1ey2n4mFaHi6ssX
	9QNxi6ILpV2rK39HdSD4APGMgxLUDc4MW2kMSNIyq4Ecj0YCSI3jL7wLkCJj95Rr6sBfIrT9JJVEi
	/6V18bLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r55q8-00CTr9-0m;
	Mon, 20 Nov 2023 15:05:32 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r55q2-00CTnn-2O
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 15:05:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 56BFF21941;
	Mon, 20 Nov 2023 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700492722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LTZeb1LDAUm8n/XMwcrZoMM17yZ3F6BlGfYIuXeMUU=;
	b=KUoPAtvi2dksK0oHQiOF84h/j90SRiTBaf9+hFA1nRUTXglvvRII+NHl0ZTM/zNVxkYxCc
	Ox4CaNUi7zOKO8A2hOWmbQ0ocHLKrA44QNdCkx9ulV22k4xTmgjOcbeOrZ9231DsPMUqp0
	XMfNQ5/NnXbB9Xmg8bPW9D8JME/MtAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700492722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LTZeb1LDAUm8n/XMwcrZoMM17yZ3F6BlGfYIuXeMUU=;
	b=J8uOygx3VIw+PH8iX4m6OLuNo38A3FFWD0S+v4C5Tpb1cbRT+Syhhej3kz3t1dTWlSdULr
	G0j6dHeApw6osABQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CC5D134AD;
	Mon, 20 Nov 2023 15:05:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ePc8BbJ1W2V2OwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 20 Nov 2023 15:05:22 +0000
Message-ID: <c12357a6-bb33-42ab-9e8c-c7dced7a10f1@suse.de>
Date: Mon, 20 Nov 2023 16:05:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: start keep-alive after admin queue setup
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20231024061337.35621-1-hare@suse.de>
 <20231024061337.35621-4-hare@suse.de>
 <a1ce2c2e-4f67-4271-ac67-5a1e8c5ebfb1@grimberg.me>
 <3b2164c7-961e-4cfb-bff9-517e7b77fd61@suse.de>
 <828693f2-1aa5-416a-9d9c-e1a1e9edcf2c@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <828693f2-1aa5-416a-9d9c-e1a1e9edcf2c@grimberg.me>
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
X-CRM114-CacheID: sfid-20231120_070527_268121_0887801C 
X-CRM114-Status: GOOD (  23.01  )
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

On 11/20/23 15:25, Sagi Grimberg wrote:
> 
> 
> On 11/20/23 16:19, Hannes Reinecke wrote:
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
>> Hmm. I could move it out of cancel_admin_tagset(). It means that I'll
>> have to touch each transport driver, but as I have to touch at least
>> fc anyway I guess it's okay.
>>
>>>> @@ -3200,6 +3201,8 @@ int nvme_init_ctrl_finish(struct nvme_ctrl 
>>>> *ctrl, bool was_suspended)
>>>>       clear_bit(NVME_CTRL_DIRTY_CAPABILITY, &ctrl->flags);
>>>>       ctrl->identified = true;
>>>> +    nvme_start_keep_alive(ctrl);
>>>> +
>>>
>>> I'm fine with moving it here. But instead, maybe just change
>>> nvme_start_keep_alive() to use a zero delay and keep it where it
>>> is? will that help?
>>>
>> Not really. We still will fail if setting up I/O queues takes longer
>> than the KATO period.
> 
> Why? Is this specific for non-tbkas? or very short kato?

Non-tbkas.

> because connect is effectively a command that should be counted as
> indication that the controller is fine.
> 
Yeah, indeed.

> If you are not able to connect even a single queue, I'd say something
> is wrong and it could be argued that you _want_ to fail.

This is in conjunction with authentication, where some controller 
implementations use external entities to calculate and/or validate the 
DH parameters. Which takes time.

Scenario is that the admin queue connects fine, but the I/O queues take
some time to setup, until eventually KATO fires before all queues are
established.
As you said, TBKAS should avoid this scenario, but non-TBKAS is still
a valid setup.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


