Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C13E8B383
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 00:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I9EEEu6uU7KXJpV7HUZ/N7aVHWqba3rbYIfABkEZfiA=; b=yZFb0wm6LW8UuMZ/Z6jN0Tvgms
	X2Jx/USfYnj/dIsow5q9t92MCBIlAhoj8+I7uTFh1yWtHL/ASBXl7VSTR3DYXJD9sbWtRWNC1OXVi
	5Ni69IEokepmuyik433G1fc4FjC6kCA8QySnujWcLKOcTLA6gpsFwbJdQD3b1zfMy8x5WwF8LgMGd
	jSewQ4cY8gPYnGpoMAnkdJdpMN0B/Bj+Pte2lIcZyhtHpWi0b+tQII2oUljDzu8Vm2oO5F8NnJK7H
	NHjehyIOsJEMcZ2LWpvbTcRB+1VgXWR1XJBDXw7uQl0E1N/Yy1EeCAk+u4Fbqk/O1Y546KRjBdug8
	rqrWmkfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnQrJ-00000007dLv-1Yaj;
	Wed, 04 Feb 2026 00:35:05 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnQrF-00000007dL3-3Tnx
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 00:35:03 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63A0D3E6CF;
	Wed,  4 Feb 2026 00:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770165298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9EEEu6uU7KXJpV7HUZ/N7aVHWqba3rbYIfABkEZfiA=;
	b=rb1Kl3bYN8XGbbzrcgmseKbz9q/Wh9zYWpYimYokdqxfNCdlNV6rPzL/atLOmkBU513Tn7
	TMSMyOqtBMMWdNYPddRoxvktXRZoYiqKSU7Y/sMmlluWhgcQQ+azw+qMeqd68crVn3L/bF
	zafcWbMYdxn8tfZbpMU0Klg3bF2ekbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770165298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9EEEu6uU7KXJpV7HUZ/N7aVHWqba3rbYIfABkEZfiA=;
	b=4d9cM59B1LwfbTSsdVyw/cMBVLd6Pq0ZS/mmBKmyyymgyb/9iguK1hGP+UUcGhopwaxMk9
	SK1gKHpByJIhJ2Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rb1Kl3bY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4d9cM59B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770165298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9EEEu6uU7KXJpV7HUZ/N7aVHWqba3rbYIfABkEZfiA=;
	b=rb1Kl3bYN8XGbbzrcgmseKbz9q/Wh9zYWpYimYokdqxfNCdlNV6rPzL/atLOmkBU513Tn7
	TMSMyOqtBMMWdNYPddRoxvktXRZoYiqKSU7Y/sMmlluWhgcQQ+azw+qMeqd68crVn3L/bF
	zafcWbMYdxn8tfZbpMU0Klg3bF2ekbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770165298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9EEEu6uU7KXJpV7HUZ/N7aVHWqba3rbYIfABkEZfiA=;
	b=4d9cM59B1LwfbTSsdVyw/cMBVLd6Pq0ZS/mmBKmyyymgyb/9iguK1hGP+UUcGhopwaxMk9
	SK1gKHpByJIhJ2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F10C3EA63;
	Wed,  4 Feb 2026 00:34:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UY1eFy2Ugmn5KQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Feb 2026 00:34:53 +0000
Message-ID: <b695a3f5-bfb9-4215-9672-47abf7e35cdf@suse.de>
Date: Wed, 4 Feb 2026 01:34:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] nvmet: Rapid Path Failure Recovery set
 controller identify fields
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
 <20260130223531.2478849-2-mkhalfella@purestorage.com>
 <59a8d510-d06d-4d35-b911-c758c184df52@suse.de>
 <20260203181457.GA3729-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260203181457.GA3729-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email,purestorage.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 63A0D3E6CF
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_163502_027621_6FDDA052 
X-CRM114-Status: GOOD (  34.35  )
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

