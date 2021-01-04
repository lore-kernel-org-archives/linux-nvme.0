Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA4BC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 20:15:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6099022241
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 20:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6099022241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/qAnJ0HFf3YimOI/1LATE2HKlNmeXPoS7kPb3RuruKo=; b=N5DW6myQlovaTGM+2gQljfne7
	4ZaJH0sYfT/Qf0ohKbVILd7v8gCiQT4jlUop2SkOTTOa6/9ukoout9cu0vEqvcSstlm097VOhcDT/
	YWzj4AjykQ0K/tW1ugW+TDuMKAdyUCiHHn9ogbMOHqYAF0q+jntPfyYbspNY+LqF9f9vlzKa92L+U
	icRbsf6XwkMARbvOF3DbTXDdCj8MaS+bQgYZZlJ+gaj8lpmfbSV++Sb636utwOiMGYeQs4TsuoATA
	yNX5wB6Uq5k8Pni8nAG15nJs33bAffUdlkvzmov3+ymFm/Me0Z6jrcTh3YE+5FaKfsEP04OGJNIEY
	ghVK8EtAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwWFy-0001T5-00; Mon, 04 Jan 2021 20:15:10 +0000
Received: from hera.aquilenet.fr ([185.233.100.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwWFw-0001S8-BI
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 20:15:09 +0000
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 1F001573;
 Mon,  4 Jan 2021 21:15:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cnyBnM3xSoPG; Mon,  4 Jan 2021 21:14:59 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr
 (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 733E5AD;
 Mon,  4 Jan 2021 21:14:59 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1kwWDf-000KtD-20; Mon, 04 Jan 2021 21:12:47 +0100
Date: Mon, 4 Jan 2021 21:12:47 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Keith Busch <kbusch@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Subject: Re: Are AER corrected errors worrying?
Message-ID: <20210104201247.5k47gueib3cw4sfr@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Keith Busch <kbusch@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
References: <20210101224028.4akud7meibjavvtf@function>
 <20210104184435.GE1024941@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210104184435.GE1024941@dhcp-10-100-145-180.wdc.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_151508_491401_59FE5B06 
X-CRM114-Status: GOOD (  13.16  )
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
Cc: linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

Vidya Sagar wrote:
> Since this is a laptop, I'm suspecting that ASPM states might have
> been enabled which could be causing these errors.

Keith Busch, le lun. 04 janv. 2021 10:44:35 -0800, a ecrit:
> Sometimes these types of errors occur from low power settings, so you
> can try disabling the automatic management of these (assuming the
> hardware supports it). To disable nvme specific power state transitions,
> the kernel parameter is "nvme_core.default_ps_max_latency_us=0".

I have tried to add it, and this one line changed in lspci -vv:

02:00.0 Non-Volatile memory controller: Sandisk Corp WD Black SN750 / PC SN730 NVMe SSD (prog-if 02 [NVM Express])
[...]
	Capabilities: [c0] Express (v2) Endpoint, MSI 00                                               
[...]
		DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
turned to
		DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-

that last value happens to be what I was seeing for that line with the
manufacturer-provided ubuntu linux kernel.

So far (30m uptime) no corrected error report, I'll watch in the coming
hours/days to see if that avoided the issue. I wasn't able to trigger
such corrected errors by loading the machine, so possibly that's indeed
the converse that I should have been trying: letting it go low power :)

> PCI also has automatic link power savings that you can disable with
> parameter "pcie_aspm=off".

I'll try that if I still see errors with the nvme_core parameter.

Samuel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
