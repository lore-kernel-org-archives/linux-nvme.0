Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26B606A337
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QUTmYnox;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1sEvuH+u;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mJJWaBAY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1sEvuH+u;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mJJWaBAY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1S8JfS/CW7jxk/rEzvNOxDJpR0OCwH1/R/kSCOJ5+S0=; b=QUTmYnox9jpVVZ
	0hz926dm0HayKHjp5Mdt3fOmJB3O3Al8lDYUvhbGbYZAxQKOrAKwhZWk+ibMnudjnU2uzCLvYV5z6
	4GTTvbljXLki3zSzbogeLXEhfaDzFfN8sLokm300cA0sD6KcVxw7oxdEiQ5SSpskc8KbxX0EMoGf8
	kK//6cWwrUgq+eTPUOh5hNLYFkaeksiuXOgnvu3o/eQBzn5t3aCQH93beB4vBzTNdaS7gmJy9c7Pi
	JoHQ6oR0G1c+ge4cxKNe/8iHH5K1Z7G8a1JaCRuZxi5TtsqUO4icNQ9lmQH75OmV9I+sdAdVoUOKX
	pAXnFQdAmb/oCoqG1T2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwfg-00000002aop-0Sgi;
	Mon, 16 Nov 2026 13:22:56 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwfd-00000002anL-2bZJ
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 13:22:54 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF91922281;
	Mon, 16 Nov 2026 13:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794835371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1S8JfS/CW7jxk/rEzvNOxDJpR0OCwH1/R/kSCOJ5+S0=;
	b=1sEvuH+ukQDc9dLNSOD+u91xY4x8bGi1WdWD0Fdryi7R2YkqGjtgronvPJb/STrzJCOKXR
	r5QXfc38T6/nj67UyfJPPQSaHjzCPajGLOw2t6OFoO+CpXgXhl+dD1GKpL1kTbQcz63g4R
	3DCraft8qJfrtYAXT5DKrXd4TQDssZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794835371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1S8JfS/CW7jxk/rEzvNOxDJpR0OCwH1/R/kSCOJ5+S0=;
	b=mJJWaBAYDCKTkhEbUWztdrKgphFo7MqOTyxBV/nTAQAxQoI5renDp2HghMnjwSbk3aKi+r
	iSJ2irRGbEUiZPDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794835371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1S8JfS/CW7jxk/rEzvNOxDJpR0OCwH1/R/kSCOJ5+S0=;
	b=1sEvuH+ukQDc9dLNSOD+u91xY4x8bGi1WdWD0Fdryi7R2YkqGjtgronvPJb/STrzJCOKXR
	r5QXfc38T6/nj67UyfJPPQSaHjzCPajGLOw2t6OFoO+CpXgXhl+dD1GKpL1kTbQcz63g4R
	3DCraft8qJfrtYAXT5DKrXd4TQDssZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794835371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1S8JfS/CW7jxk/rEzvNOxDJpR0OCwH1/R/kSCOJ5+S0=;
	b=mJJWaBAYDCKTkhEbUWztdrKgphFo7MqOTyxBV/nTAQAxQoI5renDp2HghMnjwSbk3aKi+r
	iSJ2irRGbEUiZPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89D3D1334C;
	Mon, 16 Nov 2026 13:22:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id giB1F6sD+2pMIgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Nov 2026 13:22:51 +0000
Message-ID: <6dc083eb-7286-418b-92fe-f7245f653ba0@suse.de>
Date: Mon, 16 Nov 2026 14:22:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme-auth: fix data race on ctrl->transaction
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261116081211.1757155-1-kanie@linux.alibaba.com>
 <20261116081211.1757155-3-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261116081211.1757155-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_052253_807231_48367F87 
X-CRM114-Status: GOOD (  13.52  )
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 9:12 AM, Guixin Liu wrote:
> nvme_ctrl_auth_work() queues the DH-HMAC-CHAP exchange of every queue
> on nvme-auth-wq without waiting for them, so multiple
> nvme_queue_auth_work() instances run concurrently and all increment
> ctrl->transaction in nvme_queue_auth_work(). The plain increment is a
> data race, and the lost updates hand the same transaction id to
> concurrent queues.
> 
> The counter does not need to be shared at all: the controller only
> echoes the transaction id within a queue, so a per-queue counter is
> sufficient. Increment chap->transaction instead, drop the reset in
> nvme_auth_reset_dhchap() so the id stays monotonic across
> re-authentication, and remove the now unused ctrl->transaction field.
> 
I disagree. The authentication transaction ID identifies the
transaction itself, and is used to differentiate between different
transactions. As such it needs to be unique within each queue.
But as it carries controller-specific data we should also ensure
the ID is unique per controller, ensuring we catch any possible
misdirected authentication packet.

It should be possible to move the controller value to an atomic
value, and then we could do

chap->transaction = atomic_inc_return(&ctrl->transaction);

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

