Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CCFC3DA5D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 06:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=faOHf5uPe7RqnnIBXhwHJmCyQQ6curAi6yeXTXrNZFc=; b=EDgwVYtVeLdcZBCefhb0T1YgNQ
	swuv6tvbbfL6OwdAXtgx4mQ6JXS4nMWSIT4Fcr2krwbT+qKQr5lkzXM8wLSP4NbstQklho4AxixUy
	hqQocacpoiSHm+kz5lWah2F3IGI58roGPeG4wKKt0zN9cVhwXaOcbr/Rlyhz45l6PBw+RSZqKI35e
	cuBkJZa67GqFV4Ji8+IbnuVrokhFqshQsNLNrpYsRUGwAko9c09IQxTF84W4OkwWSBYb/6+THN6NK
	+mzFDM+pJZRSv7jFGLBX6dYzJDpdc9n4VRqirAkBDuOMaamA6vGZkfbmjaI0ivONhQ7zZ/jaIlbtH
	UOivJZqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUh78-00000001oNY-12m5;
	Fri, 19 Jul 2024 06:29:10 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUh74-00000001oMa-3pHx
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 06:29:09 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5587F2189C;
	Fri, 19 Jul 2024 06:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721370545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faOHf5uPe7RqnnIBXhwHJmCyQQ6curAi6yeXTXrNZFc=;
	b=Wy/QxAQ6fQ/EsExCnhyVu/qy58RSQ6sS/ftJtRNBo4e6cBA0faBZC5MmTvbbmVOOi6heMa
	HC1sVvz6DpiEwY220ANwfArV93Ky6FZu5ekUoULndsjVf8KMWFi2fb+a9MIbetHfD44zms
	vuMSO56RIjYGyB/J1jlHtjrz44HLhbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721370545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faOHf5uPe7RqnnIBXhwHJmCyQQ6curAi6yeXTXrNZFc=;
	b=vOu8+MREuAiF5ka2pGe6BYxjOhmXur65wO/qW/39GDVzxe57vw1cfaudgq4uTGIpANFesI
	FPsgYHGz09oWI+BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721370545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faOHf5uPe7RqnnIBXhwHJmCyQQ6curAi6yeXTXrNZFc=;
	b=Wy/QxAQ6fQ/EsExCnhyVu/qy58RSQ6sS/ftJtRNBo4e6cBA0faBZC5MmTvbbmVOOi6heMa
	HC1sVvz6DpiEwY220ANwfArV93Ky6FZu5ekUoULndsjVf8KMWFi2fb+a9MIbetHfD44zms
	vuMSO56RIjYGyB/J1jlHtjrz44HLhbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721370545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faOHf5uPe7RqnnIBXhwHJmCyQQ6curAi6yeXTXrNZFc=;
	b=vOu8+MREuAiF5ka2pGe6BYxjOhmXur65wO/qW/39GDVzxe57vw1cfaudgq4uTGIpANFesI
	FPsgYHGz09oWI+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13FAD132CB;
	Fri, 19 Jul 2024 06:29:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iKyiALEHmmY6EwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 19 Jul 2024 06:29:05 +0000
Message-ID: <a6c7f769-bfc2-4e09-9f12-c3edd1c018fc@suse.de>
Date: Fri, 19 Jul 2024 08:29:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvme-sysfs: add 'tls_configured_key' sysfs attribute
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240718144858.19074-1-hare@kernel.org>
 <20240718144858.19074-6-hare@kernel.org> <20240719054429.GA21679@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240719054429.GA21679@lst.de>
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
X-CRM114-CacheID: sfid-20240718_232907_128881_971D809C 
X-CRM114-Status: GOOD (  12.47  )
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

On 7/19/24 07:44, Christoph Hellwig wrote:
>>   #ifdef CONFIG_NVME_TCP_TLS
>>   	&dev_attr_tls_key.attr,
>> +	&dev_attr_tls_configured_key.attr,
>>   #endif
>>   	&dev_attr_adm_passthru_err_log_enabled.attr,
>>   	NULL
>> @@ -741,6 +752,10 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
>>   	if (a == &dev_attr_tls_key.attr &&
>>   	    (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
>>   		return 0;
>> +	if (a == &dev_attr_tls_configured_key.attr &&
>> +	    (!ctrl->opts || !ctrl->opts->tls_key ||
>> +	     strcmp(ctrl->opts->transport, "tcp")))
>> +		return 0;
>>   #endif
> 
> The check for a specific transport hack was ok for a single attribute,
> but it probably is time to have a separate attribute_group provided
> by the transport now.  Or maybe wait until we get another one..
> 
Not a bad idea. Will be doing that for the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