On 2/3/26 19:14, Mohamed Khalfella wrote:
> On Tue 2026-02-03 04:03:22 +0100, Hannes Reinecke wrote:
>> On 1/30/26 23:34, Mohamed Khalfella wrote:
>>> TP8028 Rapid Path Failure Recovery defined new fields in controller
>>> identify response. The newly defined fields are:
>>>
>>> - CIU (Controller Instance UNIQUIFIER): is an 8bit non-zero value that
>>> is assigned a random value when controller first created. The value is
>>> expected to be incremented when RDY bit in CSTS register is asserted
>>> - CIRN (Controller Instance Random Number): is 64bit random value that
>>> gets generated when controller is crated. CIRN is regenerated everytime
>>> RDY bit is CSTS register is asserted.
>>> - CCRL (Cross-Controller Reset Limit) is an 8bit value that defines the
>>> maximum number of in-progress controller reset operations. CCRL is
>>> hardcoded to 4 as recommended by TP8028.
>>>
>>> TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
>>> Time) which is used along with KATO (Keep Alive Timeout) to set an upper
>>> time limit for attempting Cross-Controller Recovery. For NVME subsystem
>>> CQT is set to 0 by default to keep the current behavior. The value can
>>> be set from configfs if needed.
>>>
>>> Make the new fields available for IO controllers only since TP8028 is
>>> not very useful for discovery controllers.
>>>
>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>> ---
>>>    drivers/nvme/target/admin-cmd.c |  6 ++++++
>>>    drivers/nvme/target/configfs.c  | 31 +++++++++++++++++++++++++++++++
>>>    drivers/nvme/target/core.c      | 12 ++++++++++++
>>>    drivers/nvme/target/nvmet.h     |  4 ++++
>>>    include/linux/nvme.h            | 15 ++++++++++++---
>>>    5 files changed, 65 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
>>> index 3da31bb1183e..ade1145df72d 100644
>>> --- a/drivers/nvme/target/admin-cmd.c
>>> +++ b/drivers/nvme/target/admin-cmd.c
>>> @@ -696,6 +696,12 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>>>    
>>>    	id->cntlid = cpu_to_le16(ctrl->cntlid);
>>>    	id->ver = cpu_to_le32(ctrl->subsys->ver);
>>> +	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
>>> +		id->cqt = cpu_to_le16(ctrl->cqt);
>>> +		id->ciu = ctrl->ciu;
>>> +		id->cirn = cpu_to_le64(ctrl->cirn);
>>> +		id->ccrl = NVMF_CCR_LIMIT;
>>> +	}
>>>    
>>>    	/* XXX: figure out what to do about RTD3R/RTD3 */
>>>    	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
>>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>>> index e44ef69dffc2..035f6e75a818 100644
>>> --- a/drivers/nvme/target/configfs.c
>>> +++ b/drivers/nvme/target/configfs.c
>>> @@ -1636,6 +1636,36 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
>>>    CONFIGFS_ATTR(nvmet_subsys_, attr_pi_enable);
>>>    #endif
>>>    
>>> +static ssize_t nvmet_subsys_attr_cqt_show(struct config_item *item,
>>> +					  char *page)
>>> +{
>>> +	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->cqt);
>>> +}
>>> +
>>> +static ssize_t nvmet_subsys_attr_cqt_store(struct config_item *item,
>>> +					   const char *page, size_t cnt)
>>> +{
>>> +	struct nvmet_subsys *subsys = to_subsys(item);
>>> +	struct nvmet_ctrl *ctrl;
>>> +	u16 cqt;
>>> +
>>> +	if (sscanf(page, "%hu\n", &cqt) != 1)
>>> +		return -EINVAL;
>>> +
>>> +	down_write(&nvmet_config_sem);
>>> +	if (subsys->cqt == cqt)
>>> +		goto out;
>>> +
>>> +	subsys->cqt = cqt;
>>> +	/* Force reconnect */
>>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
>>> +		ctrl->ops->delete_ctrl(ctrl);
>>> +out:
>>> +	up_write(&nvmet_config_sem);
>>> +	return cnt;
>>> +}
>>> +CONFIGFS_ATTR(nvmet_subsys_, attr_cqt);
>>> +
>>>    static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
>>>    					      char *page)
>>>    {
>>> @@ -1676,6 +1706,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
>>>    	&nvmet_subsys_attr_attr_vendor_id,
>>>    	&nvmet_subsys_attr_attr_subsys_vendor_id,
>>>    	&nvmet_subsys_attr_attr_model,
>>> +	&nvmet_subsys_attr_attr_cqt,
>>>    	&nvmet_subsys_attr_attr_qid_max,
>>>    	&nvmet_subsys_attr_attr_ieee_oui,
>>>    	&nvmet_subsys_attr_attr_firmware,
>>
>> I do think that TP8028 (ie the CQT defintions) are somewhat independent
>> on CCR. So I'm not sure if they should be integrated in this patchset;
>> personally I would prefer to have it moved to another patchset.
> 
> Agreed that CQT is not directly related to CCR from the target
> perspective. But there is a relationship when it comes to how the
> initiator uses CQT to calculate the time budget for CCR. As you know on
> the host side if CCR fails and CQT is supported the requests needs to be
> held for certain amount of time before they are retried. So CQT value is
> needed and that I why I included it in this patchset.
> 
Oh, I don't disagree that CQT is needed to get full spec compliance.
But my point here is that there is no requirement that we need to
achieve full spec compliance _with this patchset_.
We are not compliant with the current implementation, and we don't
lose anything if we stay non-compliant after this patch.
 From my POV CCR is about resetting controllers and aborting commands,
and CQT is about inserting a delay before retrying commands.
And there is no dependency between those two; you can send CCR
without inserting a delay before retrying, and you can insert a
delay before retrying commands without having sent CCR.
So we should have two patchsets here. And of course, the
CQT patchset should be based on the CCR patchset.
But there is no requirements to have both in a single patchset.

>>
>>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>>> index cc88e5a28c8a..0d2a1206e08f 100644
>>> --- a/drivers/nvme/target/core.c
>>> +++ b/drivers/nvme/target/core.c
>>> @@ -1393,6 +1393,10 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
>>>    		return;
>>>    	}
>>>    
>>> +	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
>>> +		ctrl->ciu = ((u8)(ctrl->ciu + 1)) ? : 1;
>>> +		ctrl->cirn = get_random_u64();
>>> +	}
>>>    	ctrl->csts = NVME_CSTS_RDY;
>>>    
>>>    	/*
>>> @@ -1661,6 +1665,12 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>>>    	}
>>>    	ctrl->cntlid = ret;
>>>    
>>> +	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
>>> +		ctrl->cqt = subsys->cqt;
>>> +		ctrl->ciu = get_random_u8() ? : 1;
>>> +		ctrl->cirn = get_random_u64();
>>> +	}
>>> +
>>>    	/*
>>>    	 * Discovery controllers may use some arbitrary high value
>>>    	 * in order to cleanup stale discovery sessions
>>> @@ -1853,10 +1863,12 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>>>    
>>>    	switch (type) {
>>>    	case NVME_NQN_NVME:
>>> +		subsys->cqt = NVMF_CQT_MS;
>>>    		subsys->max_qid = NVMET_NR_QUEUES;
>>>    		break;
>>
>> And I would not set the CQT default here.
>> Thing is, implementing CQT to the letter would inflict a CQT delay
>> during failover for _every_ installation, thereby resulting in a
>> regression to previous implementations where we would fail over
>> with _no_ delay.
>> So again, we should make it a different patchset.
> 
> CQT defaults to 0 to avoid introducing surprise delay. The initiator will
> skip holding requests if it sees CQT set to 0.

Precisely my point. If CQT defaults to zero no delay will be inserted,
but we _still_ have CCR handling. Just proving that both really are
independent on each other. Hence I would prefer to have two patchsets.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

