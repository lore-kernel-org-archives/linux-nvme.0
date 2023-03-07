Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F36C678D5
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Mar 2023 12:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fwXujlb6cgTwYU7Amo9CfydFrIHSZ9G2XdohjjabX/M=; b=cvSCOfgstEZoQQXdazLm1NJs2K
	gtdg7k00gUFiteQqc9ELjiegN7pqYM2WwTR9SG/dJ7zmAY++zJOle1oYnb+j61bJz5cKzfpj54XjX
	XF2FxZUmTBGiEQYiZ559MSTQdljnU8RYz1vQP815A5UkfdheZC8Drr2aLSgQC69+yHTzCNRt7GkrY
	5K+Mkw3/0pdzDW2BfdbonidGsp1aZHdqmFqOtBqMuRrp134VMNM4WsdOgXHbLq30pVTur/Tn8eWw+
	o6bqCYM7pylM5pIFZdPljuoyvZYaml3zLNsiiYaAjClzCyAVD6BSwBRwvGr1oi5GITjmFkZSY/Liy
	8e65Si8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZW0L-00HaHb-Fs; Tue, 07 Mar 2023 12:01:17 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZVzG-00HZRH-TM
	for linux-nvme@lists.infradead.org; Tue, 07 Mar 2023 12:00:14 +0000
Received: by mail-wr1-f47.google.com with SMTP id f11so11836894wrv.8
        for <linux-nvme@lists.infradead.org>; Tue, 07 Mar 2023 04:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678190401;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwXujlb6cgTwYU7Amo9CfydFrIHSZ9G2XdohjjabX/M=;
        b=ApuPguWc4qNPMBBk65CuWecY17uZGK9XzwGVXef/TqJifk7tT47hJsfoEx7EKxAYqF
         N0aU2zYsELdSqAOb7ktTsou0u/deT0TZXn2/uSsbn4whhFHvw7e7bhGJAirXyZLzqpuk
         7QVEGr1lHY6sfuYydGiNyOFFas22z+/ectxbOaOcq6CKhLaucrC5vgGXYA1fQEIr4t22
         8IJjco+mDfynMkUlnxjGB8vvcaBUAwhaGp54BxmPD9APgZski+SmZNrbxnuH7SKQbVuy
         EIfiZWB8416RTPgxFjohqXs7lhHQBdfpNqosOx0b/H8MHU+xwgepzmT31h/t6mvI/Lxs
         5o2Q==
X-Gm-Message-State: AO0yUKWoTNpV9jHs9ODVMhQNGFjDacXxRvmDEica4ko4I6ZC9iKkzJGL
	1J/jnAH+zvep5pY0PlqmTQI=
X-Google-Smtp-Source: AK7set/7fatAxRqAAafJCyeP80cuLpLZ8do3T3b23JEf/CN0dZ9V4uMxDPsJPsLPOTPQr7r5JdEaKA==
X-Received: by 2002:adf:fc0d:0:b0:2c7:1755:30ad with SMTP id i13-20020adffc0d000000b002c7175530admr10194027wrr.2.1678190400796;
        Tue, 07 Mar 2023 04:00:00 -0800 (PST)
Received: from [10.100.102.14] (46-116-231-83.bb.netvision.net.il. [46.116.231.83])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d40c3000000b002ce37d2464csm8684339wrq.83.2023.03.07.04.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 04:00:00 -0800 (PST)
Message-ID: <93c02cfa-c379-49bb-9d32-af4cb7420f81@grimberg.me>
Date: Tue, 7 Mar 2023 13:59:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: nvme-pci: Disabling device after reset failure: -5 occurs while
 AER recovery
Content-Language: en-US
To: Tushar Dave <tdave@nvidia.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org
References: <de1b20e5-ded1-0aae-2221-f5d470d91015@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <de1b20e5-ded1-0aae-2221-f5d470d91015@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_040011_017460_5B1F0756 
X-CRM114-Status: GOOD (  20.33  )
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



