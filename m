Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7811C07E99
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:38:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E2C613CA
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E2C613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KztimM+ka7JHipB/wIhgrqAjppUqZbZOn3HFxNnllYI=; b=Q6yabYsLbOrtZz
	dmBKStouceQILhE4x15n/16gj8oSdCnHCBt3PeAJ5ncpx2zJMalCYWtZG6tS0h/HFpvz4tZCtfCdS
	MqnUQtNoSZezpWJp9SJnkrKDXeGAW2OGUZdRNdu/Wk8kughxbInV274GuXbLV8DEqCMKqh2CxcA4/
	O7agr0bhRIeyEbs9c8WcFHqx6F/WRUk0M99mdVNgyn7I6b+V7QoB+SnX0lFeAxRGneKDjM5Nf9AuS
	z3ZqZhZhXOlE4tkfkA6kJiRqNb6XC9oAHSEbYcK9oEd9zvFZzixCqfbqY16sl3zXZ2xDQhf+U1gZV
	1ugXpnRDbVxuGAatWR4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1m1s-001AS6-CZ; Fri, 09 Jul 2021 08:38:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1m1f-001AQG-Kc
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 08:38:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625819902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=z6Hk4bJ8S8lcwyhof3193pL12mlYl2MQc8nr7rUonLc=;
 b=I4oKiRbBfwQ5/0j7WJZ48Wc4jyciMQIR50WnjUoqyYoT+F6TMR6vS076yv+oYTO+f/ZvkI
 pKFQjVKE5nOyITagK49QcakAS+BZM44oKlmREiLwHaw4uz+Yo7p5NORMVJlXse0KuUKJLj
 3mNyQbWA3taBXd2dKl7eAtnYGffqAts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-kW-M2W2pOPeYf3W8V_w2gA-1; Fri, 09 Jul 2021 04:38:21 -0400
X-MC-Unique: kW-M2W2pOPeYf3W8V_w2gA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EA461018720;
 Fri,  9 Jul 2021 08:38:20 +0000 (UTC)
Received: from T590 (ovpn-13-13.pek2.redhat.com [10.72.13.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C27E5C1A3;
 Fri,  9 Jul 2021 08:38:13 +0000 (UTC)
Date: Fri, 9 Jul 2021 16:38:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [bug report] iommu_dma_unmap_sg() is very slow then running IO from
 remote numa node
Message-ID: <YOgK8fdv7dOQtkET@T590>
MIME-Version: 1.0
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_013823_801711_1D99627E 
X-CRM114-Status: UNSURE (   7.07  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

I observed that NVMe performance is very bad when running fio on one
CPU(aarch64) in remote numa node compared with the nvme pci numa node.

Please see the test result[1] 327K vs. 34.9K.

Latency trace shows that one big difference is in iommu_dma_unmap_sg(),
1111 nsecs vs 25437 nsecs.


[1] fio test & results

1) fio test result:

- run fio on local CPU
taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
+ fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting

IOPS: 327K
avg latency of iommu_dma_unmap_sg(): 1111 nsecs


- run fio on remote CPU
taskset -c 80 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
+ fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting

IOPS: 34.9K
avg latency of iommu_dma_unmap_sg(): 25437 nsecs

2) system info
[root@ampere-mtjade-04 ~]# lscpu | grep NUMA
NUMA node(s):                    2
NUMA node0 CPU(s):               0-79
NUMA node1 CPU(s):               80-159

lspci | grep NVMe
0003:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983

[root@ampere-mtjade-04 ~]# cat /sys/block/nvme1n1/device/device/numa_node
0



Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
