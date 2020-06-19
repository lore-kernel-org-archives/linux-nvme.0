Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35203C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 15:22:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082E321548
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 15:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TVmDxxkY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGa+oWVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082E321548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/zQL4E9COBe3+7TltS7lmCJoUfDWGxGc195pX31bckE=; b=TVmDxxkY70gI2M
	iFb63atrcVzoz9Tqug5uQvnx7i1aH6r9zHyJ0jZil4XPz9HPrPqaKtHYeATdPuQQDQED+NLDoWOgl
	11LWlPVTyq5aCpR7a+rO9al1JPI7nRxWDPz/nx8/e86+NuQeZsjwpkDnwJveWL2Up76oYtQBFX2UK
	6KEj5INFEacerh1d7t1braaCkSKMgqtMr/DY6lcF4HKBtik+t2mG5ypJn6mdPdslnauHui88MkWsh
	U38yWF6FhBHOI/zyPXeqpbmW3iPPFnHeSBBmaVYZOkInY1B0DISLHHP8wXSFs4zTucB7TxALs1CtZ
	gvnAla/MFo8qxLsbvsWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jmIqD-0007W1-EG; Fri, 19 Jun 2020 15:22:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmIq9-0007V4-3D
 for linux-nvme@lists.infradead.org; Fri, 19 Jun 2020 15:22:02 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0EBD32193E;
 Fri, 19 Jun 2020 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592580120;
 bh=e3Xj1HKNmqbdTTYJyhSmInBOYfF1bWOiUAymLVtYCng=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pGa+oWVHF1zx6b1W0IPOUx89kBvjLzfPVuG4IAXDF2jKRk4RJhZ/01OfVZEMb2aI9
 iQzPTQM4FScfJ6hXnUxUuREV8wJgm2wrvIWzHpsgOa4SZ8X3MxiAO5+UTHDgA9fwq6
 4ejRzuaCx3uNdbakHZ7NH38ltKPXKSS/Oq3yNLVQ=
Date: Fri, 19 Jun 2020 08:21:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-core: use rcu in instead rw_sem
Message-ID: <20200619152158.GA1149998@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200619033531.27819-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200619033531.27819-1-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200619_082201_154872_1D0A5199 
X-CRM114-Status: UNSURE (   8.58  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 18, 2020 at 08:35:31PM -0700, Chaitanya Kulkarni wrote:
> With the NVMeOF passthru patches we call nvme_find_get_ns() in fast path
> so that we can get the passthru namespace queue for I/O.
> 
> The function nvme_find_get_ns() uses ctrl->namespaces list which is
> protected by ctrl->namespaces_rwsem. Until now it worked fine but with
> nvme_find_get_ns() being in the fast path we need a better
> synchronization mechanism. Use of rw-semaphore slows down the 
> performance under high pressure I/O.

I'm all for a more efficient implementations, but I'm concerned that
we're still going to search a loop on every request. Maybe use xarray?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
