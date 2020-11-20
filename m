Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1ABC5519F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 08:02:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389A2222BA
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 08:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WGxqjvMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389A2222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=75XTVWcPN5Psd4feSK8WHzU+4u8WLNl8lVgIKyNgRbo=; b=WGxqjvMBl5twhtuv/YilAsZn4
	8OZhnA5G3dgcdC0xLD4/3F+HGBfxEHiVcmDtnpU+sCIJ+E1RssfP+M4Nl+SXfee0d4dDD1PJ2zBO3
	zCW87mh/1yU2C0YrpG21QfqWQsLXQWSqc8Qasepw8We203MpUihRmNNnyJKEGpDvKU/uYgWGq0qPS
	DHJq2y/O7bulDRwk/ydY+PrXANFz8myTIH3ZltLDTgjLL7z9RgJHMVjwCmKdxFuAak1u7MgiVfPAi
	Bytd93a8QmO12+cNtU4e9oMhczJj3u+Ej0SrTqI57iC9ez3FcvzDKFSNC7FBBD+zms5QHzy0rTPD+
	qo7nXtDQg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg1Nd-0003Pf-Nr; Fri, 20 Nov 2020 08:02:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg1Na-0003OD-Pe
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 08:02:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D6FE467373; Fri, 20 Nov 2020 09:02:43 +0100 (CET)
Date: Fri, 20 Nov 2020 09:02:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tom Roeder <tmroeder@google.com>
Subject: Re: [PATCH v2] nvme: Cache DMA descriptors to prevent corruption.
Message-ID: <20201120080243.GA20463@lst.de>
References: <20201120012738.2953282-1-tmroeder@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201120012738.2953282-1-tmroeder@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_030250_964324_C5F93DC9 
X-CRM114-Status: GOOD (  14.40  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Marios Pomonis <pomonis@google.com>,
 Jens Axboe <axboe@fb.com>, Peter Gonda <pgonda@google.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 19, 2020 at 05:27:37PM -0800, Tom Roeder wrote:
> This patch changes the NVMe PCI implementation to cache host_mem_descs
> in non-DMA memory instead of depending on descriptors stored in DMA
> memory. This change is needed under the malicious-hypervisor threat
> model assumed by the AMD SEV and Intel TDX architectures, which encrypt
> guest memory to make it unreadable. Some versions of these architectures
> also make it cryptographically hard to modify guest memory without
> detection.

I don't think this is a useful threat model, and I've not seen a
discussion on lkml where we had any discussion on this kind of threat
model either.

Before you start sending patches that regress optimizations in various
drivers (and there will be lots with this model) we need to have a
broader discussion first.

And HMB support, which is for low-end consumer devices that are usually
not directly assigned to VMs aren't a good starting point for this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
