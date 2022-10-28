Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A4CECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 13:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a9IAAOe1w/g9cqBzA2zrXmIFFqm2u5XuO042YeLaLhk=; b=K7aeNnqQG2chX/HBAQ8U6I9QH4
	k5bsMbl6pf17m2tsGGDxJ8nzODOY43L5YYjCY52N23PCuZrjh5bryac4rTaOQ/ppfVnp+h7dOVXw9
	x1Pp60/NOQYAvAyF06DVvE3sFT3AlgbHfKvI9cR2vxcRgzA00zzrMTq0EJyuQhhJ7JfH6bEUGZn+I
	BIH2ve14SSeR1YBaNxFeQRkxcRrPe31PB3bWg92+1VoxEOpeuL1kreYiZ2+z+PfAq6tQkFVghqdav
	h4p8xLshBpEkSABCVN2uLkH0jMDDJzskWyR9fB1Qc7WNNH3KwAmYP9ThGYv7+NANnHv2yfwWJ6rJq
	tNq1jMtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooPmn-00HSxU-KH; Fri, 28 Oct 2022 13:52:37 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooPmk-00HSvF-5U
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 13:52:35 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D7E0E21B81;
	Fri, 28 Oct 2022 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666965152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9IAAOe1w/g9cqBzA2zrXmIFFqm2u5XuO042YeLaLhk=;
	b=RHqCNIX3sE9meZhrBOmlGHKBXTAkHhL9mwPC6xf3h+kK8AE9hRAFmEIIjtUjfVtKYsR8Ae
	TlzMdAGvb88oAhdqA/NPmCAMPpmFdpoZBUp0f7nKqCxNDVFDRGOQNnOS4uXHGAPRcfpHFn
	zn3IDgSuLY1dBGiGu04CS4jDrCltam0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666965152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9IAAOe1w/g9cqBzA2zrXmIFFqm2u5XuO042YeLaLhk=;
	b=wsZVMsBE+vHbXpLCbFdQF37ZbX8J8pdlxYd4ZSMEeScJDNEzYWkgeGQdqcahoIZOsTg85+
	4lI0++04eAjcu2Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA99E1377D;
	Fri, 28 Oct 2022 13:52:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Sp0nMaDeW2McIAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 28 Oct 2022 13:52:32 +0000
Message-ID: <6707fca1-e0b0-98b3-eb51-3859df0f2c7a@suse.de>
Date: Fri, 28 Oct 2022 15:52:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: bad unlock balance WARNING at nvme/045
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20221018080350.zir6xm6dnr4wgb7j@shindev>
 <93e16b0e-4fa0-c0e1-6cc5-dec018db5f5c@grimberg.me>
 <853f0eb7-1f0f-eefe-fd32-0b1a1a98d3d7@suse.de>
 <20221026120150.luck4dinfvhrw7se@shindev>
 <dfcff06c-f645-a80e-f96d-41bdfb81afa3@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <dfcff06c-f645-a80e-f96d-41bdfb81afa3@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_065234_372102_29E2067D 
X-CRM114-Status: GOOD (  20.98  )
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

On 10/26/22 14:38, Sagi Grimberg wrote:
> 
[ .. ]
>> Hannes, thanks for the explanations.
>>
>>>
>>> Can you check if this fix works?
>>>
>>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>>> index c8a6db7c4498..4e824aab30eb 100644
>>> --- a/drivers/nvme/host/auth.c
>>> +++ b/drivers/nvme/host/auth.c
>>> @@ -926,7 +926,6 @@ void nvme_auth_reset(struct nvme_ctrl *ctrl)
>>>
>>>          mutex_lock(&ctrl->dhchap_auth_mutex);
>>>          list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
>>> -               mutex_unlock(&ctrl->dhchap_auth_mutex);
>>>                  flush_work(&chap->auth_work);
>>>                  __nvme_auth_reset(chap);
>>>          }
>>
>> I confirmed this hunk avoids the "WARNING: bad unlock balance 
>> detected!". As far
>> as I ran blktests with this change, I observe no failure in other test 
>> cases.
>>
>> However, I observed another new WARN at nvme/045: "WARNING: possible 
>> recursive
>> locking detected". I think it was caused by nvme_dhchap_auth_work in 
>> nvme_wq
>> tried to flush another work __nvme_auth_work in the same workqueue. I 
>> created a
>> patch below which creates another workqueue nvme_auth_wq for 
>> __nvme_auth_work.
>> Do you think this fix approach is acceptable?
> 
> It is fine to flush work on the same workqueue, the problem is that they
> share the same lock.
> 
> I think what we should do is:
> 1. have chap contexts in an array and not a list so we don't need
> to traverse to locate a context.
> 2. omit the dhchap_auth_mutex as I don't see a need to protect the
> array.
> 3. synchronize only the chap context itself, either with a lock, or
> a flag, or a state (atomic).
> 4. get rid of long lived allocations, it is not optimizing a whole lot
> imho, and right now we are reserving something like 5k per queue.
> 5. add one more synchronization between chap and ctrl accessing the keys
> 

I've now send a patchset which should addressing this; can you check if
that's what you had in mind?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer


