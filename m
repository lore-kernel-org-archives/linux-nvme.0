Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA037C07E99
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 14:22:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D17B613B7
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 14:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D17B613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rxdUoAybUvDeIAtGqy7eA6zkzoPFjQ007NP2pW0hBa0=; b=trMhk3rFLzP/xE
	4ofYvvBNM21UTr2zV+lRXac6ZQvhxpvcicATXwJj4aR4jAcq0BBkiYTQBIY9EwHh8vdcvtngIrWw7
	gMeykFCm79mgYvpZr4NcJNXk7dZObcoEVtMORfRfX83qmCr6h4o9qlatusEKr9NtdY1+/fO17RedF
	DE1FAGUIEaiQyPvtHYJhJ6h52lXchYQHvV0WVh5jvrLBDSKijVUAbjYdAbPm187fok3BBOjWUQePc
	Ibaw+N97UdpLOHFWo6OtucqzseFDbpYAfqrTusQIWCOPhdGVDW7ElUAtWun/lacoJRQOtMMki9IEG
	y6tivtjvxfqMSp9+I0Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1rOM-001uzQ-GU; Fri, 09 Jul 2021 14:22:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1rO9-001uy1-AY
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 14:21:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625840515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R80jkwSRBMdXMIX0M3ux6M8QaLP+0xDfTy88OLoP8qM=;
 b=feOvNtOh1zykfjLq7ZWJJuuUgCyIbYxgxsO/YMg6Siv47/x8gTl8l9XU2PUJfs5l6nRFou
 yIoloi2j83wbatGgx0YTd6VOCpslhKEVUJTI1vwcslzTpwD+aCdByKek5aTL9arhQbUWqf
 gJyZmeYI/ziO232NPY+ognMQ/+z2B7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-Mi1YBWmwOS2HtCIMAe8qEg-1; Fri, 09 Jul 2021 10:21:54 -0400
X-MC-Unique: Mi1YBWmwOS2HtCIMAe8qEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C834B343CD;
 Fri,  9 Jul 2021 14:21:52 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE32F60BD8;
 Fri,  9 Jul 2021 14:21:44 +0000 (UTC)
Date: Fri, 9 Jul 2021 22:21:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-nvme@lists.infradead.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YOhbc5C47IzC893B@T590>
References: <YOgK8fdv7dOQtkET@T590>
 <20210709101614.GZ22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210709101614.GZ22278@shell.armlinux.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_072157_504342_F0D17524 
X-CRM114-Status: GOOD (  11.63  )
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

On Fri, Jul 09, 2021 at 11:16:14AM +0100, Russell King (Oracle) wrote:
> On Fri, Jul 09, 2021 at 04:38:09PM +0800, Ming Lei wrote:
> > I observed that NVMe performance is very bad when running fio on one
> > CPU(aarch64) in remote numa node compared with the nvme pci numa node.
> 
> Have you checked the effect of running a memory-heavy process using
> memory from node 1 while being executed by CPUs in node 0?

1) aarch64
[root@ampere-mtjade-04 ~]# taskset -c 0 numactl -m 0  perf bench mem memcpy -s 4GB -f default
# Running 'mem/memcpy' benchmark:
# function 'default' (Default memcpy() provided by glibc)
# Copying 4GB bytes ...

      11.511752 GB/sec
[root@ampere-mtjade-04 ~]# taskset -c 0 numactl -m 1  perf bench mem memcpy -s 4GB -f default
# Running 'mem/memcpy' benchmark:
# function 'default' (Default memcpy() provided by glibc)
# Copying 4GB bytes ...

       3.084333 GB/sec


2) x86_64[1]
[root@hp-dl380g10-01 mingl]#  taskset -c 0 numactl -m 0  perf bench mem memcpy -s 4GB -f default
# Running 'mem/memcpy' benchmark:
# function 'default' (Default memcpy() provided by glibc)
# Copying 4GB bytes ...

       4.193927 GB/sec
[root@hp-dl380g10-01 mingl]#  taskset -c 0 numactl -m 1  perf bench mem memcpy -s 4GB -f default
# Running 'mem/memcpy' benchmark:
# function 'default' (Default memcpy() provided by glibc)
# Copying 4GB bytes ...

       3.553392 GB/sec


[1] on this x86_64 machine, IOPS can reach 680K in same fio nvme test 



Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
