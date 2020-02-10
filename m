Return-Path: <SRS0=obgt=36=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9A2C352A4
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2020 23:05:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594A1206D6
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2020 23:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JANJEkpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594A1206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hmw/IM3IYqMc6Kx4Ea1sFyMRneaaEs0MO3KnH8d7gSU=; b=JANJEkpksGkPHs
	E3oe3SyekHfJASucJF0FJo4GkHJpJtlB02sm5qCgiXNiBmdO6SR6SOXzMNffq2Su56KgM3YkAiCY3
	SNRZAvsGrcEVyLrs6HsXjuke1IhSMWiGGQJ6IwxUoaQxtanP94ADTMEYRs5Bbo5enIQzO09FDQCLk
	aVsjRH1WgaOiYja/ZqM7k4I38nDM5BFL/xtflryZB6jMEkxnTigsH2ze2g+xi7LGbU4QA96Hw0Cyg
	y5DNl9/bBEB3dof2gAExJ1ihh4tzkqn1qc2J+SzEqKvQM0LR+8xrp4A+nGq7ytUZQfq+15bus4/ns
	g4j1anlb+tJvW5g4eqyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1I73-00032D-1D; Mon, 10 Feb 2020 23:05:09 +0000
Received: from kvm5.telegraphics.com.au ([98.124.60.144])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1I70-0002H2-9H
 for linux-nvme@lists.infradead.org; Mon, 10 Feb 2020 23:05:07 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 1B613283A7;
 Mon, 10 Feb 2020 17:25:57 -0500 (EST)
Date: Tue, 11 Feb 2020 09:25:59 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
In-Reply-To: <20200210204313.GA3736@dhcp-10-100-145-180.wdl.wdc.com>
Message-ID: <alpine.LNX.2.22.394.2002110914510.9@nippy.intranet>
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200210204313.GA3736@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200210_150506_391818_EAE1D0BA 
X-CRM114-Status: UNSURE (   4.26  )
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
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Tim Walker <tim.t.walker@seagate.com>, linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 10 Feb 2020, Keith Busch wrote:

> Right now the nvme driver unconditionally sets QUEUE_FLAG_NONROT 
> (non-rational, i.e. ssd), on all nvme namespace's request_queue flags. 

I agree -- the standard nomenclature is not rational ;-) Air-cooled is not 
"solid state". Any round-robin algorithm is "rotational". No expensive 
array is a "R.A.I.D.". There's no "S.C.S.I." on a large system...

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
