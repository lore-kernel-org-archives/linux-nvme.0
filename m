Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F7EC25B7E
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 07:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iEbJsXJg0tltZiedNmfW574yl7kKUv3QYajAj48s+Gk=; b=mipnIEpdIXAw0GBo3qX1sCKnL5
	luwH1UmK36W4+328RkomuFTfTn8UV7ghMiJSkX31ee5LWu+fIiTFwcm1Icwj6DdHtf3RQrXhAmNsW
	wI3dMQi3liOzJ0lbE9KPRNOsjFreyebdkJlUc7ieeqoqnImXg3p+7fUFOYmEpC3NK3kLgDV1cgSxS
	0qIfzHcnJqF63KJq7pVsFSmuzOcBtQMrL1lveu3QMrTZARzK+vIjLxf1a/6y0w35maIgsTfkWje8z
	ynUe4ude5U/fr7hPobvSjmQPap8BVl7IpRoSKskVbxHnbTUmf6r8h6ioZ6xqMOqolfh1mSsuBRL1b
	yEvNhpNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEOPX-00000001UIs-1Zy4;
	Tue, 04 Jun 2024 07:16:47 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEOPS-00000001UHX-1SYH
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 07:16:45 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40D38219F6;
	Tue,  4 Jun 2024 07:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717485400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEbJsXJg0tltZiedNmfW574yl7kKUv3QYajAj48s+Gk=;
	b=PeaVrnWmFeIaZb46cpPOJiQ128oEJZuC2J0qgbQpYCLF0/0gie7vAYjjfLIASP9fHyZ1Sn
	ywGhly3CvhxL6W8eXOz6NVEGQr29+mgyvv0fDAvEj59FKvFnUJFQYFBLgY3e9g0a7e2rSh
	JQ+5mxwxotCKdVP+ebV96Bb7yYzsXVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717485400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEbJsXJg0tltZiedNmfW574yl7kKUv3QYajAj48s+Gk=;
	b=xEyjkD38sr1vjKaXC2qn39sYnxlDyGVRjpdi+k4ElG8uyu4urxqQIDrJcO7+G6yjDcivZ9
	QKYni5Tl5A8UzgCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717485400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEbJsXJg0tltZiedNmfW574yl7kKUv3QYajAj48s+Gk=;
	b=PeaVrnWmFeIaZb46cpPOJiQ128oEJZuC2J0qgbQpYCLF0/0gie7vAYjjfLIASP9fHyZ1Sn
	ywGhly3CvhxL6W8eXOz6NVEGQr29+mgyvv0fDAvEj59FKvFnUJFQYFBLgY3e9g0a7e2rSh
	JQ+5mxwxotCKdVP+ebV96Bb7yYzsXVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717485400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEbJsXJg0tltZiedNmfW574yl7kKUv3QYajAj48s+Gk=;
	b=xEyjkD38sr1vjKaXC2qn39sYnxlDyGVRjpdi+k4ElG8uyu4urxqQIDrJcO7+G6yjDcivZ9
	QKYni5Tl5A8UzgCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 668251398F;
	Tue,  4 Jun 2024 07:16:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NYyJFFW/XmZJfwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Jun 2024 07:16:37 +0000
Message-ID: <393edf87-30c9-48b8-b703-4b8e514ac4d9@suse.de>
Date: Tue, 4 Jun 2024 09:16:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 00/12] Implement copy offload support
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240604043242.GC28886@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240604043242.GC28886@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,lwn.net,redhat.com,kernel.org,grimberg.me,nvidia.com,zeniv.linux.org.uk,suse.cz,oracle.com,acm.org,fromorbit.com,opensource.wdc.com,samsung.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_001642_556990_5FE65387 
X-CRM114-Status: GOOD (  15.46  )
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

On 6/4/24 06:32, Christoph Hellwig wrote:
> On Mon, Jun 03, 2024 at 10:53:39AM +0000, Nitesh Shetty wrote:
>> The major benefit of this copy-offload/emulation framework is
>> observed in fabrics setup, for copy workloads across the network.
>> The host will send offload command over the network and actual copy
>> can be achieved using emulation on the target (hence patch 4).
>> This results in higher performance and lower network consumption,
>> as compared to read and write travelling across the network.
>> With this design of copy-offload/emulation we are able to see the
>> following improvements as compared to userspace read + write on a
>> NVMeOF TCP setup:
> 
> What is the use case of this?   What workloads does raw copies a lot
> of data inside a single block device?
> 

The canonical example would be VM provisioning from a master copy.
That's not within a single block device, mind; that's more for copying 
the contents of one device to another.
But I wasn't aware that this approach is limited to copying within a 
single block devices; that would be quite pointless indeed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


