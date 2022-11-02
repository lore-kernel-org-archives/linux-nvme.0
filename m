Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55C8C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 01:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rcbdylw3o2aVwAFOk0t5WKvNCnpRNnZmmUVeAYJe1Co=; b=UfSx+5XSf4LxXc9siFEhKP8buZ
	MBWK2EMlqrKtvGf8K+j/hL3bq6emP0ECRBcNHiDTkJLhj+hIQVenyGKf0q2BfHzl/XIsuMpEECv3k
	9Z2Z0q6L8J0/624Lz4Z6uJeGm94YUImNikwBp+GtgrRCKalJp2Oy3uc5OzdCP9CJb5EgrYOVwAEjc
	lrDpJcjXztT03prQsuDGpbl44GxXc+TW+fL6fnDvwnvYFoIkWOJMWB18hFKjUUR/3XzjpGkUlcvuv
	jGQWAmAaj+VBVqAXxtY2JJUlSJvUTjyqUIhUWyTNhpAhbWP7Jq/ZEG92+mtpJ9d9weP+WNRW5hTo7
	GgVPiIWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq2SQ-007sKo-2v; Wed, 02 Nov 2022 01:22:18 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq2SN-007sF9-3V
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 01:22:17 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N28Hk5kLqzmVKQ;
	Wed,  2 Nov 2022 09:21:54 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 09:21:57 +0800
Subject: Re: per-tagset SRCU struct and quiesce v3
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
CC: Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>
References: <20221101150050.3510-1-hch@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <814df289-8a55-b5c4-5725-0269b949e65e@huawei.com>
Date: Wed, 2 Nov 2022 09:21:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_182215_376557_ADFAD4EB 
X-CRM114-Status: UNSURE (   5.39  )
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

The series looks good!

Reviewed-by: Chao Leng <lengchao@huawei.com>


