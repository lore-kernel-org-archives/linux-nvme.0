Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC89C54E67
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 10:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YY6rtv+Dl0d3knW6Fl3yRPOdwl93r2CHnCxiAmWkthM=; b=ORwmfPDwS3iE1eNYCyHbsB12vE
	qJcSxmvOqZdsGNZu+YRT3/4mw44oY5291a2tJGoWRZg+6D4XqcVmiQz1eDRqmxL+JFnfACTdXnmyK
	jN2rKFeYIN6SJ9H+qrjwPHe6Dl9VIVw4fmD3jtO/0V9XQ7K9MWyPSwxsp+skNnA430mqCt4nLqVz9
	LaHnPtify2mIsDhgOQ1NSn83V8IKRT9A8ptVYI2EX0YLrl9xySqYd2M2IBE8Jchmh+SYEi8WTTcH4
	xa4GAU6WOGUvgtveVmnNFI5Iq3hd/XnCzqgsjw2aOlLWLUXohPFMvRkrcS7hUMSHtrBx/vvm849LI
	8mLQf+tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmtd1-0000000GrOG-2ujX;
	Wed, 20 Mar 2024 10:57:03 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmtcx-0000000GrNk-2vRm
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 10:57:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710932215; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YY6rtv+Dl0d3knW6Fl3yRPOdwl93r2CHnCxiAmWkthM=;
	b=vhYFLL5O/lCRLI0ytX0I2+rCnm4sjMmXJPvM/DIs2PHd0PHjsw7ohDn69jFnVg98TuJ1ix0YkCBW7Wvr2OUM720myFQfk23LYnIIhqxlMTeC1DlgKd4pHWl4cLBAKOS3PgsU09jwcSMHcpj1I43XGB9t9CmdzE8EfMnCxv/KE+Y=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W2x9uLK_1710932211;
Received: from 30.178.90.240(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W2x9uLK_1710932211)
          by smtp.aliyun-inc.com;
          Wed, 20 Mar 2024 18:56:52 +0800
Message-ID: <3bf83a58-25f3-4e2f-93c4-3c1e94ec6e0b@linux.alibaba.com>
Date: Wed, 20 Mar 2024 18:56:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-rdma: remove NVMET_RDMA_REQ_INVALIDATE_RKEY flag
Content-Language: en-GB
To: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240320092035.22546-1-kanie@linux.alibaba.com>
 <bca94901-3d77-4779-851f-d121efff3fbf@grimberg.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <bca94901-3d77-4779-851f-d121efff3fbf@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_035700_253410_57EFCFD8 
X-CRM114-Status: UNSURE (   3.42  )
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


>
> Who clears invalidate_rkey between executions?
> I think you need to clear right after nvmet_rdma_get_rsp()

You are right, I need clear invalidate_rkey to 0 after nvmet_rdma_get_rsp().

Thanks,

Guixin Liu


