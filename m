Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6C9C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 05:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BlP0QSJn/fTPCvCGa02IHH704wzW2BLqxXyNh3o3xJk=; b=qXuxvZ0NXbystVIcZMYoIikJUo
	mYCeuf7oU97Zq4dF3IfkVL7nnZgbngWWksTp1DhFlR866hooLiS4oARum7DkSlUm4jmS01/FQH+xU
	to+ZtIeZ07nw1Hm+eu6bRhTnG/LPqja0DTJS4Toq/vP3STRM8FHVoK2AdNPUNgHAnAIRg2j/4yGJh
	1Dij4RkquChY1zZZs8NVtDQ3bPBreivqvFal2s9Y7bHq9mDoSIhCEsQMoG+j0M3/Mwbgk44e5VOAM
	BqbOMwFvhKloMVJ0bnHV+yjc0bO42EI/T+tLRIpV6S64rMcak3WxSSCHfP3DRNmry9non0laJ2l4L
	oJcKu4aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3t9m-008dW4-1A; Wed, 22 Jun 2022 05:44:02 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3t9i-008dVG-L6
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 05:44:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 752D01F9FB;
	Wed, 22 Jun 2022 05:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655876636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BlP0QSJn/fTPCvCGa02IHH704wzW2BLqxXyNh3o3xJk=;
	b=V8q7LzbSu8uvUcEpqTRWqcw3LwZOrg3iazNq3x25oz1AOo8wcj8J6pzLC4ITYpIUWkoqBh
	Ux7yNBxHxVhxJP+infjIGqTEmh7zbAeItEHvwRn3OA10MY8WjFyC0zdCfYvG52krgLRtuz
	K/vryq6bvjhrMT0YOrz0sdT4YvU4vAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655876636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BlP0QSJn/fTPCvCGa02IHH704wzW2BLqxXyNh3o3xJk=;
	b=Z2fbEM6tXfhTIDxcwO1U0GUtHRg24MsrcEAQa//4Wz4EEceBEoEZwkfzQlPZXwYLijQXcm
	LehYnovUzo8Ut0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46D411342C;
	Wed, 22 Jun 2022 05:43:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Lj2HDxyssmLNOQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 22 Jun 2022 05:43:56 +0000
Message-ID: <191781ac-6bec-e941-a80a-9a349698214c@suse.de>
Date: Wed, 22 Jun 2022 07:43:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621090255.69549-1-hare@suse.de>
 <20220621090255.69549-7-hare@suse.de>
 <f8f0a631-6752-096c-4e85-bcde9bb2869e@grimberg.me>
 <22236c51-90cd-1707-05b8-3772ef4c548d@suse.de>
 <ab4aaf2b-444f-2b3c-091a-396de62afbd1@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ab4aaf2b-444f-2b3c-091a-396de62afbd1@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_224358_886635_95843091 
X-CRM114-Status: GOOD (  11.96  )
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

On 6/21/22 16:50, Sagi Grimberg wrote:
> 
> 
> On 6/21/22 17:26, Hannes Reinecke wrote:
>> On 6/21/22 16:24, Sagi Grimberg wrote:
>>> This one doesn't compile against nvme-5.20.
>>>
>>>> +    ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len, 0,
>>>> +                     qid == 0 ? NVME_QID_ANY : qid,
>>>> +                     0, flags);
>>>
>>> here ^^^^^^^
>>
>> Sheesh. I've compiled it against nvme-5.19, where it works perfectly.
>> Alright, once more unto the breach ...
> 
> Looks like if I pass a malformed ctrl key to nvme connect I am able to
> crash the system:
> -- 
> [   84.793307] Workqueue: nvme-wq __nvme_auth_work [nvme_core]
> [   84.794790] RIP: 0010:nvme_auth_transform_key+0x19/0x1f0 [nvme_common]
> [   84.796468] Code: bc f4 ff ff ff eb bf e8 f5 2f e1 ee 0f 1f 44 00 00 
> 0f 1f 44 00 00 41 57 41 56 41 55 49 89 f5 41 54 55 53 48 89 fb 48 83 ec 
> 08 <0f> b6 7f 10 e8 ce f9 ff ff 48 89 c7 0f b6 43 10 84 c0 0f 84 4c 01
> [   84.800112] RSP: 0018:ffffae5f8047bc78 EFLAGS: 00010296
> [   84.801048] RAX: ffff973b854ca0c0 RBX: 0000000000000000 RCX: 
> 0000000000000000
> [   84.802289] RDX: ffff973b8355b000 RSI: ffff973b84f568a0 RDI: 
> 0000000000000000
> [   84.803447] RBP: ffff973b842dd6b9 R08: 0000000000000003 R09: 
> ffff973bbec308a8
> [   84.804638] R10: 0000000000000147 R11: 0000000000000000 R12: 
> ffff973b842dd600
> [   84.805767] R13: ffff973b84f568a0 R14: 0000000000000000 R15: 
> ffff973b9e94250d
> [   84.806929] FS:  0000000000000000(0000) GS:ffff973bbec00000(0000) 
> knlGS:0000000000000000
> [   84.808220] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   84.809178] CR2: 0000000000000010 CR3: 00000000061ac003 CR4: 
> 0000000000370ef0
> [   84.810337] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [   84.811432] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [   84.812527] Call Trace:
> [   84.812974]  <TASK>
> [   84.813372]  nvme_auth_dhchap_setup_ctrl_response+0x4b/0x3b0 [nvme_core]
> [   84.814355]  ? preempt_count_add+0x68/0xa0
> [   84.815080]  ? _raw_spin_unlock_irq+0x16/0x28
> [   84.815840]  ? __wait_for_common+0x19f/0x1d0
> [   84.816587]  ? firmware_map_remove+0x87/0x87
> [   84.817333]  ? blk_mq_hctx_has_pending+0x38/0x70
> [   84.818123]  ? blk_mq_run_hw_queue+0x7d/0xe0
> [   84.818784]  ? __blk_mq_free_request+0x9b/0xa0
> [   84.819482]  ? blk_queue_exit+0xe/0x40
> [   84.820124]  ? __nvme_submit_sync_cmd+0xe8/0x160 [nvme_core]
> [   84.821096]  ? nvme_auth_submit+0x8f/0xd0 [nvme_core]
> [   84.821970]  __nvme_auth_work+0x1fb/0x480 [nvme_core]
> [   84.822869]  process_one_work+0x1e5/0x3b0
> [   84.823608]  worker_thread+0x1c4/0x3a0
> [   84.824343]  ? rescuer_thread+0x390/0x390
> [   84.825044]  kthread+0xe8/0x110
> -- 

Malformed exactly how?
We should've captured any malformed key during nvme_auth_extract_key().
Can you share an example of your malformed key?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

