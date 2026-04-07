Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C37FB5179
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 05:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GionfvfpXdho8bSgUgv2S/UxEe7l6eDaHJFyaw0ZCpU=; b=MeSbjGSlqbM5c+eoi90/QzH9Jd
	Tl3eAbS+JMFkCe1A3ViL1MYkXXbb6IDr223bhv4gxP3mdZptpvwt7X1/4HrlYgvgI9QeeEDbXSIpM
	ApHwCfevCDHBjOwAXsqtr6C1Vyz2QDb/tZS2aug4FpGmZ+NEmWfA+Dx1JPpxkCiodU0EAz8neioqo
	SQ4eB4p1XSH2SbvapIDKhpif3zWubNmfAEiqU6XT2UHHWNE1wSXhjH+Eb0R72ytjrbFO8Pwwlmc/8
	ZS20h55nbzfOyQHc14gWz8Lyqcrts7zYxXCO23dBAdjuy9PDjxRCAiIhN3ZHkHDgUbl/pZqldg20w
	33+EXj6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9z9h-00000005vvm-3liv;
	Tue, 07 Apr 2026 05:39:17 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9z9d-00000005vvO-3ElH
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 05:39:16 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 724D34E2B3;
	Tue,  7 Apr 2026 05:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775540350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GionfvfpXdho8bSgUgv2S/UxEe7l6eDaHJFyaw0ZCpU=;
	b=UOYVWWB66o7q7qLs+QNigb+NxYNkYpiZdntHMSKfG3Tqy7tuZPiPV5Tz5HXsdUYPT1uKry
	Co0Ugy2lGajx2JGlVx2jGpd16lacqkgTFZ1HtSbN1fUOkHEjchAhIypw6ZRiNGC5681qj0
	PGNUrEF8Wk78l1LjFcw9qZ0i/rp63c8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775540350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GionfvfpXdho8bSgUgv2S/UxEe7l6eDaHJFyaw0ZCpU=;
	b=u1EiM68hlYFJjXaR8irj8AQs9hhXV6G9TRnK6+6A4Bi52GdNyQ2A43xGd4uBWFqs5twfby
	IPwWcB3ofqOIQqDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UOYVWWB6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=u1EiM68h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775540350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GionfvfpXdho8bSgUgv2S/UxEe7l6eDaHJFyaw0ZCpU=;
	b=UOYVWWB66o7q7qLs+QNigb+NxYNkYpiZdntHMSKfG3Tqy7tuZPiPV5Tz5HXsdUYPT1uKry
	Co0Ugy2lGajx2JGlVx2jGpd16lacqkgTFZ1HtSbN1fUOkHEjchAhIypw6ZRiNGC5681qj0
	PGNUrEF8Wk78l1LjFcw9qZ0i/rp63c8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775540350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GionfvfpXdho8bSgUgv2S/UxEe7l6eDaHJFyaw0ZCpU=;
	b=u1EiM68hlYFJjXaR8irj8AQs9hhXV6G9TRnK6+6A4Bi52GdNyQ2A43xGd4uBWFqs5twfby
	IPwWcB3ofqOIQqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23ADD4A0B0;
	Tue,  7 Apr 2026 05:39:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MYuGB36Y1GnjZQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Apr 2026 05:39:10 +0000
Message-ID: <5d3fecf4-9101-4028-858d-bfbbccf3d8d3@suse.de>
Date: Tue, 7 Apr 2026 07:39:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/15] nvme: Implement cross-controller reset recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260328004518.1729186-9-mkhalfella@purestorage.com>
 <ee086ee1-a48f-41fb-a7fe-afc6b738cf21@suse.de>
 <20260331164733.GC2861-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260331164733.GC2861-mkhalfella@purestorage.com>
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,nvidia.com,kernel.dk,kernel.org,grimberg.me,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 724D34E2B3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_223913_992565_CA30706A 
X-CRM114-Status: GOOD (  19.78  )
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

On 3/31/26 18:47, Mohamed Khalfella wrote:
> On Mon 2026-03-30 12:50:24 +0200, Hannes Reinecke wrote:
>> On 3/28/26 01:43, Mohamed Khalfella wrote:
>>> A host that has more than one path connecting to an nvme subsystem
>>> typically has an nvme controller associated with every path. This is
>>> mostly applicable to nvmeof. If one path goes down, inflight IOs on that
>>> path should not be retried immediately on another path because this
>>> could lead to data corruption as described in TP4129. TP8028 defines
>>> cross-controller reset mechanism that can be used by host to terminate
>>> IOs on the failed path using one of the remaining healthy paths. Only
>>> after IOs are terminated, or long enough time passes as defined by
>>> TP4129, inflight IOs should be retried on another path. Implement core
>>> cross-controller reset shared logic to be used by the transports.
>>>
>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>> ---
>>>    drivers/nvme/host/constants.c |   1 +
>>>    drivers/nvme/host/core.c      | 145 ++++++++++++++++++++++++++++++++++
>>>    drivers/nvme/host/nvme.h      |   9 +++
>>>    3 files changed, 155 insertions(+)
>>>
[ .. ]
>>> +
>>> +int nvme_fence_ctrl(struct nvme_ctrl *ictrl)
>>> +{
>>> +	unsigned long deadline, timeout;
>>> +	struct nvme_ctrl *sctrl;
>>> +	u32 min_cntlid = 0;
>>> +	int ret;
>>> +
>>> +	timeout = nvme_fence_timeout_ms(ictrl);
>>> +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
>>> +
>>> +	deadline = jiffies + msecs_to_jiffies(timeout);
>>> +	while (time_is_after_jiffies(deadline)) {
>>> +		sctrl = nvme_find_ctrl_ccr(ictrl, min_cntlid);
>>> +		if (!sctrl) {
>>> +			dev_dbg(ictrl->device,
>>> +				"failed to find source controller\n");
>>> +			return -EIO;
>>> +		}
>>> +
>>> +		ret = nvme_issue_wait_ccr(sctrl, ictrl, deadline);
>>> +		if (!ret) {
>>> +			dev_info(ictrl->device, "CCR succeeded using %s\n",
>>> +				 dev_name(sctrl->device));
>>> +			nvme_put_ctrl_ccr(sctrl);
>>> +			return 0;
>>> +		}
>>> +
>>> +		min_cntlid = sctrl->cntlid + 1;
>>> +		nvme_put_ctrl_ccr(sctrl);
>>> +
>>> +		if (ret == -EIO) /* CCR command failed */
>>> +			continue;
>>> +
>>> +		/* CCR operation failed or timed out */
>>> +		return ret;
>>> +	}
>>> +
>>> +	dev_info(ictrl->device, "CCR operation timeout\n");
>>> +	return -ETIMEDOUT;
>>> +}
>>
>> Please restructure the loop.
>> Having a comment 'CCR operation failed or timed out',
>> returning a status, and then have a comment
>> 'CCR operation timeout' _after_ the return is confusing.
> 
> I can change /* CCR operation failed or timed out */ to something like
> 
> /*
>   * Source controller accepted CCR command but CCR operation
>   * timed out or failed. Retrying another path is not likely
>   * to succeed, return an error.
>   */
> 
> And change the log line "CCR operation timeout\n" outside the while
> loop to "fencing timedout\n".
> 
> Will this help?
> 
Yes, thank you.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

