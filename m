Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69B9C4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 09:24:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2442C20774
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 09:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="00M6UhQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2442C20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9XyrHMgHG3pRkPWtpOPB4eqf89JEmp7vRbwUafi7XXk=; b=00M6UhQEgxJaB81UBLiFRDTEB
	WuLOyWZSVgwmr0VVmWokFVQBZynfLJNJdjupEm77Z//N30XZMeE0ewodbUylgdINbs7qsMkl7hg5P
	8VWGObMJHbG33CnS+Hrl5fVrJdlZLuVwMHLFt8VH1A+06aqxDaMKqzTUItvUJXERl8xentXe1FzsR
	L+TPSYKgnU6Ec5mYI1RJzQ/Vt4g/xnJuNeDfVAbsK54Up3YowRZ9X2gIXil0coDl2FhsCp2RW+GhM
	E8UmKkm21YL28ozQ4Oa6rr+BdFa1jbKZcvHeLyDmkC9pPYVZfMwzZDLDftjJ6nxKSq3FoVGPcPhoa
	ITUg/p+Sw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPMj4-0000ou-W6; Mon, 05 Oct 2020 09:24:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPMj2-0000oR-FQ
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 09:24:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3BB3367373; Mon,  5 Oct 2020 11:24:06 +0200 (CEST)
Date: Mon, 5 Oct 2020 11:24:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC PATCH] nvme: add 'queue_if_no_path' semantics
Message-ID: <20201005092405.GA18193@lst.de>
References: <20201002160634.11821-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201002160634.11821-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_052408_708889_6E3F8BA4 
X-CRM114-Status: GOOD (  19.05  )
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
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Oct 02, 2020 at 06:06:34PM +0200, Hannes Reinecke wrote:
> Currently namespaces behave differently depending on the 'CMIC'
> setting. If CMIC is zero, the device is removed once the last path
> goes away. If CMIC has the multipath bit set, the device is retained
> even if the last path is removed.
> This is okay for fabrics, where one can do an explicit disconnect
> to remove the device, but for nvme-pci this induces a regression
> with PCI hotplug.
> When the NVMe device is opened (eg by MD), the NVMe device is not
> removed after a PCI hot-remove. Hence MD will not be notified about
> the event, and will continue to consider this device as operational.
> Consequently, upon PCI hot-add the device shows up as a new NVMe
> device, and MD will fail to reattach the device.
> So this patch adds NVME_NSHEAD_QUEUE_IF_NO_PATH flag to the nshead
> to restore the original behaviour for non-fabrics NVMe devices.
> 
> Suggested-by: Keith Busch <keith.busch@wdc.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>

This seems to include the patch from Keith to tear down the disk
earlier. I think that needs to stay a separate prep patch, otherwise
it will be very hard to review and reason about.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
