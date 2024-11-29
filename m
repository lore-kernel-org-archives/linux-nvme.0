Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC107D6EBFF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 11:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f1Br6gKgS6fdL0INNJuCKNg12N758dkumekrEVk6lDk=; b=hZxbOcH/oahZBgNTI5o0eH+Ugp
	nc/sHsUAqNsh4ngzjMoCD/k2a/OmYGP0gxrl3/I/HYspt8RTIYsPvHcvfNafy2iCNgPACJZSoHZLq
	oZCSmp3H5xWix3DbQu9QQrPNe3tw0fOW+3AXIJKbsF4f1wu95qBCga7nMnilPA0jQFZFnj3f0Md5t
	qGmEyTcJnFraLWe7ccVSiKon7wAa8zId4DHCbPafGKg/DmFm0yVhf5qFxTdPU5uIapcpEcAAZnllG
	OMOO7J5rpiCOTQSvTG5jje5azXoFO58KYYiR9AKrwh2M71H+jdFepcbZIZIoR3MK/X9d+ghi634ux
	Uii+pvCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGz0n-0000000HWIa-2kZY;
	Fri, 29 Nov 2024 11:18:13 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGz0k-0000000HWI5-3kIV
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 11:18:12 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3AFD621197;
	Fri, 29 Nov 2024 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732879089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1Br6gKgS6fdL0INNJuCKNg12N758dkumekrEVk6lDk=;
	b=fv+mCb7tXQlaixleEODXnkPMZAXZAtmQlARaw34olChGLtzZa5K5hMTf6wBMEKJdNsY2Pd
	K4I8HJS+oFKj+E+OneBseGCMr9CkxMPVDpi5LM41XLgo+oNHeAUSaXHxPrUQhGmzp9BHWY
	HxL4X3BaPiQcERkHWhwu237Cs76JGII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732879089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1Br6gKgS6fdL0INNJuCKNg12N758dkumekrEVk6lDk=;
	b=4SNVyG6fgofRN6bDsXppyue/2JVCBLvnt+tYnmUyS5S/OzKMrPWFUNVwxMy312S4o6tN/a
	NywUhbktkVLnsgAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732879088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1Br6gKgS6fdL0INNJuCKNg12N758dkumekrEVk6lDk=;
	b=QJzsne8pwKChjl/SD6WevgaQYgU/E2/uC9ps3tnOJjVVRmtwkh0dHP5E/OA0uogkzTVZF7
	WgALFIOS4zy60mP4FgcZr+4tOl+r/2hxB8/yaSyUfhwmeStOwpE9EivGjb5DHGHdglLDe0
	q3g9nfzpFKCSPK99Cm/w8Vsa/Xmy080=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732879088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1Br6gKgS6fdL0INNJuCKNg12N758dkumekrEVk6lDk=;
	b=KyWikaCsAwQLbqV6QGUbkOG0Ul5Y67D5JntY+AZXcAu0ewZ+6E8s4WNjdqgCVmrTORgdYw
	+O9kxsegzH9DC6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23758139AA;
	Fri, 29 Nov 2024 11:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SeEoCPCiSWeGdAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 Nov 2024 11:18:08 +0000
Message-ID: <6fb58b24-cb51-4287-a66c-61eabc4412c8@suse.de>
Date: Fri, 29 Nov 2024 12:18:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] nvme-rdma: unquiesce admin_q before destroy it
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1732368538.git.chunguang.xu@shopee.com>
 <9379940137a8dfddb451917c1d069eebaf3c209e.1732368538.git.chunguang.xu@shopee.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <9379940137a8dfddb451917c1d069eebaf3c209e.1732368538.git.chunguang.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_031811_100433_A969E030 
X-CRM114-Status: GOOD (  12.13  )
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

On 11/23/24 14:37, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Kernel will hang on destroy admin_q while we create ctrl failed, such
> as following calltrace:
> 
> PID: 23644    TASK: ff2d52b40f439fc0  CPU: 2    COMMAND: "nvme"
>   #0 [ff61d23de260fb78] __schedule at ffffffff8323bc15
>   #1 [ff61d23de260fc08] schedule at ffffffff8323c014
>   #2 [ff61d23de260fc28] blk_mq_freeze_queue_wait at ffffffff82a3dba1
>   #3 [ff61d23de260fc78] blk_freeze_queue at ffffffff82a4113a
>   #4 [ff61d23de260fc90] blk_cleanup_queue at ffffffff82a33006
>   #5 [ff61d23de260fcb0] nvme_rdma_destroy_admin_queue at ffffffffc12686ce [nvme_rdma]
>   #6 [ff61d23de260fcc8] nvme_rdma_setup_ctrl at ffffffffc1268ced [nvme_rdma]
>   #7 [ff61d23de260fd28] nvme_rdma_create_ctrl at ffffffffc126919b [nvme_rdma]
>   #8 [ff61d23de260fd68] nvmf_dev_write at ffffffffc024f362 [nvme_fabrics]
>   #9 [ff61d23de260fe38] vfs_write at ffffffff827d5f25
>      RIP: 00007fda7891d574  RSP: 00007ffe2ef06958  RFLAGS: 00000202
>      RAX: ffffffffffffffda  RBX: 000055e8122a4d90  RCX: 00007fda7891d574
>      RDX: 000000000000012b  RSI: 000055e8122a4d90  RDI: 0000000000000004
>      RBP: 00007ffe2ef079c0   R8: 000000000000012b   R9: 000055e8122a4d90
>      R10: 0000000000000000  R11: 0000000000000202  R12: 0000000000000004
>      R13: 000055e8122923c0  R14: 000000000000012b  R15: 00007fda78a54500
>      ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
> 
> This due to we have quiesced admi_q before cancel requests, but forgot
> to unquiesce before destroy it, as a result we fail to drain the
> pending requests, and hang on blk_mq_freeze_queue_wait() forever. Here
> try to reuse nvme_rdma_teardown_admin_queue() to fix this issue and
> simplify the code.
> 
> Reported-by: Yingfu.zhou <yingfu.zhou@shopee.com>
> Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
> Signed-off-by: Yue.zhao <yue.zhao@shopee.com>
> ---
>   drivers/nvme/host/rdma.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

