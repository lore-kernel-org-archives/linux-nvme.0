Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648E1C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 11:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KKAmnX0uvI7eqHYsZoxYudOhUkhEYS3PsuNr1hA4Q+c=; b=G9/pYwSOqLiztuYv3fIk37vL1N
	CPrqC2SJMHrRQmZde+kz8wMZpewwERdyan1KXnlKNg3wvaYfu5Kyd6RS9B8caj6VadvE39aqTZ8y2
	Q+O4uEb8X+yJPmO1mNOr5Rc3rW24+axDfqS5DnPOClwnbMvzEbWQiFZgrXuFZGnncbDnSCoDPWQUH
	aJQp59wP8GeTe6fSCkoFnIA6G9TvwAhhWouNA3FFjgCDLVZxn0DzFvcYcBQNw430yzbIe2e0COhVi
	DJHgZ6NDvzjVa+9fp6xJ3q1aXWgGXrt0t9q9gaxIAPw1ONSwBg+MB3kpzX1IilPERFoONuJhq3tLt
	dBiwVhuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5PR-00000004LtW-2OSO;
	Tue, 26 Mar 2024 11:56:05 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5PL-00000004LsJ-0uQI
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 11:56:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CABD5CC90;
	Tue, 26 Mar 2024 11:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711454156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKAmnX0uvI7eqHYsZoxYudOhUkhEYS3PsuNr1hA4Q+c=;
	b=e2ul4SIzYt0r8W3g1k93CbwRV/SYpTgSoEm2qNiZu43ZJN/uVZXLLYLpCmXDEIBArLARtE
	/RS+SwdiYTeS36NeGre/WHYr8ZVYEwxVddYuusTkT7ra4WQWJ4FAzUsO7J6JvrspD6dnSJ
	es4jRuFkAezxFftKIaR8EkQDBEQw5L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711454156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKAmnX0uvI7eqHYsZoxYudOhUkhEYS3PsuNr1hA4Q+c=;
	b=sHbx4gLn8iHzpRJp79JF2kpNvPhEhgMdJBxXs96XEhswLu5M/gEp1rICm4Kn5C5BI/hkHp
	1tH6lwyIpqFRD/Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711454156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKAmnX0uvI7eqHYsZoxYudOhUkhEYS3PsuNr1hA4Q+c=;
	b=e2ul4SIzYt0r8W3g1k93CbwRV/SYpTgSoEm2qNiZu43ZJN/uVZXLLYLpCmXDEIBArLARtE
	/RS+SwdiYTeS36NeGre/WHYr8ZVYEwxVddYuusTkT7ra4WQWJ4FAzUsO7J6JvrspD6dnSJ
	es4jRuFkAezxFftKIaR8EkQDBEQw5L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711454156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKAmnX0uvI7eqHYsZoxYudOhUkhEYS3PsuNr1hA4Q+c=;
	b=sHbx4gLn8iHzpRJp79JF2kpNvPhEhgMdJBxXs96XEhswLu5M/gEp1rICm4Kn5C5BI/hkHp
	1tH6lwyIpqFRD/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3480C138A1;
	Tue, 26 Mar 2024 11:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O5czDMy3AmaiFwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 26 Mar 2024 11:55:56 +0000
Message-ID: <9645b4b6-5cd2-4500-9e66-4fea027fd76c@suse.de>
Date: Tue, 26 Mar 2024 12:55:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] nvmet: add debugfs support
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
References: <20240322070333.3820-1-hare@kernel.org>
 <20240322070333.3820-2-hare@kernel.org>
 <0e5f59ee-9ec0-4abe-bd57-ec3fe3d1b27e@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <0e5f59ee-9ec0-4abe-bd57-ec3fe3d1b27e@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.34 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.05)[87.75%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_045559_464760_508F7D39 
X-CRM114-Status: GOOD (  11.30  )
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

On 3/23/24 21:25, Sagi Grimberg wrote:
>> +int nvmet_debugfs_subsys_setup(struct nvmet_subsys *subsys)
>> +{
>> +    int ret = 0;
>> +
>> +    subsys->debugfs_dir = debugfs_create_dir(subsys->subsysnqn,
>> +                         nvmet_debugfs);
>> +    if (IS_ERR(subsys->debugfs_dir)) {
>> +        ret = PTR_ERR(subsys->debugfs_dir);
>> +        subsys->debugfs_dir = NULL;
>> +    }
>> +    return ret;
>> +}
>> +
>> +void nvmet_debugfs_subsys_free(struct nvmet_subsys *subsys)
>> +{
>> +    debugfs_remove_recursive(subsys->debugfs_dir);
>> +}
> 
> The subsys setup/free look trivial enough to just open-code
> in the call-sites.
> 
> The rest looks fine to me.

Agreed for the 'free' call, the setup call has to stay as it's
referring to the static dentry 'nvmet_debugfs', which I'd like
to keep private to 'debugfs.c'.

Cheers,

Hannes


