Return-Path: <SRS0=tL+/=A3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E673C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 14:39:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F42F206F4
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 14:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vGEliTmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F42F206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PPUphPUnlIw3KKWdf3uQ+u8sxfn3tKXXK1fqBxaZDSY=; b=vGEliTmU2kzPIe8wk1PNafsox
	HA5DJ3Uv8aBwtVi/fMlW8mGDR89iucAr/gqtLDdUA/DVTaM6uI47+bX42dslAgn2XNs/iAbnP4a6q
	QixLhH6XAofVGSqlrk+j1CgfiayCphqOdDfVc4BQkMAE2jgBPee0ZLLBsQbdbxBnDTHguBSsKbMuA
	ZQqpsEaHVMFAAn8rBM6LuiwLPA7mC3SNklKvtYFsAZDSGt0Hh95dPFQRcqOquV6f4j5h4YIYtawbj
	Nn3nXAS9hLUYSlv1zZmM6diGqBMd1dZCZUVzqEbiMn/zWRvQE/TS4NAtWqKhua9DesBpCWm55jKdQ
	Ofb0FI5BA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jw52y-0000vO-90; Thu, 16 Jul 2020 14:39:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jw52v-0000tQ-QF
 for linux-nvme@lists.infradead.org; Thu, 16 Jul 2020 14:39:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 90D1B68BEB; Thu, 16 Jul 2020 16:39:31 +0200 (CEST)
Date: Thu, 16 Jul 2020 16:39:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V5] drivers/nvme: Add support for ACPI StorageD3Enable
 property
Message-ID: <20200716143931.GA23501@lst.de>
References: <20200702225011.10932-1-david.e.box@linux.intel.com>
 <20200709184333.6241-1-david.e.box@linux.intel.com>
 <CAJZ5v0iJeyf+eMsDd37GdBdQq4e_JkJwcCm9VdQNgaxcf_RrEg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iJeyf+eMsDd37GdBdQq4e_JkJwcCm9VdQNgaxcf_RrEg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_103937_972326_A5E9E610 
X-CRM114-Status: GOOD (  10.66  )
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
Cc: shyjumon.n@intel.com, Sagi Grimberg <sagi@grimberg.me>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, Jens Axboe <axboe@fb.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "David E. Box" <david.e.box@linux.intel.com>, Keith Busch <kbusch@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 13, 2020 at 01:12:26PM +0200, Rafael J. Wysocki wrote:
> I would write this as
> 
> if (fwnode_property_read_u8(acpi_fwnode_handle(adev),
>                             "StorageD3Enable", &val))
>         return false;
> 
> return val == 1;
> 
> to eliminate the redundant fwnode variable and untangle the last
> checks somewhat.
> 
> With that changed please feel free to add
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied to nvme-5.9 with the above fixup.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