On 3/2/23 02:09, Tushar Dave wrote:
> Hi,
> 
> We are observing NVMe device disabled due to reset failure after 
> injecting Malformed TLP. DPC/AER recovery succeed but NVMe fails.
> I tried this on 2 different system and it is 100% reproducible with 6.2 
> kernel.
> 
> On my system, Samsung NVMe SSD Controller PM173X is directly behind the 
> Broadcom PCIe Switch Downstream Port.
> MalformedTLP is injected by changing MaxPayload Size(MPS) of PCIe switch 
> to 128B (keeping NVMe device MPS 512B).
> 
> e.g.
> # change MPS of PCIe switch (a9:10.0)
> $ setpci -v -s a9:10.0 cap_exp+0x8.w
> 0000:a9:10.0 (cap 10 @68) @70 = 0857
> $ setpci -v -s a9:10.0 cap_exp+0x8.w=0x0817
> 0000:a9:10.0 (cap 10 @68) @70 0817
> $ lspci -s a9:10.0 -vvv | grep -w DevCtl -A 2
>          DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
>              RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>              MaxPayload 128 bytes, MaxReadReq 128 bytes
> 
> # run some traffic on nvme (ab:00.0)
> $ dd if=/dev/nvme0n1 of=/tmp/test bs=4K
> dd: error reading '/dev/nvme0n1': Input/output error
> 2+0 records in
> 2+0 records out
> 8192 bytes (8.2 kB, 8.0 KiB) copied, 0.0115304 s, 710 kB/s
> 
> #kernel log:
> [  163.034889] pcieport 0000:a5:01.0: EDR: EDR event received
> [  163.041671] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
> [  163.049071] pcieport 0000:a9:10.0: DPC: containment event, 
> status:0x2009 source:0x0000
> [  163.058014] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error 
> detected
> [  163.066081] pcieport 0000:a9:10.0: PCIe Bus Error: 
> severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
> [  163.078151] pcieport 0000:a9:10.0:   device [1000:c030] error 
> status/mask=00040000/00180000
> [  163.087613] pcieport 0000:a9:10.0:    [18] MalfTLP                
> (First)
> [  163.095281] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080 
> ab0000ff 00000001 d1fd0000
> [  163.104517] pcieport 0000:a9:10.0: AER: broadcast error_detected message
> [  163.112095] nvme nvme0: frozen state error detected, reset controller
> [  163.150716] nvme0c0n1: I/O Cmd(0x2) @ LBA 16, 32 blocks, I/O Error 
> (sct 0x3 / sc 0x71)
> [  163.159802] I/O error, dev nvme0c0n1, sector 16 op 0x0:(READ) flags 
> 0x4080700 phys_seg 4 prio class 2
> [  163.383661] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
> [  163.390895] nvme nvme0: restart after slot reset
> [  163.396230] nvme 0000:ab:00.0: restoring config space at offset 0x3c 
> (was 0x100, writing 0x1ff)
> [  163.406079] nvme 0000:ab:00.0: restoring config space at offset 0x30 
> (was 0x0, writing 0xe0600000)
> [  163.416212] nvme 0000:ab:00.0: restoring config space at offset 0x10 
> (was 0x4, writing 0xe0710004)
> [  163.426326] nvme 0000:ab:00.0: restoring config space at offset 0xc 
> (was 0x0, writing 0x8)
> [  163.435666] nvme 0000:ab:00.0: restoring config space at offset 0x4 
> (was 0x100000, writing 0x100546)
> [  163.446026] pcieport 0000:a9:10.0: AER: broadcast resume message
> [  163.468311] nvme 0000:ab:00.0: saving config space at offset 0x0 
> (reading 0xa824144d)
> [  163.477209] nvme 0000:ab:00.0: saving config space at offset 0x4 
> (reading 0x100546)
> [  163.485876] nvme 0000:ab:00.0: saving config space at offset 0x8 
> (reading 0x1080200)
> [  163.495399] nvme 0000:ab:00.0: saving config space at offset 0xc 
> (reading 0x8)
> [  163.504149] nvme 0000:ab:00.0: saving config space at offset 0x10 
> (reading 0xe0710004)
> [  163.513596] nvme 0000:ab:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [  163.522310] nvme 0000:ab:00.0: saving config space at offset 0x18 
> (reading 0x0)
> [  163.531013] nvme 0000:ab:00.0: saving config space at offset 0x1c 
> (reading 0x0)
> [  163.539704] nvme 0000:ab:00.0: saving config space at offset 0x20 
> (reading 0x0)
> [  163.548353] nvme 0000:ab:00.0: saving config space at offset 0x24 
> (reading 0x0)
> [  163.556983] nvme 0000:ab:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [  163.565615] nvme 0000:ab:00.0: saving config space at offset 0x2c 
> (reading 0xa80a144d)
> [  163.574899] nvme 0000:ab:00.0: saving config space at offset 0x30 
> (reading 0xe0600000)
> [  163.584215] nvme 0000:ab:00.0: saving config space at offset 0x34 
> (reading 0x40)
> [  163.592941] nvme 0000:ab:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [  163.601554] nvme 0000:ab:00.0: saving config space at offset 0x3c 
> (reading 0x1ff)
> [  210.089132] block nvme0n1: no usable path - requeuing I/O
> [  223.776595] nvme nvme0: I/O 18 QID 0 timeout, disable controller
> [  223.825236] nvme nvme0: Identify Controller failed (-4)
> [  223.832145] nvme nvme0: Disabling device after reset failure: -5

