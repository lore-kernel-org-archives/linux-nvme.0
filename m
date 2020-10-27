Return-Path: <SRS0=wn7D=EC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00315C4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 20:23:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B742072D
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 20:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bij13MqT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKFXJkJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B742072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5qr+uPJ5GAQle11vCo8quWUFzucjTU3sMgkaYCmaFQ8=; b=Bij13MqTc8I0hXE2p+5RVGi1Z
	nbxcbK7nMNLEp5pLcOnfCvMsTT4Ppd7nJ0MZxROjRmGZ3/vsnBO2co0zIRjJINxCK7flydakHvP1w
	SKMtoXw3Pkg5q6GEe/BluHU8Be1qlVHf6rn3X2y/iv8WoyOTx+QI+VeaKW7KCyzcDtmRceJKgcw+U
	I+FEri9DE2YIr7tabUkfI/Di+KqhI0O67dkK2byulkxoi47/WBQUTI0yR2z1DguFWGOO3JUo9ljHR
	jDIVZSux3nQarjmCQkS11uCYCFLg6AOS6WfKR2BuJQHak6XlzhRJmBpsV1NAsp/NVdgInozDOYqkg
	0KD12EFtQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXVVP-00021x-4X; Tue, 27 Oct 2020 20:23:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXVVL-00021E-BL
 for linux-nvme@lists.infradead.org; Tue, 27 Oct 2020 20:23:40 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0172020719;
 Tue, 27 Oct 2020 20:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603830217;
 bh=3emz6UQhpY4UW+3j5aomFK7x1AuiURETZZxGwVy/TZA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vKFXJkJMwVpGxzCd/Nc/P9I90wffuBoPzvKvYQdoogX9+xnFsxShG0XBCmxlqGgzA
 BV+vT0OTrLxXtczLxwLEBPeiqOAaudyrmpWonO80WiVQn78QtBCZERXUd+rpTcZ3jW
 +SnauYBe9GDb0iwfCPj8FZ2PPinN/8qkw/BIXKlM=
Date: Tue, 27 Oct 2020 13:23:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jongpil Jung <jongpuls@gmail.com>
Subject: Re: [PATCH 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Message-ID: <20201027202334.GA1942708@dhcp-10-100-145-180.wdc.com>
References: <20201027155438.GA111754@jongpil-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201027155438.GA111754@jongpil-desktop>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201027_162339_497673_CF47E12B 
X-CRM114-Status: GOOD (  14.15  )
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
Cc: sagi@grimberg.me, gloria.tsai@ssstc.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, jongpil19.jung@samsung.com,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 28, 2020 at 12:54:38AM +0900, Jongpil Jung wrote:
> suspend.
> 
> When NVMe device receive D3hot from host, NVMe firmware will do
> garbage collection. While NVMe device do Garbage collection,
> firmware has chance to going incorrect address.
> In that case, NVMe storage device goes to no device available state.
> Finally, host can't access the device any more.
> 
> Quirk devices will not use simple suspend even if HMB is enabled.
> In case of poweroff scenario, NVMe receive "PME turn off".
> So garbage collection will not be happening.
> 
> Liteon(SSSTC) will fix the issue, that's why quirk apply on specific
> vendor id and firmware version.

This is a concerning quirk. We use the simple suspend when HMB is
enabled because at least some platforms disable device DMA access in the
runtime suspend state. Many devices continue to access their HMB while
in low power, so we can't let both conditions occur concurrently.
Unless you know for sure this device doesn't access host memory in
low-power, there will be at least some platform combinations where this
quirk will fail.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
