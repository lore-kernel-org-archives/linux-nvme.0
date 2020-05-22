Return-Path: <SRS0=OKIn=7E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B748C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2020 14:14:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1572225D
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2020 14:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nd+SEC0I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0I9tiae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1572225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BAkXy+fKNniYVrD/dEz+GhDN3Kc4crbZT4IYa9zzFHo=; b=Nd+SEC0IzrixPo
	YlrAY3Ak9P92eH8qKpytH+7nWCqXsIO7eEEjdasj6Y5iPF6lIpSYSiUFxOvKnUQ133wlpw1hw1aFV
	vJhNiU8IzgOY4WPSX59eD3Uzq/NYQyaSdg+8LH18rBO5Dc1sm9XM4Wh0Jp9YUtPYmUPMiLcZbr+/v
	gSvADUC0CQ/5nVMvoel7On/FtMgyXRvBbmRPxb9c92j4eZxNMS5NeQi96kZQJqXfnmTgQ+P7+2t0C
	jnq35wGw28zIsO2ngzJ5w/79brDT4os6zmNgyLqPDDC++h3raVhb7NZtaZZ44r9OCl12zKHa4Du7V
	vIXMWtDJmwxwElS0miaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jc8Rp-0007Kn-I6; Fri, 22 May 2020 14:14:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jc8Rn-0007Jt-LF
 for linux-nvme@lists.infradead.org; Fri, 22 May 2020 14:14:52 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6BFF62225D;
 Fri, 22 May 2020 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590156889;
 bh=gdKixlSUUbnKOyJGher+uVnnEQYKsMdvWoJlTqdLHq0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L0I9tiaeZ2vQIdyvDGdvPkcR7zUDSraEsHyNzHQVcneC8Ne5VYzLT4asixKz98kf+
 JHHXYQVImpcnKpJO/+E851BqRNLsyaj8+1JjoEbS/FHauvc5fQNg5nr9b8gwd8fk70
 l54N6FiOOE0zaSdiGZjcSw7D3dTeiBbN+Dyoq65U=
Date: Fri, 22 May 2020 07:14:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: Improve io_opt limit stacking
Message-ID: <20200522141447.GB3423299@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200514065819.1113949-1-damien.lemoal@wdc.com>
 <BY5PR04MB6900144BD2729172EBF5DF2EE7B40@BY5PR04MB6900.namprd04.prod.outlook.com>
 <yq1lflkp0b9.fsf@ca-mkp.ca.oracle.com>
 <yq1ftbsp06e.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <yq1ftbsp06e.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200522_071451_718545_16A6C049 
X-CRM114-Status: GOOD (  12.72  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Mike Snitzer <snitzer@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 22, 2020 at 09:36:18AM -0400, Martin K. Petersen wrote:
> 
> >>> +	if (t->io_opt & (t->physical_block_size - 1))
> >>> +		t->io_opt = lcm(t->io_opt, t->physical_block_size);
> >
> >> Any comment on this patch ?  Note: the patch the patch "nvme: Fix
> >> io_opt limit setting" is already queued for 5.8.
> >
> > Setting io_opt to the physical block size is not correct.
> 
> Oh, missed the lcm(). But I'm still concerned about twiddling io_opt to
> a value different than the one reported by an underlying device.
>
> Setting io_opt to something that's less than a full stripe width in a
> RAID, for instance, doesn't produce the expected result. So I think I'd
> prefer not to set io_opt at all if it isn't consistent across all the
> stacked devices.

We already modify the stacked io_opt value if the two request_queues
report different io_opt's. If, however, only one reports an io_opt value,
and it happens to not align with the other's physical block size, the
code currently rejects stacking those devices. Damien's patch should
just set a larger io_opt value that aligns with both, so if one io_opt
is a RAID stripe size, the stacked result will be multiple stripes.

I think that makes sense, but please do let us know if you think such
mismatched devices just shouldn't stack.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
