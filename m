Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDB2C3DA60
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 07:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZzMwdYEqkBn1xyQ4tU7cVsz0GrDYjPW0SWCT9hPvY7w=; b=euum0+fycW3jQfjGdDgVgslXFv
	nNcHRzX7XQFL/abWByTj0BZyUMZc0MNx3ENab+wjfA9bbAKiWsWLEVoo+TEGE6R2gAr/OGJEslW8l
	jr5NEYCGbqld61xN0SX194KvzpAIPCAo1VmMnAFpvzSltH6axNCBsAly/MMbLzVzmrq6P8a5hJAzy
	VMzl0nMHIWFZ3Gpd1FTTVr6mUNNa2jAErLBjQZwzYioc6HmK9zrRXdh7J0000mE1QWUsPS0GZ5M6c
	8Av2QsVhqhdYPvdAQoTABLI0SmavRoI6Ku14t7hnGOmb7iLx3olWzlktgd537YxKWGENa0ikL+o1T
	lZQAsKHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sULKi-0000000G800-3M9S;
	Thu, 18 Jul 2024 07:13:44 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sULKd-0000000G7x4-3sSj
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 07:13:42 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8170D21C33;
	Thu, 18 Jul 2024 07:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721286818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzMwdYEqkBn1xyQ4tU7cVsz0GrDYjPW0SWCT9hPvY7w=;
	b=YPTjsx8kAUJu3b/IeB4pGK1s9694smHNb9Fylqrm//1D7X8NIVT7wC/NL9Qma7W3Y4Bwqp
	8CD+DEP9oYNERBKe2U2MQByFSrvkoqiZQKozD+acMvrbwK4VKU4Yfkn+Hjb40kwl5QsR5q
	74krtlHMYWmoFvU2p0SbUoWaiL191TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721286818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzMwdYEqkBn1xyQ4tU7cVsz0GrDYjPW0SWCT9hPvY7w=;
	b=PWgwpG3Fl9JZRuUjHYrJR/PNfo5btuwLjane8riwXPhL/NarfQLotBONKpBPFFjVZBuIDn
	ZF1ZRy7RRnNyU+AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721286818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzMwdYEqkBn1xyQ4tU7cVsz0GrDYjPW0SWCT9hPvY7w=;
	b=YPTjsx8kAUJu3b/IeB4pGK1s9694smHNb9Fylqrm//1D7X8NIVT7wC/NL9Qma7W3Y4Bwqp
	8CD+DEP9oYNERBKe2U2MQByFSrvkoqiZQKozD+acMvrbwK4VKU4Yfkn+Hjb40kwl5QsR5q
	74krtlHMYWmoFvU2p0SbUoWaiL191TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721286818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzMwdYEqkBn1xyQ4tU7cVsz0GrDYjPW0SWCT9hPvY7w=;
	b=PWgwpG3Fl9JZRuUjHYrJR/PNfo5btuwLjane8riwXPhL/NarfQLotBONKpBPFFjVZBuIDn
	ZF1ZRy7RRnNyU+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 412DA136F7;
	Thu, 18 Jul 2024 07:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xodgDqLAmGarDAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Jul 2024 07:13:38 +0000
Message-ID: <eea02389-244b-4428-9299-0ddad504ca16@suse.de>
Date: Thu, 18 Jul 2024 09:13:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] nvme-sysfs: add 'tls_configured_key' sysfs
 attribute
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-6-hare@kernel.org>
 <e77a7fb7-f753-4a48-882b-ced61ba0c668@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e77a7fb7-f753-4a48-882b-ced61ba0c668@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_001340_133295_A7508490 
X-CRM114-Status: GOOD (  18.06  )
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

On 7/17/24 23:58, Sagi Grimberg wrote:
> 
> 
> On 17/07/2024 12:10, Hannes Reinecke wrote:
>> There is a difference between the negotiated TLS key (which is
>> always present for a TLS encrypted connection) and the configured
>> TLS key (which is specified with the --tls_key command line option).
>> To differentate between these two add a new sysfs attribute
>> 'tls_configured_key' to hold the specified on the command line.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/sysfs.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index be36206cb594..e5cd738660b1 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -676,6 +676,19 @@ static ssize_t tls_key_show(struct device *dev,
>>       return sysfs_emit(buf, "%08x\n", ctrl->tls_pskid);
>>   }
>>   static DEVICE_ATTR_RO(tls_key);
>> +
>> +static ssize_t tls_configured_key_show(struct device *dev,
>> +        struct device_attribute *attr, char *buf)
>> +{
>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> +    struct key *key = ctrl->opts->tls_key;
>> +
>> +    if (!key)
>> +        return 0;
> 
> Shouldn't this check move to the are_visible part so it isn't visible if
> tls_key is not provided?

Guess you are right. I thought we could not as the tls_key might change
with secure concatenation, but that doesn't affect the configured key.

Will be updating the patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


