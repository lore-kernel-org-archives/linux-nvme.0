Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC785C00144
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Jul 2022 00:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SNORJat9DEbcOZJlEG1rqLYdpNJd2IkTTq0acGBszNM=; b=M5eq794Pjt7aNtVWjbJCzwNQXo
	s0f6Tal/JBDZKlfkhMEsw1rgOmydl7CwHvEi7aaCyPiLLKg+L570PzhbAc9fLLe4hPdWNkuWmmGeF
	QO6SNPtQ1XOHHcWXSc0WgaSTc+oYOARXIa+ZGED4v09Tna0l+9ILea8fRsytrYMVgT6C8Y51nNWd8
	AuSrFn9eTzCxu1JW/kAUAgrWHvaqREEwfhHZxDVj+JdP8u5/EGTajdjQblt+D+vek0Sr24UYpjrIj
	8noCsnm0kK5M6rYpDBmk8IdKLcJhEMF49GbZ6bjeTPg3EeVORW1FniHhQUjYZdCqLiUEFnaB1qi++
	pnbDiEvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHaWT-00EokS-Sb; Sat, 30 Jul 2022 00:40:05 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHaWQ-00Eoga-VQ
	for linux-nvme@lists.infradead.org; Sat, 30 Jul 2022 00:40:04 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LvlmZ5Ch4zWfM6;
	Sat, 30 Jul 2022 08:35:58 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 30 Jul 2022 08:39:54 +0800
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
To: Christoph Hellwig <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<sagi@grimberg.me>, <kbusch@kernel.org>, <axboe@kernel.dk>
References: <20220729073948.32696-1-lengchao@huawei.com>
 <20220729142605.GA395@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <1b3d753a-6ff5-bdf1-8c91-4b4760ea1736@huawei.com>
Date: Sat, 30 Jul 2022 08:39:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220729142605.GA395@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_174003_202424_24AD8558 
X-CRM114-Status: UNSURE (   7.15  )
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



On 2022/7/29 22:26, Christoph Hellwig wrote:
> Why can't we have a per-tagset quiesce flag and just wait for the
> one?  That also really nicely supports the problem with changes in
> the namespace list during that time.
Because If quiesce queues based on tagset, it is difficult to
distinguish non-IO queues. The I/O queues process is different
from other queues such as fabrics_q, admin_q, etc, which may cause
confusion in the code logic.
> 
> .
> 

