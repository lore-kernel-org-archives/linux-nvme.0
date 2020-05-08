Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E645FC38A2A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 14:38:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C2120CC7
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 14:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G76lRUWt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp5kVDvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C2120CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XsMO9hrTH7HhgDnPmGUqv8F10pQbiaLito07qtN2g30=; b=G76lRUWtKCl0c0
	rPjlNFFGUvtyrosudwzmCOZwSNT12HcU4py2hXLQMRpComQKSju2rN1DlVqr1KOG9enFVHAUU5OO+
	aROkf5YLndCiu45xQ7OxUyTU9/gcEsYbEuT+2k1Y8dq8ETsSKRg0P2HHIIM2iKkxNdNAmtCDIPXxf
	aB30/GdubPOfFMA02DGFwsW0i2diVRUNhecQrmzjjHFJvSCdge4YQ/An+R+5nQXz+CEXOvLWbip5c
	6ji6/NVv+Y2CwSqsH7V5y/yRsx3qRa4VnRqT3XwVy88xTTXkLksWtE09312fIS07kpKMGydxfr6eY
	0D0C3vRXk2m5y7L7SYCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jX48y-0006IB-VL; Fri, 08 May 2020 14:38:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jX48v-0006Hk-HP
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 14:38:27 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7243A2083B;
 Fri,  8 May 2020 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588948704;
 bh=SRH46TFag6rthGYWqaxabGEmNvpUc6NNAakKJDo4GfU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lp5kVDvGNoUqekqaFYZ2MT8RnEDNDzKDilNP97kP5B8IUbH4r9+6wdcEJ9A2m153I
 3KHHqSK4ibS157vBP3UoIL/8cU+q4ng4+A+AxDgSb/9Rytk0WgW+zpZswvDXcjycJ8
 a/3xczlWF7LSYlsXTFIJ1Dw7NRKI96JnFTsRMqg8=
Date: Fri, 8 May 2020 07:38:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fix possible hang when ns scanning fails during
 error recovery
Message-ID: <20200508143822.GF2621480@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200506224402.19952-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200506224402.19952-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200508_073825_600098_F0E7EB95 
X-CRM114-Status: GOOD (  10.85  )
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
Cc: Anton Eidelman <anton@lightbitslabs.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 06, 2020 at 03:44:02PM -0700, Sagi Grimberg wrote:
> When the controller is reconnecting, the host fails I/O and admin
> commands as the host cannot reach the controller. ns scanning may
> revalidate namespaces during that period and it is wrong to remove
> namespaces due to these failures as we may hang (see 205da2434301).
> 
> One command that may fail is nvme_identify_ns_descs. Since we return
> success due to having ns identify descriptor list optional, we continue
> to compare ns identifiers in nvme_revalidate_disk, obviously fail and
> return -ENODEV to nvme_validate_ns, which will remove the namespace.
> 
> Exactly what we don't want to happen.

Looks fine,

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
