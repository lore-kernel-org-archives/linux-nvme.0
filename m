Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A139BC25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 14:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hwcDxOQ6pMSkl1QmM4849RB+YcZAC4TGgNQOUHZaoVk=; b=yBkRClI6Snt43ZS1NFHsieVrf4
	3nTlXtrE0lHFPqq9Rm6md2mDSNV34amD3LFfLxkhIJXO1gOnyj7yi7CEdwoOUKrGlfEAtAmSXD4lI
	8sdSzmkeH528+wEIm6GSL+L49hdLsHKhbFf7nRWEGHN+w94TYBDf28VeFsIo23uP8RyZ0CRQlfheC
	vFcUWmtFJU1vo0E6+2DkrIUOCx9dvU5YcOtYhJxH5PdVecPxWQIS4ZyqKIziRQ/uhcYKxNpcueD2G
	AK392Yy8Hqy092XksSUG/RJ3jOCKmyxIz9qSsPn+iV+rNfCkVQ809vYZsF3CVK+NJ0T9pQ/F7P1jn
	nfXd4+4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9QPQ-00000000AIM-41oE;
	Tue, 21 May 2024 14:24:08 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9QPL-00000000AEi-2T3t
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 14:24:07 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5DE621F30;
	Tue, 21 May 2024 14:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716301434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwcDxOQ6pMSkl1QmM4849RB+YcZAC4TGgNQOUHZaoVk=;
	b=g7tdXcB39KNS8WdFtJn52wuwAySC0q6KRg0Z/PrhvOFdsTTabEjtNeuvHi3WLJ94McQDuV
	/UGwLpGe0nENe50QVY4thYdEvHmZuyCS1C8DZMzz0TXsAEvPi04Xle3hrQ/1/clW093duo
	kHToGsjGAcd8aN2HROlgt87Em9yFCvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716301434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwcDxOQ6pMSkl1QmM4849RB+YcZAC4TGgNQOUHZaoVk=;
	b=M6Gna1IilS619jmNwu2oEwx2c6QG72sMUpeUhiG106lcQpEzkNHRpjXYesAmw/LNeVbBYN
	nPliXiL5N88kGSCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716301433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwcDxOQ6pMSkl1QmM4849RB+YcZAC4TGgNQOUHZaoVk=;
	b=ZahKT0keeWaUlD2YKQ9twPNc1vfZMhj5MMJXOL9esWEP9lA+M6N34/QkDDCjW93O6S89aV
	KZbm/fyiZE1FCPC2HgQwpx0EpjA+BlXNMjz3v93pPNt7uwyiR9AbUKQlVxeh7WaOTtJTQL
	yXsjsul3ZWyYAB31Xo1HyQ7qSZyU8CQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716301433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwcDxOQ6pMSkl1QmM4849RB+YcZAC4TGgNQOUHZaoVk=;
	b=+J9kbIcF/fkeBDN03mRV9flYCB/1MNDJbNB9J3HgTS7ZBHjAvaLnXnbuleeoPUv9ja0ywr
	9KkDUCiol5/UnfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2C2B13A1E;
	Tue, 21 May 2024 14:23:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dP/lKnmuTGYdQAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 21 May 2024 14:23:53 +0000
Message-ID: <872f0ebd-124e-4a39-987c-ef9c273f1957@suse.de>
Date: Tue, 21 May 2024 16:23:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <f808fa46-e7c7-48e6-8c80-3d28efd0afec@suse.de>
 <595e5988-b94d-41ba-a233-f87aed55028d@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <595e5988-b94d-41ba-a233-f87aed55028d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_072403_808532_56B0C3D5 
X-CRM114-Status: GOOD (  17.69  )
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

On 5/21/24 15:58, John Meneghini wrote:
> On 5/21/24 02:46, Hannes Reinecke wrote:
>> On 5/20/24 22:20, John Meneghini wrote:
>>> From: "Ewan D. Milne" <emilne@redhat.com>
>>>
> ...
>>> Tested-by: Marco Patalano <mpatalan@redhat.com>
>>> Reviewed-by: Randy Jennings <randyj@redhat.com>
> 
> I need to fix this. Randy doesn't have a redhat.com email address... Cut 
> an paste error :-(
> 
>>> Tested-by: Jyoti Rani <jani@purestorage.com>
>>>
> ...
>>> +void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int 
>>> iopolicy)
>>> +{
>>> +    struct nvme_ctrl *ctrl;
>>> +    int old_iopolicy = READ_ONCE(subsys->iopolicy);
>>> +
>>> +    WRITE_ONCE(subsys->iopolicy, iopolicy);
>>> +
>>> +    mutex_lock(&nvme_subsystems_lock);
>>> +    list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>>> +        atomic_set(&ctrl->nr_active, 0);
>>> +        nvme_mpath_clear_ctrl_paths(ctrl);
>>
>> You always reset the variables here, even if specified iopolicy is
>> the same than the currently active one.
>> I'd rather check if the iopolicy is different before changing the 
>> settings.
> 
> Yes, Keith pointed this out too.  This is actually a feature not a bug.  
> In situations were we want to "reset" the nr_active counters on all 
> controllers the user can simply set the queue-depth iopolicy a second 
> time.  I don't expect users to do this very often... they shouldn't be 
> changing IO policies back and forth too much... but the ability to 
> "reset" the nr_active counters during testing has been very helpful and 
> important to do.  So I'd like to keep this.  Moreover, this is NOT the 
> performance path. I don't see the point in making performance 
> optimizations in a code path that is run once a year.
> 
Please add a comment indicating that.
Just to make it clear that it's by design.

Cheers,

Hannes

