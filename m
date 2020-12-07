Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4CBC433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 15:34:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9843222B40
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 15:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9843222B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CIsNdghDWSQZpJ9upDxYokid1sMbw+Fklloube4SVQM=; b=kEtfyFNvaqVMtJKIHyFhOwDX+
	UUumYpfOfxox8OSXRfHPULQlsTdzHFoJ6xESvKUk3BAEj2aR//lFy+QaCX0I9vG8Cl3SzIHUrIpVQ
	Z4gUOOosWvVxzC1dV44lDK1qrwCIWL3OjRBgZcr2+LN6M4NQQZMCMn9TjJXVcOmMCte6TY2810oao
	ss7Dkrz9UZ6g/KgLdQGFdAd9+AZdypGze90XeFYPAzsTyb9zsDHUlh1PaVWqRj8a3VSSeML23VAFr
	A3pM2IDKbC6L7PJILkquakhF7l/Sv3S/ogWR+CSqz/0BBvd7wNe7GIRw3gUzy9WTyeHNcEQLIhG0n
	z4BPzyADw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmIXI-0000xt-Bo; Mon, 07 Dec 2020 15:34:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmIXG-0000xR-4q
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 15:34:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0FAA067373; Mon,  7 Dec 2020 16:34:44 +0100 (CET)
Date: Mon, 7 Dec 2020 16:34:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: retrigger ANA log update if group descriptor
 isn't found
Message-ID: <20201207153443.GA6236@lst.de>
References: <20201205152901.56665-1-hare@suse.de>
 <20201207153121.GA3679937@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201207153121.GA3679937@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_103446_316148_4A016DE6 
X-CRM114-Status: GOOD (  14.60  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 07, 2020 at 07:31:21AM -0800, Keith Busch wrote:
> On Sat, Dec 05, 2020 at 04:29:01PM +0100, Hannes Reinecke wrote:
> > If ANA is enabled but no ANA group descriptor is found when creating
> > a new namespace the ANA log is most likely out of date, so trigger
> > a re-read. The namespace will be tagged with the NS_ANA_PENDING flag
> > to exclude it from path selection until the ANA log has been re-read.
> > 
> > Reported-by: Martin George <marting@netapp.com>
> > Signed-off-by: Hannes Reinecke <hare@suse.de>
> 
> This looks good to me.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

But as I just outlined it just papers over buggy controllers.  I really
don't think we should just silently do that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
