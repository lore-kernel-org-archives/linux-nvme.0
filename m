Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD06F606A321
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 01:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=z5mN+CUh;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FPG/D1GF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IrR0ucWnwxQ/cocBxwwq0cb5UPgH07q1FaZL6ppOVpA=; b=z5mN+CUh/Enix2
	jzfNsQnuLGhpVFytv3j4THpQHGh5Uz8Joo4X621pIzed+4poE1dFfF6bg+CXK5z8QPVdAWwImPNBh
	V0yWqHgQmqi5VZyC32+pHifQ6QogUhZPqa8FRXx482TRqdJSHrJfmHmXNr9nBSp47XiZ/H//kNOkE
	FFV751chazPzbFK+gjgZ+OhGtzMHP19J44irXqTHIR0pcKP3jJDxFno4D5+NXJsXxsvO/ont1N+/p
	LPMC9dQV1HudPnI012+sGKJECLNSCcI5Y/VK0Y0hVeZLFQtRFgsy/1GHdytGeI2aXg7afXzCB9i/O
	uKjya3hvSjEL0HQC4A5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWOW8-0000000BovX-3YnX;
	Thu, 26 Nov 2026 01:43:20 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWOW5-0000000Bov9-2nwm
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 01:43:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795657395; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IrR0ucWnwxQ/cocBxwwq0cb5UPgH07q1FaZL6ppOVpA=;
	b=FPG/D1GF8WqyfBa5FsxlJRnkFOQTIzM0NMXRtK7KI6ivXpLz9Bw1oBKeemAJUzLSEXnJw/ga7Z3woiSCyvMZRTx2aUvqw9KK+nGjqizp0OMIxHXl+m4sRJmNkgcxF7M3oJYiFip1/c7BK7hyp9KUBDzbh0o/z9PsgV812cLz9V4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0XFSr1ve_1795657394;
