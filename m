Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08A3C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 06:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5fRA7qudfidtdFLBOO+aiAH8e3TprfZSLlGsNWUXprk=; b=EN46R1xq6EOyvuRLUE5VOd6DUT
	beRk3hohlWWn2zE/JSvfQbLnTjkezfZMS4zFS+mlQqjvJETeLfaV4xoaRB9WOGFJkv60aPYCWI6vd
	CK4+q+BhMv9w3A3U2WPaGxUuI1WqZfkJOLwrEnQSKlPo/TcaII/T27gwfI7Sq+VAMc9WazCjbgtgR
	6vwi1jcxZBYGPtK4s3TYPZ9k4KwKQDIn31Re9Ur1JEjCHJWc0LAmSg5W5vW8tFYJo2m6egHF+PXV2
	UprYKXxDA04JerXBWCBbr+HUI8S2mEmlngeKDeTx/RZeL4jYvBVFQx8edY4d4ULiOVSleSvTlplrZ
	bkhfdk3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA1wO-00000005DGZ-1noP;
	Thu, 23 May 2024 06:28:40 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA1wF-00000005DFY-2Lfz
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 06:28:37 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A278E221D3;
	Thu, 23 May 2024 06:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716445708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fRA7qudfidtdFLBOO+aiAH8e3TprfZSLlGsNWUXprk=;
	b=yF0+EBx1wURqRhSPSctGLXxt9H6M+3mnkghA/pWP7OQ4UKfBk31g/qOFqYD6NDYYnN4qTl
	DR6FRAT2CWcaJ4e3cAVaICp7QyR5MbQfR9RQYf7X+Iwc3P+RD3FaFb+7p0kxsqZdvLRLWm
	22Syho+eZo+O/AEvalcb2XZIXTnA7UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716445708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fRA7qudfidtdFLBOO+aiAH8e3TprfZSLlGsNWUXprk=;
	b=XgXcXCrBNHUOgHko9wtgsxiQos1Q+lG4t2Yv7YrC1fEEWNmHBirvYWZN9qGLbzbgrazmL+
	NM+5zwWQRBG/0JDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yF0+EBx1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XgXcXCrB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716445708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fRA7qudfidtdFLBOO+aiAH8e3TprfZSLlGsNWUXprk=;
	b=yF0+EBx1wURqRhSPSctGLXxt9H6M+3mnkghA/pWP7OQ4UKfBk31g/qOFqYD6NDYYnN4qTl
	DR6FRAT2CWcaJ4e3cAVaICp7QyR5MbQfR9RQYf7X+Iwc3P+RD3FaFb+7p0kxsqZdvLRLWm
	22Syho+eZo+O/AEvalcb2XZIXTnA7UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716445708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fRA7qudfidtdFLBOO+aiAH8e3TprfZSLlGsNWUXprk=;
	b=XgXcXCrBNHUOgHko9wtgsxiQos1Q+lG4t2Yv7YrC1fEEWNmHBirvYWZN9qGLbzbgrazmL+
	NM+5zwWQRBG/0JDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38BAB13A6B;
	Thu, 23 May 2024 06:28:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3Y3UAQziTmZZLAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 23 May 2024 06:28:28 +0000
Message-ID: <60758e4d-4bdc-4a99-a151-a9009a8a460f@suse.de>
Date: Thu, 23 May 2024 08:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 John Meneghini <jmeneghi@redhat.com>, "emilne@redhat.com" <emilne@redhat.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jrani@purestorage.com" <jrani@purestorage.com>,
 "randyj@purestorage.com" <randyj@purestorage.com>,
 "hare@kernel.org" <hare@kernel.org>
References: <20240522165406.702362-1-jmeneghi@redhat.com>
 <935f7e10-ccb4-4891-8f29-84909c061e7a@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <935f7e10-ccb4-4891-8f29-84909c061e7a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A278E221D3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_232831_807394_90F86275 
X-CRM114-Status: GOOD (  27.93  )
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

