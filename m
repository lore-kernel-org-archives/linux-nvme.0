Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A35AD1D86E
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 14:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1XZEwkb3/rO7EWc64PR2c7vFbgkWv4OhJhmSWl4zXY=; b=BBvzxd3r4hG0xec+wsBlQkAE2B
	ma8TT07AktKFF2PwYP1+PtcbD8vxsh/uhnKYSF7X5NoCdsu6Gi/sf5mbvkgD6X26G4UxbQS2j9Xfs
	EvBv7HM1IMia26ktgSrMZXghjiophZ4tzfoZu4YD0GiIZPBmR1AW2y60OkGrLjyV9a+6/ycysCkxm
	Xs1XJzf+EbbRMlWiwmQXmwZLmgjwyl5DU5KXQcFBYFPeat6MaEa7CVCdIVGRuL4Zdifxh5Xlvjpt0
	AEAg0e4fixGUDqtHvPYPWOQ7nwL/Km8WAgKwgxMv+LnUcEpY8voAGXUBqa8+gpJCliZ+Xcq0YEKjP
	MlYxttwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0j0Z-00000008bz1-1RnQ;
	Tue, 15 Oct 2024 14:58:47 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0iy5-00000008bHY-3xUn
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 14:56:18 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4FA551F7F0;
	Tue, 15 Oct 2024 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729004170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1XZEwkb3/rO7EWc64PR2c7vFbgkWv4OhJhmSWl4zXY=;
	b=plFEQs9rs51JpfLKUjVNy8l22U/V/PtgSGlghMR8QU0RsN/ElJGDqe3RDxQA7Z9boXnVOu
	LKXJHbwolrsa2C5Lt2R1iWF3OVlEbjzE6nApRqkRBP445UVIZhe8tIthaTa2C8zmAwVFoL
	uYK9LT3iBinrxFZbqPsmrHLLlsekIKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729004170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1XZEwkb3/rO7EWc64PR2c7vFbgkWv4OhJhmSWl4zXY=;
	b=svgTmcWfBtrJbQyJM8Omh7orh3Gjp11bIcu5+m9ovbPLqjF1oQgeL3M9SdW+iP8t9I4j7Z
	Nqsdk/82Kwy+GGCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GCgmNgt+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aovZdtN5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729004169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1XZEwkb3/rO7EWc64PR2c7vFbgkWv4OhJhmSWl4zXY=;
	b=GCgmNgt+RVh4OqeD6B/FnaDD/pfnVpg2o4C+8+jKKe06FcVzGnpfb5NO/EeeG1SDUxRaGE
	XMmJWYvdSQkWVZDE8Fuz+3qpdgm59PNsZKZL7DERLUUIz/WEIwyQM5LN8mySKNdx3ofSnY
	474aT3MBWxxrGQhjJ19vmBIUQz48uQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729004169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1XZEwkb3/rO7EWc64PR2c7vFbgkWv4OhJhmSWl4zXY=;
	b=aovZdtN5ySPYYVW2QR7hIrkE0gUf8dh79PVIGa4BfVTOHAEkqvK9zrhGd5ILtfut6rCB2n
	RwwE+VQwOZ2l8DAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 168C113A42;
	Tue, 15 Oct 2024 14:56:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RvhsAomCDmfQDgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 15 Oct 2024 14:56:09 +0000
Message-ID: <4478f837-b504-44dd-8f5b-facab6aa8161@suse.de>
Date: Tue, 15 Oct 2024 16:56:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-multipath: cannot disconnect controller on stuck
 partition scan
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-3-hare@kernel.org> <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
 <47968bf9-2b98-4e5e-9040-2db6f15d86a6@suse.de> <ZwWY8d3vOLUaYaJ6@kbusch-mbp>
 <3b8ff898-9529-4506-8c5d-0fcf3423730f@suse.de> <Zwa-MBS6wn_dGxge@kbusch-mbp>
 <b7ffdbbb-0b4e-4215-bf2b-b5c2f9a2dc08@suse.de> <Zw59LxZ3cngO17_f@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Zw59LxZ3cngO17_f@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4FA551F7F0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_075614_202061_46E79423 
X-CRM114-Status: GOOD (  16.58  )
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

On 10/15/24 16:33, Keith Busch wrote:
> On Thu, Oct 10, 2024 at 10:57:23AM +0200, Hannes Reinecke wrote:
>> On 10/9/24 19:32, Keith Busch wrote:
>>> @@ -974,14 +991,14 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
>>>    		return;
>>>    	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>>>    		nvme_cdev_del(&head->cdev, &head->cdev_device);
>>> +		/*
>>> +		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
>>> +		 * to allow multipath to fail all I/O.
>>> +		 */
>>> +		synchronize_srcu(&head->srcu);
>>> +		kblockd_schedule_work(&head->requeue_work);
>>>    		del_gendisk(head->disk);
>>>    	}
>>
>> I guess we need to split 'test_and_clear_bit()' into a 'test_bit()' when
>> testing for the condition and a 'clear_bit()' after del_gendisk().
>>
>> Otherwise we're having a race condition with nvme_mpath_set_live:
>>
>>          if (!test_and_set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>>                  rc = device_add_disk(&head->subsys->dev, head->disk,
>>                                       nvme_ns_attr_groups);
>>
>> which could sneak in from another controller just after we cleared the
>> NVME_NSHEAD_DISK_LIVE flag, causing device_add_disk() to fail as the
>> same name is already registered.
>> Or nvme_cdev_del() to display nice kernel warnings as the cdev was
>> not registered.
> 
> Is that actually happening for you? I don't think it's supposed to
> happen because mpath_shutdwon_disk only happens if the head is detached
> from the subsystem, so no other thread should be able to possibly
> attempt to access that head's disk for a different controller path. That
> new controller should have to allocate an entirely new head.

Na, forget it. Not only doesn't it happen, but we need the 
'test_and_set_bit()' at the start otherwise we can't abort I/O.
So all's fine with your patch, and it even survives my testcase.

(The first to do so even after several runs, I might add :-)

Care to send an official patch?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