Received: from 30.178.66.94(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFSr1ve_1795657394 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Nov 2026 09:43:14 +0800
Message-ID: <86b6f4e4-f3b3-41ff-b0bb-1d8c959b37eb@linux.alibaba.com>
Date: Thu, 26 Nov 2026 09:43:11 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-multipath: serialize ana_log_buf lifecycle with
 ana_lock
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261125122446.1122253-1-kanie@linux.alibaba.com>
 <sashiko-outbox-233382@kernel.org>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <sashiko-outbox-233382@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_174318_171389_347C986F 
X-CRM114-Status: GOOD (  21.41  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/25 20:39, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] nvme-multipath: ana_work re-queued with NULL buffer after
>   nvme_mpath_uninit()
> - [Medium] nvme-multipath: stale ana_log_buf parsed against shrunk size
>   on reset
> --
>
> commit 6951dbeaa851be5d302a81751db149aaf0a1b322
> Author: Guixin Liu <kanie@linux.alibaba.com>
>
> nvme-multipath: serialize ana_log_buf lifecycle with ana_lock
>
> This commit serializes ctrl->ana_log_buf and ctrl->ana_log_size updates
> under ctrl->ana_lock across nvme_mpath_init_identify() and
> nvme_mpath_uninit(), and adds a NULL buffer check to nvme_parse_ana_log().
>
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 27facdbb3d4c0..91ba71ab1c614 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -867,6 +867,9 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
>>  
>>  	lockdep_assert_held(&ctrl->ana_lock);
>>  
>> +	if (!ctrl->ana_log_buf)
>> +		return 0;
>> +
>>  	for (i = 0; i < le16_to_cpu(ctrl->ana_log_buf->ngrps); i++) {
>>  		struct nvme_ana_group_desc *desc = base + offset;
>>  		u32 nr_nsids;
>> @@ -1589,13 +1592,22 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>>  		goto out_uninit;
>>  	}
>>  	if (ana_log_size > ctrl->ana_log_size) {
>> +		void *buf;
>> +
>>  		nvme_mpath_stop(ctrl);
>> -		nvme_mpath_uninit(ctrl);
>> -		ctrl->ana_log_buf = kvmalloc(ana_log_size, GFP_KERNEL);
>> -		if (!ctrl->ana_log_buf)
>> +		buf = kvzalloc(ana_log_size, GFP_KERNEL);
>> +		if (!buf)
>>  			return -ENOMEM;
>> +		mutex_lock(&ctrl->ana_lock);
>> +		kvfree(ctrl->ana_log_buf);
>> +		ctrl->ana_log_buf = buf;
>> +		ctrl->ana_log_size = ana_log_size;
>> +		mutex_unlock(&ctrl->ana_lock);
>> +	} else {
>> +		mutex_lock(&ctrl->ana_lock);
>> +		ctrl->ana_log_size = ana_log_size;
>> +		mutex_unlock(&ctrl->ana_lock);
>>  	}
>> -	ctrl->ana_log_size = ana_log_size;
>>  	error = nvme_read_ana_log(ctrl);
>>  	if (error)
>>  		goto out_uninit;
> [Severity: Medium]
> When a controller resets with a smaller ana_log_size (or a smaller
> ctrl->anagrpmax, which is updated above outside ctrl->ana_lock), does this
> else branch leave the pre-reset ANA log in ctrl->ana_log_buf while
> shrinking ctrl->ana_log_size?
>
> A concurrent nvme_parse_ana_log() running before nvme_read_ana_log()
> overwrites the buffer will validate the old descriptors against the newly
> shrunk ctrl->ana_log_size and ctrl->anagrpmax, hitting WARN_ON_ONCE() and
> failing with -EINVAL:
>
> CPU0                                  CPU1
> nvme_mpath_init_identify()
>   ctrl->anagrpmax = ...
>   mutex_lock(&ctrl->ana_lock)
>   ctrl->ana_log_size = ana_log_size
>   mutex_unlock(&ctrl->ana_lock)
>                                       nvme_mpath_add_disk()
>                                         mutex_lock(&ctrl->ana_lock)
>                                         nvme_parse_ana_log()
>                                           offset > ctrl->ana_log_size
>                                             <-- WARN_ON_ONCE()
>   nvme_read_ana_log()
>
> Zeroing ctrl->ana_log_buf->ngrps (and updating ctrl->anagrpmax) under
> ctrl->ana_lock would keep concurrent parsers from walking stale pre-reset
> descriptors before nvme_read_ana_log() populates the new log.
>
>> @@ -1615,7 +1627,9 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>>  	 */
>>  	cancel_work_sync(&ctrl->ana_work);
>>  
>> +	mutex_lock(&ctrl->ana_lock);
>>  	kvfree(ctrl->ana_log_buf);
>>  	ctrl->ana_log_buf = NULL;
>>  	ctrl->ana_log_size = 0;
>> +	mutex_unlock(&ctrl->ana_lock);
>>  }
> [Severity: High]
> Can nvme_mpath_add_disk() re-queue ctrl->ana_work after
> nvme_mpath_uninit() has already cancelled it and freed ctrl->ana_log_buf?
>
> When nvme_mpath_init_identify() jumps to out_uninit during a reset (for
> example, when ana_log_size > max_transfer_size disables ANA with
> error == 0 so the controller still becomes live), nvme_mpath_add_disk()
> can pass its unlocked nvme_ctrl_use_ana() check before ctrl->ana_log_buf
> is cleared:
>
> CPU0                                  CPU1
> nvme_mpath_add_disk()                 nvme_mpath_uninit()
>   if (nvme_ctrl_use_ana(ctrl))          cancel_work_sync(&ctrl->ana_work)
>                                         mutex_lock(&ctrl->ana_lock)
>                                         kvfree(ctrl->ana_log_buf)
>                                         ctrl->ana_log_buf = NULL
>                                         ctrl->ana_log_size = 0
>                                         mutex_unlock(&ctrl->ana_lock)
>     mutex_lock(&ctrl->ana_lock)
>     nvme_parse_ana_log()
>       if (!ctrl->ana_log_buf)
>         return 0
>     mutex_unlock(&ctrl->ana_lock)
>     if (desc.state) /* 0 */
>     else
>       set_bit(NVME_NS_ANA_PENDING, ...)
>       queue_work(..., &ctrl->ana_work)
>                                       nvme_ana_work()
>                                         nvme_read_ana_log()
>                                           nvme_get_log(..., NULL, 0, 0)
>                                             <-- numd underflows to 0xffffffff
>
> Because nvme_parse_ana_log() returns 0 with desc.state == 0 when
> ctrl->ana_log_buf is NULL, nvme_mpath_add_disk() treats it as a missing
> group descriptor, leaves the namespace stuck with NVME_NS_ANA_PENDING set,
> and queues ctrl->ana_work.  nvme_read_ana_log() then calls nvme_get_log()
> without checking ctrl->ana_log_buf, passing a NULL buffer and size 0;
> nvme_bytes_to_numd(0) underflows to 0xffffffff and submits a 16 GiB
> Admin Get Log Page command with no data buffer mapped.
Right.. Fixed in v3.

Best Regards,
Guixin Liu
>


