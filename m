Return-Path: <SRS0=mUlG=GL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630FEC433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 22:35:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8D423A74
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 22:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8D423A74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0levyyes/HPse5iK27q5RnGEU/Lj7Vlh7QMBd4OW55A=; b=a3+2ansWwDHZjufVuihHmlMOQ
	wExNOX1JOEnZ4YvDdG4eEHV8rbNSjCevQ4sv2PLpiaygfBn0mzQcNLuoiuDdANutidvWasqLc7kpN
	HM1GUwtFUMDAmItQ303nUXhwJiZF2UrQTXxBjz/6cY0XckY+29qCJuHFZ7P1/Bz7CLkRx9smH0S/G
	rfoUKp+Vnc5JAvUIfLOQus9dx0l1gVunMGma6+G61m6ROWFN8SX8j2zwNnMYW5j8uZG9ZAL2dMZDu
	R4kO/BQ0igR3dz5vSqden7So06/aVIGejvAApOnoBij2jX4+/e4vOiuptU0Qfqc+fxwBbt7buf1LT
	Dn5mrrFbg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ky0LU-0002TJ-SO; Fri, 08 Jan 2021 22:35:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ky0L5-0002Sv-4x
 for linux-nvme@lists.infradead.org; Fri, 08 Jan 2021 22:34:35 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03FBB23A74;
 Fri,  8 Jan 2021 22:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610145273;
 bh=amX0M3ICMK4H8NloqusDNHwY8d4QdxcxrjbUPHZNkuo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZsxMlHPIIqrfSJwfFjx3czWo1iS9PqbK34QLGf2KYUNPMFz/Zmytd5YsNw7evNP0j
 g/Dwm978xlshsL9XZpYJPwDR6wIvOvieIvwLq6RQnZWW2qqvaMbbNoJS00Gxg4UXw9
 sh1jUdjwhrxIkSnCm2/8rIfWkZ9Z6OC+MXwoCqCCYrRcZ2LNTehivmk9Va1ErjSqvo
 6AuXYQ7e0EhKXIbB2TEm4fn5hwZ7Lp5/1xVuEsuh5rCw2X78jG8Yr3C3dw6DRwR9mL
 lUrAvNUVehsF3Dm+oHtheBUp87n0x3xFVvCyRbUDFvdRZx82dIlsFrxKzIIgd/vbSW
 zRHc0QLLunlUg==
Date: Fri, 8 Jan 2021 14:34:31 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: trace: parse format nvm command in detail
Message-ID: <20210108223431.GA1451691@dhcp-10-100-145-180.wdc.com>
References: <20210104155343.GA26034@michal-desk>
 <20210104160220.GB1024941@dhcp-10-100-145-180.wdc.com>
 <20210106090053.GA32643@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210106090053.GA32643@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210108_173435_269100_78261F41 
X-CRM114-Status: GOOD (  18.20  )
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
Cc: Michal Krakowiak <michal.krakowiak@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Michal Krakowiak <michal.krakowiak@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 06, 2021 at 10:00:53AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 04, 2021 at 08:02:20AM -0800, Keith Busch wrote:
> > Perhaps it's too late since we've already gone done this path in the
> > driver, but IMO, we should have only traced raw dwords without any
> > additional decoding. This would have allowed consistent output for all
> > kernel versions and resilient to future spec changes. Then that could
> > have made possible for a user space utility to do the decoding to a
> > human friendly format, kind of like what blkparse does for block layer
> > trace events.
> 
> the block tracepoints actually contain pretty detailed decoding as well.

Sure, but what I'm trying to say is that the current nvme decoding isn't
forward compatible with spec changes that tools will be able to use, and
will not be possible to see currently reserved fields. It will be a
never ending maintenance burden to chase those changes, and there will
be no consistency in nvme trace events for different kernel versions.

If it would help at all to move in a more future proof direction, I
wrote a little script handling all the decoding and posted it here:

  https://github.com/linux-nvme/nvme-trace/blob/main/nvme-trace.pl

If that's okay, we can greatly simplify the nvme tracing so that it
will always be consistent and able to obtain new command fields as they
show up.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
