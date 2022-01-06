Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1DBC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jan 2022 00:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xd/zzcY0SvCAKYFGCavbLme1V0VcAHZaS1RZsxBRqRw=; b=FQkZK5u+cm4fsoO5amUJr+m/jU
	Sixfo5kwlMpZ3Be4eZH8re8r27BX2s7FtrM8KD+5MIDI9yYMv4ztyGocH4wMkmQsCTrB0lYIko+pw
	13TtT6wrUwlPzHUhjMCicRDoT7vPVhGCTdIqslDGd0It8PXMK1hb9WMaAtnbRDBiiA0J+lvTi2lb0
	xF80CGYnl5bavK+UMY/l/b2hKJiKtDiQErml7XDzRCAsnrCS18kYd9hIAtdOW0giWstCm4i2Opo97
	iaABHp38xfhrL0oR4S7zgYlqw6c2VjXkZCAq/Q+v40PfNngd17zdMESdRCl4TwBj7Xj8039SC96sc
	VB8Y+Iqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n5GaU-00G4MG-AV; Thu, 06 Jan 2022 00:25:02 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n5GaR-00G4La-8d
 for linux-nvme@lists.infradead.org; Thu, 06 Jan 2022 00:25:00 +0000
Received: by mail-wr1-f52.google.com with SMTP id l10so1481949wrh.7
 for <linux-nvme@lists.infradead.org>; Wed, 05 Jan 2022 16:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xd/zzcY0SvCAKYFGCavbLme1V0VcAHZaS1RZsxBRqRw=;
 b=47j1iY+hlTD93vwSRWy0a05VpE1UcydbCurf3NoO7u8uV/QUCOg5fd2vhP1eAXubc8
 xHrlqRvamssZ4+e0A53nvHR/VC6P+KjACrx7bksLaktMyl8huyKWEp69SrKJbEgqYvay
 qQ2+iOzEWT8bnY4QLqqYZOcbsI1sL2/orXMFamoRtEoTeouChLtvXF2iALZqPU+ptiSi
 SnzKEGLSBG3S0eiNbIlMPy8/3BtpjCYDrbGahmjYNR/JC0gcDbtqdYD7gdxS1pV6M5/F
 qdWhSMSs9YNytFL1YlLO8f5G5ZNbedvftrUti36ju0zyJxLlTSNuyoXqGKtNReFUgxoC
 n4+w==
X-Gm-Message-State: AOAM530S66HVQKJrCnxBPMvcu0b5o79sgWAA+sSRChA3rfgfZy1j+Niy
 D+PImuqX8hRUDQXD7QFlSWbuuvkRgKI=
X-Google-Smtp-Source: ABdhPJwIXmBSCfSAq3o3Q1o9PH37mCc6pSo385DKFA0Ufb3l3X6iKCFTvxeR7MQJdCbX9yVgDPDJ0Q==
X-Received: by 2002:adf:f442:: with SMTP id f2mr372142wrp.59.1641428696922;
 Wed, 05 Jan 2022 16:24:56 -0800 (PST)
Received: from [10.100.102.14] (85.65.254.236.dynamic.barak-online.net.
 [85.65.254.236])
 by smtp.gmail.com with ESMTPSA id l19sm123226wme.33.2022.01.05.16.24.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jan 2022 16:24:56 -0800 (PST)
Subject: Re: nvme-tcp: io queue shutdown ordering
To: Jonathan Nicklin <jnicklin@blockbridge.com>, linux-nvme@lists.infradead.org
References: <CAHex0crxy=3c-OouRWLXhvBMZjhgDsg-7wcyGrPE0R8ymPTEYg@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3fb8de5a-6277-29ca-56bf-a78cd1394406@grimberg.me>
Date: Thu, 6 Jan 2022 02:24:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHex0crxy=3c-OouRWLXhvBMZjhgDsg-7wcyGrPE0R8ymPTEYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220105_162459_347504_C04B95AD 
X-CRM114-Status: GOOD (  19.06  )
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


> When disconnecting an nvme-tcp device using nvme cli (i.e., nvme
> disconnect), nvme_tcp_teardown_ctrl() destroys I/O queues before
> issuing the shutdown notification on the admin queue.

Yes, same for rdma, and also pci.

> According to the fabrics spec version 1.1a section 1.5.2, an
> association is terminated if an NVMe Transport connection is lost
> between the host and controller for any I/O Queue when the host or
> controller does not support individual I/O Queue deletion.

The connection lost implies that the controller (or host) is not
reachable I think. disconnecting a controller is an explicit
operation triggered, and an orderly shutdown done (or at least
attempted). But none the less, the association is being terminated.

The message in the paragraph that you are referring to was designed
to articulate that there is no mode where the controller will continue
to function and accept I/O with a subset of the queues available which 
requires logic for I/O failover within queues of a controller ala iscsi
erl=2. Instead the spec says something like "if a connectivity issue was
detected on any of the queues, just terminate the entire association".

An orderly teardown/disconnection does not qualify as a connection loss.

> The initiator in mainline does not advertise support for I/O queue
> deletion in the fabrics connect attributes (i.e., bit 3). Therefore,
> termination of the association in response to connection loss of an
> I/O queue should terminate the admin queue connection. This could
> result in an inability to process the shutdown notification, causing a
> disconnect request to hang until a timeout occurs.
> 
> Is this possibly a bug or my misunderstanding of the spec?

The spec does not say anything about making sure that no I/O is sent
when the association is terminated, it actually says that its up to
the host implementation (see the shutdown section 4.6, which is probably
more relevant to the orderly shutdown you are describing).

