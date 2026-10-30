Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A744606A31D
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zKyTiU6I;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DpC4Fhvy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vXEZe1pJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DpC4Fhvy;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vXEZe1pJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Q4jrBtDa9XdgPx65X4O9wIPTGTES0E0M7mDS6n2yd28=; b=zKyTiU6IirnSZypb2if6PLAzQT
	od6wxw2mYAKXIOiJ0CLccTz5Cvnc9u/Wu+RWJTUxTdr6wcXbLDuBkUDRhBvw8YaYejfa+cv6rwLkq
	w0ZkjrZpWkOjNz9K8d0kkZdc2vdpSr0nmKRfGijkRfkruRpR9G6UdBdNGPj547Gq6Tq5vaje+hUzn
	2YJRCI+WyfewMJNgVVnH2ccyMYaK3Hilj2nJLt6/KBUQ+fX3HNfh669G1C2PworkZKGJTTqLBM85j
	Fs9YeLwhVqzE0jOcAFQA0Z9ilt/HzuyhvpT4ohPf833VEkCVi1Ohp1ykc/xEB/uH3eC9zClfKATNW
	g/xlMYiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMjux-0000000BPK7-01QU;
	Fri, 30 Oct 2026 10:33:03 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMjut-0000000BPJn-3dau
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 10:33:01 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C88821EB0;
	Fri, 30 Oct 2026 10:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793356377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4jrBtDa9XdgPx65X4O9wIPTGTES0E0M7mDS6n2yd28=;
	b=DpC4FhvycI7jwNItULPTfitzNbDGIKcx1UT4Xr9bU22B3MUMo2OqDylLIfSeKaj+Ph0OxZ
	Mq4M4P0tdIrBhQYvS0lE78SIQ11LQ9oL5eT6GVdtg1vEXlttJ+nfyAS8siOdc9+w3a2TPD
	X2hHbFdRKnrMSz7cn5xKqvUHccUADxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793356377;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4jrBtDa9XdgPx65X4O9wIPTGTES0E0M7mDS6n2yd28=;
	b=vXEZe1pJz/CvXHkQLyskU5i1XIX/K6kfLkF0W+dVogxYpwSayYUrI53tfYlTZPflR8N27b
	6CHVqZ5u+uPej1Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793356377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4jrBtDa9XdgPx65X4O9wIPTGTES0E0M7mDS6n2yd28=;
	b=DpC4FhvycI7jwNItULPTfitzNbDGIKcx1UT4Xr9bU22B3MUMo2OqDylLIfSeKaj+Ph0OxZ
	Mq4M4P0tdIrBhQYvS0lE78SIQ11LQ9oL5eT6GVdtg1vEXlttJ+nfyAS8siOdc9+w3a2TPD
	X2hHbFdRKnrMSz7cn5xKqvUHccUADxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793356377;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4jrBtDa9XdgPx65X4O9wIPTGTES0E0M7mDS6n2yd28=;
	b=vXEZe1pJz/CvXHkQLyskU5i1XIX/K6kfLkF0W+dVogxYpwSayYUrI53tfYlTZPflR8N27b
	6CHVqZ5u+uPej1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 656AD13419;
	Fri, 30 Oct 2026 10:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lMp1EFly5GonIQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 30 Oct 2026 10:32:57 +0000
Date: Fri, 30 Oct 2026 11:32:52 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
	Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 07/18] nvme: Introduce FENCING and FENCED controller
 states
Message-ID: <fe4f3c98-492c-418a-9ff2-b3c6cf5446cf@flourine.local>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-8-mkhalfella@purestorage.com>
 <179242929827.3619480.8550407233438315193.b4-review@b4>
 <20261019212630.GN2931-mkhalfella@purestorage.com>
 <7e73057c-698a-4ce6-b153-3b8b1077f77c@flourine.local>
 <20261021183357.GX2931-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021183357.GX2931-mkhalfella@purestorage.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org,suse.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_033300_071997_7C5761D6 
X-CRM114-Status: GOOD (  10.60  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 11:33:57AM -0700, Mohamed Khalfella wrote:
> Is Documentation/ABI/stable/sysfs-nvme a living history of sysfs-nvme
> documentation or a documentation for the specific kernel release?

I understand it documents the sysfs API. sysfs is supposed to be stable,
so adding a new state is factually a breaking change. The document
should document the current API the kernel provides.

