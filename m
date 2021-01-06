Return-Path: <SRS0=xG/4=GJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE27C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 20:36:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E85CB2311B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 20:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85CB2311B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3FtLGXtTlOKSNn8vCXKI4fNDco2BqnPwjDJHJhyP1/s=; b=BtdCrtglURbtEliRDLYUEOvtwT
	bNynpeDuvqIWlWATz4gJQsR3bBaPMRS8rNdpqV5z80ghrgNvAVZtLXgiSQ912wkP+Q81aI/U78t48
	p8FRl1Oy7kCMRZpOemtVrjEaT67/LiRPRwfLWkY1drttorTs0visMVQCzIIrUA6pI05w9YPK6NB7f
	RyWC16bFAMjhNCGsEVk8iIPt+FHH2giS56YCSfJ27x6vjhBwhH/R1k6J0WSQarUL8ggW+hwhKJhi7
	6Lru+tuwliogDdhqF6wijbA1JGLJxKtxsrhlMwtpoeBeOE07+smmv3V/GGBVXs+ijMYPBLPhumC9o
	U1WXHylg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxFX0-0004fn-2j; Wed, 06 Jan 2021 20:35:46 +0000
Received: from hera.aquilenet.fr ([185.233.100.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxFWm-0004ZX-9N
 for linux-nvme@lists.infradead.org; Wed, 06 Jan 2021 20:35:43 +0000
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 8AAE35B0;
 Wed,  6 Jan 2021 21:28:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wI9yWFO6irt6; Wed,  6 Jan 2021 21:28:24 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (unknown
 [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id BCB8043F;
 Wed,  6 Jan 2021 21:28:24 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1kxFPr-005qGU-Nc; Wed, 06 Jan 2021 21:28:23 +0100
Date: Wed, 6 Jan 2021 21:28:23 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Keith Busch <kbusch@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: Are AER corrected errors worrying?
Message-ID: <20210106202823.ehdkno3inlzszqtb@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Keith Busch <kbusch@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
References: <20210101224028.4akud7meibjavvtf@function>
 <20210104184435.GE1024941@dhcp-10-100-145-180.wdc.com>
 <20210104201247.5k47gueib3cw4sfr@function>
 <20210104213648.enkuq5e2o6adbiur@function>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210104213648.enkuq5e2o6adbiur@function>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210106_153532_495428_ED274FB3 
X-CRM114-Status: GOOD (  20.69  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Samuel Thibault, le lun. 04 janv. 2021 22:36:48 +0100, a ecrit:
> Samuel Thibault, le lun. 04 janv. 2021 21:12:47 +0100, a ecrit:
> > Vidya Sagar wrote:
> > > Since this is a laptop, I'm suspecting that ASPM states might have
> > > been enabled which could be causing these errors.
> > 
> > Keith Busch, le lun. 04 janv. 2021 10:44:35 -0800, a ecrit:
> > > Sometimes these types of errors occur from low power settings, so you
> > > can try disabling the automatic management of these (assuming the
> > > hardware supports it). To disable nvme specific power state transitions,
> > > the kernel parameter is "nvme_core.default_ps_max_latency_us=0".
> > 
> > I have tried to add it,
> > 
> > I'll watch in the coming
> > hours/days to see if that avoided the issue.
> 
> I did get one
> 
> Jan  4 22:34:53 begin kernel: [ 7165.207562] pcieport 0000:00:1d.0: AER: Corrected error received: 0000:02:00.0
> Jan  4 22:34:53 begin kernel: [ 7165.213891] nvme 0000:02:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> Jan  4 22:34:53 begin kernel: [ 7165.216949] nvme 0000:02:00.0:   device [15b7:5006] error status/mask=00000001/0000e000
> Jan  4 22:34:53 begin kernel: [ 7165.219995] nvme 0000:02:00.0:    [ 0] RxErr
> 
> > > PCI also has automatic link power savings that you can disable with
> > > parameter "pcie_aspm=off".
> > 
> > I'll try that if I still see errors with the nvme_core parameter.
> 
> I'm on it.

I tried to make the machine only run apt-get update every 10m for 24h.

With pcie_aspm=off, I didn't get any corrected error
Without it I got 39 corrected errors

So that seems very relevant :)

Is there more I can provide to investigate if that can somehow be fixed
in the driver? I guess I can safely use the system with pcie_aspm=off?
(the energy saving seems neglectible)

Samuel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
