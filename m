Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BB4D5E150
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Dec 2025 13:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vm7HudL1aqGJfiPkRkarTR7MZeS1NbOn4sFaOu3DkXY=; b=TeujPKNvunYGp72DjXHGlsZIg2
	YAx6S8jUCeFcNBq1LKzvO4hOKhFmqPA3zrEIIHFzreqcTuA6ABatXFyNobln6m8rzAba/8M+pHPl+
	+23POD4rgWuklDulnm244OVNFwVVtYiOcXLE/R0kQjjYSvCdAmgETih8V3Lv3Z6qD5QbAzg7qC9cq
	PreZAbKuwcY1OKzOZN5iHhyQsrAvk8zGSKW8lVqeWRfKW1FpgosFx90HT35mDoZv0ytHGvvf2Z2zR
	Tzg5nHOxqWJfhql63Jw19xBY38Tf3APQNj/2Nfev2jvgfqT72PgOm5m/J0ZxlKuJOi7CccIp5ke5m
	LJ31X+8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVVPP-00000005IHa-0qeU;
	Tue, 16 Dec 2025 13:48:11 +0000
Received: from relay4.mymailcheap.com ([137.74.80.156])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVVPM-00000005IHB-40Uz
	for linux-nvme@lists.infradead.org;
	Tue, 16 Dec 2025 13:48:10 +0000
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id F16E920057;
	Tue, 16 Dec 2025 13:48:05 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 53A3A40085;
	Tue, 16 Dec 2025 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1765892885; bh=MJJFPU5l/IkQvxNX9Lq0VP/ykfAP0Eh22OmWK6Qz+T4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=affPBMq4Au3vfK2G3vwYTZGIYEBMc7oUU909vh6pNNIfosmNkmc76vuVkloSPOQx/
	 vLjIwF9fnWYU6SSAIdLI2LhXxbzXdklgCY1NM/ptG6dSWDkI3f4nmRYvE8lBfPFxZd
	 MQEULRgfxXMf01dNKiXAS8YQ/KAkW4TU26VtPJCo=
Received: from [192.168.5.7] (unknown [111.40.58.141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id E292743ADF;
	Tue, 16 Dec 2025 13:47:57 +0000 (UTC)
Message-ID: <84cb474d-c41e-40dd-9a75-704b9ebaaf45@aosc.io>
Date: Tue, 16 Dec 2025 21:47:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: add quirk for Wodposit WPBSNM8-256GTP to
 disable secondary temp thresholds
To: Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org, Wu Haotian <rigoligo03@gmail.com>,
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>,
 stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <20251208132340.1317531-1-ilikara@aosc.io>
 <aUAqGO7GXRrTk4Vq@kbusch-mbp>
From: Ilikara Zheng <ilikara@aosc.io>
In-Reply-To: <aUAqGO7GXRrTk4Vq@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: 53A3A40085
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 10.00];
	BAYES_HAM(-0.36)[76.71%];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,aosc.io,kernel.dk,lst.de,grimberg.me,lists.infradead.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251216_054809_175428_72810529 
X-CRM114-Status: GOOD (  11.48  )
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

Hi Keith,

On 12/15/2025 11:32 PM, Keith Busch wrote:
> I'm not finding vendor 1FA0 registered on the public pci-ids, nor in the
> pcisig.com members list.

When I run command lspci -vvnnk, I got outputs below:

     01:00.0 Non-Volatile memory controller [0108]: Device [1fa0:2283] 
(prog-if 02 [NVM Express])
             Subsystem: Device [1fa0:2283]
             Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0
             Interrupt: pin A routed to IRQ 37
             NUMA node: 0
             Region 0: Memory at 40110000 (64-bit, non-prefetchable) 
[size=16K]
             Expansion ROM at 40000000 [disabled] [size=64K]
             Capabilities: <access denied>
             Kernel driver in use: nvme

 > I just want to make sure the identifier is officially registered.

I have no idea why they didn't use their PCI Vendor ID, see 
https://pcisig.com/membership/member-companies where they used a 
different Vendor ID (0x2094).

