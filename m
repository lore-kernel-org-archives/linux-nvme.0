Return-Path: <SRS0=6u0/=ES=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49548C5519F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 17:36:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405C22223C
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 17:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N1inZPuP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFMsnNC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405C22223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hnQrxljxfqs8MMnL1DhEMdNx0ylpPVyIH2KZNo7gq2I=; b=N1inZPuPHGq6vmNp1uM9vzSxc
	mu5ubtIvjYfIj3lT6/sZesEmzY04FG+YVYutTv9TKXTbW+ybMvfSEk27Q4ArnTQN+4MviVGLhfRJ4
	NxSJqwe16ha2ES+WS9e1WWxxkUfUXPq/OXDNJabTX4Aqu6qTkOa00geFqTKbi73wjvPM8decTQCZx
	j/ZpJP6kUPeehYd3N0dslCqtjY2ZvdiwTFZPPEpHoxbd/GJyWfQaukkRMN0wicSFVIZz0csR4D/X+
	40AwnpPvObDmq26aRoz1qI5gtgHQNhG6VMFoc/1JSOh1FIazgeem3kat9oAmonab/AfWMm0+dhb+d
	NGn1Yvp2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdGWZ-00008q-Cw; Thu, 12 Nov 2020 17:36:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdGWU-00008A-5S
 for linux-nvme@lists.infradead.org; Thu, 12 Nov 2020 17:36:39 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BA570206CA;
 Thu, 12 Nov 2020 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605202597;
 bh=62n+3qAQC/6pRGdolxF8eh1RRuxn+EPmo03iIszC2mY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oFMsnNC08E3xNKjAJdF9XvQggRV+d/ZTTnyuA+kv7rhlqb5xxzc/cdc53XZB7kAFR
 sOL+e6cixjCZ3sA0eoY36K8pMaDrwPlI1Dub8jjWLyRJJkJBe+rY39xN9aAfvYNtms
 Wl4ioiq/T/ouYRW+eQ4ErB8cabgDriZtHIRw4CSg=
Date: Thu, 12 Nov 2020 09:36:34 -0800
From: Keith Busch <kbusch@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH 0/2] nvme-pic: improve max I/O queue handling
Message-ID: <20201112173634.GA2626470@dhcp-10-100-145-180.wdc.com>
References: <20201112082302.82441-1-schnelle@linux.ibm.com>
 <20201112145325.GC2573679@dhcp-10-100-145-180.wdc.com>
 <10908f20-7e18-e967-76dd-1a38e216b378@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10908f20-7e18-e967-76dd-1a38e216b378@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201112_123638_454790_8039C99F 
X-CRM114-Status: GOOD (  13.15  )
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
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 12, 2020 at 04:45:35PM +0100, Niklas Schnelle wrote:
> You got to get something wrong, I hope in this case it's just the subject
> of the cover letter :D

I suppose the change logs could be worded a little better :)

> Thanks for the review, I appreciate it. Might be getting ahead of
> myself but I'm curious who would take this change through their
> tree if accepted?

The linux-nvme tree is located here:

  http://git.infradead.org/nvme.git

Christoph is currently handling patch commits there.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
