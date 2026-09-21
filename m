Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CADC982ED
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 14:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dXLyIitXIRXihEvVH2hDTFHNE6dERQ29Aq4FyRubbak=; b=aVa8o56bKMu8PoXbrbWvvOuPed
	m9qKWxZtiXpYfWvvmOd44b9zuhJ9+uC8AeoZDulbUTPL8ay3JeoGe+MsTFA6PfkeT6SL61cIWfsHY
	qvNzR5ok9l1Rs1ys9vavspJovdM1kZVQodmqJT/OzGNuYI7LAFIFVIMLWPGTKopyl2dBoRDUJiCgv
	rWeazjrLIBvQr+XZpDAyJadqcm5CTntP1V0T/7vfRNw7F4wmMAhzdsMQhqaQiCu4YqWi8SwPhTdDE
	hRK6LpW6iaQqu1PWFrNO6FIQ4jkNPHhZhv9w1lGGZ8lX7wmDBSZfuDPbsfPclvKPb8N30HZXfxmj6
	qEta6f5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eYq-00000002JeZ-1RMG;
	Mon, 21 Sep 2026 14:00:00 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eYm-00000002Jdx-48mQ
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 13:59:58 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 28FBF1F385;
	Mon, 21 Sep 2026 13:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789999191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXLyIitXIRXihEvVH2hDTFHNE6dERQ29Aq4FyRubbak=;
	b=liQ7xanluPqChOfUvxWbwQSGm6HBzYL1k8ptPIuoP9PgXNwCSHg3BdyGBdOOd9K4v2ZdxG
	X2dOA76qUOdeYQPHH8LGF2gjng5YpFGb3tcOPlpTj4vpQwCVe/ANJc0a9/UcoKKv6Qsgoj
	j7bSKaZLE7Hvmd9LAtjH0BYD8/v0Z7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789999191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXLyIitXIRXihEvVH2hDTFHNE6dERQ29Aq4FyRubbak=;
	b=ucPrQT75DSJgN0N8qaefccNRLO9kSTlB/8A8wne+ftwb3I/8S2tMfB0Q2le2B/w9kncFbo
	mUkk1l6JTuR+b3Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789999187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXLyIitXIRXihEvVH2hDTFHNE6dERQ29Aq4FyRubbak=;
	b=tMYeHUNQG1kAn5C2cAjWDYegazwSO0BbuTT0wYYnL2K4VFkWRVfDR/SsfDsurpSiSQst+u
	XOcZJbmUIqnTwWvSc/bJBghqLhInC25LUSBKGxDjpGCHpj++gmbljDgqz/KJ9c+xrRm7my
	xVWIBImYkzjOuBzzu4iKZvVPlRl/+w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789999187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXLyIitXIRXihEvVH2hDTFHNE6dERQ29Aq4FyRubbak=;
	b=uDU0Ky2RlO3l6dJYTYv3jrzqnxq5vhFAQjFkGzgpje3Q8ySW/fSBzmaednVCW5JNp5Yacq
	iIGietpj/vcnnnAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F2091368D;
	Mon, 21 Sep 2026 13:59:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zqTwN1E4sWqSIgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 13:59:46 +0000
Message-ID: <16cda566-f798-427d-bc51-a069b4195c28@suse.de>
Date: Mon, 21 Sep 2026 15:59:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] nvme: add NVME_CTRL_MARGINAL flag
To: Jesse Taube <jtaubepe@redhat.com>, linux-nvme@lists.infradead.org
Cc: linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 John Meneghini <jmeneghi@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
 Chris Leech <cleech@redhat.com>, "Ewan D . Milne" <emilne@redhat.com>,
 shinichiro.kawasaki@wdc.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20260902200547.184734-1-jtaubepe@redhat.com>
 <20260902200547.184734-2-jtaubepe@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260902200547.184734-2-jtaubepe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lwn.net,linuxfoundation.org,kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,hansenpartnership.com,oracle.com,marvell.com,redhat.com,wdc.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_065957_499130_DD1002F9 
X-CRM114-Status: GOOD (  15.61  )
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

On 9/2/26 10:05 PM, Jesse Taube wrote:
> From: Bryan Gurney <bgurney@redhat.com>
> 
> Add a new controller flag, NVME_CTRL_MARGINAL, to help multipath I/O
> policies to react to a path that is set to a "marginal" state.
> 
> The "marginal" flag is initialized to false in `nvme_init_ctrl` and
> cleared in `nvme_fc_ctrl_connectivity_loss` before re-association.
> It is only cleared there, not in the generic `nvme_reset_ctrl` path,
> because the marginal condition reflects a physical link problem.
> An arbitrary controller reset does not signal that a hardware fault has
> been resolved. Calling `nvme_fc_ctrl_connectivity_loss` means the FC
> association has failed and will be re-established, so the prior link
> quality state is no longer meaningful.
> 
> Signed-off-by: Bryan Gurney <bgurney@redhat.com>
> ---
> V10 -> V1:
>   - No change
> V1 -> V2:
>   - Add nvme_ctrl_assign_marginal
>   - Fix nvme_fc_ctrl_connectivity_loss clearing wrong bit.
>   - Update commit message
> ---
>   drivers/nvme/host/core.c |  1 +
>   drivers/nvme/host/fc.c   |  4 ++++
>   drivers/nvme/host/nvme.h | 11 +++++++++++
>   3 files changed, 16 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

