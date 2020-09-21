Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D967EC4363C
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 20:46:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A47218AC
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 20:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J3wQLJvB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLMs1Z8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A47218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LTgaj1xsk4Cc/thl/K3J7GtjKOxEHLML0niN0YZSd4I=; b=J3wQLJvBr4UBJASDSKQ4KqVYE
	4yLp6zzabroj65fVsqPzTOh135UIsrZeQXV/dBmMeNs2EaRuCVw/M/D25egCQQg0+IJ0TGigzuUVB
	+TXu2gVC+QrNStTJz9tf9sMGUJOixMk90G8T2Oc+LRAiyBi8BzZGqk9lG67AwSECxsbifxDO55D+6
	0cora3A9pZz6bNOuTazondp10EwmKYboleA08nqojZSd/sJLh5mcn2IuDs8wuS8ypKBM8rHLQxfg2
	vYtm77VT2EQBRFCQtHzwNZwseinu/YJ6I3iPowYZ4wu5m6JM2TkqJ67j+8BrFLnA7fy60ffHHu81p
	UR9K1w+BA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKShG-00051B-JL; Mon, 21 Sep 2020 20:46:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKShB-00050L-St
 for Linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 20:45:58 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0A6A4216C4;
 Mon, 21 Sep 2020 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600721157;
 bh=1VWiJqUcP/1ACFEOIo0/XzbR5Z7rIMIXmtQI1WPTjGs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RLMs1Z8mQ+k9Crx35Q162Mwf6LvMdNzO+SL4HK2kbKKBOz1dSHW8VphY573u8Zcw6
 SiXkTA3Z5oamqeU4DUexlDb5k3W2j5X8K10y7L0bhgtMONm4C5PAKJKA/NOa4ZOsWo
 8TXP8xZGSRgxKJFueI0q1v1gRGI8rh+CVoq5OJC8=
Date: Mon, 21 Sep 2020 13:45:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kallol Biswas <kallol@nucleodyne.com>
Subject: Re: processor reboots if nvme host controller is surprise removed
Message-ID: <20200921204544.GC4034420@dhcp-10-100-145-180.wdl.wdc.com>
References: <CAH=XD5_UeVPWHskOwwPeHZpv9sKXKvvA8BS-_58KqdXfpY8OWw@mail.gmail.com>
 <20200921192403.GA4034420@dhcp-10-100-145-180.wdl.wdc.com>
 <CAH=XD5_RvYU_prCRCZCD7eGgNB23PQfN-yx_D+NLz6fW4ZHa8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAH=XD5_RvYU_prCRCZCD7eGgNB23PQfN-yx_D+NLz6fW4ZHa8Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200921_164558_140286_770692DF 
X-CRM114-Status: GOOD (  11.62  )
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
Cc: Linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 21, 2020 at 01:31:20PM -0700, Kallol Biswas wrote:
> The PCIe dump for the port is copied below. The Slot seems to have the
> presence detect bit.
> 
> root@earley:~# lspci -vvv -s 0:3.2
> 00:03.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 1483
>         Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
>                 DevCap: MaxPayload 512 bytes, PhantFunc 0
>                         ExtTag+ RBE+
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 512 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 16GT/s, Width x8, ASPM L1, Exit Latency L0s unlimited, L1 <64us
>                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 16GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>                         Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>                         Changed: MRL- PresDet- LinkState+
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
>                 RootCap: CRSVisible+
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd-
>                 DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
>                 LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+, EqualizationPhase1+
>                          EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
>         Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                 Address: 00000000fee0a000  Data: 4021
>         Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD] Device 1453
>         Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
>         Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
>         Capabilities: [270 v1] #19
>         Capabilities: [2a0 v1] Access Control Services
>                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
>                 ACSCtl: SrcValid+ TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
>         Capabilities: [370 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+ L1_PM_Substates+
>                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>                 L1SubCtl2:
>         Capabilities: [3c4 v1] #23
>         Capabilities: [400 v1] #25
>         Capabilities: [410 v1] #26
>         Capabilities: [440 v1] #27
>         Kernel driver in use: pcieport

At least as reported from the PCIe level, this port does not support the
test you're attempting. It doesn't have surprise link down, hotplug
surprise, or advanced error reporting capabilities.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
