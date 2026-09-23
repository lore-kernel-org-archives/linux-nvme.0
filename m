Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE44C982FA
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 12:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X82AAFYdz7Dx5o1mkGUIY0w831FriM7mT4TbrllzsBI=; b=mR2gpRYlJVH+ObP73mkU8dQzge
	RLD5/LbugNR7U+0DxjHm8/qEdazENZe1T6q5SEWurnELA3Ny7RzGkSKXQcRqFIPqzCs/Afu3hpLJm
	qEFDEi72U+iXopzrrnAbWc0v0XeRitJY6eVXfV4dYe1XoYtzuqnaBsHS3jDNEXUUQNjQumEhbqEUp
	JkpQqzRJ9to1ntVMZVn43Yd3i7rBsjEUTWSpeLfpB48+54lZXvixctKtc/niw9s1FZAToF3JG7/Nl
	+P9ky5WWW68J3iYjVOilq28uTC6VS1dwFMBXYIDCTUosNSgccIv29KNY6kctiC6BbPP2lTCkeRuAC
	CLWUXChA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Lk8-00000008CLY-1Yyl;
	Wed, 23 Sep 2026 12:06:32 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Lk4-00000008CIb-2yqu
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 12:06:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B912421DE7;
	Wed, 23 Sep 2026 12:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790165178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X82AAFYdz7Dx5o1mkGUIY0w831FriM7mT4TbrllzsBI=;
	b=zxFC4SOvXEZr/dgW2G3gocXpVxLhsERcKHHoRkDfnotK2ckLg4EnGKKwVEsvqmAgV0B/Pt
	1T+90p7VHqFvwicUaepkKZVRWpERr7Y51VBFmiEYEa7gwM9S7ZoR14169ko0ZtamZynSaj
	CnMMgs7g0IW/exSwWlCUg9YSwV6YkDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790165178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X82AAFYdz7Dx5o1mkGUIY0w831FriM7mT4TbrllzsBI=;
	b=Cd8laXDbA2AkPm1I2qSHWWWU/vUe4+EbORJH5XOVmdXnPlJPkoqYaA38Bomapifdg0AStc
	bCqZFqkfoeT28LAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790165174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X82AAFYdz7Dx5o1mkGUIY0w831FriM7mT4TbrllzsBI=;
	b=NJWYRt8XKFyvwbU5+oYaJCzqdos8uFNTyJY9kNbmu6qwFbkIJiBwdj1/tOEfkl7eqn6KCI
	v/Cf8rYBiWOjX5xbqXOOwfHxivbeFCh5e6v18wq6rmNx3W8xoq57MPL2NBHPOOE/ScfAfs
	ozbn9ilGO1XZGIQelxuU6taxb6MVNbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790165174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X82AAFYdz7Dx5o1mkGUIY0w831FriM7mT4TbrllzsBI=;
	b=LoGAYKbW43VUgpukAc0fQwFbMsW9C5qohQrKe6o/miyDzNMvF8rJE3NvZccAjOhyXVOm2c
	PwabhdXr1AfcjCBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49D1313A6A;
	Wed, 23 Sep 2026 12:06:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ShFKB7bAs2qfSAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 23 Sep 2026 12:06:14 +0000
Message-ID: <0fef5f65-55dd-493b-935a-d54c10030046@suse.de>
Date: Wed, 23 Sep 2026 14:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme-multipath: add fail_if_no_path sysfs attribute
To: Krishna Iyer <kiyer@crusoe.ai>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 nilay@linux.ibm.com, sjpark@crusoe.ai, saravanand@crusoe.ai
References: <20260923004959.88440-1-kiyer@crusoe.ai>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260923004959.88440-1-kiyer@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_050628_901907_37B19BD9 
X-CRM114-Status: GOOD (  18.88  )
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

On 9/23/26 2:49 AM, Krishna Iyer wrote:
> When no usable path exists, I/O on a multipath namespace is queued
> until a path returns. With ctrl_loss_tmo=-1 that can be forever:
> during a long fabric outage any process waiting on the I/O is stuck in
> D state. We hit this on virtualization hosts, where a SIGKILLed VM
> process cannot exit while draining I/O to an unreachable NVMe/TCP
> target.
> 
> Nothing can fail this I/O without tearing something down: controller
> deletion takes every namespace on the controller with it.
> 
> Add a fail_if_no_path attribute on the ns-head disk: a persistent
> per-namespace policy to fail parked and newly arriving I/O instead of
> queueing it when no usable path exists. It is enforced where a path is
> known to be unusable: CONNECTING controllers and LIVE controllers with
> the path ANA inaccessible or persistent-loss stop counting as
> available, RESETTING and ANA change keep queueing, and with no
> controllers left the policy overrides the delayed_removal_secs
> queueing window. Controller state is untouched and reconnects
> continue. Like dm's fail_if_no_path, the policy is transport agnostic.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
> ---
> Changes since v2 [1]:
> - use the nvme_state_is_live() helper for the ANA state check, keeping
>    the explicit NVME_ANA_CHANGE carve-out so transient ANA transitions
>    still queue (Nilay)
> - return early when the stored value matches the current setting,
>    skipping synchronize_srcu() and the requeue kick (Nilay)
> 
[ .. ]
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a643c4723a69..9773538101ca 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -590,6 +590,7 @@ struct nvme_ns_head {
>   #define NVME_NSHEAD_DISK_LIVE		0
>   #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
>   #define NVME_NSHEAD_CDEV_LIVE		2
> +#define NVME_NSHEAD_FAIL_IF_NO_PATH	3
>   	struct nvme_ns __rcu_guarded	*current_path[];
>   #endif
>   };

Remind me again: what is the meaning of 'NVME_NSHEAD_QUEUE_IF_NO_PATH'?
Isn't this the exact opposite of the proposed
'NVME_NSHEAD_FAIL_IF_NO_PATH'?
IOW can't you rewrite this patch to use the existing 
'NVME_NSHEAD_QUEUE_IF_NO_PATH' flag instead of adding another?
(And if you have to introduce 'FAIL_IF_NO_PATH' you'd have to explain
what exactly should happen if QUEUE_IF_NO_PATH _and_ FAIL_IF_NO_PATH
are set ...)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

