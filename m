Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90D606A32E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lj04v+xA;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fbueesWb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UV8wFrRd9rkiIlpugBk7ezJ4Swo/IBOIk9B+puP7igc=; b=lj04v+xAt1gpkT
	jGnfKQ90T9qz1GjaoPYWzQ4g18p33ptTojI+tduNQzTpQ6PPXiuFMVxQJmBoY9n1wLt2lwuhrNaOi
	8jkCQG8hJ8JuhdpNRQ07EnKhWoirbQ5dxL590CQqQdSnbsgg1vNyh7M4OGd1mcvwoBWfHABoLb31d
	lYuLJaKQE/HfNrdd/in/tMzZfQT9fqMZq1bW7Z2JQ4j46DieIe5McDP3ew93kWOspZa6ToTznOO6l
	48awsaRl9r/LQEf7VMh14TlR5kg3LhNk8GcogRnfQMlUXGcH6VHy56W42Y+hDbgjXgmsR/NuqBVzY
	HwK2j/ZmvGANDTDI+Ejw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVpkf-00000006Whw-1aV3;
	Tue, 24 Nov 2026 12:36:01 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVpka-00000006Whc-3hPH
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 12:35:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795523753; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UV8wFrRd9rkiIlpugBk7ezJ4Swo/IBOIk9B+puP7igc=;
	b=fbueesWb+W+ED/zAZq0li/y9F0G2ifI4Ae4XvJv3Xpt013wSRtvujdgBC3cj3sFQ+COVG2nwddvco1hlpud6ENCzb9EuNu8ye3NkRAKc+vDUJHnurStqM0uMnpG5wFmXa2QHQY5FcNdmt+V/Aa4hQXx3oK9AZqXyrHazaa5Qijg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0XFObgDc_1795523752;
Received: from 30.178.69.52(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFObgDc_1795523752 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 20:35:53 +0800
Message-ID: <e7e925d7-27e9-4961-b405-aef832525dba@linux.alibaba.com>
Date: Tue, 24 Nov 2026 20:35:51 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: delete the ANATT timer after draining
 ana_work
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261124121349.1861269-1-kanie@linux.alibaba.com>
 <sashiko-outbox-231129@kernel.org>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <sashiko-outbox-231129@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_043557_351372_53E44C67 
X-CRM114-Status: GOOD (  13.72  )
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



在 2026/11/24 20:22, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [Critical] nvme-multipath: use-after-free in nvme_parse_ana_log() [1]
> --
>
> commit e4ad87877e854ebed2991236e7f5c8c425e05678
> Author: Guixin Liu <kanie@linux.alibaba.com>
>
> nvme-multipath: delete the ANATT timer after draining ana_work
>
> This commit cancels ana_work before deleting anatt_timer in
> nvme_mpath_stop() and also deletes the timer in nvme_mpath_uninit() after
> draining ana_work.
>
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 27facdbb3d4c0..40f6cab3db47c 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
> [ ... ]
>
>> @@ -1614,6 +1614,7 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>>  	 * resources.
>>  	 */
>>  	cancel_work_sync(&ctrl->ana_work);
>> +	timer_delete_sync(&ctrl->anatt_timer);
>>  
>>  	kvfree(ctrl->ana_log_buf);
>>  	ctrl->ana_log_buf = NULL;
> [Severity: Critical]
> This problem wasn't introduced by this patch, but can freeing
> ctrl->ana_log_buf here without holding ctrl->ana_lock cause a
> use-after-free in nvme_parse_ana_log() [1]?
>
> When nvme_mpath_init_identify() sees a larger ana_log_size, it calls
> nvme_mpath_uninit() to free the old buffer before allocating a new one,
> without taking ctrl->ana_lock.  A concurrent namespace scan in
> nvme_mpath_add_disk() takes ctrl->ana_lock and reads ctrl->ana_log_buf in
> nvme_parse_ana_log():
>
> CPU0                                CPU1
> nvme_mpath_init_identify()          nvme_mpath_add_disk()
>                                       if (nvme_ctrl_use_ana(ns->ctrl))
>                                         mutex_lock(&ns->ctrl->ana_lock)
>                                         nvme_parse_ana_log()
>                                           base = ctrl->ana_log_buf
>   nvme_mpath_uninit()
>     kvfree(ctrl->ana_log_buf)
>                                           /* dereferences freed base */
>                                           <-- use-after-free
>
> Taking ctrl->ana_lock around freeing and replacing ctrl->ana_log_buf would
> serialize this with concurrent readers.
>
> [1] https://sashiko.dev/#/bug/linux-48603474-5139-4b24-a567-ce7f9706b201
What Sashiko found is a pre-existing bug, not something introduced by this patch.

Let me check wheather I can send a separate patch for it.

Best Regards,
Guixin Liu
>


