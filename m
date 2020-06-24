Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB2AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 19:11:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA9120702
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 19:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OtZ4SG05";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="in62/pK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA9120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8M+tc3quZLorWpB9ZbzYBo/aVGexQYExG0LscAq1odo=; b=OtZ4SG053v+oGqKundoVB4pzG
	ZlJ5SK3glxwUdVbyz5iXjO6GWqDgJXvL7oEkaA/loxv3z/ALxQno7wcsHyZK7HqPGfhOzRVuDC5mE
	qXGAN953k8sJ43nHKD26t4vdJ+8iIbvrSmvh7UlsoPzElSJ0JsMUYA13VtJd2pLkb7New/QO+nXFG
	GcRyQgE1dFu+FEtT3JAXo6D2514VfBA8Yq+f/7vPU2Qk/T0LJk9izn2SHsWehLOmlHhoqiFVvlsBQ
	jRRZFN9sJlubaaWQTpg+Ul8vA4lUKUNVh7b4zEfN2vLwCNcW2QagtPMHdExOv6GUWrEYAjgf6TdBm
	oR8Iw0qQA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joAna-0003w7-GN; Wed, 24 Jun 2020 19:11:06 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joAnX-0003vJ-So
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 19:11:04 +0000
Received: by mail-ed1-x542.google.com with SMTP id s28so2299994edw.11
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 12:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HUy3SYLieHUYRrbu7ksz+DDx5NoSGhvtwAWM7BS+NcQ=;
 b=in62/pK4305qlruXOrme3JoGaFZsG+ngmdYPd6qQJVPMZU8zi45J/cdtrR/1S2nDpG
 osC789ZrUhTlXbnv7LgWIfcNPZ+ugiqfFG98EnA6GebisxGlzNr6DE/YYjikoTyjpTr6
 dzESw5Tk70JPsArLMfUSCMZmv4fCVRQauL8U50UEeeTPu7ml5UcziaUxfOow1iLRtOE9
 g3KIkUWDlvL4VHx0ultb5v4HHmoFF5GBabUMOWbywjy9cYRAsAWsYMhAumd5XKngyrLj
 x1ScTaJ71iWX60kuFWHkQlJK56tNx/8L3F9ZHkDXvkYZVgaBDVCDP3QzFahIOfXx7tbl
 dc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HUy3SYLieHUYRrbu7ksz+DDx5NoSGhvtwAWM7BS+NcQ=;
 b=inNaW0+DUVA/naN/GQah+QRuJOAz2NC9x9Xl9gALqiqfn0Kp0quXcrdd20cM71jpCM
 5j7O2/FZMMQN6/jvmi6U0mJQpaARd0o3+MKS6fX0AlpT/QQsXY4O6aXw6xApKRstIo2g
 xW9UkX1IOcc5eyTpfqIRB430mmpgLxG0/PL4NsZfxikbf5h8k4BmrOsJx0hlOLRU74Sv
 Q8Qj29ynusv8XVv8lv37U1N3KgLiqNIe/DBcgOAvNXy7TmB5lvFiERcllXRVzj/qTwUH
 noofIZ8s6P67Fv2quxhtThNtiUUHgU8Qp846xtzzvNalRlOBNZTDvW2gj0JB8+6SSTuV
 F9yg==
X-Gm-Message-State: AOAM532N1lyK0RU14E4U4Q1ybDJwCAjAMETv1ehuzpOQ4PIb9+FhnoO9
 QG/71ArrDTptNMS45FlIKggQoHEFiRXf7hvaxqiWx4VX
X-Google-Smtp-Source: ABdhPJwTc+VdGxK7PxA2A2Hb2Q/oOwneukaqMN+TiIWLM8FMg1nGLcl6/OQXIozSlGxncNmyGtKZ6GK3+EL+fh+R4Sw=
X-Received: by 2002:aa7:d6c1:: with SMTP id x1mr27574990edr.154.1593025862677; 
 Wed, 24 Jun 2020 12:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
 <20200612204820.20111-1-david.e.box@linux.intel.com>
 <12d36fdcdbcf438dd3aac7769e8366afd9d5aa1a.camel@linux.intel.com>
In-Reply-To: <12d36fdcdbcf438dd3aac7769e8366afd9d5aa1a.camel@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 24 Jun 2020 12:10:50 -0700
Message-ID: <CAPcyv4iYGgjmAUiKUgFBF+nm=axamYFueCkN5Jyu7yQ6w1HxLg@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] nvme: Add support for ACPI StorageD3Enable property
To: David Box <david.e.box@linux.intel.com>
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
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Linux ACPI <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, "N, Shyjumon" <shyjumon.n@intel.com>,
 Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Christoph Hellwig <hch@lst.de>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 11:55 AM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Friendly reminder. Thanks.

Are you looking for this to be merged by ACPI with an NVMe ack, or
merged by NVMe with an ACPI ack? It sometimes helps to be explicit to
break the log jam.

>
> David
>
> On Fri, 2020-06-12 at 13:48 -0700, David E. Box wrote:
> > This patch set implements a solution for a BIOS hack used on some
> > currently
> > shipping Intel systems to address issues with power management policy
> > decisions concerning PCIe NVMe drives. Some newer Intel platforms,
> > like
> > some Comet Lake systems, require that PCIe devices use D3 when doing
> > suspend-to-idle in order to allow the platform to realize maximum
> > power
> > savings. This is particularly needed to support ATX power supply
> > shutdown
> > on desktop systems. In order to ensure this happens for root ports
> > with
> > storage devices, Microsoft apparently created this ACPI _DSD property
> > as a
> > way to override their driver policy. To my knowledge this property
> > has not
> > been discussed with the NVME specification body.
> >
> > Though the solution is not ideal, it addresses a problem that also
> > affects
> > Linux since the NVMe driver's default policy of using NVMe APST
> > during
> > suspend-to-idle would lead to higher power consumption for these
> > platforms.
> >
> > Patch 1 provides a symbol in the PCI/ACPI layer to read the property.
> > Patch 2 uses the symbol in the NVMe driver to select D3 as a quirk if
> > set.
> >
> > Changes from V2:
> >       - Export the pci_acpi_storage_d3 function for use by drivers as
> >         needed instead of modifying the pci header.
> >       - Add missing put on acpi device handle.
> >       - Add 'noacpi' module parameter to allow undoing this change.
> >       - Add info message that this is a platform quirk.
> >
> > David E. Box (2):
> >   PCI: Add ACPI StorageD3Enable _DSD support
> >   drivers/nvme: Add support for ACPI StorageD3Enable property
> >
> >  drivers/acpi/property.c |  3 +++
> >  drivers/nvme/host/pci.c | 14 ++++++++++
> >  drivers/pci/pci-acpi.c  | 59
> > +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci.h     |  2 ++
> >  4 files changed, 78 insertions(+)
> >
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
