Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B79DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 08:51:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D79360F0F
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 08:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D79360F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:From:CC:To:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TUd+DICeOE+E/4hpDjTgBTobGxi4ctjBhA/gLNgPBD0=; b=SZ3bCx7vAfR/RrFd2WbNywagVa
	0zM3RGKAJqOgLKVUVRdkXSz+aDEV2qd/bBUVW23RKv9FfTDi8eU/tyu1iJS7k7UuVLWNikm76voo1
	RU82eiZrB1yipG4S7U65egC10T51y1Va6rUPpmjG1csK13ePXhmRDNTQkxlptvy4kSo0ueZSaO0Nf
	D2ADCROoMjLFq1vhFj4IHJSxAYfPkXNTxhp+0SzlgF5IYGSWaD760mBIpkyIxXEUSCkHO4K08a3PS
	BdQujKWrjDQYh7vTcxR2DSZAEDFnVj0arwpjJJzDCJhODmGj2CydJ7cGrV7VrB5OjfxvH3OI83jR+
	1f0LQxxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfeeR-004M4t-UX; Wed, 27 Oct 2021 08:51:15 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfeeO-004M2s-7B
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 08:51:14 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HfMjl3b1RzbhG6;
 Wed, 27 Oct 2021 16:46:19 +0800 (CST)
Received: from kwepemm600011.china.huawei.com (7.193.23.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 27 Oct 2021 16:50:58 +0800
Received: from [10.169.46.19] (10.169.46.19) by kwepemm600011.china.huawei.com
 (7.193.23.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 27 Oct
 2021 16:50:57 +0800
To: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: <linux-nvme@lists.infradead.org>
From: liruozhu <liruozhu@huawei.com>
Subject: consultation about NVME_SGL_FMT_INVALIDATE not set when using
 nvme-rdma t10-pi
Message-ID: <ff7c0b84-e0e4-e22d-1ab8-1b31a0aeaf3b@huawei.com>
Date: Wed, 27 Oct 2021 16:50:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600011.china.huawei.com (7.193.23.229)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211027_015113_171617_A9B9280A 
X-CRM114-Status: UNSURE (   7.02  )
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

Hi Max,

I was testing T10-PI feature of nvme-rdma recently, and found that when 
using T10-PI, nvme-rdma driver did not set NVME_SGL_FMT_INVALIDATE flag 
in the sgl type field, so the host software needs to do invalid rkey by 
itself. I tried to add the flag to test it. Turns out T10-PI feature is 
still working, and I get better IO latency with it enable.
I read the original patches in the mailing list, and found that patch v1 
set this flag. But it was silent dropped on patch v5 without any 
comments. Is it for any special considerations to delete it?

Thanks,
Ruozhu


