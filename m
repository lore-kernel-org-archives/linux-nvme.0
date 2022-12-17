Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A45CC4332F
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Dec 2022 01:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9nypNRz8kPrXzyznyzvFSxvH27Po+30xp/n24/f/zsE=; b=kHvAKiqdxdvQkZ
	Tbb8s17PsF+zyQZRCqTNKioHqEQRFdA6Jw7gCH8DEQGLhpO5JzNKgDGw3RJeXQ+1TLmJ0qfPKBjXm
	sRx1l1AgZtBp77KNQcKIzFgVsr5Wo2/5zS12qTWUusbShdNl9V7GCq5Zjc3/fSrGgl1lRK9jss7fv
	CMCDCow18H72LLNObXTzk2ZDeFgVDkpKMQ0tvQPCFCMs4JoGbDDQZB4YE6itZhGTwoq/e3SpyWNV0
	B6qkm4Us72RVgoOR3z20qQXQoehCGcxmrXpznj/QnqyCFM9jCZv8nQgoeEceAnUJ2xPAyxPXBUZiW
	q2PriCP8Xjdvd0nl1Fyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6M0h-003dyA-EF; Sat, 17 Dec 2022 01:29:07 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6M0d-003dv8-Uc
	for linux-nvme@lists.infradead.org; Sat, 17 Dec 2022 01:29:05 +0000
Received: by mail-pf1-x430.google.com with SMTP id 124so2933966pfy.0
        for <linux-nvme@lists.infradead.org>; Fri, 16 Dec 2022 17:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9nypNRz8kPrXzyznyzvFSxvH27Po+30xp/n24/f/zsE=;
        b=ILZtapd2JHsZyVdQW4WjO++ETMr90IFfIX/UGKan6VJ0bAq0Kua+SLWvHPVOk3GBTO
         761EgY1H7/7RRhchC0ncmuccn1DKAOqt+Z33XFo1/3dBEy/KBQcl82IycfcZLLe9jlFU
         HzfE2h6PSRiZcllWyF6RJfwJftcga4QNTASphKrYQnGHixkYW/wIa5izPWgU0wHgsviw
         Nzhgw9ahGkCzExWvKxlox9UOCjQ7Y8CqYDREBsZ00ajtWi55ylxdsQm77ZDkanzCffxb
         U0bHH/GeyykP0tkRBRJNn/8YGL+hdtVq2nCpxTzwh/LCWXFH8L3+MzmdTVKXFwmiTLkA
         G9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nypNRz8kPrXzyznyzvFSxvH27Po+30xp/n24/f/zsE=;
        b=ZgBGt8pAcTwbIx185UKSo6i9luD/qrj3+K84pGCtUsXcfs5xI52VldF3/Emtu+Qc1S
         WHVWptJtwu1RNUUSfFWIQY6abAyd01to9pBK3EIeBcFwSRiF4b6h5uRfKHSyaDV4uXxJ
         nTzk/QJG11sP2PSPybnVCo4AFg4zSZugs6oQ8D9xYU7Bv0hOzL/xt2hKtHA0e9/lMXyU
         D0R7HShA4qwCthPzMKOizMD2MednQIfJ90MCyZo4Z5TK5eIST+mw70p07GmwN26Hu+6y
         H/6XF5wfHe46AHd+XYelbLDPNZgGStUYxsN637HfUG6yMVslseq1X52I627F/EDB8ctS
         8Dvw==
X-Gm-Message-State: ANoB5plDThEW6ZL6bgEPDymDmzQoTplxcuVkxt+cHVP5ZQfqmL/ks/q7
	HOvcgFJHpXDBcGaCBcdsuMZ4D/RP0wc=
X-Google-Smtp-Source: AA0mqf5xbfM8iV1Z+FSeXbJvYWkIv08JXcpkAhhSrVEmNLe8Ua4ZizDhOO47Vq6U4K9u/M5kuBmrbw==
X-Received: by 2002:a62:e119:0:b0:576:ebde:78fa with SMTP id q25-20020a62e119000000b00576ebde78famr31577570pfh.9.1671240541987;
        Fri, 16 Dec 2022 17:29:01 -0800 (PST)
Received: from [192.168.0.23] (q014251.dynamic.ppp.asahi-net.or.jp. [203.181.14.251])
        by smtp.gmail.com with ESMTPSA id y16-20020aa79430000000b00561d79f1064sm2083920pfo.57.2022.12.16.17.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 17:29:01 -0800 (PST)
Message-ID: <eb882c34-7b69-e0c2-f100-35f3a90ce94c@gmail.com>
Date: Sat, 17 Dec 2022 10:28:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source drive
 corruption observed
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
References: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
 <Y5z8Sj+7N7HF4ZyP@kbusch-mbp.dhcp.thefacebook.com>
From: "J. Hart" <jfhart085@gmail.com>
In-Reply-To: <Y5z8Sj+7N7HF4ZyP@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221216_172904_032267_34A4418C 
X-CRM114-Status: GOOD (  16.52  )
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
Reply-To: jfhart085@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/17/22 8:16 AM, Keith Busch wrote:

> Seems odd that the nvme driver is in use, but MSI/MSI-x are not. We
> really don't have a lot of testing with legacy IRQ.
> 
> Could you add the output from 'lspci -vvv -s 02:00.0'?

Here is what I have from "lspci -vvv -s 02:00.0:

02:00.0 Non-Volatile memory controller: Kingston Technologies Device 500f (rev 03) (prog-if 02)
         Subsystem: Kingston Technologies Device 500f
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at ef9fc000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable- Count=1/8 Maskable+ 64bit+
                 Address: 0000000000000000  Data: 0000
                 Masking: 00000000  Pending: 00000000
         Capabilities: [70] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 <1us, L1 <8us
                         ClockPM+ Surprise- LLActRep- BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not Supported
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
         Capabilities: [b0] MSI-X: Enable- Count=16 Masked-
                 Vector table: BAR=0 offset=00002000
                 PBA: BAR=0 offset=00002100
         Kernel driver in use: nvme

>> CPU (quad core, cpu 0 shown, others the same):
>>
>> processor	: 0
>> vendor_id	: GenuineIntel
>> cpu family	: 6
>> model		: 23
>> model name	: Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz
>> stepping	: 7
> 
> That's a pretty old processor for an M.2 slotted drive. Are you using a
> retimer or some type of AIC adapter card?

The controller I have is this:

MZHOU M.2 NVME SSD-PCIe 4.0 X4 adapter
Key-M NGFF PCI-E 3.0、2.0 or 1.0 controller expansion cards
(2230 2242 2260 2280 22110 M.2 SSD）

The processor I have is indeed an older one, but times are hard as I am not working at present and must economize....:-)

I should also note that I have a replacement nvme drive coming and will be replacing the Kingston  SNVSE500G with
a Samsung 970 EVO Plus 500 GB. That model has been confirmed as working under Linux according to what I
have read.  I should have that today or tomorrow and will be sending back the Kingston device.

Please let me know if you need additional testing or results.

With Thanks and Best Regards for the holidays to you and yours,

J. Hart

