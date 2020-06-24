Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DA8C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 19:39:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B5B2081A
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 19:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z4HMaRxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B5B2081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mUu8N6MzP/ZYAv4KisgxrjW8o+MKTaKcLeUpI3R5EYc=; b=Z4HMaRxO1EXPM9YUErZFGE0+se
	bAmHm2i1I1oRFGo0ckrR9xfCsM7tyFT7TmiJjJyXE07iMDTpDomR8aqsIldo1IQoxPz6u8PZ0d9jC
	xZoOzDPf9ncdhiAxDm0xwx5cF6yD1RedjiAGwKG4+8fmUf2AMpnjMMpK+i8tubxJ/JyStiSQwIMXB
	uP1YKAV5De7CYCLJCprJEperthJE/mNbHb5v0Zc8gQ5EFixxVn8VIZheuvB3TLuQ3S6iUeMwNw244
	H51VMwmzkRGkKOQ+EMgLzPU4rfglzpfBTopcr9oJAptS7TK6NOwUDvyCiudz9cpwuJ1OAj0MiCdEW
	Zb9RQRMA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joBEo-0005C7-3W; Wed, 24 Jun 2020 19:39:14 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joBEk-0005AE-I6
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 19:39:11 +0000
IronPort-SDR: VUyvZNENan1PBa9y2gg69p1DDsFPJVuJGVk61C/2ApgmO9diqj3KWWqt/u/VfNmpb5wjL7qGu3
 cd0miXg+QKjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="162691943"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; d="scan'208";a="162691943"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2020 12:39:08 -0700
IronPort-SDR: z6nfZQhPv6nuVQFeUgr2r64l76Au49sOAqbkao9966p02ZnG72vHFKXI02Sr/mMBU5QJql8KRS
 zGLWFpgHM0XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; d="scan'208";a="275798065"
Received: from linux.intel.com ([10.54.29.200])
 by orsmga003.jf.intel.com with ESMTP; 24 Jun 2020 12:39:08 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com
 [10.7.201.137])
 by linux.intel.com (Postfix) with ESMTP id 0257D5804D6;
 Wed, 24 Jun 2020 12:39:08 -0700 (PDT)
Message-ID: <06eff8e884b7bddd155fcaad5ef25b9db80a12d5.camel@linux.intel.com>
Subject: Re: [PATCH V2 0/2] nvme: Add support for ACPI StorageD3Enable property
From: "David E. Box" <david.e.box@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 24 Jun 2020 12:39:07 -0700
In-Reply-To: <CAPcyv4iYGgjmAUiKUgFBF+nm=axamYFueCkN5Jyu7yQ6w1HxLg@mail.gmail.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
 <20200612204820.20111-1-david.e.box@linux.intel.com>
 <12d36fdcdbcf438dd3aac7769e8366afd9d5aa1a.camel@linux.intel.com>
 <CAPcyv4iYGgjmAUiKUgFBF+nm=axamYFueCkN5Jyu7yQ6w1HxLg@mail.gmail.com>
Organization: David E. Box
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
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

On Wed, 2020-06-24 at 12:10 -0700, Dan Williams wrote:
> On Wed, Jun 24, 2020 at 11:55 AM David E. Box
> <david.e.box@linux.intel.com> wrote:
> > Friendly reminder. Thanks.
> 
> Are you looking for this to be merged by ACPI with an NVMe ack, or
> merged by NVMe with an ACPI ack? It sometimes helps to be explicit to
> break the log jam.

Ah. NVMe merge with ACPI ack. Thanks.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
