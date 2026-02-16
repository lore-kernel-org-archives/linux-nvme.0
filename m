Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FB3E63F36
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Feb 2026 17:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ox2zOip8ex/pPOz0MZ66YdomhlQUxEYWyv12vdPkcRw=; b=uwqAayz0Uk/3b7lKqjFFgf+JWS
	LVEjaP9TXhB1nap9yg+iUhepwI7b6OC/EokB+hMXZ2MMfMPM4TgEadP+Aw17WgOkq9uthakSiq+GA
	kASkGnftjZfdNfykudcwBxqSZzyMOLLmi51na6uqbVopvzgzuAZMUKLbce63+LksLdNU5imEa3Zow
	voD6fuBNoOGNwVjvfIS3DFlOnp8eFrX50zfujrhzi1RIbgmD43DRaS33SXuswy/xFqUfQcuyewavB
	hrJvSy4z+DSm6djixFSANdsx+HqERCYae6v57JxLDOsKu427tlVAxkCasaUQG7YPpGNeXmCWvhvdP
	AD/Sc60Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs2GL-000000075Va-2IQo;
	Mon, 16 Feb 2026 17:19:57 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs2GF-000000075UR-3FcP
	for linux-nvme@lists.infradead.org;
	Mon, 16 Feb 2026 17:19:53 +0000
Received: by mail-wm1-x341.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso6318075e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 16 Feb 2026 09:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1771262389; x=1771867189; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ox2zOip8ex/pPOz0MZ66YdomhlQUxEYWyv12vdPkcRw=;
        b=kK4qxWQbuhprlABbkhQ7G1o+7Th4kaj0ydR3mS1Jms3dVANvs9v1KjFpJ8JYBCtZZx
         hiIQjZiSi2L+wfUuM62w/jFF18ZrN0P1MwEfHK/7T+OwPbE+FKI+xPBJznppyABDHtHO
         urGvzrITWAmxFafGYk7UCPMT5oR3p2baD/CulJbKxuUo0QJx342C8tzTdBZB5aw++VoV
         KRhtwyjj4/9ppwK/MxFg3sSeNraTDNWPtUKQgiFtN4wpZn1LQj9q4ABobLgeoBAKjGKP
         AMqhPDxduO4H1MvXuzNh69iNmxELOGtCDqPUNqHhx75Ne0JR0MgTJaJUXu4/GK82dpXQ
         zYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771262389; x=1771867189;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ox2zOip8ex/pPOz0MZ66YdomhlQUxEYWyv12vdPkcRw=;
        b=iqOFZfhDoHBDnoNEl4wLeQCASgS0Yzar1U1u6C9lyOdM+wzEzvRx+wI+ces1Yqs6YL
         w4OcJkdSodqt/BWwP943uqJkJz5RI1QOgUq/GBnektgxq5weQmuNaPXnjpscRiUoRHRM
         vUGy3WeMA7ZnDFxUxb2pPhfuqaavJ89O3oIsuaXXEKl7ChaJPEoJHDXCevF+mVERGHC5
         3SD3OSyTfWcdMOiXKBhqIkqWE7wQJkSuQ6c/5ZY/c69+TmmFlZNRY8eoLo1BvsI2fR7g
         lOvz6SPfaU196KRXkmeVhlHDkHwxrAjJ9FCZsFv0WARRbhdAhHtrMofTrLj/YXQxHz/+
         5gIg==
X-Forwarded-Encrypted: i=1; AJvYcCXsF1t/D/RBhwQEXY7sxbqrrGczet4pKeEfvEDCsDhMhwwSwxf2lzufrXv5JmTTwd9a02UEbLptsb7Q@lists.infradead.org
X-Gm-Message-State: AOJu0YyX4N6Fukas7te8znK3k/tn8sbgvEJ2xGv6Gj7QvELmu5+Efq2Z
	43pem2Wchp4SxPDrz1Y0MgJqLczPhqtwJX35LAYiyhpjPfbRwuLt6DCeCkDqoI6XQ1c=
