Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC869C0218D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 19:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dm3Wthh3Fmw7cWLh7JvtK6wWvuTAS9Lb+ZHNQ12VKL4=; b=S6LVGLLfqYcTe7
	KkS2tREG/jVZLQFQWyfNlOT1F6gVXZaJN38o5NErXZHnH0Wfxx2rmy5i0wLMxzb75llBfY8IJhCBB
	qEbQt3s8NKlf8W09D/vO2Zx2HCY3WHkJARLGVPd4wpbIMyWQp/x6ZitGNdrDtawKMUmTKD07X3Knq
	ipHzqyOqj219MwVDNbSJd/xUaeCjor1MqclzHZUolkMK/DZA7EEUxEqOta8f3ecDbkiTfah29iIu+
	N06XnTLex/LtX2Oo/EJq9PRV88ckqf6XntSQTarOqiiS43VGRIj0ieJf87gVW19wNDgl9JKqiM1yq
	fh8Njm8eQ5PhuYLxCyRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdDKH-00000007eYB-1Dkj;
	Wed, 29 Jan 2025 19:02:13 +0000
Received: from smtp-18.italiaonline.it ([213.209.10.18] helo=libero.it)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdDKE-00000007eXp-17pJ
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jan 2025 19:02:11 +0000
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id dDK7tLmCk5LVidDK7tuU5X; Wed, 29 Jan 2025 20:02:05 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1738177325; bh=Dm3Wthh3Fmw7cWLh7JvtK6wWvuTAS9Lb+ZHNQ12VKL4=;
	h=From;
	b=0MAc0AgZm4XiO2Nn39YPgHGN17LqnPhayTPKt0H7Aav6UnK576K4ZBd3Lafz66IfR
	 Ncf3Ql69XaTXL+5gec8nMaehgPMqfYy2KGWASIwo/vRKR4q3JLI1QhoOTh5KiInxjV
	 OHXBZqcDh2+tMN/n6Yu7/IUWNQvh4tioq/m4AVEwYXBNFYoUi+Z5K2BIPsnFVhlr4l
	 Gvqg42Um9TjXMjLkn3t1ZecUIfxTsmOeO5rt+BDE742+ffC4t5tCsQYcdjM3DbrCJc
	 cLaezrDtn99Rld8xDx5kHEWqY5MfcgaHJ7/njf0gvnd4JOdt5nDDTS5oKFTNjLLHMW
	 9GQVrXy4TJ3NA==
X-CNFS-Analysis: v=2.4 cv=StRb6+O0 c=1 sm=1 tr=0 ts=679a7b2d cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=WJyTCbUXE8ZVV855lvUA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
Message-ID: <83b8c701-7719-4e90-b435-6398e132b921@libero.it>
Date: Wed, 29 Jan 2025 20:02:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Btrfs checksum offload
To: Kanchan Joshi <joshi.k@samsung.com>, josef@toxicpanda.com,
 dsterba@suse.com, clm@fb.com, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de
Cc: linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
 <20250129140207.22718-1-joshi.k@samsung.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <20250129140207.22718-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCkU6Ctt9veVANLcmm22pdNQVNMnyeTYb76F8RfeZVZ3cJzJxfW4tBqUf0X9NE0G0rWGDopElgxfXFLpDuRX8cHTOV8x3cuFVK7pHjUmwE+jN60QTOdw
 JUW8PVie0x7Nr2hdmbucatzt5s5YAjK2o2+3li7rWcI8gyTikJNfL8DeJiEst2OfqmVZ7xr1zDffrAt0ugX2kVkpf5F5IqsM4dwrEzKA6HcRtmSyhTb/v5NB
 Y5BPOaXiSOOGw5nn7PsIadJPJ8XyqrJ4L0lKOXKJJf+ZmTuC+hCDzywmOwJlJUJYa1MErFxAxmYr0iXmHFVkkv91CRGDlfr4CaNq9Pf3iRitQBdW+3IE9c42
 qMNWp0M8cLvbYJx7+5gGFAl4yBVwg8xJQqT4tkUhIVnssL4dfvXzhxAbJG1ozkp7EfEdE2htwEgMJVfbj4/mWb6XXcjZo2jWyLpkeuyeFqIdedyMFXNNHnqB
 CUpc6nhX65L7Mh4ZuX8prDmvqGNgLumGE0kcbQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_110210_752227_62222A68 
X-CRM114-Status: UNSURE (   7.91  )
X-CRM114-Notice: Please train this message.
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
Reply-To: kreijack@inwind.it
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 29/01/2025 15.02, Kanchan Joshi wrote:
> TL;DR first: this makes Btrfs chuck its checksum tree and leverage NVMe
> SSD for data checksumming.
> 
> Now, the longer version for why/how.
> 
> End-to-end data protection (E2EDP)-capable drives require the transfer
> of integrity metadata (PI).
> This is currently handled by the block layer, without filesystem
> involvement/awareness.
> The block layer attaches the metadata buffer, generates the checksum
> (and reftag) for write I/O, and verifies it during read I/O.
> 
May be this is a stupid question, but if we can (will) avoid storing the checksum
in the FS, which is the advantage of having a COW filesystem ?

My understand is that a COW filesystem is needed mainly to synchronize
csum and data. Am I wrong ?

[...]

BR

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

