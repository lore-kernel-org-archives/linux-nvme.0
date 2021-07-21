Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E7EC636C8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 01:41:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B436113B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 01:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B436113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tA+zq6HHCrusZlPuUr5u5NyBf76chCVQCL3HOq38Sws=; b=cBaCKm2dEKob6g
	6RfVklu6jq/TwV1x17oCAfI1UjbWtxKaQcnZ3nHChaE4sD06ecMa+cx9CWNdzRpYG4/sbca7d9+sd
	2tiHO5ecGfoXhK0QleWcduMhatA7Ak5x8WR9DN+/fG6duxrqfOr4ofMBM3pQ0/l28GYG+ymWyVI4Z
	e0QRKJtwpG6ApaWYq2Z7qWQ80U2F7hiI5mXsxxZqJCiOHnetXW78Ja/r5MlJSrUt4niIxsbSvbPOL
	AiX4EDPBKfLCu6SRvT8ACFI4KinGWc713HZ3KZLwQev4VxtzBLsTfNPubfeyvzWaP/KsoexkQT5sh
	TizvqqYXh3bdqNzmwmJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m61Ec-00EFTa-Hb; Wed, 21 Jul 2021 01:41:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m61EP-00EFRu-2M
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 01:41:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626831663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SyII5sjQfVW2iEOXEHyiVYmuKihq8QrTV1vY6sLK7cs=;
 b=B2p/Y9IzzPA8P9nX2KCELbOEBhWLPNfFhYqIm/Pz6t8985Xm5IeBt5mSVq5pgAmTaL4H8Y
 MpFtCMhmV4kgCOZshz2r2SMMTXWSG/A0B/rmzA64L1qfY8c+47DxZUMVm40tV2id/iqbZd
 lXnrx7yoWPKfFCTUWGGWBwpT1FZmT7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-3TZXnutvN6Wd7PFM0fVGXA-1; Tue, 20 Jul 2021 21:41:01 -0400
X-MC-Unique: 3TZXnutvN6Wd7PFM0fVGXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81BD9802C80;
 Wed, 21 Jul 2021 01:41:00 +0000 (UTC)
Received: from T590 (ovpn-12-206.pek2.redhat.com [10.72.12.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65F035D9DC;
 Wed, 21 Jul 2021 01:40:53 +0000 (UTC)
Date: Wed, 21 Jul 2021 09:40:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YPd7IGFZrsTRfUxE@T590>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
 <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_184105_255715_B8AE8083 
X-CRM114-Status: GOOD (  14.75  )
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

On Mon, Jul 19, 2021 at 05:14:28PM +0100, John Garry wrote:
> On 09/07/2021 15:24, Ming Lei wrote:
> > > associated compromises.
> > Follows the log of 'perf report'
> > 
> > 1) good(run fio from cpus in the nvme's numa node)
> 
> Hi Ming,
> 
> If you're still interested in this issue, as an experiment only you can try
> my rebased patches here:
> 
> https://github.com/hisilicon/kernel-dev/commits/private-topic-smmu-5.14-cmdq-4
> 
> I think that you should see a significant performance boost.

There is build issue, please check your tree:

  MODPOST vmlinux.symvers
  MODINFO modules.builtin.modinfo
  GEN     modules.builtin
  LD      .tmp_vmlinux.btf
ld: Unexpected GOT/PLT entries detected!
ld: Unexpected run-time procedure linkages detected!
ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.o: in function `smmu_test_store':
/root/git/linux/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3892: undefined reference to `smmu_test_core'
  BTF     .btf.vmlinux.bin.o
pahole: .tmp_vmlinux.btf: No such file or directory
  LD      .tmp_vmlinux.kallsyms1
.btf.vmlinux.bin.o: file not recognized: file format not recognized
make: *** [Makefile:1177: vmlinux] Error 1


Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
