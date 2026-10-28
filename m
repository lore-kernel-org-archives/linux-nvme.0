Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C85606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oYo/NkWy;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oGxtqA4v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nrIneqfes6JoFjXmvDcpZPQSMgS2uSEcL6WtuAIeqHY=; b=oYo/NkWyeBMEWn
	3BHspoeRP7NQCb2ooGW1kby6XsqF67hAvYqEM+LYRcyg6xoR8KEucZP+50DiTmz+f57mmg8OdJ3uU
	nBOgGmnmv4msLBjfxeLsNSkDnzkQ+saQsOS3514fKa63uj+wIRSMaSvWN0E0ASBvPXb99+Ks3rNN2
	1+qbCggFszmGSYmJ1KJZ98ssOMAZF3fO47pqAhWCIirWOGC+o1wUyua15eyoiEuTenMjWmypDtkrt
	6xk12b2se1ryimCHlgkJlRKX1sZUGxrH4J9fF4MZaOADBas3FJO5DctUFkn+4Mkd58/N7vrd3A9wd
	GOo7FEpmzDxQyJNtx+iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLyy1-00000006YEz-3DiV;
	Wed, 28 Oct 2026 08:25:05 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLyxz-00000006YDt-1uZ4
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 08:25:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793175899; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nrIneqfes6JoFjXmvDcpZPQSMgS2uSEcL6WtuAIeqHY=;
	b=oGxtqA4v87EGzrOXgvZIVTzQ3tNBWq2w1hpbWPKuAdnC0g9XxoLkPTNWPGm3XTZmaN9DLuMF1aH+D4sE8ipzJ39/VC5UoZRQdne61p5QCqy9us0DnkHOahGBAKZtmXyyWHVPxx/mexXG5EA2jtqGCG1OnU4ZolRemOdeoJz7D4k=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDgE-Ho_1793175897;
Received: from 30.178.69.77(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDgE-Ho_1793175897 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 16:24:58 +0800
Message-ID: <db1819ed-a087-46fa-acab-9f94ec778ce6@linux.alibaba.com>
Date: Wed, 28 Oct 2026 16:24:56 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: Check the admin queue before reading its TLS key
 in debugfs
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261028064417.548948-1-kanie@linux.alibaba.com>
 <2f4468e2-9b25-4df7-8ad9-606a9aee2e0b@suse.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <2f4468e2-9b25-4df7-8ad9-606a9aee2e0b@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_012503_769996_22202222 
X-CRM114-Status: GOOD (  15.78  )
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
X-Spam-Status: No, score=-24.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/10/28 15:42, Hannes Reinecke 写道:
> On 10/28/26 7:44 AM, Guixin Liu wrote:
>> nvmet_ctrl_tls_key_show() dereferences ctrl->sqs[0] unconditionally,
>> but the admin queue is not installed yet while the controller is
>> being created, and sqs[0] is set to NULL again when it is destroyed.
>> Reading the tls_key debugfs entry in either window crashes the kernel.
>>
>> Only query the queue's TLS key when the admin queue is present and
>> report 0 otherwise.
>>
>> Fixes: 316dabe6089fe ("nvmet: add tls_concat and tls_key debugfs entries")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/nvme/target/debugfs.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
>> index e85fe1d4c9f8..a27a501fe61a 100644
>> --- a/drivers/nvme/target/debugfs.c
>> +++ b/drivers/nvme/target/debugfs.c
>> @@ -136,8 +136,10 @@ NVMET_DEBUGFS_ATTR(nvmet_ctrl_host_traddr);
>>   static int nvmet_ctrl_tls_key_show(struct seq_file *m, void *p)
>>   {
>>       struct nvmet_ctrl *ctrl = m->private;
>> -    key_serial_t keyid = nvmet_queue_tls_keyid(ctrl->sqs[0]);
>> +    key_serial_t keyid = 0;
>>   +    if (ctrl->sqs[0])
>> +        keyid = nvmet_queue_tls_keyid(ctrl->sqs[0]);
>>       seq_printf(m, "%08x\n", keyid);
>>       return 0;
>>   }
>
> I think it might be easier if 'nvmet_queue_tls_keyid()' would accept
> a NULL argument.
This is simpler, however Sashiko's review points out that after the
NULL check, sq->tls_key clould be freed by nvmet_sq_put_tls_key(),
or sq itself could be destroyed. 

My idea is store admin queue's tls_key to nvmet_ctrl to prevent access
sq and sq->tls_key in debugfs interface, what do you think?

Best Regards,
Guixin Liu
>
> Cheers,
>
> Hannes


