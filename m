Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2598C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 09:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z7XsvvDD3lAGGTfjFdUJv5srpa5eDBG4LZsKF0c3GRY=; b=hIA0gUjEnUdeG1C4V6kKzETWfO
	w36WNAuk4VI6fpJcFX+Fq+GncoNpsDP6o7JIIPlr5XeBDJoxrkP5EzrehFnxfngYsDsXbImj0tzL+
	BffnvromZCX01qkWK2RxA/suG6L4dD+Ny0J7sr+aQY7+5CDRe68CvqGes9XtNOcxXA15IO+yiw/0t
	+TWMKPGi9fDSs2UjQrjjBq8xZqF8TQEMYk78bz21rL4weB0tFi93bLmKoExqmFIMGuD/CHxKIFETS
	SVz7m2ME9bWfsyBtFalx2xNgfUg9KV/5gmBWhb3YDsnss0RDyDNXI4oGNGo9Q4Z9Qr6PD8K4a/sEO
	tfHYeG8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAH9-00000003uG9-2E2c;
	Thu, 07 Mar 2024 09:42:55 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAH6-00000003uEe-1sOl
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 09:42:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709804562; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Z7XsvvDD3lAGGTfjFdUJv5srpa5eDBG4LZsKF0c3GRY=;
	b=X3WsOYdBBNX66pi89p8uq7dstNgnRHLCLmgvl1z19RErfo4TLY3AFw9tTFyK+M4GGBChIgFlpQpZdvPGQwPALp/nY3sSzxvYZp+1jVH5ivF4dMuFpssaQ42yYNS/kc2R12xPhLACbWsjz53wVLn1ihHxBI3QHbqkTSr6w/dn8ps=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2-C-8._1709804560;
Received: from 30.178.90.161(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W2-C-8._1709804560)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 17:42:41 +0800
Message-ID: <97fcbc6b-0bd4-4dad-808d-11804e97b397@linux.alibaba.com>
Date: Thu, 7 Mar 2024 17:42:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Content-Language: en-GB
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <20240201023207.112007-2-kanie@linux.alibaba.com>
 <ee516418-d072-4506-acba-d02f22cc4476@grimberg.me>
 <0c74a2c2-c9d9-4b0c-9deb-bdc3caf72005@linux.alibaba.com>
 <Zd6msstIWsNQMPfK@kbusch-mbp>
 <727aabbc-1464-48d6-9915-a1c22343c2b2@linux.alibaba.com>
 <6e34a652-da40-46f2-8a43-b45b08682e41@grimberg.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <6e34a652-da40-46f2-8a43-b45b08682e41@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_014252_706807_FA29152C 
X-CRM114-Status: UNSURE (   8.07  )
X-CRM114-Notice: Please train this message.
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


在 2024/3/7 17:27, Sagi Grimberg 写道:
> unlike abort, preempt-and-abort needs a semantic guarantee because the 
> consumer
> may rely on this for fencing purposes. So it cannot be supported in 
> "best effort" I think.
>
> A possible implementation would be not to abort as there is no such 
> interface, but
> nvmet may wait for all pending ns IO to complete and disallowing new 
> IO to come in
> (using percpu_ref_kill and percpu_ref_resurrect on ns->ref). This 
> won't work very efficiently
> withALL_REGS reservations though. 

I will think deeply，and send a v9 patch.

Best regards,

Guixin Liu


