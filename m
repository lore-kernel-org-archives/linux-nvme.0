Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A6ED6B6B5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 17:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SwxKfN96hIqYCkb8QGNlA8KosCPk0jUCEfVCsG/NExc=; b=OwxGcfDVoGFmnqQZeJStIPknRx
	jynfEl/GR6QVAl2HErV/lKgelKvf2XL35ciK5M2FPC74AmwkL3k8Qpy5kKXxhEXfPw15tlHKELGQb
	1edsah50HORGY0YKrYTGT9kn02dLF5K0KJmW+w4+/Fwj8pCQoRCqx3ZNxBINkiRI56tZZWCJIwSlm
	wKYEeI+Bekxj2yrQ9NAMX0JPfKiYHVEihR0zfwLo3TSqq6qmEUqafPD9B3HdNrMA9459a4b+IBMQf
	xv+2LB+NijnN60+vzwfKiLb7DmnQP8cf7kglSlBlhR49BArhXYvm3WDRUxz1/kWNAQdM7+usKeAtT
	4CCW7lfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6C7w-00000001BMY-1Sjy;
	Wed, 30 Oct 2024 17:05:00 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6C2l-000000019mf-1usV
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 16:59:41 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Xdtdk1cwnz6CkhT8;
	Wed, 30 Oct 2024 16:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730307570; x=1732899571; bh=SwxKfN96hIqYCkb8QGNlA8Ko
	sCPk0jUCEfVCsG/NExc=; b=MexNnD/aEVaXzpRD5MISzOL1S5JHtj7aKWSWgfVw
	HOMB19KGgbyPmg4UKxoOgLWrSRUxXot2/LDK941QdpGi7kcJc524kjWOMOznHEMc
	JZFjOQNHaqq0Aw6MUeThPKGoyinJEbqOKAqxxV5GuT4xCWg8zg6U3Y4gmfpV16T9
	ubJ4hrrpQ41SOl5ZHA3leu7hVEhYUreKQWXILrK3BoN7vkE1tAWSlpUxPw1fiPF7
	f4QPCL5OkcM/yU/UtJY1BFI8t+/AgfH8pXoLrfssVJ6vuQpLHbIcheCo8MR8Dfu8
	VdMsjKQ9xR3g+epauZYGRPFjnYvbtonLrIvSEta7m9PF+A==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8PFHBzjVBJzT; Wed, 30 Oct 2024 16:59:30 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XdtdV5P1Wz6ClY9S;
	Wed, 30 Oct 2024 16:59:25 +0000 (UTC)
Message-ID: <c9c2574b-b3be-47ac-8a82-10d92c5892bc@acm.org>
Date: Wed, 30 Oct 2024 09:59:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 joshi.k@samsung.com, javier.gonz@samsung.com, Hannes Reinecke
 <hare@suse.de>, "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-10-kbusch@meta.com> <20241029152654.GC26431@lst.de>
 <ZyEAb-zgvBlzZiaQ@kbusch-mbp> <20241029153702.GA27545@lst.de>
 <ZyEBhOoDHKJs4EEY@kbusch-mbp> <20241029155330.GA27856@lst.de>
 <ZyEL4FOBMr4H8DGM@kbusch-mbp> <20241030045526.GA32385@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241030045526.GA32385@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_095939_577434_49F1CE61 
X-CRM114-Status: GOOD (  12.29  )
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


On 10/29/24 9:55 PM, Christoph Hellwig wrote:
> For the temperature hints the only public user I known is rocksdb, and
> that only started working when Hans fixed a brown paperbag bug in the
> rocksdb code a while ago.  Given that f2fs interprets the hints I suspect
> something in the Android world does as well, maybe Bart knows more.

UFS devices typically have less internal memory (SRAM) than the size of 
a single zone. Hence, it helps UFS devices if it can be decided at the
time a write command is received where to send the data (SRAM, SLC NAND
or TLC NAND). This is why UFS vendors asked to provide data lifetime
information to zoned logical units. More information about UFS device
internals is available in this paper: Hwang, Joo-Young, Seokhwan Kim,
Daejun Park, Yong-Gil Song, Junyoung Han, Seunghyun Choi, Sangyeun Cho,
and Youjip Won. "{ZMS}: Zone Abstraction for Mobile Flash Storage." In
2024 USENIX Annual Technical Conference (USENIX ATC 24), pp. 173-189.
2024 (https://www.usenix.org/system/files/atc24-hwang.pdf).

Bart.