At this point the device is not going to recover.


> [  223.876833] Buffer I/O error on dev nvme0n1, logical block 2, async 
> page read
> [  223.876939] pcieport 0000:a9:10.0: AER: device recovery successful
> [  223.893404] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
> [  223.901469] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80
> [  223.938902] pcieport 0000:a5:01.0: EDR: EDR event received
> [  223.946077] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
> [  223.953901] pcieport 0000:a9:10.0: DPC: containment event, 
> status:0x2009 source:0x0000
> [  223.963243] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error 
> detected
> [  223.971691] pcieport 0000:a9:10.0: PCIe Bus Error: 
> severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
> [  223.984144] pcieport 0000:a9:10.0:   device [1000:c030] error 
> status/mask=00040000/00180000
> [  223.993966] pcieport 0000:a9:10.0:    [18] MalfTLP                
> (First)
> [  224.002023] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080 
> ab0000ff 00000001 1e659000
> [  224.011644] pcieport 0000:a9:10.0: AER: broadcast error_detected message
> [  224.019604] nvme nvme0: frozen state error detected, reset controller
> [  224.236597] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
> [  224.244676] nvme nvme0: restart after slot reset
> [  224.250584] nvme 0000:ab:00.0: restoring config space at offset 0x3c 
> (was 0x100, writing 0x1ff)
> [  224.260945] nvme 0000:ab:00.0: restoring config space at offset 0x30 
> (was 0x0, writing 0xe0600000)
> [  224.271460] nvme 0000:ab:00.0: restoring config space at offset 0x10 
> (was 0x4, writing 0xe0710004)
> [  224.282012] nvme 0000:ab:00.0: restoring config space at offset 0xc 
> (was 0x0, writing 0x8)
> [  224.291713] nvme 0000:ab:00.0: restoring config space at offset 0x4 
> (was 0x100000, writing 0x100546)
> [  224.302430] pcieport 0000:a9:10.0: AER: broadcast resume message
> [  224.309618] pcieport 0000:a9:10.0: AER: device recovery successful
> [  224.316968] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
> [  224.324865] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80
> 
> After test, NVMe device still shows up in lspci and I can read pcie 
> config space but cannot read/write from/to the nvme controller.
> 
> I am trying to narrow down but would appreciate help from linux-nvme.

The issue is that during the reset the controller failed to identify
the controller, due to a second failure. The nvme controller does not
know how to handle that.

