Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AC6C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 15:11:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283C1600CC
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 15:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 283C1600CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:Cc:To:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tlF8urmdUMRKKbsKjk7Tie7O/x8mCFfQ8DXaFPtSZMA=; b=WOeda6veQw3jqxhjHXx31FFNnF
	OWf2+UdJQ4hb/lzLw7loHEhrPkIC7Jx0qzQsStb/hFLwjZTl+7pgxZXz3czFFO5W23jtJWALz1yiP
	adJ3Ip1c2+RF+cNvjgsZ5M27bDiix0TiT4GQDFt3L9NnCtKzdrMAr0C/f2KVtlfijbm38+eu+X+Wq
	koeFgPhaPpXUKDf42dW8VaVu63gJQsLtgBPZqLbJD2HiQLycu/2qQ8caYiut0cBcvDdK2icNXrwUt
	jB/GyERLtk+Wk3IzVk4cVcCSR64nxK//J2qGskVCiJsPw0d1aF5M3S7EcT4CrGKtzx80ej/fUAuG4
	gAj/dufg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG0jz-002lpX-D7; Tue, 17 Aug 2021 15:10:59 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11] helo=mx1.molgen.mpg.de)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG0jv-002ln5-Rb
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 15:10:58 +0000
Received: from [192.168.0.7] (ip5f5aeb65.dynamic.kabel-deutschland.de
 [95.90.235.101])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id D2DE061E5FE00;
 Tue, 17 Aug 2021 17:10:40 +0200 (CEST)
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: SK hynix BC511: warning: nvme nvme0: missing or invalid SUBNQN field.
Message-ID: <67f74c8e-9d5e-22a1-f1c2-a4284b07ba56@molgen.mpg.de>
Date: Tue, 17 Aug 2021 17:10:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_081056_098153_31B3AB0F 
X-CRM114-Status: GOOD (  14.69  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Dear Linux folks,


On a Dell OptiPlex 7780 AIO/04G47W (BIOS 1.6.3 03/08/2021) Linux 5.10.47 
shows the warning below:

     $ dmesg | grep nvme
     [    3.015392] nvme 0000:02:00.0: platform quirk: setting simple 
suspend
     [    3.021861] nvme nvme0: pci function 0000:02:00.0
     [    3.026593] ahci 0000:00:17.0: version 3.0
     [    3.026922] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 1 ports 6 
Gbps 0x1 impl SATA mode
     [    3.035020] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only 
pio slum part ems deso sadm sds apst
     [    3.035219] nvme nvme0: missing or invalid SUBNQN field.
     [    3.044518] scsi host0: ahci
     [    3.051632] nvme nvme0: 12/0/0 default/read/poll queues
     [    3.052590] ata1: SATA max UDMA/133 abar m2048@0xd1339000 port 
0xd1339100 irq 125
     [    3.058538]  nvme0n1: p1 p2 p3

The disk model is:

     $ sudo ./nvme list
     Node                  SN                   Model 
                 Namespace Usage                      Format 
FW Rev
     --------------------- -------------------- 
---------------------------------------- --------- 
-------------------------- ---------------- --------
     nvme0n1               NY11N03531080183V    BC511 NVMe SK hynix 
512GB                1         512.11  GB / 512.11  GB    512   B +  0 B 
   11004101
     $ lspci -nn -s 2:00
     02:00.0 Non-Volatile memory controller [0108]: SK hynix Device 
[1c5c:1339]

Should it be added to the quirk list in `drivers/nvme/host/pci.c` or is 
it a real issues, the manufacturer should fix? If so, do you have SK 
Hynix contacts?


Kind regards,

Paul

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
