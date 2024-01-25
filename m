Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06F9C47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6W/6AY5jfOD02UgXrAR/aGl6v5p7vcQ1RlyaJ27tqkw=; b=2+zQdhQRwJiGQNo99CPQyMX9mW
	UvG+saQWl9selSCrnPtTyZ9rOOVK5+gyQjGwUCOaDYOiVlAtIHGy8cYZvBEEyQ698BHwoI85pnV24
	Xpu09Eo4VjWun/mPN4EKQTurxYmNPFFXgPJVotvrecABMa3gxJdcZiu8jGu90KnCXznXZAujPP9RD
	SXJttvkzBQ/EeKBcoq1LFTmn1Jbon26gHUnLXLMMpcWW1zzMFh35evGA/o2Cfhgj82OIoE0tKarXj
	jKf273xARynPOLwRezoh8r0cMa4XiRP7EVzQn1zZujxjBzIvXyPgG8cdhw+3bCqTfRl0npL+yy2Iq
	tDc+Pwhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT2Sr-00000000lxW-2IKm;
	Thu, 25 Jan 2024 16:20:29 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT2Sm-00000000ltj-42lJ
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 16:20:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ACA1D1F88D;
	Thu, 25 Jan 2024 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706199619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6W/6AY5jfOD02UgXrAR/aGl6v5p7vcQ1RlyaJ27tqkw=;
	b=aHiZl3xl9F8OhwAiBeh4BszUCLGxj/zhfXiZnQyn+nJDJCIb/iTBVd205sB5+CsUoWpfAs
	rvPe5u9i+c3sfxUHPA5a8YMUtUEM8iCUtvwd/nJGRwtexJCp6/B3KZDvUknXmUyX8gDy8s
	0plosVWfzbZ2FXCT+Vxbs70H3t3kSDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706199619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6W/6AY5jfOD02UgXrAR/aGl6v5p7vcQ1RlyaJ27tqkw=;
	b=DMsCJAo0cabujhj9wwmYMK2vBMUd+v5h/YJDZ2HFHzod3zWL7y8uwPa7TdcYNLLG+WD/vo
	UwkM6cF258YEY/Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706199619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6W/6AY5jfOD02UgXrAR/aGl6v5p7vcQ1RlyaJ27tqkw=;
	b=aHiZl3xl9F8OhwAiBeh4BszUCLGxj/zhfXiZnQyn+nJDJCIb/iTBVd205sB5+CsUoWpfAs
	rvPe5u9i+c3sfxUHPA5a8YMUtUEM8iCUtvwd/nJGRwtexJCp6/B3KZDvUknXmUyX8gDy8s
	0plosVWfzbZ2FXCT+Vxbs70H3t3kSDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706199619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6W/6AY5jfOD02UgXrAR/aGl6v5p7vcQ1RlyaJ27tqkw=;
	b=DMsCJAo0cabujhj9wwmYMK2vBMUd+v5h/YJDZ2HFHzod3zWL7y8uwPa7TdcYNLLG+WD/vo
	UwkM6cF258YEY/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64EEA13649;
	Thu, 25 Jan 2024 16:20:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3SjwFkOKsmVEeAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 25 Jan 2024 16:20:19 +0000
Message-ID: <b3e68e05-f698-4fbc-87a7-99f7461d88be@suse.de>
Date: Thu, 25 Jan 2024 17:20:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: enable retries for authentication commands
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: hare@kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Martin George <marting@netapp.com>
References: <20240125130906.94874-1-hare@kernel.org>
 <13922738-7cdb-457d-9ba6-4a3a9a064a8b@kernel.dk>
 <20240125154814.GA23800@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240125154814.GA23800@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_082025_195422_483C1A80 
X-CRM114-Status: GOOD (  15.17  )
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

On 1/25/24 16:48, Christoph Hellwig wrote:
> On Thu, Jan 25, 2024 at 08:42:10AM -0700, Jens Axboe wrote:
>> On 1/25/24 6:09 AM, hare@kernel.org wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> Authentication commands are normal NVMe commands, and as such
>>> can return a status where NVME_SC_DNR is not set, indicating
>>> that the command should be retried.
>>> Rather than checking NVME_SC_DNR manually for each command completion
>>> this patch adds a flag 'retry' to __nvme_submit_sync_cmd(), causing
>>> the REQ_FAILFAST_DRIVER option to be cleared and the command to
>>> be retried via the normal mechanism.
>>
>> Can we please do this without adding Yet Another parameter to that
>> function?
> 
> Heh, I wrote about the same reply a few minutes ago.  I'll try to think
> what we can do instead.

We could do something like this:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8ebdfd623e0f..200326dc33c1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1057,6 +1057,8 @@ int __nvme_submit_sync_cmd(struct request_queue 
*q, struct nvme_command *cmd,
         if (IS_ERR(req))
                 return PTR_ERR(req);
         nvme_init_request(req, cmd);
+       if (flags & BLK_MQ_REQ_RETRY)
+               req->cmd_flags &= ~REQ_FAILFAST_DRIVER;

         if (buffer && bufflen) {
                 ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1ab3081c82ed..7983e1abb622 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -719,6 +719,8 @@ enum {
         BLK_MQ_REQ_RESERVED     = (__force blk_mq_req_flags_t)(1 << 1),
         /* set RQF_PM */
         BLK_MQ_REQ_PM           = (__force blk_mq_req_flags_t)(1 << 2),
+       /* enable command retries */
+       BLK_MQ_REQ_RETRY        = (__force blk_mq_req_flags_t)(1 << 3),
  };

  struct request *blk_mq_alloc_request(struct request_queue *q, 
blk_opf_t opf,

but that's arguably a misuse of block layer flags ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


