Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D963BC79FAD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 09:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OFy++4CRN7lI0j/kviTcTSk7uFefrVuF9kwKMb0UpAU=; b=nCTHgFTCG0UnqtgMcMEv4rxwbu
	G03oH3YzbPzWTsBHbMgyr2QesLp3gxxYj0imgh0Dd68WBimweoRN7b/RLWociuQvUwQPy4PDZIiFi
	K+f2EQJKv6yuAERLub5H7i5u6kfo+CsPmeE/reI4m4/bGdhwIa3YtJBEcwoTA6cL/LGSYzabwHPJO
	I4Nt3wQk1kpM4chcePxS++U9uWj89KojK8DEfEsRDy6I9VprMsHpElUZSWs3TUOeSr3rUkUc59WJ+
	TwLwGZdOWae/pMOnJO+rlUTWiU/a5kHiOve/BJKnxRhtd3HbrH44WOUYWIgH+AmInYtzpplixt4A7
	/IbaDuWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4EIJ-0000000BFbz-0xex;
	Wed, 09 Sep 2026 09:08:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4EIH-0000000BFbe-0iUT
	for linux-nvme@bombadil.infradead.org;
	Wed, 09 Sep 2026 09:08:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OFy++4CRN7lI0j/kviTcTSk7uFefrVuF9kwKMb0UpAU=; b=ncchaULLa0qhyAE93Nn1lQataR
	qmuMy+QUbLqqBFsVW6oz1LZkhpgiQPnaoUzu5giNtkdVXu8pwELUWtR/wOG4UCt6VN6OhzgPu3242
	L2C7+3pYpXdkQgLRT+Uhf0/0IWUNsTuFf+AuwoX3vQyv4L3Ix7QaWdyvEM3KheApS1h0RmLQv+Im7
	OoKkiqdlLalVnmkZxjpCXYRf249Ga9F8J9059Uz2vDMEDosdW4OCDRUoogV9XxNi5UBdzg4Lbeend
	gfw82YA1t8j1rwy0zcKO4tOh4HSkT0Oa7aPbo1lUf6xutKOUPFUxvdoQJY4UIuzNOh1NsvWsJEHL5
	LJnDx0tg==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4EIE-00000000yIc-1XSE
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 09:08:36 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1BA931F8BA;
	Wed,  9 Sep 2026 09:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OFy++4CRN7lI0j/kviTcTSk7uFefrVuF9kwKMb0UpAU=;
	b=Po5/pt6csuOGX8PyzuJ/HsBEpeBD4LwoFbSqebdWe6SbH84IPsswwBSfUmqqSgbEltZCb4
	q8bohe5CFhBFmyF/cYJpX+hGUvM/H4OJSyEL61vPsQkm+PXeqG3l2UeAKihGgy6GpbXt43
	rGJ9v32HRdRBoMk1WLqQFQiA3WNJZks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OFy++4CRN7lI0j/kviTcTSk7uFefrVuF9kwKMb0UpAU=;
	b=yqyZRpKnxqqL08L7n8Fsrdtmc6xWr6er2ExTfOkjwLhIx59XBX82Q9bP6R15xOx8I1yoEn
	PY4ToL4D+sDAgrCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OFy++4CRN7lI0j/kviTcTSk7uFefrVuF9kwKMb0UpAU=;
	b=s7e61xk9NBwomrbxngDO3IK+wVDyEhDkGs9v0lDkqNihIsrYidJ8evsBNfMX8KdaCJW8hB
	oH0ETrY2TaVVObuATP1T70BgR48LQTL0a8P04MkBYDGGrmT8k7H5wqB6UGygsCIKywEni3
	xFiKgQ8gU3WXw1s0Ygeck41BnilMVQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OFy++4CRN7lI0j/kviTcTSk7uFefrVuF9kwKMb0UpAU=;
	b=lRoFd76AxRal62wc/D4fNcGOE4CYbdTau04mDKqRGCdkEoaOtFUuXiSGN6dO7mNKvmjRPA
	QM6VGkT8SAdOb8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4CDC1347F;
	Wed,  9 Sep 2026 09:08:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vgrSNwcioWrOWgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 09 Sep 2026 09:08:23 +0000
Date: Wed, 9 Sep 2026 11:08:15 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	hare@suse.de, kbusch@kernel.org, hch@lst.de, gjoyce@linux.ibm.com, 
	chaitanyak@nvidia.com
Subject: Re: [PATCH 0/3] nvme-cli: NIC topology aware I/O queue scaling
Message-ID: <83e6f964-0124-43a6-9673-eeed631cd16c@flourine.local>
References: <20260821144329.3620389-1-nilay@linux.ibm.com>
 <4a80220a-2cba-4a4a-85c2-7c3d3ae8a20a@grimberg.me>
 <32bcaf68-a142-4612-9967-815dd28ee2a0@linux.ibm.com>
 <9271266f-3d7e-426e-93b6-6f1f28bc9b0f@grimberg.me>
 <9691f1d3-ec06-45d2-a427-ba46df5fa57c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9691f1d3-ec06-45d2-a427-ba46df5fa57c@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_100834_557773_EB7454D9 
X-CRM114-Status: GOOD (  10.63  )
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

Hi Nilay,

On Mon, Aug 31, 2026 at 10:34:42AM +0530, Nilay Shroff wrote:
> So the policy would effectively be:
> 
> if (nr_hw_queues > 1)
>     nr_io_queues = min(nr_hw_queues, num_online_cpus);
> else
>     nr_io_queues = num_online_cpus;
> 
> This would preserve the existing behavior for single-queue devices while still using the
> NIC hardware queue count to constrain the default on multi-queue devices.

BTW, I would like to have test cases in nvme-cli for the queue
calculation etc.

Thanks,
Daniel

