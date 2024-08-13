Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C59C52D7B
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GXRgLkxyC/dpVU41pK83To0EvKa/ZG+IbZrjhmzuLqo=; b=RzYfzNtomgxpt2MVbRJqYxxU9L
	Y1FKlm1l+3LqTNlxS/R/L/lYkKMDqI8C47u0cqHXNHLqWGLTIV9npS7Qix5qt5opMjCa5xNl+afdU
	VCq1OpDfPKUp7KnOlhI5ax/zx7mlltNK/rwypmr1o0uUu9/zVAy189Ns+NiNzvI3sVs0Tz+rTGSa/
	OBSowUhKNu4VGqk//6zpIwcrFUXI5OqBKkQXajgUpRdmUKazAG6m3b7PAw7MFVr2N6vfoNgpmEo8D
	yDPzSfC0yCUG82sHdunCZe4koGqBrxWhn57ZW9/ZRUgyIJ8KZqanwbBfxS3nn6Ph50BbVatx9Ub6E
	WBG+qXzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdt22-000000047U7-0WME;
	Tue, 13 Aug 2024 15:01:54 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdnzz-00000003AJO-0wai
	for linux-nvme@lists.infradead.org;
	Tue, 13 Aug 2024 09:39:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1D12721E0B;
	Tue, 13 Aug 2024 09:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723541964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GXRgLkxyC/dpVU41pK83To0EvKa/ZG+IbZrjhmzuLqo=;
	b=jiupi3NLgPMgYfIffRAAOpn+g3K6vOr5gho1Y/P18Wm7cR3OiQoI4HFmq//jcOnrecYIOk
	/v6T+qfNSU/zE55X9UGBK3ob/2txqzFtaXwDows0ZOdDlZg2Hv4NeMZrM/Is/UeJm4H9n+
	OSVrwBXR4wlQuGpWyaZU88LgK00KDPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723541964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GXRgLkxyC/dpVU41pK83To0EvKa/ZG+IbZrjhmzuLqo=;
	b=f7RIfquVrOly7ZcFhi8/1y9O0C7jB66GbQLUHhXYSS1bEFcLDTJaMdzZI24m80ztW9Na0Z
	MrUZhK4P31W2uNBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723541964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GXRgLkxyC/dpVU41pK83To0EvKa/ZG+IbZrjhmzuLqo=;
	b=jiupi3NLgPMgYfIffRAAOpn+g3K6vOr5gho1Y/P18Wm7cR3OiQoI4HFmq//jcOnrecYIOk
	/v6T+qfNSU/zE55X9UGBK3ob/2txqzFtaXwDows0ZOdDlZg2Hv4NeMZrM/Is/UeJm4H9n+
	OSVrwBXR4wlQuGpWyaZU88LgK00KDPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723541964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GXRgLkxyC/dpVU41pK83To0EvKa/ZG+IbZrjhmzuLqo=;
	b=f7RIfquVrOly7ZcFhi8/1y9O0C7jB66GbQLUHhXYSS1bEFcLDTJaMdzZI24m80ztW9Na0Z
	MrUZhK4P31W2uNBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0348B13ABD;
	Tue, 13 Aug 2024 09:39:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RPV9AMwpu2YNSwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 13 Aug 2024 09:39:24 +0000
Date: Tue, 13 Aug 2024 11:39:23 +0200
From: Daniel Wagner <dwagner@suse.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Christoph Hellwig <hch@lst.de>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Kashyap Desai <kashyap.desai@broadcom.com>, Sumit Saxena <sumit.saxena@broadcom.com>, 
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, 
	Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, 
	Jonathan Corbet <corbet@lwn.net>, Frederic Weisbecker <frederic@kernel.org>, 
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Sridhar Balaraman <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>, 
	Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, virtualization@lists.linux.dev, 
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 04/15] scsi: replace blk_mq_pci_map_queues with
 blk_mq_dev_map_queues
Message-ID: <465981a9-69ed-4683-ad5d-806b3cd25378@flourine.local>
References: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
 <20240806-isolcpus-io-queues-v3-4-da0eecfeaf8b@suse.de>
 <038a3990-6ca2-4260-a36e-b5f0c16d8f76@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <038a3990-6ca2-4260-a36e-b5f0c16d8f76@oracle.com>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,linutronix.de,lst.de,oracle.com,redhat.com,broadcom.com,marvell.com,lwn.net,suse.de,parallelwireless.com,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,microchip.com];
	R_RATELIMIT(0.00)[to_ip_from(RLqmh8xjmb7g5apbd4gmjneg9b)];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_023927_439241_D69DE834 
X-CRM114-Status: GOOD (  18.12  )
X-Mailman-Approved-At: Tue, 13 Aug 2024 08:01:52 -0700
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

On Mon, Aug 12, 2024 at 04:31:32PM GMT, John Garry wrote:
> On 06/08/2024 13:06, Daniel Wagner wrote:
> > Replace all users of blk_mq_pci_map_queues with the more generic
> > blk_mq_dev_map_queues. This in preparation to retire
> > blk_mq_pci_map_queues.
> 
> nit: About blk_mq_dev_map_queues(), from the name it gives the impression
> that we deal in struct device, which is not the case.

What about blk_mq_hctx_map_queues?

> > +static const struct cpumask *hisi_hba_get_queue_affinity(void *dev_data,
> > +							 int offset, int idx)
> 
> personally I think that name "queue" would be better than "idx"

Yes, makes sense and would be more consistent with the rest of the code.

> > +	return blk_mq_dev_map_queues(qmap, hisi_hba, 96,
> 
> blk_mq_dev_map_queues() returns void, and so we should not return the value
> (which is void).
>
> And I know that the current code is like this, but using CQ0_IRQ_INDEX
> instead of 96 would be nicer.

Sure, will do.

