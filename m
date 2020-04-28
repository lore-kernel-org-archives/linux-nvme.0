Return-Path: <SRS0=qSsZ=6M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F6FC83001
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 15:28:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28FDA206D8
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 15:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vBy7QlnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FDA206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5WPChpbdGOlOqCS7O+lOdD8eItA9Z+8QchHzKTMKLoA=; b=vBy7QlnULhRGpR
	gW+6ed1kN9RdvTWD+UrSGEbDWYrEdeqwftmx1DF+3z0BeaByIf1ttO/LJaIG/PP6wthFMU6q7i7rX
	4NKKocdQl7T4fFX/lVFys8VF8u7HsSlcP0pVyvAeCaWAP/BcOrHTpLd7oXxc8g9YKEBKlhyJMkh+P
	azzLnCdx6ZgTRTnkbOyjSSPcCCW/y6EkvpEU/mE5uojvH6gv/nl6y6A3oDY14porNJyb51fiN8zr9
	/O86UU0nHm2I9hd5Nm+u53fGqlSVi5NAC6J701thNo9E64jrTJLA4CqQD3h4R/IsZpsh75h1cbIah
	b5lkbEHn4OE5kAfn0lHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTS9M-000078-9h; Tue, 28 Apr 2020 15:27:56 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTS9J-000067-Jn
 for linux-nvme@lists.infradead.org; Tue, 28 Apr 2020 15:27:54 +0000
IronPort-SDR: O7nBv4zFYpUqd7xLO53zxjUe3WjpZpogwYOsGIsvCHfOwfIy2VLckYZtrtFh/AqUgl4U8Ychyn
 BGSAho6g96VQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2020 08:27:51 -0700
IronPort-SDR: UNnU/pmBRK2OkJ3qAl3VQ1s9gW2e4JpF7lPfFAiI7yqU9sbKROyoly5hqXVOgWqX5u3I4vC1Fw
 PsaBRrDB9MQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; d="scan'208";a="282179569"
Received: from linux.intel.com ([10.54.29.200])
 by fmsmga004.fm.intel.com with ESMTP; 28 Apr 2020 08:27:50 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com
 [10.7.201.137])
 by linux.intel.com (Postfix) with ESMTP id 38EE4580CC1;
 Tue, 28 Apr 2020 08:27:50 -0700 (PDT)
Message-ID: <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
From: "David E. Box" <david.e.box@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Date: Tue, 28 Apr 2020 08:27:50 -0700
In-Reply-To: <20200428142247.GB5439@lst.de>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
 <20200428051312.GB17146@lst.de>
 <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
 <20200428142247.GB5439@lst.de>
Organization: David E. Box
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200428_082753_660218_81A2FE7E 
X-CRM114-Status: GOOD (  20.03  )
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
Reply-To: david.e.box@linux.intel.com
Cc: sagi@grimberg.me, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org,
 bhelgaas@google.com, lenb@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, 2020-04-28 at 16:22 +0200, Christoph Hellwig wrote:
> On Tue, Apr 28, 2020 at 07:09:59AM -0700, David E. Box wrote:
> > > I'm not sure who came up with the idea to put this into ACPI, but
> > > it
> > > belongs into NVMe.  Please talk to the NVMe technical working
> > > group
> > > instead of trying to overrules them in an unrelated group that
> > > doesn't
> > > apply to all of PCIe.
> > 
> > Agreed that this is not ideal since it does not apply to all of
> > PCIe.
> > But as the property already exists on shipping systems, we need to
> > be
> > able to read it in the NVMe driver and the patch is consitent with
> > the
> > way properties under PCI ports are read.
> 
> The point is that it is not the BIOSes job do decide how Linux does
> power management.  For example D3 has really horrible entry and exit
> latencies in many cases, and will lead to higher power usage.

The platform can know which pm policies will save the most power. But
since the solution doesn't apply to all PCIe devices (despite BIOS
specifying it that way) I'll withdraw this patch. Thanks.

David


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
