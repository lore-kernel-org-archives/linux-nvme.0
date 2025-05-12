Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE60C3ABC3
	for <linux-nvme@archiver.kernel.org>; Mon, 12 May 2025 05:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Z+ke6MvJ0YG/IdZESuXdXK68o3nGTRbajQEJraDSeo=; b=4RfSEj7kWaWIRwZmv7rzgtXO4D
	tVp+q6hpXCJ7y+CIizAQy5+bPFaWfQ0m49mGAgad9QdVMvu5fbZLmWvaQZWOtxKgmpdIV6anxak4N
	YH9Eai3VTr+5gbXPBtII+IU/VDiTotfEROIN2w4coGcP0Y8Dszg4vuKD7VcxBdL5fx3eb8D/Xy5nr
	1njyjWucST4P5LNt57TEaI7SK6G2wT4Z7ZvvZSiehf5KFHXYWzJzGrcnPc8BOJaf9501l9Y25MjKV
	/DIHIH8veN7Opxl+WqZGXnNrtB1p0PkfD3yv6gEPPw9Tkt646kVd4PylKjTyR0C8LZgKTKzQ9svdC
	PiD1BKAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEM4m-00000008Rxd-370o;
	Mon, 12 May 2025 05:51:44 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEM4j-00000008Rx3-41PC
	for linux-nvme@lists.infradead.org;
	Mon, 12 May 2025 05:51:43 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CF3D1F391;
	Mon, 12 May 2025 05:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747029098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Z+ke6MvJ0YG/IdZESuXdXK68o3nGTRbajQEJraDSeo=;
	b=TbSpXZRGMSYHU/63kl3ptv6gLJyAQzQ2BWscMBC7QxMt8nHOkBxIw3UgrQajgT0OQmnWjD
	RQzHgnAnli3F10BylpfHXUYNd7q2Cf9fO/H0ScQaW7G4JMsYShngCSPQKs/X2iWL1x6Sro
	R2d6c94TqTsQvdi9OC9JXjFWez/zwGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747029098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Z+ke6MvJ0YG/IdZESuXdXK68o3nGTRbajQEJraDSeo=;
	b=kk9LU+dAI9vZ2AOf7Yhq8gJLEgkQ9N3KvaS7xmyk0T8oxhnH3tr/nq/OZZWwZRMEmyFyws
	KpU2PQtZVK5QLwDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TbSpXZRG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kk9LU+dA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747029098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Z+ke6MvJ0YG/IdZESuXdXK68o3nGTRbajQEJraDSeo=;
	b=TbSpXZRGMSYHU/63kl3ptv6gLJyAQzQ2BWscMBC7QxMt8nHOkBxIw3UgrQajgT0OQmnWjD
	RQzHgnAnli3F10BylpfHXUYNd7q2Cf9fO/H0ScQaW7G4JMsYShngCSPQKs/X2iWL1x6Sro
	R2d6c94TqTsQvdi9OC9JXjFWez/zwGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747029098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Z+ke6MvJ0YG/IdZESuXdXK68o3nGTRbajQEJraDSeo=;
	b=kk9LU+dAI9vZ2AOf7Yhq8gJLEgkQ9N3KvaS7xmyk0T8oxhnH3tr/nq/OZZWwZRMEmyFyws
	KpU2PQtZVK5QLwDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E2C813794;
	Mon, 12 May 2025 05:51:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jySVCGqMIWjzbQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 May 2025 05:51:38 +0000
Message-ID: <e7aee53a-4ac1-42dc-b492-e83e4f2a5c9d@suse.de>
Date: Mon, 12 May 2025 07:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv4 1/3] nvme-multipath: introduce delayed removal of
 the multipath head node
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, jmeneghi@redhat.com,
 axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250509175158.2753396-1-nilay@linux.ibm.com>
 <20250509175158.2753396-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250509175158.2753396-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7CF3D1F391
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,infradead.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250511_225142_238011_D106D3EA 
X-CRM114-Status: GOOD (  16.76  )
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

On 5/9/25 19:51, Nilay Shroff wrote:
> Currently, the multipath head node of an NVMe disk is removed
> immediately as soon as all paths of the disk are removed. However,
> this can cause issues in scenarios where:
> 
> - The disk hot-removal followed by re-addition.
> - Transient PCIe link failures that trigger re-enumeration,
>    temporarily removing and then restoring the disk.
> 
> In these cases, removing the head node prematurely may lead to a head
> disk node name change upon re-addition, requiring applications to
> reopen their handles if they were performing I/O during the failure.
> 
> To address this, introduce a delayed removal mechanism of head disk
> node. During transient failure, instead of immediate removal of head
> disk node, the system waits for a configurable timeout, allowing the
> disk to recover.
> 
> During transient disk failure, if application sends any IO then we
> queue it instead of failing such IO immediately. If the disk comes back
> online within the timeout, the queued IOs are resubmitted to the disk
> ensuring seamless operation. In case disk couldn't recover from the
> failure then queued IOs are failed to its completion and application
> receives the error.
> 
> So this way, if disk comes back online within the configured period,
> the head node remains unchanged, ensuring uninterrupted workloads
> without requiring applications to reopen device handles.
> 
> A new sysfs attribute, named "delayed_removal_secs" is added under head
> disk blkdev for user who wish to configure time for the delayed removal
> of head disk node. The default value of this attribute is set to zero
> second ensuring no behavior change unless explicitly configured.
> 
> Link: https://lore.kernel.org/linux-nvme/Y9oGTKCFlOscbPc2@infradead.org/
> Link: https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> [nilay: reworked based on the original idea/POC from Christoph and Keith]
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      |   8 ++-
>   drivers/nvme/host/multipath.c | 130 +++++++++++++++++++++++++++++++---
>   drivers/nvme/host/nvme.h      |  16 ++++-
>   drivers/nvme/host/sysfs.c     |   7 ++
>   4 files changed, 147 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

