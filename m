Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE98B606A329
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=neqIYL9P;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k6WQHG06
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3vSKLY6ci4827lDDWDftJsLpYRYQ1Si00Ad4sUNwuek=; b=neqIYL9P3MidKX
	OwlLvWszGPRjonJXQZ35xZbU7KDymS3u61gHvok1pCCxpylvVbzcd0QdPCnKyr3a21RMiuOJQrKAD
	7lKT77Qc1XxxMnHY56XwCXxGQ3+tbemUrdJNmFRO9lOICg0arXM2HZQR74eFDAia2CNrti1YGZmZS
	YRoLMGJMFyKk5842sWgovBq6Oid/3fg0S1GYpc11pbunVYQRfYMmElYBcq+U/hvZe01obPTUUVBTR
	UeQTLkYuSTZHU7Jv4SyqDXxRo3esrql4RE8V43kblKP0elMsBrHfeghKItfTiq2fPQMPMSKG7omuj
	LVvSBBzuWLyyppNThQbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWBB6-00000009djb-2TVM;
	Wed, 25 Nov 2026 11:28:44 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWBB3-00000009diK-1PIG
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 11:28:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795606111; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3vSKLY6ci4827lDDWDftJsLpYRYQ1Si00Ad4sUNwuek=;
	b=k6WQHG06mKpk5SAV4xFzpWI95wFGPkT/wtio5b/6QT28EpwmqQyGPlvBI4iMhM8Mm4tbGVafzyMlctIY4dfJnk2LudvwrNYotBsG0iij11iqkPLGjWEPCueylpLQicz5cddLfQ3Ek2iXtzQGyUMfWjaXGjOT5RE90Dw6WorP0EU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFRVTh3_1795606109;
Received: from 30.178.67.246(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFRVTh3_1795606109 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 19:28:30 +0800
Message-ID: <557019e8-9699-4fc8-bd98-21a8cfd4deee@linux.alibaba.com>
Date: Wed, 25 Nov 2026 19:28:28 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: protect ana_log_buf teardown with
 ana_lock
To: Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
References: <20261125060153.206699-1-kanie@linux.alibaba.com>
 <20261125072348.GA21866@lst.de>
 <a0f493ac-7792-4390-a28f-5ee94e32ad52@linux.ibm.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <a0f493ac-7792-4390-a28f-5ee94e32ad52@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_032842_178034_AD5382DD 
X-CRM114-Status: UNSURE (   8.34  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/25 17:43, Nilay Shroff 写道:
> On 11/25/26 12:53 PM, Christoph Hellwig wrote:
>> On Wed, Nov 25, 2026 at 02:01:53PM +0800, Guixin Liu wrote:
>>> Reported by Sashiko AI review as a pre-existing issue (not introduced by
>>> the ANATT timer fix). Confirmed by source analysis and reproduced in a
>>> KASAN guest with nvmet-tcp loopback and ANA enabled.
>>
>> Sashiko thinks this is still not enough, and it's probably right.
>>
> Yes and I think we should add __guarded_by(&ctrl->ana_lock) context annotation
> around ctrl->ana_log_buf and ctrl->ana_log_size.
True, I will do the full fix in v2, thanks.

Best Regards,
Guixin Liu
>
> Thanks,
> --Nilay


