Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3987606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=d4BQTb2Y;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Iej7ZZn/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=E+R5ldVMnM6SiHaqzRNgI339c5i8U3B8zxVyFHNBoRg=; b=d4BQTb2YIcw/Tt
	6LQB/BKydFC/2lIDF6HRWb0wRkEgHQT8bzdgeynycTo4NKi/0B6pghk1M5K6xU2iWabbqKypHolmg
	zGrHNDjRdi4/f3xTZ70Sakr4SWRYbV4E5wRGb3POeJ5Imh8HOrPgJLYDz4m46/Ct9I/wb4Se73WL0
	1elleJt38JratZS39Ot2gjwXdZyPrtf6AQKkQTCJ71xEonfz4VkKXPEBQSpA9MMIJP69u2Udk7gJ1
	Fa0bhuYNpJVYv9hFYvmT6fhsAw80pPdURH+gDVDMj94exEtL07aFQRwzXiKTZI2V2xbgsqy/iV7dc
	Y3fl2JUxr2fufhVdxboA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQFEV-0000000H8j6-34ib;
	Mon, 09 Nov 2026 02:35:43 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQFES-0000000H8ii-2rCV
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 02:35:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794191738; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=E+R5ldVMnM6SiHaqzRNgI339c5i8U3B8zxVyFHNBoRg=;
	b=Iej7ZZn/VVOzoXTmDJmuE1tnfomuQ35iXjW6om2wcVGMNSNuCwZFqm1be75tuFzM2tiJrh63Pci1A7dLgw2R6wT0bRJQj1Uo/cCtNiKd+ICNz+KCvoirxW71wAtaTdLbbmmdgx1YCy5tEDarwdld8Z6bAQW99MgJAoLV6F2v50w=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEIBK5K_1794191736;
Received: from 30.178.85.177(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEIBK5K_1794191736 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 10:35:37 +0800
Message-ID: <ae3b49ac-5eb8-45a3-8f3d-9710873ecfbb@linux.alibaba.com>
Date: Mon, 9 Nov 2026 10:35:35 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet: Handle a NULL admin queue in
 nvmet_queue_tls_keyid()
From: Guixin Liu <kanie@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
References: <20261029034306.3626274-1-kanie@linux.alibaba.com>
 <20261029121552.GC24375@lst.de>
 <6d28ec32-b6af-425c-9cbc-ac1172baf979@linux.alibaba.com>
In-Reply-To: <6d28ec32-b6af-425c-9cbc-ac1172baf979@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_183541_059498_FA41EC0F 
X-CRM114-Status: GOOD (  21.39  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL,WEIRD_QUOTING autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christoph,
  Any feedback?

Best Regards,
Guixin Liu

在 2026/10/30 10:36, Guixin Liu 写道:
>
> 在 2026/10/29 20:15, Christoph Hellwig 写道:
>> On Thu, Oct 29, 2026 at 11:43:06AM +0800, Guixin Liu wrote:
>>> The admin queue is not necessarily installed when the tls_key debugfs
>>> entry is read: it may not have been created yet, or it may have been
>>> destroyed already.  nvmet_queue_tls_keyid() then dereferences a NULL
>>> sq.
>>>
>>> Guard the helper and return 0 instead, which also covers the read
>>> racing with admin queue teardown.
>> The patch itself looks obviously fine, but do we have any synchronization
>> that ensure it does not go away while we're looking at the submission
>> queue?
> The nvmet_sq has percpu_ref, but it can keep nvmet_sq_destroy() from
> freeing sq only, it can't keep nvmet_tcp_release_queue_work() from
> setting tls_key to NULL, so we need serialize with nvmet_sq_put_tls_key():
>
> """""
> diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
> index e85fe1d4c9f8..cc451e25ea1d 100644
> --- a/drivers/nvme/target/debugfs.c
> +++ b/drivers/nvme/target/debugfs.c
> @@ -136,8 +136,19 @@ NVMET_DEBUGFS_ATTR(nvmet_ctrl_host_traddr);
>  static int nvmet_ctrl_tls_key_show(struct seq_file *m, void *p)
>  {
>         struct nvmet_ctrl *ctrl = m->private;
> -       key_serial_t keyid = nvmet_queue_tls_keyid(ctrl->sqs[0]);
> -
> +       struct nvmet_sq *sq = ctrl->sqs[0];
> +       key_serial_t keyid = 0;
> +
> +       /*
> +        * Pin the admin queue against teardown, and serialize with
> +        * nvmet_sq_put_tls_key() so the key cannot be dropped mid-read.
> +        */
> +       if (sq && percpu_ref_tryget_live(&sq->ref)) {
> +               mutex_lock(&ctrl->lock);
> +               keyid = nvmet_queue_tls_keyid(sq);
> +               mutex_unlock(&ctrl->lock);
> +               percpu_ref_put(&sq->ref);
> +       }
>         seq_printf(m, "%08x\n", keyid);
>         return 0;
>  }
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index e315f1c24e73..24df9e4a1e1c 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -957,13 +957,17 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
>  #ifdef CONFIG_NVME_TARGET_TCP_TLS
>  static inline key_serial_t nvmet_queue_tls_keyid(struct nvmet_sq *sq)
>  {
> +       if (!sq)
> +               return 0;
>         return sq->tls_key ? key_serial(sq->tls_key) : 0;
>  }
>  static inline void nvmet_sq_put_tls_key(struct nvmet_sq *sq)
>  {
>         if (sq->tls_key) {
> +               mutex_lock(&sq->ctrl->lock);
>                 key_put(sq->tls_key);
>                 sq->tls_key = NULL;
> +               mutex_unlock(&sq->ctrl->lock);
>         }
>  }
> """"
>
> Best Regards,
> Guixin Liu


