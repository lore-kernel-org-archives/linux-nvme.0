Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95FBC43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 15:22:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C1420820
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 15:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PDRXPRBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C1420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aCNMc/KOu0FGkN/Xx/1XKCDE+5P/65LlMBmnP3CEyl8=; b=PDRXPRBOIu4U+g
	UVUbIC+AAej0ru8hC4toCmAdrRVHUbO8RqozJbIf7USGBKJe91/hneMqJfKnOwdNFyLCzcxO7K1BF
	UGNgU8oNROhllUILgSSQakO2neYgxdRuQbPSB7TDhWHOK0dhCLZS8Umi6Hqb48GQp50bFiLRESKVB
	ZlsZm1bNEYWT8Mn998C3kQaZNBimBsTva2YSWy+9QPdGsRVirJxXvB6Isx1iSTm7qQtoJ/LtZY+DS
	UsztRJKLnSsAY4oChtBZs2xcZLMXTyfa+cvuomBJK8hrrPFVCKuJgjCMKpdTBCDsg5COW2/7kpbSI
	c9lGh1edy9hY9pwZpc6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5tav-0004cs-C4; Thu, 05 Sep 2019 15:22:45 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5tar-0004Zt-K8
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 15:22:43 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Sep 2019 08:22:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,470,1559545200"; d="scan'208";a="173980175"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
 by orsmga007.jf.intel.com with ESMTP; 05 Sep 2019 08:22:39 -0700
Date: Thu, 5 Sep 2019 09:21:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Israel Rukshin <israelr@mellanox.com>
Subject: Re: [PATCH] nvme: Remove double assignment of cq vector
Message-ID: <20190905152110.GC24939@localhost.localdomain>
References: <1567695048-5234-1-git-send-email-israelr@mellanox.com>
 <20190905145937.GB24939@localhost.localdomain>
 <4de909ca-b4f6-a842-5d3f-a738b5a01a1f@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4de909ca-b4f6-a842-5d3f-a738b5a01a1f@mellanox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_082241_674990_0FD3D548 
X-CRM114-Status: GOOD (  10.50  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 05, 2019 at 03:10:35PM +0000, Israel Rukshin wrote:
> On 9/5/2019 5:59 PM, Keith Busch wrote:
> > It's not really a double assignment. An interrupt driven queue may beco=
me
> > a polled queue after a reset, in which case this assignment serves to
> > clear it's previously assigned vector. It doesn't actually appear to
> > matter if we've cleared it or not when the NVMEQ_POLLED flag is set,
> > though.
> =

> So what about the second assignment when polled is false?
> =

>  =A0=A0=A0=A0=A0=A0=A0 nvmeq->cq_vector =3D vector;
>  =A0=A0=A0=A0=A0=A0=A0 nvme_init_queue(nvmeq, qid);
> =

>  =A0=A0=A0=A0=A0=A0=A0 if (!polled) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nvmeq->cq_vector =3D vecto=
r; <<<<<
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D queue_request_i=
rq(nvmeq);

Oh sure, that one serves no purpose at all.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
