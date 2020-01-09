Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B99C282DD
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 16:26:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61322067D
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 16:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JblW/8g4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y3qh+EI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61322067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y+vPDJ1Dro2GwLkplOrS0nXI53t1errf/k46Ylm1TY0=; b=JblW/8g4ilzmi1
	ShlSj4PeRYPrSK8+BWp55wEAwwLmbzMMrMJ6B0bz8hkohL4VcfDfyItE5xpN54/9KYeTpe/WaNDnC
	/IMv5MVWMzLrgKxkxbN5KEaCg0mZGgxz+jKJIlexbf4pa5wOyj1+fstHCR60twPX/Hiwb11kCFXbb
	c3U3mDoT/y3Yw4k9lAajgxUK6i1cpkAk5cBD6hbd2djvqiW6cCTKL28oWA+GDTTZ5gj20/SqUToJU
	7a08oiiPooIOGwZOMY32Bork4fDREjmJsEq23Y0WBexvuUuViPsKQ6spK7WwJKc72PvKeIDBfQxFI
	GkSI1YU7K2Mria2GPsbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipadj-0004dV-T4; Thu, 09 Jan 2020 16:26:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipadg-0004dE-Ip
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 16:26:29 +0000
Received: from chuupie.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3F8482067D;
 Thu,  9 Jan 2020 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578587188;
 bh=IoewwOcnDzGRcg5rkqeCnflgabess73xUELfgsfVYbk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=y3qh+EI9XdNocgUXtrzvN5p04ANnVusoPkqM9CuNMXlGOiGXo9M1Hp84VlByC/pGi
 rp3jUlYT1Cn99zRHABFIZy3mK653AitX3cMM/WCWcf3MtedOrSZFoXGx3Kpm0teOv4
 VJ0eG58RTTSztBZTHVA19UopVznewwTMrI1jzpWo=
Date: Thu, 9 Jan 2020 08:26:25 -0800
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 01/15] nvme: Introduce namespace features flag
Message-ID: <20200109162625.GB1032473@chuupie.wdl.wdc.com>
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-3-maxg@mellanox.com>
 <yq1imllz5l4.fsf@oracle.com>
 <87553ee2-74f4-8eb9-dd07-552f2637dab8@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87553ee2-74f4-8eb9-dd07-552f2637dab8@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200109_082628_640655_53D96F67 
X-CRM114-Status: UNSURE (   7.89  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@kernel.dk, sagi@grimberg.me,
 "Martin K. Petersen" <martin.petersen@oracle.com>, shlomin@mellanox.com,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, oren@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 09, 2020 at 12:38:05PM +0200, Max Gurtovoy wrote:
> 
> On 1/9/2020 5:11 AM, Martin K. Petersen wrote:
> > Max,
> > 
> > > +#define NVME_NS_DIX_SUPPORTED	(1 << 1)
> > > +#define NVME_NS_DIF_SUPPORTED	(1 << 2)
> > Not so keen on the DIF/DIX terminology in this context.
> 
> Martin,
> 
> how about:
> 
> +#define NVME_NS_PI_HOST_SUPPORTED (1 << 1)
> +#define NVME_NS_PI_CTRL_SUPPORTED (1 << 2)

Well, I was trying to say earlier that nvme supports formats with metadata
that's not used for protection information. The metadata, whether separate
or interleaved, can be used for some proprietary non-pi related feature.

The nvme driver only leverages "blk-integrity" to facilitate allocating
and managing the metdata payloads even when not used for integrity. It
might make sense to give that block component a more generic name than
"integrity".

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
