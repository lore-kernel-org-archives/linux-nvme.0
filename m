Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03974606B139
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qitTmGmS;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=G8da3cr+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9u6zqlZR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=G8da3cr+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9u6zqlZR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=l2kXO8R7D/HqnnkolucySnxxJxR+jPUp7l9pNnDn8RM=; b=qitTmGmSt7wuAC596cZAPg13tb
	5XHIOp3Mh6bxM91dFyMjJxNR2HIqMQguZ+Nr/07xgpoLFV//YKCkQFnKNnVHZkzYuE1+vISwIKHdZ
	3ulxML4vwkOi8bWGOD24EDRTkkVuL8kdH9Sm9BhrZN52D0P17AFJe8qrnh7FoF1YgbkRbBaxxwwKu
	oG5hpJovlbiV3xhgp35M0bntFm/6kxejcU0gL8M1IpfyiNZi6les4t7gDAS9BbDcVUQDfaA6K9DrY
	IdLIo6CQjwYhMU4AhhH3eLJ7mS3PsusfnU11X/O/DtFILJHC9ciFMudZVzOen0mMADIDhGnyrb02v
	7/HQ/Kgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBbf-00000001xvG-0Kbp;
	Tue, 03 Nov 2026 10:19:07 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBbT-00000001xsZ-1V1i
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 10:19:02 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A74582223E;
	Tue,  3 Nov 2026 10:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793701133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2kXO8R7D/HqnnkolucySnxxJxR+jPUp7l9pNnDn8RM=;
	b=G8da3cr+tLDhdtZrFG2Dy3mFwonbHK6dHOGh9nX4mvx60liZN06aBx5OQt2+l05ncOEGwI
	oxpClPC0laeVL7hFaLHxeafc4JIV4alLSNEJ2e4n9S0AUaOyHM62rK7jBqoWPlaXp0gICI
	4tr51FnQvINzcQg3IalNOLujWr7uRGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793701133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2kXO8R7D/HqnnkolucySnxxJxR+jPUp7l9pNnDn8RM=;
	b=9u6zqlZRDN1tWGL46HkARybMvc/3LjNK9c7cyYh5xxvV3QFKYcQEUZqxjhGAezj/e3b5wt
	uw4VHQTyYIHGrBAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793701133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2kXO8R7D/HqnnkolucySnxxJxR+jPUp7l9pNnDn8RM=;
	b=G8da3cr+tLDhdtZrFG2Dy3mFwonbHK6dHOGh9nX4mvx60liZN06aBx5OQt2+l05ncOEGwI
	oxpClPC0laeVL7hFaLHxeafc4JIV4alLSNEJ2e4n9S0AUaOyHM62rK7jBqoWPlaXp0gICI
	4tr51FnQvINzcQg3IalNOLujWr7uRGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793701133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2kXO8R7D/HqnnkolucySnxxJxR+jPUp7l9pNnDn8RM=;
	b=9u6zqlZRDN1tWGL46HkARybMvc/3LjNK9c7cyYh5xxvV3QFKYcQEUZqxjhGAezj/e3b5wt
	uw4VHQTyYIHGrBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60A601350A;
	Tue,  3 Nov 2026 10:18:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HNZmDg216WpZewAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 03 Nov 2026 10:18:53 +0000
Date: Tue, 3 Nov 2026 11:18:52 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/12] nvmet: FDP bridge for NVMe-oF targets
Message-ID: <0c20ee56-5ff9-4c64-a7a9-84140e5e5cf0@flourine.local>
References: <20261029122833.284572-1-kanie@linux.alibaba.com>
 <6b361e89-8a46-42d9-ae02-f9d85a3c8549@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b361e89-8a46-42d9-ae02-f9d85a3c8549@linux.alibaba.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_021901_704072_E65B1CAA 
X-CRM114-Status: GOOD (  13.80  )
X-Spam-Score: -4.4 (----)
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

Hi,

On Tue, Nov 03, 2026 at 11:05:46AM +0800, Guixin Liu wrote:
>   All the issues Sashiko raised are addressed in this v3, and it looks
> like Sashiko has no further comments on the current version now.
>   Please review this series, all comments are welcome. Or if can tell
> me this approach is reasonable, I'll keep iterating on the implementation
> details.

Before diving deeper into the implementation details, I want to make
sure we're aligned on the higher-level direction. As far as I recall
from previous discussions, there has been significant hesitation around
supporting FDP.
 
I am happy to help review, but to respect everyone's time, it might be
best to first confirm that this has a change to be accepted.

Thanks,
Daniel

