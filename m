Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E7DC433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 17:14:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A51721D90
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 17:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nxZrkdqB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTMWV6IT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A51721D90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cBNuHyMqciapwVtCtabBOu+a79T/QOHCxPqFwLVSsgc=; b=nxZrkdqB4sniow0QfPyaHARax
	HSPlYS4/UpFs4svWbaxjoFkcOn4rOfB+5z6llBtKWs7Ou13d50QI0j1k8fLBxZ9UK1SXMh5/JAMgW
	HOsbJJVUaw9LvdTde/Ma8s82JF22QspDRH6B43hz63oL7dmW2pUkz5mFXGkvS8r+X2iG7z9U3t6g6
	jpTFmfukAaMLgBs5qw82YJtsHPkIcJxFcmMI7f81J2RFptp/DjnNQFIXBsZ+SjuCUYarzwZscztN5
	N40BSVzpy6Sgqd7U7KYhje/L2Mxpk2dBg9zpIIyvcPgzCw1Ms4t5YNy5aFoesKmQIKkYIgOaF7tN7
	TtPQYIelw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIxUa-0004rA-Jk; Thu, 17 Sep 2020 17:14:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIxUX-0004qV-QU
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 17:14:42 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 75B5F221E7;
 Thu, 17 Sep 2020 17:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600362879;
 bh=N+eMo2ivbUAlU4tiuPV3XzvKxw5wJfWKr0TMAEzfrow=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NTMWV6ITEHU1I15LMBE6Q7ueKeHjX4U9ool0IrdKy3+AKTHkedFGvinUS7ImrnOzN
 G/N38mYsPSnl0GhG+n4iJRpryht29fWyziwVTZ/nk+Vncn1oRAWrSf60Yg2mwOK/6U
 h1Wt3nSGI3bVJ4oXyflNwTSZNg1FeVNW5bdKp+44=
Date: Thu, 17 Sep 2020 10:14:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH] nvme: fix NULL pointer dereference
Message-ID: <20200917171437.GB3766534@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200916153648.5475-1-ztong0001@gmail.com>
 <20200916165433.GA3675881@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4B-KpRvFuf+5YR4iOqNzic=fuYm=_seqwLoLp9+_xOqdA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAA5qM4B-KpRvFuf+5YR4iOqNzic=fuYm=_seqwLoLp9+_xOqdA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_131441_919765_105F51BD 
X-CRM114-Status: UNSURE (   9.69  )
X-CRM114-Notice: Please train this message.
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
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 17, 2020 at 12:56:59PM -0400, Tong Zhang wrote:
> The command_id in CQE is writable by NVMe controller, driver should
> check its sanity before using it.

We already do that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