X-Gm-Gg: AZuq6aLCNWRtgezSprQ9Xke0/6RagWYrfFDLPmCZwFXOgq3DJ83Osm8TqbW5iE01rVe
	dEsleByycMzbjpNiLwU+vP628k6bA25SrWWERNpkmRqwr6HAun6RvaQmyAK1oPRNrp01xV5rUz/
	+Hlt2qsCjdbh0mtkIjsZS6m2xFYCte35jEc+HWK4l4r8c8w029oZEtIv0yeqq8BvF7WeI9ul/lA
	rJ0vh/Q9c8JrgKp2rLZvzcOKBwR7jJfk6sIn5fFMz0pWcSkyp1UwZ3LGWt5sXJ6ZeKHgxQLk2ap
	IIXOqfV3YWw+jO0N8hD3t0GOHTKwV1DgZUhySrMUpTJJYv9/Wy6C923acfvAki7zZFMn606sbM2
	lXkcnqzSUb1uoJnHc/T0sVrWQO0Xm1Z3p9mmDhV8PkOjpCFXd0uYkXEn/VAgwbXbUWg7YlmYb1e
	vRXxmr4LZB0AiNO3EkAcmAIcg9tX3LYh0H3nP4gAXsEA==
X-Received: by 2002:a05:600c:1547:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-483710858c8mr218566385e9.21.1771262389276;
        Mon, 16 Feb 2026 09:19:49 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd34sm502143425e9.7.2026.02.16.09.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 09:19:48 -0800 (PST)
Message-ID: <ccf3bfd6-c060-4b88-bf4d-37425aea4cfa@tuxon.dev>
Date: Mon, 16 Feb 2026 19:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
To: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 "David E. Box" <david.e.box@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Chia-Lin Kao <acelan.kao@canonical.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, John Madieu <john.madieu.xa@bp.renesas.com>
References: <7306256a-b380-489b-8248-b774e6d3d80e@nvidia.com>
 <20260122152903.GA1247682@bhelgaas>
 <5z7c25nkb35prvax6vq6ud7eaeuhzsswbf7fqvmlgys3xftgwb@odocboejrdrv>
Content-Language: en-US
In-Reply-To: <5z7c25nkb35prvax6vq6ud7eaeuhzsswbf7fqvmlgys3xftgwb@odocboejrdrv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_091952_029652_645A5EDE 
X-CRM114-Status: GOOD (  31.96  )
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

Hi,

