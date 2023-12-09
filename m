Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F4EC4167B
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Dec 2023 02:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4s+G/wfgh0EkCj4vTc35OseOCDzoNVBcxB+9GOGa0kc=; b=tXTDE6tR1IlGc2w1wnzMg/2/VO
	8ZE+Qnbaskrp/30mx16AuH8yNPJ2z9iDCl5hfMq6uzzQp/ugDTOmZRiV0X5flTEuCJZPWZS4rP+HP
	6jP6ZUC/S78JRIK+tKqenfgdnbRyGz0CtuoFi3ApbVN5GNSsZnW7CDR59S1BGkGNXrf82aFCpWS5O
	ai0nOwTIA708TNtAij34eRYP21fu2oibrqlJcJWpMtQsHLwdbzttmWKnoBh6UeFOKtGIuM4emU9ZW
	HltmZLmbvwQS/d//ncExs6C8ktotyimfWEInwlXkZ25p45LoJG2xlJJcUM/lU8u4QAp1CsRttFHrG
	5FkRXHtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBmpl-00Gwsa-2Q;
	Sat, 09 Dec 2023 02:12:49 +0000
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBmpi-00Gwrn-0H
	for linux-nvme@lists.infradead.org;
	Sat, 09 Dec 2023 02:12:47 +0000
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d852ac9bb2so26230757b3.2
        for <linux-nvme@lists.infradead.org>; Fri, 08 Dec 2023 18:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aeoncomputing-com.20230601.gappssmtp.com; s=20230601; t=1702087959; x=1702692759; darn=lists.infradead.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4s+G/wfgh0EkCj4vTc35OseOCDzoNVBcxB+9GOGa0kc=;
        b=DTB7RtNcI5O/TsNhM+XOyKTPvz8VV9GMBSuVdieXk2QnBDMyf6mE94fnwm2RjRI3jf
         9MkOTEaJrR7rJcCKOhsIcJSc7FWsozY1u1ASoGH9lqfnW/7XFBu4+apeSXjuJ+dpROKV
         GEYVMC+pS5swxAZ3zXy66QK3XqzC6GcGF3YqOuDj035M6Lcq3gkLes9gDHtYzgFDN+pv
         d7xyaIYqFbGdp2xCVt+fJNoyfbwP3X2nHngOStKeb6N7lFI9RFy0mu+V4asua8qduHim
         MZuBtf+26UxeTzzg43JYnhw1H8+5PpcuJtJtSfJ4XbQ9CEfUaEb9gpwPn+rOxyOY5h0H
         BF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702087959; x=1702692759;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4s+G/wfgh0EkCj4vTc35OseOCDzoNVBcxB+9GOGa0kc=;
        b=Wt5YcMfgHzBk3RpsSCJpAag+1UZLwAuqEmDfoADjNK4+5GmlNBC2X4R2qcFmLBHGJj
         46TkOP9Y2/x5Wl9m1vyVbkz9PzbKReyu/2bH7Lg8J27v9i2nGLAWqIcyNZH+gTRYZTfB
         kEhHt2+AU8h4p20PbzYQfB0V1HhKWyW6cL7CpZN9bsuPHkgErJ7jLvqQ7xIB8S5IikEV
         wvU7CBJnbj2usEv9A57jkV760glKgm9E8pySwL7/3uXbYxToLkVhfkhlkm8EQGiUFTlW
         +gnCVI68/xMtAgk+ho4S4xEXLmqJnrhalvQBMm4AfSpElx2VLYZXJjy6U57ERpd5Q2UH
         /OSA==
X-Gm-Message-State: AOJu0YxYuGZ1EHYnvRyq24mF/CLhMQODmu+t8R0mSPVUxG62TgTHj6nn
	TaS1+9QhytIE34y+Vst0ztHyFGMWH3iajAYbNjWws3GbvLVuXGNHSMs=
X-Google-Smtp-Source: AGHT+IE3DFFHUhrDy55QVr0tayj/06WnBtG3lZwWENBoE80gQw7JRX8TbJmtNRQSfxaS/Zg0dianxZYdoU6EV9TAiuk=
X-Received: by 2002:a81:4fc1:0:b0:5d7:3748:9a1e with SMTP id
 d184-20020a814fc1000000b005d737489a1emr968820ywb.4.1702087959473; Fri, 08 Dec
 2023 18:12:39 -0800 (PST)
