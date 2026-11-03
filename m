Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28B9606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=il0XD4sn;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GJHiRXM/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bapJExKuncQlgMbjOO4Tz6CpPBsNnousD8vFxwysKa4=; b=il0XD4sn55Dth5
	2wXiipKBFNFpye6GwwCEO3Dm31D56kFb/AEbJFOLdoSyTPx7/lWZC6d6P4IMlZ1nvq0e8DwQ1++ez
	yA9xblNQ0wJ9RaKsgiMC1FMizrzxFoN/Lw9cb0cOSb04LLWlyO864C/Ts39oeEVLh0iTksP5xxc0b
	SE0DRsTBfzYxwyxd9f/l5aE6UjnBzcmR3orV1MJCh4WH1vYehdb/REOeHWAssz4wbJHoE42DBCDbu
	lXlhPAPOfpsEG3bgci1kIPpRwopde2JF047Jq4ZItpiON2SW+YgNXe7zmiMDML5jcTxwZA6vqxchw
	+dgAgYlT3aS3Cu/Lc/0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xODVj-00000002M54-09qZ;
	Tue, 03 Nov 2026 12:21:07 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xODVg-00000002M4V-0xSQ
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 12:21:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793708462; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bapJExKuncQlgMbjOO4Tz6CpPBsNnousD8vFxwysKa4=;
	b=GJHiRXM/47OJVjPiBMWHgYCyZMzqHvjrLvYwR8fEeHjBDNYAI1+69fznwJgyz8bwEYuuJ4p8fV2dItySxlfdzOyt9kqSM5N8in7Sz8Pfp6ZzfvJXSdqLqj/1ePKAu9NmdnUFgZSVPmr648Gnb0heYra96eQ1vX3wumB8OMaVouU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XE2hjJi_1793708460;
Received: from 30.178.83.74(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XE2hjJi_1793708460 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 20:21:01 +0800
Message-ID: <630fba9b-7e23-47ea-a161-0d79d9ab1ebe@linux.alibaba.com>
Date: Tue, 3 Nov 2026 20:20:59 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/12] nvmet: FDP bridge for NVMe-oF targets
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
References: <20261029122833.284572-1-kanie@linux.alibaba.com>
 <6b361e89-8a46-42d9-ae02-f9d85a3c8549@linux.alibaba.com>
 <0c20ee56-5ff9-4c64-a7a9-84140e5e5cf0@flourine.local>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <0c20ee56-5ff9-4c64-a7a9-84140e5e5cf0@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_042104_454951_245A2F5A 
X-CRM114-Status: GOOD (  15.43  )
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



在 2026/11/3 18:18, Daniel Wagner 写道:
> Hi,
>
> On Tue, Nov 03, 2026 at 11:05:46AM +0800, Guixin Liu wrote:
>>   All the issues Sashiko raised are addressed in this v3, and it looks
>> like Sashiko has no further comments on the current version now.
>>   Please review this series, all comments are welcome. Or if can tell
>> me this approach is reasonable, I'll keep iterating on the implementation
>> details.
> Before diving deeper into the implementation details, I want to make
> sure we're aligned on the higher-level direction. As far as I recall
> from previous discussions, there has been significant hesitation around
> supporting FDP.

Has FDP passthrough support in the nvme target module been discussed before?

I'm not familiar with the history here — could you fill me in so we can align on whether we want to support it?


Best Regards,

Guixin Liu

>  
> I am happy to help review, but to respect everyone's time, it might be
> best to first confirm that this has a change to be accepted.
>
> Thanks,
> Daniel


