Return-Path: <SRS0=D+H5=A2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED75C433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 00:47:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FDC2071B
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 00:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uNY47/ys";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnzTzsO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FDC2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E01yn5OiP5G9LwvNv+0OimTB8fMDPZ1Wogrx2HFgub4=; b=uNY47/ysB8Y+z+/tpgFaKh1B1
	WbKPEuCC25L3Ig91092ySj4UooMqzN/0LO+RZnYG93bf67BwatawuV2Jjtdm3Mc3yl3RfLoVJjP0x
	5+Ay3o0TROieMHasNFX0rON3am7LalU0c8yWrARuPQXJe4bgEmXbhK/kixjKYzaPoTRimml7GXNik
	aGqwNqEvPspsOi1fzHo58CVuNjvHs+oj7SmCQqD5cczySdH+mrsRFXXa/cLx4Xkgnzp92QzL8oqr+
	k8WITM/fIC8540horrCjCci40rV13DBFGMzrNdVxwq1K8xAuiN5NMD3T4U2pv9eomz6EEB2bqQxRH
	kgUjZy65Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvVZT-00020R-Mb; Wed, 15 Jul 2020 00:46:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvVZP-0001zn-NI
 for linux-nvme@lists.infradead.org; Wed, 15 Jul 2020 00:46:48 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 43BFD20674;
 Wed, 15 Jul 2020 00:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594774005;
 bh=ZVLO2D3ydrxNeNfkrlJgwbsT8vNErLs69JikOs1M5LI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZnzTzsO16gM8NcXbJURCH94mkJPW6ApwFaZD5e0tTRilpyzRt0pnOmf9I7Qcbm7H+
 e8xDRN7H+07lh658kTAaj1QZSuy3zsQvwSnhCjS3q4V1H7QlDecFzmjYP68/WZYcRz
 cgFcwVdDpisU5qQDLN9tvtYWzSkoK3RHT+NdXie0=
Date: Tue, 14 Jul 2020 17:46:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 01/10] xarray: add __xa_load() version
Message-ID: <20200715004643.GA2772284@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
 <20200714233057.10915-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200714233057.10915-2-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_204647_930966_F4F612E6 
X-CRM114-Status: UNSURE (   9.61  )
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
Cc: linux-nvme@lists.infradead.org, hch@lst.de, willy@infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 14, 2020 at 04:30:48PM -0700, Chaitanya Kulkarni wrote:
> This patch adds a new xarray API __xa_load() that moves xa_load() core
> to its low level function __xa_load(). Caller is responsible for handling
> RCU locking. This API is needed for NVMe subsystem so that it can take
> an advantage of the RCU locking provided by the XAarray for reference
> counting.

I asked last time: why is this necessary? All the docs say you can nest
RCU read locks so what is wrong with doing the following with existing
xa_load()?

	rcu_read_lock()
	xa_load(..)
	do_something(..)
	rcu_read_unlock()

If there's nothing wrong with the above, then we shouldn't need to
introduce a new API.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
