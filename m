Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D64FC38A2A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 15:34:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6980321841
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 15:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lTVx9YK2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMSZtxHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6980321841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KjhJJXjRFDXrsBDTRAfPzSgOxKkRTIMrtPjnb2AmqNk=; b=lTVx9YK2bFCLd7
	F6PIZL5IDdeCUQkihIPBpNTYJ4BEo4sLyyPKmuUHl+2ZCYevdE8H9OU6KqbVbeLE63Jv5GXZa+enz
	FbnfOwqT27oTm3colXEhr485icdzyhoCj9TSHMBbLG1FYb10CG88Y5iktPTb1w1Zp9XLyWoof/4Oh
	730k+tgaSK95DKS1IGQkb654AMlDUG/px3L9JUBZwW3nREvo2fk+RHJ/XD8+g1Di0FWtI00QqZEnD
	J7pjjs3eAecREuYUwKPUhHx9A60SWJkgYuiazAnxPgs7Z5qmudt7tRIkpNL9xOSWP/uHgSQdZ2Hzr
	nM+420oJsCijxeoa07qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jX50s-000071-GN; Fri, 08 May 2020 15:34:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jX50p-000069-Tp
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 15:34:09 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8474621841;
 Fri,  8 May 2020 15:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588952047;
 bh=VSVspwCcRw4BQSWmpInNSpbzTtFGf73Mv6Ows2oeCBQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eMSZtxHpgKjz1vYGjtxy3fTwgEjuHbKsENO/29FsJfTXhi/npHbaHXaEOcUzZbeA+
 FZrmBa0tLmKaVRnoUFhEDSoP3OwztqSQPzrJHxCDqsEMyvFg9sj1IotzQfAPzt2SLo
 wzUwDxEKHUdAqH8V7DepJ11dLpStaseCsegS/A/8=
Date: Fri, 8 May 2020 08:34:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
Message-ID: <20200508153404.GA2622778@dhcp-10-100-145-180.wdl.wdc.com>
References: <e1643b53-d362-0b5e-573f-72f0ea249ebf@huawei.com>
 <20200507142352.GA2621422@dhcp-10-100-145-180.wdl.wdc.com>
 <8b297620-c72b-2184-36cb-032f5cfda05c@huawei.com>
 <20200507153506.GA2621480@dhcp-10-100-145-180.wdl.wdc.com>
 <9e04eebc-a55b-ac7e-3cb3-9c65f084ee6c@arm.com>
 <20200507173545.GC2621480@dhcp-10-100-145-180.wdl.wdc.com>
 <20200507174429.GA4466@willie-the-truck>
 <20200507180612.GD2621480@dhcp-10-100-145-180.wdl.wdc.com>
 <20200508114020.GA16247@willie-the-truck>
 <20200508140733.GE2621480@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200508140733.GE2621480@dhcp-10-100-145-180.wdl.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200508_083407_990963_6FC445D6 
X-CRM114-Status: GOOD (  12.33  )
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
Cc: sagi@grimberg.me, John Garry <john.garry@huawei.com>,
 linux-nvme@lists.infradead.org, Alexey Dobriyan <adobriyan@gmail.com>,
 axboe@fb.com, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 08, 2020 at 07:07:33AM -0700, Keith Busch wrote:
> On Fri, May 08, 2020 at 12:40:20PM +0100, Will Deacon wrote:
> > Without a barrier on the read side, something like the following might be
> > able to happen:
> > 
> > 	CPU				NVME
> > 	Read stale data
> > 					Write data
> > 					Write phase bit
> > 	Read phase bit
> > 
> > So you need a dma_rmb() on the CPU side to prevent that reordering, and
> > ensure that the phase bit is read first.
> 
> I hadn't mentioned the driver CQE reads use 'volatile' access, reading
> phase first, then command id some time after.

Well, maybe that doesn't mean anything. We're using conditional control
dependencies, like this pseudo code:

	if (READ_ONCE(cqe->phase) is new phase) {
		...
		command_id = READ_ONCE(cqe->command_id)
		...
	}

But according to Documentation/memory-barriers.txt:

  (*) Control dependencies can order prior loads against later stores.
      However, they do -not- guarantee any other sort of ordering:
      Not prior loads against later loads

So a read barrier would be necessary if that's how it is.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
