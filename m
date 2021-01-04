Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726DEC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 22:33:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D682251E
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 22:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D682251E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RbGlsGZgTzTsi8pSDAuJhKfyC8H+QcbC/trHM6LVKpU=; b=rn0U+T9PnMTJWzkRCLih/TAf/m
	VKEaxojzH3hE15w3iEj4NRykNnV4hOfyd6spEshTb/qh7rc+k8SO2u1y3XcPT/P7+/i8sXoySTG+3
	Nur0re0hgyyDG1ChXDoxH1/Xaco6Csa5zcaqCbqicgcthv0ZLYbmo1e97aCPsQc5qDLHFpHvth0tA
	blHQsNG6fVGurPG4Vddo+PrJWhLEDsLtrZzU8JweKcxpzsRa3J09fWIYdqrod9GZWofqJJYuDIsKg
	JM2Wg6eie007SobiZk6L4yJV3AjxmcIeXVDXMBdNwbUGSjzwWb6xom9aFKGzSY13pckU/aMnaebLA
	WSVAmBPQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwYPi-0005C3-8z; Mon, 04 Jan 2021 22:33:22 +0000
Received: from hera.aquilenet.fr ([185.233.100.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwYPe-0005BK-SJ
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 22:33:19 +0000
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 9ACAD5E7;
 Mon,  4 Jan 2021 23:33:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fz4CyzIeWsiw; Mon,  4 Jan 2021 23:33:14 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr
 (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id BAE108A;
 Mon,  4 Jan 2021 23:33:14 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1kwYPZ-000tPK-I9; Mon, 04 Jan 2021 23:33:13 +0100
Date: Mon, 4 Jan 2021 23:33:13 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Keith Busch <kbusch@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: Are AER corrected errors worrying?
Message-ID: <20210104223313.plaaph3erefjw3rd@function>
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
X-CRM114-CacheID: sfid-20210104_173319_022219_95B14579 
X-CRM114-Status: UNSURE (   9.34  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Samuel Thibault, le lun. 04 janv. 2021 22:36:48 +0100, a ecrit:
> Samuel Thibault, le lun. 04 janv. 2021 21:12:47 +0100, a ecrit:
> > Keith Busch, le lun. 04 janv. 2021 10:44:35 -0800, a ecrit:
> > > PCI also has automatic link power savings that you can disable with
> > > parameter "pcie_aspm=off".
> > 
> > I'll try that if I still see errors with the nvme_core parameter.
> 
> I'm on it.

(FTR It switched these lines)

02:00.0 Non-Volatile memory controller: Sandisk Corp WD Black SN750 / PC SN730 NVMe SSD (prog-if 02 [NVM Express])
	[...]
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		[...]
		DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
	->	DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
		DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
	->	DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
	[...]
	Capabilities: [100 v2] Advanced Error Reporting
		CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
	->	CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
	[...]
	Capabilities: [900 v1] L1 PM Substates
		[...]
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
			T_CommonMode=0us LTR1.2_Threshold=163840ns
		->	T_CommonMode=0us LTR1.2_Threshold=81920ns

Samuel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
