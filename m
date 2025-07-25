Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D52C83F26
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jul 2025 02:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zVvfWV5xBTWUvWPUT+1g04ilqXeQlsqxXaj7jUtWr24=; b=R7uJBVA8QANDVrmuUwijgp4C8Z
	eOy37B3Y35fh7+jEW72WDqZwUWrwGOPJUmiZC7qhN7JfAqlK+L0aZVde1XvtJQSTgsG++ssTeNWxs
	T53ZqBLjlDXDCmHA8kzaqGDqz9rxIoR9YWjsxZ43Zm9sremzwVaEZcnisn8GDrvzsykPjpC6B6Um6
	qe9QaxkBYQGCDt/70Sq5DZXQ9mq5Xl94eDG+LFN+KnfccsIOBYTZOlhCvNs/K6UOY5u2a91hvdFsi
	pHa2nr/+8sN0K8efQrHw/CsnJxwG1ycfKxMJ/+qQKV0k4BvkV2oeyOzRj2wRZojm+CCNSURpzLgJZ
	zIjF64ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uf7jQ-00000008reK-43vz;
	Fri, 25 Jul 2025 02:00:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uf7h1-00000008rD3-2ckO
	for linux-nvme@lists.infradead.org;
	Fri, 25 Jul 2025 01:57:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E800B417E3;
	Fri, 25 Jul 2025 01:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD80C4CEED;
	Fri, 25 Jul 2025 01:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753408670;
	bh=OXEGSolN6hWAZmpwucLokUEPFVf6sVZ8bKkWun3/kJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BWeou7zqPx6Z7PvCD94cqSc4ollYNooFEmkRIJ6t8rUqcaJzEQdvkNwAT5VsQbe7z
	 1hIkg3pZoLUlgH8gJZPc6ziLZEl8+kPYT2IOAtPuU3EUaqGHlaOjuvf2vfaXzbKQ1x
	 yBUbBYD0H6xqbjJYb0HJL4fDfhrYaxCe8ZBFurexpxh9wUtTz8WzAlmGTaaDMomWlW
	 LnDoSm22OQGJqapg7R0NCVAofpYIF28SaA8ES1rzcRylg7eERIIr+zEZxvOv6kEPS0
	 PVYDEYpUeQazs45YMmeHEzhhadAOpg1XOqiROQSgd8QBqnj7Si4UH7t5xB5RCX1UBu
	 efNHJoYy+EQ7g==
Message-ID: <1f447780-09a2-4f97-a17d-5489ebd4da5f@kernel.org>
Date: Fri, 25 Jul 2025 10:57:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/nvme/host/pci: Fix the asynchronous detection
 issue of nvme devices
To: Bart Van Assche <bvanassche@acm.org>, likunyu10 <likunyu10@163.com>,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 likunyu15 <likunyu15@jd.com>
References: <20250720185154.138391-1-likunyu10@163.com>
 <58c289ef-770b-4524-b38d-ebdb51ccc8f4@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <58c289ef-770b-4524-b38d-ebdb51ccc8f4@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250724_185751_690247_8FB4C8FF 
X-CRM114-Status: GOOD (  10.21  )
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

On 7/25/25 01:07, Bart Van Assche wrote:
> On 7/20/25 11:51 AM, likunyu10 wrote:
>> PROBE_PREFER_ASYNCHRONOUS asynchronous detection has a significant impact
>> on important devices. For example, if a server has two or more nvme disk
>> devices, it can cause disk loading disorder, which can also have a
>> certain impact on actual production environments.
> 
> That's intentional. Please fix your user space code that uses hard-coded
> NVMe block device names or introduce a mechanism in user space for block
> devices that is similar to the predictable network interface names
> mechanism. See also https://systemd.io/PREDICTABLE_INTERFACE_NAMES/.

Userspace can use /dev/disk/by-id or any of the other /dev/disk/by-* for
reliable device names. Using directly /dev/sd* or /dev/nvme* is bad userspace
practice.

Even without asynchronous device scan, adding or removing a device to a system
can change device file names. The symlinks in /dev/disk/by-id are stable and
will exist as long as a device is present.


-- 
Damien Le Moal
Western Digital Research