On 5/23/24 06:29, Chaitanya Kulkarni wrote:
> On 5/22/24 09:54, John Meneghini wrote:
>> From: "Ewan D. Milne" <emilne@redhat.com>
>>
>> The round-robin path selector is inefficient in cases where there is a
>> difference in latency between paths.  In the presence of one or more
>> high latency paths the round-robin selector continues to use the high
>> latency path equally. This results in a bias towards the highest latency
>> path and can cause a significant decrease in overall performance as IOs
>> pile on the highest latency path. This problem is acute with NVMe-oF
>> controllers.
>>
>> The queue-depth policy instead sends I/O requests down the path with the
>> least amount of requests in its request queue. Paths with lower latency
>> will clear requests more quickly and have less requests in their queues
>> compared to higher latency paths. The goal of this path selector is to
>> make more use of lower latency paths which will bring down overall IO
>> latency and increase throughput and performance.
>>
>> Signed-off-by: Thomas Song <tsong@purestorage.com>
>> [emilne: patch developed by Thomas Song @ Pure Storage, fixed whitespace
>>         and compilation warnings, updated MODULE_PARM description, and
>>         fixed potential issue with ->current_path[] being used]
>> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
>> [jmeneghi: vairious changes and improvements, addressed review comments]
>> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
>> Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/
>> Tested-by: Marco Patalano <mpatalan@redhat.com>
>> Reviewed-by: Randy Jennings <randyj@purestorage.com>
>> Tested-by: Jyoti Rani <jrani@purestorage.com>
>> ---
> 
> [...]
> 
>> +static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
>> +{
>> +	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
>> +	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
>> +	unsigned int depth;
>> +
>> +	list_for_each_entry_rcu(ns, &head->list, siblings) {
>> +		if (nvme_path_is_disabled(ns))
>> +			continue;
>> +
>> +		depth = atomic_read(&ns->ctrl->nr_active);
>> +
>> +		switch (ns->ana_state) {
>> +		case NVME_ANA_OPTIMIZED:
>> +			if (depth < min_depth_opt) {
>> +				min_depth_opt = depth;
>> +				best_opt = ns;
>> +			}
>> +			break;
>> +
> 
> nit:- no need to add white line needed after break above ?
> 
>> +		case NVME_ANA_NONOPTIMIZED:
>> +			if (depth < min_depth_nonopt) {
>> +				min_depth_nonopt = depth;
>> +				best_nonopt = ns;
>> +			}
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +
>> +		if (min_depth_opt == 0)
>> +			return best_opt;
>> +	}
>> +
>> +	return best_opt ? best_opt : best_nonopt;
>> +}
>> +
>>    
> 
> [...]
> 
>> @@ -800,6 +860,29 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
>>    			  nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
>>    }
>>    
>> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> 
> nit:- overly long line, as rest of the file is < 80 char par line ?
> 
>> +{
>> +	struct nvme_ctrl *ctrl;
>> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
>> +
>> +	if (old_iopolicy == iopolicy)
>> +		return;
>> +
>> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
>> +
>> +	/* iopolicy changes reset the counters and clear the mpath by design */
>> +	mutex_lock(&nvme_subsystems_lock);
>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +		atomic_set(&ctrl->nr_active, 0);
>> +		nvme_mpath_clear_ctrl_paths(ctrl);
>> +	}
>> +	mutex_unlock(&nvme_subsystems_lock);
>> +
>> +	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
>> +			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],
> 
> nit: overly long line above as rest of the file is < 80 char ...
> 
> As far as I remember, most of the nvme code uses pr_info(), but if
> decision has been made to use pr_notice() for a specific reason then
> please ignore this comment.
> 
>> +			subsys->subnqn);
>> +}
>> +
> 
> [...]
> 
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index fc31bd340a63..fa3833d88a85 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -50,6 +50,8 @@ extern struct workqueue_struct *nvme_wq;
>>    extern struct workqueue_struct *nvme_reset_wq;
>>    extern struct workqueue_struct *nvme_delete_wq;
>>    
>> +extern struct mutex nvme_subsystems_lock;
>> +
>>    /*
>>     * List of workarounds for devices that required behavior not specified in
>>     * the standard.
>> @@ -195,6 +197,7 @@ enum {
>>    	NVME_REQ_CANCELLED		= (1 << 0),
>>    	NVME_REQ_USERCMD		= (1 << 1),
>>    	NVME_MPATH_IO_STATS		= (1 << 2),
>> +	NVME_MPATH_CNT_ACTIVE	= (1 << 3),
> 
> nit:- I think we need to align above line to rest of the members in
>         this enum ...
> 
>>    };
>>    
>>    static inline struct nvme_request *nvme_req(struct request *req)
>> @@ -359,6 +362,7 @@ struct nvme_ctrl {
>>    	size_t ana_log_size;
>>    	struct timer_list anatt_timer;
>>    	struct work_struct ana_work;
>> +	atomic_t nr_active;
>>    #endif
>>    
>>    #ifdef CONFIG_NVME_HOST_AUTH
>> @@ -407,6 +411,7 @@ static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
>>    enum nvme_iopolicy {
>>    	NVME_IOPOLICY_NUMA,
>>    	NVME_IOPOLICY_RR,
>> +	NVME_IOPOLICY_QD,
>>    };
>>    
>>    struct nvme_subsystem {
> 
> apart from the few nits patch does looks good to me.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> not a blocker to merge this patch, but we need a blktests for this code
> in nvme
> category ...
> 
As presented at LSF by Daniel; ALUA support (and, with that, multipath 
support) is one of the topics to be implemented for blktests.
And without that we can't have a meaningful QD test.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


