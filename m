Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098BBD3C927
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 01:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GQA277wjiIsEsX13SC3EOBQ9MmBhGxtmhKvxedw4Rlk=; b=dl26rIR1FJiP9/5mGAm1weZl/T
	wpDt4nuji6pA3OdCLema0+/lSvJQQaHdxnJnhVuG+G3sgVE1FS95I9S2KV8CSM8cqSsBkD9YAW0V8
	PSaDZsSgdXp6OUC1vRHvnzPsA7wyK4+o83FZaulnT4HWZXpYiMK/wDI0Nsi+b3L/LoSY3UYVbzL+j
	pFG4srZ0NWY1ZANsNqY38a+O2ZUkGw5SEXYuzdyNDWZmUVAULlQtzWCg8BHOKHoictcZS563GbHdR
	TEj41zbwwiiyqlg79nLoXYfO28Lm3LXFpkzqbDyUkXv735vmM7WGE5eJS9JkeNpVg8K8OqbmzKaq4
	u8wWBD0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2hOU-00000005oHy-42Ul;
	Mon, 21 Oct 2024 01:39:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2hOK-00000005oHV-1cug
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 01:39:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729474765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQA277wjiIsEsX13SC3EOBQ9MmBhGxtmhKvxedw4Rlk=;
	b=AZeQqg/Xmcc6nimbyHORQTzSExfIcaUc8WfNYlg2yd7VTKcbmsBsCcWinVam44JESJid8n
	jjCAn+nhE2tjm7GxYooOj2jvz322XrQXAgHFYGRnY8yKOuEcSKcZGf/Y/UPaiFbov/4zmC
	NM/rQG/wfa4Yk2X7hvWsSV3P2XxFNmk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-wQlEZ6TvMaiCF-M6LJjQ4Q-1; Sun,
 20 Oct 2024 21:39:24 -0400
X-MC-Unique: wQlEZ6TvMaiCF-M6LJjQ4Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63B2719560A2;
	Mon, 21 Oct 2024 01:39:21 +0000 (UTC)
Received: from fedora (unknown [10.72.116.25])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87D5519560A2;
	Mon, 21 Oct 2024 01:39:14 +0000 (UTC)
Date: Mon, 21 Oct 2024 09:39:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: zhuxiaohui <zhuxiaohui400@gmail.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
Message-ID: <ZxWwvF0Er-Aj-rtX@fedora>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_183928_526571_A3D7A6C5 
X-CRM114-Status: GOOD (  15.44  )
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

On Sun, Oct 20, 2024 at 10:40:41PM +0800, zhuxiaohui wrote:
> From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
> 
> It is observed that nvme connect to a nvme over fabric target will
> always fail when 'nohz_full' is set.
> 
> In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
> isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
> and when nvme connect to a remote target, it may fails on this stack:
> 
>         blk_mq_alloc_request_hctx+1
>         __nvme_submit_sync_cmd+106
>         nvmf_connect_io_queue+181
>         nvme_tcp_start_queue+293
>         nvme_tcp_setup_ctrl+948
>         nvme_tcp_create_ctrl+735
>         nvmf_dev_write+532
>         vfs_write+237
>         ksys_write+107
>         do_syscall_64+128
>         entry_SYSCALL_64_after_hwframe+118
> 
> due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
> blk_mq_ctx on the hw queue.
> 
> This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
> as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
> indicate that block layer can fallback to a  blk_mq_ctx whose cpu
> is not isolated.

blk_mq_alloc_request_hctx()
	...
	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
	...

It can happen in case of non-cpu-isolation too, such as when this hctx hasn't
online CPUs, both are same actually from this viewpoint.

It is one long-time problem for nvme fc.


Thanks,
Ming


