Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610DDC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 07:06:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F007460F44
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 07:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F007460F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fiX71Ls0ADB61HKlLS9RZab1p8dZ7TDOj6eITo2gZ6c=; b=Ot+ShRpwnKmK+/Oia47lHn4O9F
	xIMoao6zLyVtiCoXMgq9jf0YHf62wX8ZQv8VVdNlQtBfKPDMjkc9WJjcCIDLULGZJDraDl/HK/L/4
	7rGMuwEPSOguNbYqVCFoM02fqYFby+AZTQXlv4UByBJa617A5aZ2l22ZTvUHmHJHCou8WUw/eQ2mI
	j2TJ7oRQM/CLrQsJ5NVJpQrYl60BcEjK/3vRyTjYfgWVC1FEc6ovn/pTujrDh596UAeHLQ7i3Dh3K
	wuBbkjwwFQdBqaPVXqRwDY/lVR8+Q+WMlDyCgvYdGp2qtEl8Te5ZHalYWf7jKqJOYhTx/sLhNQwTr
	mfqQMWig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcMjG-00EQOE-FR; Mon, 18 Oct 2021 07:06:38 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcMjD-00EQNa-U0
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 07:06:37 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HXntj4bQwz1DHhW;
 Mon, 18 Oct 2021 15:04:45 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 15:06:25 +0800
Received: from [10.169.63.14] (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 15:06:25 +0800
Message-ID: <aa9042b5-d45b-ebd0-0209-e83ad79ed48e@huawei.com>
Date: Mon, 18 Oct 2021 15:06:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0
Subject: Re: [PATCH nvme-cli] huawei: filter out the partition disks
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "sunao.sun@huawei.com" <sunao.sun@huawei.com>, "jiangtao62@huawei.com"
 <jiangtao62@huawei.com>
References: <20211014091130.2083-1-chengjike.cheng@huawei.com>
 <19ce83c6-7ef6-d21d-9133-607a56c0d3d2@nvidia.com>
From: "Chengjike (ISSP)" <chengjike.cheng@huawei.com>
In-Reply-To: <19ce83c6-7ef6-d21d-9133-607a56c0d3d2@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_000636_194000_D78DDDCD 
X-CRM114-Status: UNSURE (   6.80  )
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


在 2021/10/18 13:30, Chaitanya Kulkarni 写道:
> On 10/14/21 02:11, chengjike wrote:
>> When using "nvme huawei list" command, if the current disk has partitions,
>> disk partitions will be displayed. This is not expected!
>> So filter out the disk partitions through disk name.
>>
>
> Is this specific to the Huawei or generic to all the vendors ?
>

This is a fix patch for huawei, and other vendors don't have this problem.

When the following patch is merged(when replace huawei_scan_dev_filter 
with scan_dev_filter,
the codes of partition filtering are deleted), it has this issue.
nvme-cli: Code reorg
commit: a3b3e93286a30852b7973a524b47ef35d42aa6cf