On 1/22/26 19:01, Manivannan Sadhasivam wrote:
> On Thu, Jan 22, 2026 at 09:29:03AM -0600, Bjorn Helgaas wrote:
>> [+cc NVMe folks]
>>
>> On Thu, Jan 22, 2026 at 12:12:42PM +0000, Jon Hunter wrote:
>>> ...
>>
>>> Since this commit was added in Linux v6.18, I have been observing a suspend
>>> test failures on some of our boards. The suspend test suspends the devices
>>> for 20 secs and before this change the board would resume in about ~27 secs
>>> (including the 20 sec sleep). After this change the board would take over 80
>>> secs to resume and this triggered a failure.
>>>
>>> Looking at the logs, I can see it is the NVMe device on the board that is
>>> having an issue, and I see the reset failing ...
>>>
>>>   [  945.754939] r8169 0007:01:00.0 enP7p1s0: Link is Up - 1Gbps/Full -
>>>    flow control rx/tx
>>>   [ 1002.467432] nvme nvme0: I/O tag 12 (400c) opcode 0x9 (Admin Cmd) QID
>>>    0 timeout, reset controller
>>>   [ 1002.493713] nvme nvme0: 12/0/0 default/read/poll queues
>>>   [ 1003.050448] nvme nvme0: ctrl state 1 is not RESETTING
>>>   [ 1003.050481] OOM killer enabled.
>>>   [ 1003.054035] nvme nvme0: Disabling device after reset failure: -19
>>>
>>>  From the above timestamps the delay is coming from the NVMe. I see this
>>> issue on several boards with different NVMe devices and I can workaround
>>> this by disabling ASPM L0/L1 for these devices ...
>>>
>>>   DECLARE_PCI_FIXUP_HEADER(0x15b7, 0x5011, quirk_disable_aspm_l0s_l1);
>>>   DECLARE_PCI_FIXUP_HEADER(0x15b7, 0x5036, quirk_disable_aspm_l0s_l1);
>>>   DECLARE_PCI_FIXUP_HEADER(0x1b4b, 0x1322, quirk_disable_aspm_l0s_l1);
>>>   DECLARE_PCI_FIXUP_HEADER(0xc0a9, 0x540a, quirk_disable_aspm_l0s_l1);
>>>
>>> I am curious if you have seen any similar issues?
>>>
>>> Other PCIe devices seem to be OK (like the realtek r8169) but just
>>> the NVMe is having issues. So I am trying to figure out the best way
>>> to resolve this?
>>
>> For context, "this commit" refers to f3ac2ff14834, modified by
>> df5192d9bb0e:
>>
>>    f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
>>    df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
>>
>> The fact that this suspend issue only affects NVMe reminds me of the
>> code in dw_pcie_suspend_noirq() [1] that bails out early if L1 is
>> enabled because of some NVMe expectation:
>>
>>    dw_pcie_suspend_noirq()
>>    {
>>      ...
>>      /*
>>       * If L1SS is supported, then do not put the link into L2 as some
>>       * devices such as NVMe expect low resume latency.
>>       */
>>      if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>>        return 0;
>>      ...
>>
>> That suggests there's some NVMe/ASPM interaction that the PCI core
>> doesn't understand yet.
>>
> 
> We have this check in place since NVMe driver keeps the device in D0 and expects
> the link to be in L1ss on platforms not passing below checks:
> 
>          if (pm_suspend_via_firmware() || !ctrl->npss ||
>              !pcie_aspm_enabled(pdev) ||
>              (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
> 

We noticed a similar issue with the Renesas RZ/G3S host driver and NVMe devices. 
We currently have 2 SoCs where we identified this problem (RZ/G3S and RZ/G3E), 
both present on SoM modules, and the SoM modules could be connected to the same 
carrier board where the PCIe signals are routed and connectors exists. On the 
carrier board we have 2 connectors were we can attach NVMe devices, one M.2 Key 
B and one PCIe x4 connector 
(https://www.amphenol-cs.com/product/10061913111plf.html).

The issue described in this thread is reproducible for us only after suspend and 
only for the NVMe device connected to the the PCIe x4 connector. The device is 
working correctly just after boot. On suspend, power to the most SoC components 
(including PCIe) is lost but the endpoints remains powered.

The issue is not reproducible if the following command is executed before 
suspend: echo performance > /sys/module/pcie_aspm/parameters/policy

The difference we identified in terms of signals connected from the SoC to the 
on board connectors relies in the CLKREQ#. This signal is only connected to the 
PCIe x4 slot.

On RZ/G3E the CLKREQ# is configured as a individual GPIO pin. On RZ/G3S it is 
muxed by the pin controller with PCIe function. We tried on RZ/G3E to not 
configure the CLKREQ# pin at all and with this the NVMe connected on the PCIe x4 
slot started to work even after suspend. We cannot reproduce the same behavior 
on RZ/G3S.

Initially, we considered we might have to update the existing code to do 
specific configuration for the boards were CLKREQ# is not connected (through 
supports-clkreq DT property that some controllers are using).

Currently, the manual is unclear on how to control CLKREQ#.

Apart from the suggestions mentioned in [1], could you please let me know if you 
have any others?

Thank you,
Claudiu

[1] 
https://lore.kernel.org/all/unc5zefwndgcv7wufaezz3gkg3qtaymkjlmymhyqdqwzn3wybl@ow2rhbyt772h/