MIME-Version: 1.0
From: Jeff Johnson <jeff.johnson@aeoncomputing.com>
Date: Fri, 8 Dec 2023 18:12:28 -0800
Message-ID: <CAFCYAseYeXvTTRaC_Mmcbo34Lqd=YApa6-VU93Vz3yPW4Rbr8w@mail.gmail.com>
Subject: Advice appreciated - attempting data recovery on Intel Optane H10 (CSTS=0x0?)
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231208_181246_316296_387535FE 
X-CRM114-Status: GOOD (  16.86  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Greetings,

Seeking wisdom, many thanks to anyone who stops to read and more if
you have advice.

I'm attempting data recovery on a odd little SSD Intel built called
the H10. It is an M.2 NVMe SSD with two controllers and two different
flash devices. The M.2 is bifurcated from x4 into x2x2 with a
different controller and flash device behind each x2.

I was able to access the low side x2 (lanes 0-1) that connected to the
32GB 3dXpoint flash device. It was a cache so not much valuable data.

I had to do some lab gymnastics to access the high side x2 but I was
successful. Now I can see the other controller and the link speed and
width are fine but it won't initialize. Basically I had to disable
PCIe spread spectrum in the system BIOS and use kapton tape to mask
out PCIe xmt&rcv lanes for lanes 0 & 1 so the high side x2 lanes 2-3
were the only lanes the root complex saw and connected. Crazy I know
but it worked.

Rocky 9.3, 5.14.0-362.8.1.el9_3.x86_64
[   12.077360] nvme nvme0: pci function 0000:06:00.0
[   72.080442] nvme nvme0: Device not ready; aborting initialisation, CSTS=0x0

Controller appears in lspci
lspci -s 06:00.0
06:00.0 Non-Volatile memory controller: Intel Corporation Optane NVME
SSD H10 with Solid State Storage [Teton Glacier] (rev 03) (prog-if 02
[NVM Express])

Verbose output shows a good connection. LnkSta: Speed 8GT/s (ok), Width x2 (ok)
# lspci -s 06:00.0 -vvv
06:00.0 Non-Volatile memory controller: Intel Corporation Optane NVME
SSD H10 with Solid State Storage [Teton Glacier] (rev 03) (prog-if 02
[NVM Express])
Subsystem: Intel Corporation Device 8410
Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 79
NUMA node: 0
Region 0: Memory at fb500000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [50] MSI: Enable- Count=1/8 Maskable+ 64bit+
Address: 0000000000000000  Data: 0000
Masking: 00000000  Pending: 00000000
Capabilities: [70] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 25.000W
DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 8GT/s, Width x2, ASPM not supported
ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 8GT/s (ok), Width x2 (ok)
TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
FRS- TPHComp- ExtTPHComp-
AtomicOpsCap: 32bit- 64bit- 128bitCAS-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
AtomicOpsCtl: ReqEn-
LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+
EqualizationPhase1+
EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
Retimer- 2Retimers- CrosslinkRes: unsupported
Capabilities: [b0] MSI-X: Enable- Count=16 Masked-
Vector table: BAR=0 offset=00002000
PBA: BAR=0 offset=00002100
Capabilities: [100 v2] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
HeaderLog: 00000000 00000000 00000000 00000000
Capabilities: [158 v1] Secondary PCI Express
LnkCtl3: LnkEquIntrruptEn- PerformEqu-
LaneErrStat: 0
Capabilities: [178 v1] Latency Tolerance Reporting
Max snoop latency: 0ns
Max no snoop latency: 0ns
Capabilities: [180 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
  PortCommonModeRestoreTime=100us PortTPowerOnTime=3100us
L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
   T_CommonMode=0us LTR1.2_Threshold=0ns
L1SubCtl2: T_PwrOn=10us
Kernel modules: nvme

Even though the controller is talking on PCIe Intel's SSD tools like
isdct and intelmas do not see the controller when run.

I'm not going to use this device long term, just trying to access the
QLC flash device behind the controller to rescue data for someone
desperate. Not a paying gig, being kind and charitable during the
holidays.

Is there some vendor unique magic required to wake this up or activate
the controller to flash path?

Not only do Intel's SSD tools not see it, nvme-cli doesn't see it
either. It is as if the device is alive but not reporting as storage
or a block device.

Any advice is greatly appreciated.

--Jeff

