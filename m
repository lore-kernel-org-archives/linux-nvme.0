Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76195C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 19:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oZ+muMxsYAdOfLFCfYelUSEsPZYYdxDi6dVCQc7XtEo=; b=DUdeuAfCnVQPQoTnl5Q9opMJMv
	zv/dAvkU08hStXe0ynd5Wha7aKa2yuTmpOPMBzNEHkNxgghcCQyI30hzSFTwShdZHYAEAAsYRskmO
	aTVO3KOCBjhDNrcy43EHQPBJMGu13tM96F4BSEbvYW7pFZRWkuw3Nz6cl2tkRc/9SAP19scPKjkK3
	52UD8YZaEWy9NCh7UqIrE3mrcgsPInCjWzHfA4UaYmfylGOF+nzMrK0JGXFvr+vjayo2DErWRXtQS
	0VOTWM9NmHM6g/as/YsJCtpU0E+6ND8bAqk13Saw5rtbCBJflpfiDeuK6oO24BOyG24eENzP639Xz
	nrKr1sNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDA2L-00GtTk-0k; Thu, 27 Jan 2022 19:02:25 +0000
Received: from mail-yb1-f178.google.com ([209.85.219.178])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDA2H-00GtSY-41
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 19:02:22 +0000
Received: by mail-yb1-f178.google.com with SMTP id r65so11522229ybc.11
 for <linux-nvme@lists.infradead.org>; Thu, 27 Jan 2022 11:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oZ+muMxsYAdOfLFCfYelUSEsPZYYdxDi6dVCQc7XtEo=;
 b=oSAzSNOSO8eB/SDIPq4kmKIkUIgCxIKYtXc+ZW3M94a4z9f1f6xnSHuLOzlfsBMmv6
 gD+YpG4yqQea/ttBIYVMaXDXfrax/OLBxQfp0roavivgtCIn5d4pfzcdacwH3yN2c5ja
 yTHCZTQiIexU7O0huzFE3H3wIOS28QppnCYUQDSCZlmF0qdQf8wgkBOvXAghbOJTyEs2
 BWIlvuxHEToLFKtApK4RDsponKhNox8HKWNrGzM4UFUHoGyeqDm5TErE5+yPTOQ2goKs
 fFhkr1Po6ZwHstvNHHhOkN8tByww0gjPkscoaPG16uzU42Qfl64M/aVmYegdkbl76XEy
 HTcA==
X-Gm-Message-State: AOAM530KbLWLscmttnNGJ+naJmp1ci5ncPWUonbxQUiOIIN/njCTIpZd
 dzgHhbdmb8kxoQnIlQlH1tQ320UG21FZRD9elTk=
X-Google-Smtp-Source: ABdhPJwwuxh+M4WNtLnUTBMcxZ4UlZ/mbrCOF3BFwwbMrVAKbA9jwi4/N4qiIr/DrG4bB3Ls48sOKRNYl5cxrLmFhb8=
X-Received: by 2002:a25:c102:: with SMTP id r2mr8103463ybf.330.1643310138759; 
 Thu, 27 Jan 2022 11:02:18 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
 <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Jan 2022 20:02:07 +0100
Message-ID: <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com>
Subject: Re: [Bug] nvme blocks PC10 since v5.15 - bisected
To: Keith Busch <kbusch@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, 
 Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 m.heingbecker@googlemail.com, linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_110221_187858_6CA2B28D 
X-CRM114-Status: GOOD (  25.17  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 21, 2022 at 10:09 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Jan 21, 2022 at 08:00:49PM +0100, Rafael J. Wysocki wrote:
> > Hi Keith,
> >
> > It is reported that the following commit
> >
> > commit e5ad96f388b765fe6b52f64f37e910c0ba4f3de7
> > Author: Keith Busch <kbusch@kernel.org>
> > Date:   Tue Jul 27 09:40:44 2021 -0700
> >
> >    nvme-pci: disable hmb on idle suspend
> >
> >    An idle suspend may or may not disable host memory access from devices
> >    placed in low power mode. Either way, it should always be safe to
> >    disable the host memory buffer prior to entering the low power mode, and
> >    this should also always be faster than a full device shutdown.
> >
> >    Signed-off-by: Keith Busch <kbusch@kernel.org>
> >    Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> >    Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > is the source of a serious power regression occurring since 5.15
> > (please see https://bugzilla.kernel.org/show_bug.cgi?id=215467).
> >
> > After this commit, the SoC on the affected system cannot enter
> > C-states deeper than PC2 while suspended to idle which basically
> > defeats the purpose of suspending.
> >
> > What may be happening is that nvme_disable_prepare_reset() that is not
> > called any more in the ndev->nr_host_mem_descs case somehow causes the
> > LTR of the device to change to "no requirement" which allows deeper
> > C-states to be entered.
> >
> > Can you have a look at this, please?
>
> I thought platforms that wanted full device shutdown  behaviour would
> always set acpi_storage_d3. Is that not happening here?

Evidently, it isn't.

Also that flag is about putting the device into D3, which need not be
necessary as long as the LTR is set to "don't care".

