Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35022C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 19:12:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1537205ED
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 19:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KfKYEkbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1537205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2WyIbhf2exABL765aioeADl8PCthqU7pHT/+1mIuVbM=; b=KfKYEkbE8ARDnG
	EyUclJMAsFbGKwMhFfVT+q53uszfDoJyhdxiiYlP2TLXbXvS6YUszy4pz/SY3R7Cxw4hzeBOESWRJ
	duKETtTWZC8rUToJ+/dfDV7DV3/4pzP3w43H0X57uZzI5pSajG1GKGUsX/4fLB5YXOKfhwi71JZXj
	8hQfMb1YU9KzvvEBSs6trIswi56GESoSIFmZhLXWJeKG+0yaqT/LkDpfuGRX9T4FEHsF7/wQ3m5Wn
	ec8O+Zdf5sYTZdZPHLmhZMHUJxr695brEfHBvLNaOhAb5mOZgaoAFZd4fQiGmPnzzKYCTnBoKlp5m
	oqm9Kyo9K+GakP9tkwwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYwnl-0001Ui-Vi; Wed, 13 May 2020 19:12:21 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYwnk-0001SZ-65; Wed, 13 May 2020 19:12:21 +0000
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 6900A127DD751;
 Wed, 13 May 2020 12:12:11 -0700 (PDT)
Date: Wed, 13 May 2020 12:12:10 -0700 (PDT)
Message-Id: <20200513.121210.1508400748648949138.davem@davemloft.net>
To: hch@lst.de
Subject: Re: remove kernel_setsockopt and kernel_getsockopt
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200513062649.2100053-1-hch@lst.de>
References: <20200513062649.2100053-1-hch@lst.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 13 May 2020 12:12:12 -0700 (PDT)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_121220_229193_1123F5CA 
X-CRM114-Status: GOOD (  10.86  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: marcelo.leitner@gmail.com, edumazet@google.com,
 linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 target-devel@vger.kernel.org, linux-afs@lists.infradead.org,
 drbd-dev@lists.linbit.com, linux-cifs@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, cluster-devel@redhat.com,
 kuznet@ms2.inr.ac.ru, linux-block@vger.kernel.org, kuba@kernel.org,
 ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, nhorman@tuxdriver.com,
 yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, vyasevich@gmail.com,
 linux-kernel@vger.kernel.org, jmaloy@redhat.com, ying.xue@windriver.com,
 ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Christoph Hellwig <hch@lst.de>
Date: Wed, 13 May 2020 08:26:15 +0200

> Hi Dave,
> 
> this series removes the kernel_setsockopt and kernel_getsockopt
> functions, and instead switches their users to small functions that
> implement setting (or in one case getting) a sockopt directly using
> a normal kernel function call with type safety and all the other
> benefits of not having a function call.
> 
> In some cases these functions seem pretty heavy handed as they do
> a lock_sock even for just setting a single variable, but this mirrors
> the real setsockopt implementation - counter to that a few kernel
> drivers just set the fields directly already.
> 
> Nevertheless the diffstat looks quite promising:
> 
>  42 files changed, 721 insertions(+), 799 deletions(-)

Overall I'm fine with these changes, but three things need to happen
before I can think about applying this:

1) Address David's feedback about the ip_mtu*() calls that can occur
   on ipv6 sockets too.

2) Handle the feedback about dlm now bringing in sctp even if sctp
   sockets are not even used because of the symbol dependency.

3) Add the rxrpc documentation requested by David.

Thank you.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
