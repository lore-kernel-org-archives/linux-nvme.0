Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA76C6377D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 07:58:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7046461279
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 07:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7046461279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lIlrLY9vejQYVl6ulhWi3h20RdMXapjpEo6tsVP9PWQ=; b=3sZPBmvL0057FH
	BhnxPKNocZuVo7shOgJzjmIWsXTlViCq3RpTl0B8gScY7BcCPk7Wn1bclNGGHwqHPmZwsKegwUZ4C
	jg1O9fsaMnR1DBj7Y4E8OuL64FP7Nusu+j2gHmnjW55Kr4VrjydjsUVwV//GTS04vGhnVL/GGG5qt
	GmX3Ir5RTjm01Yo7s71nHZ94wELMYMu2oBXrhPXXaYG72Y3nAQAap8aFu0isKR3hBIYZL/e9Zlr39
	mSOAfPpjc2Av8pzBOaKXZxHC915fMpi+QZgKTojVEaOKIFh1NmBdplKGX+oFCjC+UFGOCHzP9iFdY
	+v/S72f6BIKsScTJLXpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6TbI-000bzY-Gl; Thu, 22 Jul 2021 07:58:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6Tb3-000bvP-PT
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 07:58:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626940700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6lwGJN8TiFLyvyvEI71qHXGC7kR0F74D2az+cv8IX3c=;
 b=VNLOSW+RFFAa31ENYkreYzf27nC0nJCzQwvzSqwnBqjFqXpIZ78PMysOjtHEoSOG+dpYjA
 iKGIbWfST5/Q7mR2LX0CVRmB7h/FmtGdLqhlD0sbynPLlvyI7sLT6IMgiauCRUjq3RR1ir
 +aX07HOoV6Rvjpq6esnrZ+pyHa/nKxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284--TOyIPhhNMqqiunAANAukQ-1; Thu, 22 Jul 2021 03:58:17 -0400
X-MC-Unique: -TOyIPhhNMqqiunAANAukQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AB9D93923;
 Thu, 22 Jul 2021 07:58:16 +0000 (UTC)
Received: from T590 (ovpn-13-219.pek2.redhat.com [10.72.13.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE72160CA1;
 Thu, 22 Jul 2021 07:58:08 +0000 (UTC)
Date: Thu, 22 Jul 2021 15:58:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YPklDMng1hL3bQ+v@T590>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
 <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com>
 <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com>
 <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_005821_928310_D07AE2B6 
X-CRM114-Status: GOOD (  14.89  )
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

On Wed, Jul 21, 2021 at 12:07:22PM +0100, John Garry wrote:
> On 21/07/2021 10:59, Ming Lei wrote:
> > > I have now removed that from the tree, so please re-pull.
> > Now the kernel can be built successfully, but not see obvious improvement
> > on the reported issue:
> > 
> > [root@ampere-mtjade-04 ~]# uname -a
> > Linux ampere-mtjade-04.khw4.lab.eng.bos.redhat.com 5.14.0-rc2_smmu_fix+ #2 SMP Wed Jul 21 05:49:03 EDT 2021 aarch64 aarch64 aarch64 GNU/Linux
> > 
> > [root@ampere-mtjade-04 ~]# taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
> > + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
> > test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
> > fio-3.27
> > Starting 1 process
> > Jobs: 1 (f=1): [r(1)][100.0%][r=1503MiB/s][r=385k IOPS][eta 00m:00s]
> > test: (groupid=0, jobs=1): err= 0: pid=3143: Wed Jul 21 05:58:14 2021
> >    read: IOPS=384k, BW=1501MiB/s (1573MB/s)(14.7GiB/10001msec)
> 
> I am not sure what baseline you used previously, but you were getting 327K
> then, so at least this would be an improvement.

Looks the improvement isn't from your patches, please see the test result on
v5.14-rc2:

[root@ampere-mtjade-04 ~]# uname -a
Linux ampere-mtjade-04.khw4.lab.eng.bos.redhat.com 5.14.0-rc2_linus #3 SMP Thu Jul 22 03:41:24 EDT 2021 aarch64 aarch64 aarch64 GNU/Linux
[root@ampere-mtjade-04 ~]# taskset -c 0 ~/git/tools/test/nvme/io_uring 20 1 /dev/nvme1n1 4k
+ fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting
test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=1489MiB/s][r=381k IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=3099: Thu Jul 22 03:53:04 2021
  read: IOPS=381k, BW=1487MiB/s (1559MB/s)(29.0GiB/20001msec)


thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
