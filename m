Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ED2C41604
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 07:52:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F52120760
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 07:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rfRNZOGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F52120760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pkkmYlsrUpt7icw6f4Tz0KtCMJTHKTVZ7OvH3AOovRQ=; b=rfRNZOGjbaxDvTiQP6oBR+N/T
	5HOYwfE3FSH9kSmNn4OFOnjPxrEFw6AFj11Gq9PPX80lUiNIz3MuoiGN6EDIoWVIvlVMIAOke7FR+
	k20FWYL3C0OlHBiE90DxbQzZ0CHeIWSn6zg+Rm1dSg/9LzzdEiJ5jEJrkGfw2YfPw9ZkJ1dX7+DOn
	iYdO1kVGzQqlGuSEGMOoEwvIbcQ0raX0L3jp2ShIu5OMO4pyNxHs/91PBNHgTAiYMtz2gWUS3EJ0T
	tbJ+zPdkTHOyJDWx3JXRwTpfDKq05lIHxAAQVk6esHTeeN3CccJjKKHtJUjPFBLOjxqVFdI0eYS5E
	fbYHhHu6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPhlQ-00025a-Pr; Tue, 06 Oct 2020 07:52:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPhlN-00025C-Q5
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 07:51:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BF07D67373; Tue,  6 Oct 2020 09:51:53 +0200 (CEST)
Date: Tue, 6 Oct 2020 09:51:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] nvme: add 'queue_if_no_path' semantics
Message-ID: <20201006075153.GA10041@lst.de>
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-3-hare@suse.de> <20201005125201.GB1125@lst.de>
 <8d7d4803-5808-0839-ee4f-e36a12756497@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d7d4803-5808-0839-ee4f-e36a12756497@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_035157_975700_27DA2D52 
X-CRM114-Status: GOOD (  12.81  )
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

On Tue, Oct 06, 2020 at 07:48:40AM +0200, Hannes Reinecke wrote:
> Well, because it's established behaviour of the current code.
> Changing it now has the potential to break existing scenarios.
>
> For PCI (ie non-fabrics) the current behaviour is arguably a corner case 
> (as one needs to have a PCI-NVMe with CMIC bit set), but once you have it 
> PCI hotplug is done for. So there we really want to change the behaviour to 
> get the same user experience for all NVMe drives.

Dual port PCI NVMe devices are pretty common in the enterprise space.
I really don't see any good reason to differ here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
