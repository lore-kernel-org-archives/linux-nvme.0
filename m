Return-Path: <SRS0=Nwsb=7A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F4EC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 17:20:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3FD204EC
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 17:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mX1uZmc1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="PuiVlzFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3FD204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JQ4eRzYNxGO2cpWu77Gc6URAnuNxZvW/dNne99QZh9Q=; b=mX1uZmc1y5GBzO
	pEOC1seBSckZ2/O3j4uesQg2n6rsyv2nJXBQFJci9pEqyOMGH25599YoqytOPuo03yn4NCpH4T6wN
	jJi8ECvydpfMNeghHiEBdR3AdsSxwGSIEnIGilIe2ThK77VBXTfPDQ1xZnPjYim9RQ/WYd0rhmtcc
	BXHOadEkHslW4BXd49cUWMHSSeTWCFQqqWSUeegWmynmnn2Bq2TMUssJLOekxVSDxgI6Ln+ClAmmI
	bAi+Rw4Spr5jg/RP7guiaRRqtw9qIpGTsDXjt6smIDPpP2QA9WMV7ELKvbkZJmszu+A60rUyLREpv
	PW6eho2WwdLn2jwURdJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jajRP-0006Wz-Rf; Mon, 18 May 2020 17:20:39 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jajRM-0006WO-R5
 for linux-nvme@lists.infradead.org; Mon, 18 May 2020 17:20:38 +0000
Received: by mail-ed1-x544.google.com with SMTP id d24so1204119eds.11
 for <linux-nvme@lists.infradead.org>; Mon, 18 May 2020 10:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GgTcEd+caanrx1t1o1gL/Ypc50CeCw/F8i23bYyVrUw=;
 b=PuiVlzFghkrRKLS1pILHxv+676poFWDYeHwwBLU2TzTknD+dFYLk0xk+5TDy5pgW64
 qhuwEWP7J2W6vsJz9bxByoo2dcZ36iMpyHBw7XLV0g5MUF4S816ICg1DZOwDObAlCM3l
 jlS2qNoPNiw16Z9LbJPF9al5A655ElOJAWZCiLcMB/bVFyCP105iTKNVuysDuncWhyKd
 BhtMjOTMlylTNZO9ZnTXwTC3GcHLAoPHCQ+Rc0wCdFGDFSgZbzPR0IlAhtNd6yFRaXUC
 QFTeTJBaBJG91RBZss95qPo8+kfKyS7kah/YxohaMXsSe2dPgCxaCsSp+E0yeuj4kHg4
 cGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GgTcEd+caanrx1t1o1gL/Ypc50CeCw/F8i23bYyVrUw=;
 b=MruS6jNbv0tL8Ba/SLA2+auC+VDYtammcDESq1fRfN4fNnuF9vy9HxiUtKHEwdOcFV
 9pFXr8+RAo9YguP8wGfemRV3rVI/NOlCCnw8nlnk0oY/SOJ4Ks4qUrM98iuu9vwaOiqi
 EufgJHHn9BNd5nSYFXgI/FBvKU8lAUN2UheBIwpQ+d2FYHApy5GrV/jlH08y5YHG1AJp
 j4JRTBHvnnt8vZM55vn2kLjl+L+DHrcljX3D4fIPL5ReCX5UpypsZOsRjwaEpbtpInUF
 Vbs85otyY01DQCAxTwGbR8oouWWAWMjEQSVnVvMSD1Vjt2PLTXDgHko0ihqteKhAwUbL
 cF4w==
X-Gm-Message-State: AOAM532NbbWdMBHOABQNLBAUZZ2CgbY+YCN9qxFR+3aUhw7ODfUoymb/
 g9Qd3xdckyVPVCp5HxxEEBxxZXCK3mznrION92WnwdUh
X-Google-Smtp-Source: ABdhPJz5bmBALzw+D9Jia6d4zvkIV02xWwFo/oM2e8pEt1WN25M6AUsNVPV+EY0iKhYAw1fQk4Bl1vsVwJ4nmUApjn8=
X-Received: by 2002:a05:6402:1c1e:: with SMTP id
 ck30mr14064996edb.154.1589822434411; 
 Mon, 18 May 2020 10:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
 <20200428051312.GB17146@lst.de>
 <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
 <20200428142247.GB5439@lst.de>
 <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com>
 <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com>
 <b0ca81f973ba55a2d6a8c84bc00f2324bad64f30.camel@infradead.org>
In-Reply-To: <b0ca81f973ba55a2d6a8c84bc00f2324bad64f30.camel@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 18 May 2020 10:20:23 -0700
Message-ID: <CAPcyv4hE6iW3MwW=qybN8aXN4wHJ7R2OCDCUEw9FdKu4NeZ6iw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
To: David Woodhouse <dwmw2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200518_102036_940655_52FF8C13 
X-CRM114-Status: GOOD (  15.23  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "hch@lst.de" <hch@lst.de>,
 "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 18, 2020 at 6:52 AM David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Wed, 2020-04-29 at 05:20 +0000, Williams, Dan J wrote:
> > The *patch* is not trying to overrule NVME, and the best I can say is
> > that the Intel Linux team was not in the loop when this was being
> > decided between the platform BIOS implemenation and  whomever  thought
> > they could just publish random ACPI properties that impacted NVME
> > operation [1].
> >
> > So now David is trying to get these platform unbroken because they are
> > already shipping with this b0rkage.
>
> This is what we have WARN_TAINT() for though, right? It can suitably
> warn users when such breakage is detected in the platform.
>

I see WARN_TAINT() as "BIOS implemented its specification wrong". This
case is BIOS "implemented a mechanism in the wrong specification".

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
