Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68172606A323
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2ZuObpy5;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tUooAsZZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Ht/4Zv8vReTWNzwe8U7mP97/jA/SA5fhwbA7wkWleFo=; b=2ZuObpy5jRW2xG
	+m0lSNKd8/E5mZRWyd9f46wYUk/b29sB9dfc0vLHUdjeuuOi7TrQoTNyZ0vHlu+MLNWtw9t3PUQ8Y
	QxgR9Ne8FFpgdBJ5p5DnLQ6HqGgExmfT8jZn1RD4+sB+Duj8zFgJFQRKeO72O0fjj1FZrmJadTwZY
	gA+qUFLadnTgLzfBhJOCo675mPOh2K5Zr58Wo1Gh/rCGbzee0lByLu/qjpLkXb6h6JaooguA1GbeG
	cWi3H2/QJBRK8tKNInoJh5/ra43lBOoCQsGPSxtUJLDUJAY93s2+kX7QkBsCua6KFE6GmgRW7CUkY
	aNWv2QqEYmIjqPx+Mb6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6Zv-00000008iLD-1rbR;
	Wed, 25 Nov 2026 06:34:03 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6Zr-00000008iJK-1xdg
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 06:34:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795588436; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ht/4Zv8vReTWNzwe8U7mP97/jA/SA5fhwbA7wkWleFo=;
	b=tUooAsZZN1i2J8YC6EbzxWQS4fFd7IW4afqr/XbUKDcIjpOxyaKVEZ+Pu/eBO/KOdLK9eIJv9YMBvlZfyg1HyGPKxTky0Mz6Qn+I/ajgvQ2q0i2Jh3KcbN40L0vzmvvahRlFKfaeL2W7vme+mucKXP8x8MZ3YcFkoN0BdFIBU0g=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0XFQbHol_1795588435;
Received: from 30.178.67.246(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFQbHol_1795588435 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 14:33:56 +0800
Message-ID: <317af3d9-9055-42ff-adc7-4f1f0e37a210@linux.alibaba.com>
Date: Wed, 25 Nov 2026 14:33:54 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: protect ana_log_buf teardown with
 ana_lock
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261125060153.206699-1-kanie@linux.alibaba.com>
 <sashiko-outbox-232646@kernel.org>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <sashiko-outbox-232646@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_223400_193224_C31C5F75 
X-CRM114-Status: GOOD (  12.26  )
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
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/25 14:10, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] nvme-multipath: NULL deref and uninit read in
>   nvme_parse_ana_log()
> --
>
> commit d312e34ea57a3e103965fa1cad1dd210a8ca3b3a
> Author: Guixin Liu <kanie@linux.alibaba.com>
>
> nvme-multipath: protect ana_log_buf teardown with ana_lock
>
> This commit acquires ctrl->ana_lock around freeing and clearing
> ctrl->ana_log_buf in nvme_mpath_uninit() to serialize against concurrent
> ANA log parsers.
>
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 27facdbb3d4c0..bc0abd1f30274 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -1615,7 +1615,9 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>>  	 */
>>  	cancel_work_sync(&ctrl->ana_work);
>>  
>> +	mutex_lock(&ctrl->ana_lock);
>>  	kvfree(ctrl->ana_log_buf);
>>  	ctrl->ana_log_buf = NULL;
>>  	ctrl->ana_log_size = 0;
>> +	mutex_unlock(&ctrl->ana_lock);
>>  }
> [Severity: High]
> Can a concurrent parser in nvme_mpath_add_disk() still hit a NULL pointer
> dereference or read uninitialized memory in nvme_parse_ana_log() when
> nvme_mpath_uninit() unlocks ctrl->ana_lock?
>
> In the concurrent nvme_mpath_init_identify() and nvme_mpath_add_disk()
> path, nvme_mpath_add_disk() checks nvme_ctrl_use_ana() (which tests
> ctrl->ana_log_buf != NULL) before acquiring ctrl->ana_lock, and
> nvme_parse_ana_log() unconditionally dereferences
> ctrl->ana_log_buf->ngrps:
>
> CPU0                                  CPU1
> nvme_mpath_init_identify()            nvme_mpath_add_disk()
>                                         if (nvme_ctrl_use_ana(ctrl))
>   nvme_mpath_uninit()
>     mutex_lock(&ctrl->ana_lock)
>     kvfree(ctrl->ana_log_buf)
>     ctrl->ana_log_buf = NULL
>     mutex_unlock(&ctrl->ana_lock)
>                                         mutex_lock(&ctrl->ana_lock)
>                                         nvme_parse_ana_log()
>                                           ctrl->ana_log_buf->ngrps
>                                             <-- NULL pointer dereference
>   ctrl->ana_log_buf = kvmalloc(...)
>   nvme_read_ana_log()
>
> Even if CPU1 acquires ctrl->ana_lock after kvmalloc() runs in
> nvme_mpath_init_identify(), ctrl->ana_log_buf and ctrl->ana_log_size are
> assigned before nvme_read_ana_log() retakes ctrl->ana_lock to populate the
> buffer, so nvme_parse_ana_log() can parse uninitialized memory from
> kvmalloc().  In addition, while ctrl->ana_log_buf is NULL between
> nvme_mpath_uninit() and kvmalloc(), concurrent callers of
> nvme_ctrl_use_ana() transiently observe the controller as non-ANA.
Oh, Sashiko is right, I didn't fix all race condition.

1. We should check NULL under lock to prevent NULL reference.
2. Should use kvzalloc instead kvmalloc.

Changed in v2.

Best Regards,
Guixin Liu
>


