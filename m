Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B94C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 08:06:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2823060F5A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 08:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2823060F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:CC:References:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4mGA7Xucphb5INUB+X36A8SbQOPv94fGaDQlOqNC224=; b=dsfVfhQfkSFv8HcqKlCdLFxdJ0
	3SGuUbGTxZx29fPJLeW7l5BsEKB8s02Z7HD/7MyJo/2zx8Ig47AU1foam0nzDvLpmBW1QqYVE0MJH
	BJLRNY8T7JfKeIz2a4ArUxhSU7pWZg6D2t8dxYiXOfEr3h++BL4l+aiiyTsR2kXJJ3XsM50NRSy45
	RVu7mh41OsFbri/BJJuBtZgQeNrz5FmyBgG8gmcvZheiC2UMyleqaqcmIuoj7BuTNS5cKzkkgz7iw
	ocGNTiYchxtGr7rDsZ3Ov+s0rh65Bx188swZ/hvu5saQLhDtY9eQMPknuMy5SAvuHwB33Q6wmfI8D
	8najd0AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1miBHP-004SyL-RQ; Wed, 03 Nov 2021 08:05:55 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miBHM-004Sx1-N8
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 08:05:54 +0000
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HkfTT17R2z90k7;
 Wed,  3 Nov 2021 16:05:33 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Wed, 3
 Nov 2021 16:05:41 +0800
Subject: Re: [PATCH 14/16] block: switch polling to be bio based
To: Christoph Hellwig <hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-15-hch@lst.de>
 <beb633f4-4508-ea53-4a34-adf0f20cda85@hisilicon.com>
 <20211103072223.GB31003@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Jeffle Xu <jefflexu@linux.alibaba.com>, Ming
 Lei <ming.lei@redhat.com>, Damien Le Moal <Damien.LeMoal@wdc.com>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, "Wunderlich,
 Mark" <mark.wunderlich@intel.com>, "Vasudevan, Anil"
 <anil.vasudevan@intel.com>, <linux-block@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-nvme@lists.infradead.org>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <eb91f95b-4cb2-ef6f-a204-15b8b0077f81@hisilicon.com>
Date: Wed, 3 Nov 2021 16:05:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20211103072223.GB31003@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211103_010553_050151_6FA92AE4 
X-CRM114-Status: UNSURE (   8.18  )
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



在 2021/11/3 15:22, Christoph Hellwig 写道:
> On Wed, Nov 03, 2021 at 03:11:25PM +0800, chenxiang (M) wrote:
>> For some scsi command sent by function __scsi_execute() without data, it
>> has request but no bio (bufflen = 0),
>> then how to use bio_poll() for them ?
> You can't send these requests as polled.  Note that these are passthrough
> requests only.

Understood, thanks.


