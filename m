Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7D6C07E9B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 11:08:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B01608FC
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 11:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B01608FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I+J+lB58svU/L9DyfoMnMYyw9jSASl8lhNRhlWsWff0=; b=WaySw0KhwC/wrwZ5hpLF0PfgLS
	Zs5w+H1bTVLh8D898G2DyWCKHf5yRDMXL5vXp63tOf2Q576QjkBm8SdBkBM/Mzqeox5Dh+aeEYkVq
	8R6cE43GAud5ELm3M8iYX0J2FLHsy2iFVITylYW2JIFiLXVC4guxXE2fQftS1IGYqT6umZunvbcEF
	/xA5wW+Ff0uuiPIgic5ZDnjCJaohOsDpbHI6kFs90uv4JZz3II1vOLA2HP/IL2wFnrCe8a5bYjuCl
	+v0aVBySFvFBTSytEfIy7rwNHNEvU5S8PAc8rmXToP2AT5XRnH5IMaMzhoivoOBTGaaMk0T/gm4jG
	IEYXn6Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6A4o-00FNqp-Jr; Wed, 21 Jul 2021 11:07:46 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6A4Y-00FNoU-VT; Wed, 21 Jul 2021 11:07:33 +0000
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVC8m0yxyz6D8Wf;
 Wed, 21 Jul 2021 18:52:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Jul 2021 13:07:26 +0200
Received: from [10.47.85.43] (10.47.85.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 21 Jul
 2021 12:07:25 +0100
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Ming Lei <ming.lei@redhat.com>
CC: Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com> <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com> <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com> <YPfwAN1onpSKoeBj@T590>
From: John Garry <john.garry@huawei.com>
Message-ID: <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com>
Date: Wed, 21 Jul 2021 12:07:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YPfwAN1onpSKoeBj@T590>
Content-Language: en-US
X-Originating-IP: [10.47.85.43]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210721_040731_214774_07D41179 
X-CRM114-Status: UNSURE (   9.84  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21/07/2021 10:59, Ming Lei wrote:
>> I have now removed that from the tree, so please re-pull.
> Now the kernel can be built successfully, but not see obvious improvement
> on the reported issue:
> 
> [root@ampere-mtjade-04 ~]# uname -a
> Linux ampere-mtjade-04.khw4.lab.eng.bos.redhat.com 5.14.0-rc2_smmu_fix+ #2 SMP Wed Jul 21 05:49:03 EDT 2021 aarch64 aarch64 aarch64 GNU/Linux
> 
> [root@ampere-mtjade-04 ~]# taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
> test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
> fio-3.27
> Starting 1 process
> Jobs: 1 (f=1): [r(1)][100.0%][r=1503MiB/s][r=385k IOPS][eta 00m:00s]
> test: (groupid=0, jobs=1): err= 0: pid=3143: Wed Jul 21 05:58:14 2021
>    read: IOPS=384k, BW=1501MiB/s (1573MB/s)(14.7GiB/10001msec)

I am not sure what baseline you used previously, but you were getting 
327K then, so at least this would be an improvement.

> 
> [root@ampere-mtjade-04 ~]# taskset -c 80 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
> test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
> fio-3.27
> Starting 1 process
> Jobs: 1 (f=1): [r(1)][100.0%][r=138MiB/s][r=35.4k IOPS][eta 00m:00s]
> test: (groupid=0, jobs=1): err= 0: pid=3063: Wed Jul 21 05:55:31 2021
>    read: IOPS=35.4k, BW=138MiB/s (145MB/s)(1383MiB/10001msec)

I can try similar on our arm64 board when I get a chance.

Thanks,
John

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
