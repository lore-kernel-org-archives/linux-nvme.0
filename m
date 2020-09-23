Return-Path: <SRS0=afDi=DA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C41C2D0A8
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 19:46:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69D82068E
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 19:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vCgvYJH3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="O9FTvRdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69D82068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=d1GSO2vahYURrOEBLapBa+3r/YdG28WSn+51pdL5ek0=; b=vCgvYJH32NJdDVTjEPNVNHhEj
	MDvdCXAnrD+bjpfXFB4Q5xi9P8AvlFVS2HfVmLNBTZQj0PQP1oJYJdjwUf6Wuae3S2UmPAr4Dx3Gs
	v2Ujh3fQbFVMtZGHLAhY2fVTZW0QDyqUAPTNfywB1mk6KjucciCnAWTyAziFGagaECMeh2lPxm0hm
	EilczzIpWQksh6Xm2laGwWdnD2ETjvyaFAkjijeESluun0aQCQzt3yKgJ404lhNYn6PLUSpHFuARz
	vMjGA3hilRhJAuqvsoeht48ORhmfBTk3EU1AWpnoWZHHx4dhUh/WYjOdJXoEYle8yQG2LO5fMbgll
	w38RhThqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLAi8-0000eA-6O; Wed, 23 Sep 2020 19:45:52 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLAi5-0000by-Iw
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 19:45:50 +0000
Received: by mail-lj1-x241.google.com with SMTP id c2so625759ljj.12
 for <linux-nvme@lists.infradead.org>; Wed, 23 Sep 2020 12:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z4e3pg0c/Zru5ZWtPKdeWn+c+nXGAjJi5U8aCz3uzeQ=;
 b=O9FTvRdvjPNRL462v9lU8NIGlyHwkPJ5W9/eQ0TRTTQQwnaFxTZYWBlUU1rxo4C9wR
 XKCjF/OEpnVpB1Hx8iwZ4/Q24/gWv1FUF75tZuce80eU9w3H1KRzmhltU5WLEXbR8qMZ
 lr50EYWyEA2wU+zKRJVODvRN+LLAaCVTB9TIAc2zhdNcGkCjKxyf95y9S0zTpWzFIfQc
 zltn6UqVGdCk6jTwRBa3tdFUUeZIN3nErofso7zTU8hFeytLzETmtF0DNgN132Nvl+QN
 d5i/zB8Tex55NdNjabAdvug3kj99BjJsv1HnljfJjOpiNzk+QXco5JVHODj4vGXcG09G
 sFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z4e3pg0c/Zru5ZWtPKdeWn+c+nXGAjJi5U8aCz3uzeQ=;
 b=kfj1fnL+m60DOlbK0R0rdpp++u7MgJoZcNw4MR1mJeweVpXgb4/20lEDSgAqf9nSQG
 Z55WZEt911C408u/bBK8Gwh/Om1p6D1tXv1PgsMGWkwIyGrJhQ33/HJzGanS5wXlIien
 sGoxeJtqq9sXYjVM2PYEdPC59LDyLCV0XSk+texfYPwdNYrljmkxQIhPEEiuKueDFxgA
 1ueMRTd20j4gwwqgSi1ptqBOWqlLZkSXI5Zd8k2MKlP7XThJ4jCFxNBxKuY60XYBWvup
 QUPelzDSc9urwJWcIOw2SeCgCOTgeycxPgDIbMpeZBlGJiVZYJ8ueiJewUsYMCYu8dut
 2QRw==
X-Gm-Message-State: AOAM53179KAdc9ujMXvNIgAU8pSyZIijUYUGNRLKR+4i6S10DF/bW6sm
 XHPB1uKu73Irn0h+69g5Q1HibLtzsUNU7R/MtjKVwA==
X-Google-Smtp-Source: ABdhPJy4oRt0D9rAphLkS6oUMlrRISLyr5oeHKiOWqU9MeWzlP89ss68bpX12wL2+9Wg6MMYiYJlPXW7BeKR0U5TOmE=
X-Received: by 2002:a2e:3208:: with SMTP id y8mr480904ljy.216.1600890348085;
 Wed, 23 Sep 2020 12:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200923160327.GA2267374@bjorn-Precision-5520>
 <20200923161944.GA17764@otc-nc-03>
In-Reply-To: <20200923161944.GA17764@otc-nc-03>
From: Rajat Jain <rajatja@google.com>
Date: Wed, 23 Sep 2020 12:45:11 -0700
Message-ID: <CACK8Z6HkPBXeRnzeK9TdBSkJOPx=Q775065RRqeaa3XWajuZQw@mail.gmail.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config space
 not accessible after S3]
To: "Raj, Ashok" <ashok.raj@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200923_154549_628545_15471AC6 
X-CRM114-Status: GOOD (  18.20  )
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
Cc: Joerg Roedel <jroedel@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci <linux-pci@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>,
 Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 23, 2020 at 9:19 AM Raj, Ashok <ashok.raj@intel.com> wrote:
>
> Hi Bjorn
>
>
> On Wed, Sep 23, 2020 at 11:03:27AM -0500, Bjorn Helgaas wrote:
> > [+cc IOMMU and NVMe folks]
> >
> > Sorry, I forgot to forward this to linux-pci when it was first
> > reported.
> >
> > Apparently this happens with v5.9-rc3, and may be related to
> > 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint"),
> > which appeared in v5.8-rc3.
> >
> > There are several dmesg logs and proposed patches in the bugzilla, but
> > no analysis yet of what the problem is.  From the first dmesg
> > attachment (https://bugzilla.kernel.org/attachment.cgi?id=292327):
>
> We have been investigating this internally as well. It appears maybe the
> specupdate for Cometlake is missing the errata documention. The offsets
> were wrong in some of them, and if its the same issue its likely cause.

Can you please also confirm if errata applies to Tigerlake ?

Thanks,

Rajat

>
> Will nudge the hw folks to hunt that down :-(.
>
> Cheers,
> Ashok

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
