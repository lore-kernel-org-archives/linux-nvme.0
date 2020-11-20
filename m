Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933A6C5519F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 14:30:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6352224C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 14:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UPGrIAYr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="isGoTN8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6352224C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zp2xCbNcmmypYcAjEpvBE96S0mDY0Drbry6hZyRwMPA=; b=UPGrIAYrgvUI+TfGAMcc8g91/
	2q8Tjliopwkd1UoY8vGH8j1aZ9TtBk292KYI637u4y6LbIpYnLMoawaL2FnGLatLY2U4/OkGz5rJB
	XN4s34q9qfxVqPlz2ZUE3lZuZDwu+Rc2qaxrwvWyfmCMZ3AUFafJdVVSPITdhKQEnjw6UFMpznH1X
	wpeOEsdnxCPFgS9M+hmoSJFawtFwovQemLi+7FmPJim638lstUBXn7eAa9THRsIsg0m4unLyWnyeh
	P6azayeqJalby5ZMGKAXQKoY8CV0X993/sRBDRpvvnNLIpb16BmIdjwclOBvJPoJ95A+NSd5jTxOg
	bunmV0oyQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg7QI-0001Im-3Z; Fri, 20 Nov 2020 14:30:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg7QE-0001IH-Pm
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 14:29:59 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EED1A2224C;
 Fri, 20 Nov 2020 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605882597;
 bh=D7G2QiwBgP/TgokMQw/VvHYyaDp0QQP9o0ZunMnsyT4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=isGoTN8kfGIgpSbhE+UqwrB7/Skyo0gqfxICHnyceiFYzpW00hjsAjBTvntcyUKxY
 afDFDsZQttR236cf1dHhTGnTaLfA+HEH5+fdi4lZYwo2byBxGXd6i8OANyBUXmE2Xz
 trRVLG/1iNk40+kUv+JMvCu2+p4E75DwEvxTLhWM=
Date: Fri, 20 Nov 2020 06:29:54 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme: Cache DMA descriptors to prevent corruption.
Message-ID: <20201120142954.GC2855047@dhcp-10-100-145-180.wdc.com>
References: <20201120012738.2953282-1-tmroeder@google.com>
 <20201120080243.GA20463@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201120080243.GA20463@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_092959_010931_EDBA3BA6 
X-CRM114-Status: GOOD (  21.31  )
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
 Tom Roeder <tmroeder@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 20, 2020 at 09:02:43AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 19, 2020 at 05:27:37PM -0800, Tom Roeder wrote:
> > This patch changes the NVMe PCI implementation to cache host_mem_descs
> > in non-DMA memory instead of depending on descriptors stored in DMA
> > memory. This change is needed under the malicious-hypervisor threat
> > model assumed by the AMD SEV and Intel TDX architectures, which encrypt
> > guest memory to make it unreadable. Some versions of these architectures
> > also make it cryptographically hard to modify guest memory without
> > detection.
> 
> I don't think this is a useful threat model, and I've not seen a
> discussion on lkml where we had any discussion on this kind of threat
> model either.
> 
> Before you start sending patches that regress optimizations in various
> drivers (and there will be lots with this model) we need to have a
> broader discussion first.
> 
> And HMB support, which is for low-end consumer devices that are usually
> not directly assigned to VMs aren't a good starting point for this.

Yeah, while doing this for HMB isn't really a performance concern, this
method for chaining SGL/PRP lists would be.

And perhaps more importantly, the proposed mitigation only lets the
guest silently carry on from such an attack while the device is surely
corrupting something. I think we'd rather free the wrong address since
that may at least eventually raise an error.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
