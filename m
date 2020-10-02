Return-Path: <SRS0=oqNq=DJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D463C35257
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 22:28:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB487206B6
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 22:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s1qnQJL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB487206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:From:Subject:To:
	Message-Id:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DplTVnI/LCyLY43X0MrU2GI71jOcpI652/6xd/jbGPA=; b=s1qnQJL7YfcEF6aUKdFESze2p
	SzVjVSjycACMPWAxaAJXU2G91hezjuTch4usGU20kYJkcCQy6B2H/MJdVrlyHAGlmvrkrhHuxadTn
	utjgBJ+VgPSKvXnZGHDGYjRkqWejxvsesTuaJeDOUYXVDQPdsUCVqQl3O/WR1+bBbx2jZDzqvrB8Y
	xIl97WAn1Ylfkrxjqu9Hm+Uqoir1CdSb14+DD5dZgIDBI6qpgn6or6QFNKoFDE/Nyw8taLWBTogrO
	Dc3bjVioU6pr/GJEfR6yshG0h2tHS43RCV8EIOFXYuCbRdvcO4b5jBaGpDRS5qHTCWP+eC+1/AopY
	3VvO8wzNg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kOTXe-0007RY-GF; Fri, 02 Oct 2020 22:28:42 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOTXc-0007Oc-7N
 for linux-nvme@lists.infradead.org; Fri, 02 Oct 2020 22:28:41 +0000
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 75BFB11E4824E;
 Fri,  2 Oct 2020 15:11:42 -0700 (PDT)
Date: Fri, 02 Oct 2020 15:28:29 -0700 (PDT)
Message-Id: <20201002.152829.1002796270145913943.davem@davemloft.net>
To: colyli@suse.de
Subject: Re: [PATCH v10 0/7] Introduce sendpage_ok() to detect misused
 sendpage in network related drivers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20201002082734.13925-1-colyli@suse.de>
References: <20201002082734.13925-1-colyli@suse.de>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [2620:137:e000::1:9]);
 Fri, 02 Oct 2020 15:11:43 -0700 (PDT)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201002_182840_489675_A0ABDFDF 
X-CRM114-Status: GOOD (  12.07  )
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
Cc: michaelc@cs.wisc.edu, amwang@redhat.com, linux-nvme@lists.infradead.org,
 philipp.reisner@linbit.com, hch@lst.de, vbabka@suse.com, sagi@grimberg.me,
 linux-scsi@vger.kernel.org, idryomov@gmail.com, open-iscsi@googlegroups.com,
 mskorzhinskiy@solarflare.com, chaitanya.kulkarni@wdc.com,
 linux-block@vger.kernel.org, hare@suse.de, ceph-devel@vger.kernel.org,
 axboe@kernel.dk, cleech@redhat.com, vvs@virtuozzo.com, eric.dumazet@gmail.com,
 netdev@vger.kernel.org, jlayton@kernel.org, linux-kernel@vger.kernel.org,
 lduncan@suse.com, jack@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Coly Li <colyli@suse.de>
Date: Fri,  2 Oct 2020 16:27:27 +0800

> As Sagi Grimberg suggested, the original fix is refind to a more common
> inline routine:
>     static inline bool sendpage_ok(struct page *page)
>     {
>         return  (!PageSlab(page) && page_count(page) >= 1);
>     }
> If sendpage_ok() returns true, the checking page can be handled by the
> concrete zero-copy sendpage method in network layer.

Series applied.

> The v10 series has 7 patches, fixes a WARN_ONCE() usage from v9 series,
 ...

I still haven't heard from you how such a fundamental build failure
was even possible.

If the v9 patch series did not even compile, how in the world did you
perform functional testing of these changes?

Please explain this to me, instead of just quietly fixing it and
posting an updated series.

Thank you.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
