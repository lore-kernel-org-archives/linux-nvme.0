Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C3BC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Dec 2022 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BB8Rar3bxIi8QeLI9g7jXZhNC/ZalkocgiZqNCfBckQ=; b=V8aasLyhWiPOYDW3dWwrsOhaX4
	IF23CwYfkm5WDBcqPxayQtxfcXl7oeR5CPHAACakpBpIK2VU3bmr9yvbdUcMq0GWfsncNdkmKaAjJ
	IywRN1vptvlVfVW8DD78xYbz+3P08z/urt9demR81P3/lqHJgInQu1eatcrTjafvLXD8jTWZymp8S
	9ispUP3xXbrvTUfRhcVWI7nlsGqtgdGMsMdPxpgMEDdr+Xf81RKFS2SIp84dHhMoIVxzGiuY30sgo
	jktIl+GGNnfXfo82X6MJsTZAmoSySHD+mY11rxs7meUzcyyh2yPK6GGLbl1GwqqZJSW4oclQghIKm
	OsYSa+FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7IV5-00FiC0-Dd; Mon, 19 Dec 2022 15:56:23 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7HKt-00Eruq-Uu
	for linux-nvme@lists.infradead.org; Mon, 19 Dec 2022 14:41:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id BFC9BB80DF2;
	Mon, 19 Dec 2022 14:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D25DC433D2;
	Mon, 19 Dec 2022 14:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671460903;
	bh=Zzt4GzTgc5dPERHB/v4vPOF2iKW927CteVnPb4DSaIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFxhNoo0ylUNjq601g1BLf6kjSPKXrhfiNZlPFoIjdtBaf7AuHge5e5L2FN7BPmuS
	 c211JcUK/eUJcUIsCqhyA9EuFni1eWmvQRFS3PBPMweEnB1SQHE7YlWxBRju4WT1H8
	 lNJVpEJo91BKWPuoRWssBDDDMCyOTpHWg/lfiru/mDRvlkRpgbMPvV1er6oy5wlGKl
	 i8dzPhtEWscCQs/Oq7Ly9CJf06RAnqvXUd6mVkxmvapBQ2NJe1LopIHx8ulW/HVD8f
	 fTpd0YqPbjTvExiLnwed8UFYYZvYE5lmXcrN8IbfiqELtG/FuHQD6W5niTtXLWX8m0
	 PHsC4SGbrwvZA==
Date: Mon, 19 Dec 2022 07:41:40 -0700
From: Keith Busch <kbusch@kernel.org>
To: "J. Hart" <jfhart085@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source
 drive corruption observed
Message-ID: <Y6B4JFj5jIDs0cBI@kbusch-mbp.dhcp.thefacebook.com>
References: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
 <Y5z8Sj+7N7HF4ZyP@kbusch-mbp.dhcp.thefacebook.com>
 <eb882c34-7b69-e0c2-f100-35f3a90ce94c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb882c34-7b69-e0c2-f100-35f3a90ce94c@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221219_064148_356831_D6578222 
X-CRM114-Status: GOOD (  11.53  )
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

On Sat, Dec 17, 2022 at 10:28:58AM +0900, J. Hart wrote:
> 02:00.0 Non-Volatile memory controller: Kingston Technologies Device 500f (rev 03) (prog-if 02)
>         Subsystem: Kingston Technologies Device 500f
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at ef9fc000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [50] MSI: Enable- Count=1/8 Maskable+ 64bit+
>                 Address: 0000000000000000  Data: 0000
>                 Masking: 00000000  Pending: 00000000
>         Capabilities: [70] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-

Given the potential flakiness of read corruption, I'd disable relaxed
ordering and see if that improves anything.

>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 <1us, L1 <8us
>                         ClockPM+ Surprise- LLActRep- BwNot-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-

Something seems off if it's downtraining to Gen1 x1. I believe this
setup should be capable of Gen2 x4. It sounds like the links among these
components may not be reliable.

Your first post mentioned total transfer was 50GB. If you've deep enough
queues, the tail latency will exceed the default timeout values when
you're limited to that kind of bandwidth. You'd probably be better off
from a performance strand point with a cheaper SATA SSD on AHCI.

