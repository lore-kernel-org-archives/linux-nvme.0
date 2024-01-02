Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5312C47073
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 18:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HUdFZN4kMgbmwcXynR9BvCjEEmSquM1vOzSS27o4cNY=; b=o5bDD9t5xyQXm4PgJBPGKAL7xW
	7cOGc5dtaiu9ZSx1Z7BBSb6DFdGVcN5WZqj8J+M7Uxmh7UEP5i3nyhP+AcdvoKK/q8BLOMr08nkYS
	n5S/4NM27YY18ChU54RcZzf2VmUvyeKnvT7asENB1Et280n0EifCF+8SnWjQzDjoG3ODhzh5ROh1J
	YVIuJBsaldeWEJN5JWDkgr80yIVeJwyzSPSYyk3WL/hrL0H51j/ZMMNqHMUB7PfjzLyZqLxxmuFGQ
	nEAoH3ipyfG29cKNtLaOWtWXohQ65nPvB4nzDpfPnv6IUbb94mYwk6QBDvKeVrcL42p8bkNM9xs17
	zLVArFtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKjAy-008fdQ-1z;
	Tue, 02 Jan 2024 18:07:40 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKjAu-008faz-1U
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 18:07:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=HUdFZN4kMgbmwcXynR9BvCjEEmSquM1vOzSS27o4cNY=; b=gxT0PttjGNgE+0j7AtdFT1lvUo
	xiVroB8P5Tq8Qpl7oIZQlnQAoZYn6TdSk+SI4o/pR0u1785fSRIbnZYLvPdsGjdl+vlwzx4eMkGN3
	Ng7GZlzhFZXbZo1Rerml/YTnQhPrsZEtA4Eaeuhhf12Ui6syUM76xkaltZtCenCwUhn9ciAI6b+/y
	2vF1lImBKJcB3lWWDMh3nRMC1iXMHDiH26tQaoArWJ32wTBScvWPuQnlSO55Re0RPjKRGAzdNZglC
	fkpUv+/vGE8RUqWDqSfCSkHrQgYyWMVADpuIDMh3fqM46Iyrc9uwnxxA8+0BlDqcf1js6uTd7uzml
	6LdyBMo0UF5grKooRO5e5AWt4HPJy4olqOLOAQh1Ut8ljxVluxLpwbgN/X/26puAyHo+lA9orQWLP
	pSdLTOz1sOyroKHIAA89Oproc3yu28/lMbKxWk4me7HeWndrpxYxepoY+KI0jKEgKw1sMG5B82U40
	+WGx1F2iNk9UJhVd7UjeWK8t;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rKjAs-0067GI-16;
	Tue, 02 Jan 2024 18:07:34 +0000
Date: Tue, 2 Jan 2024 10:07:30 -0800
From: Jeremy Allison <jra@samba.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org, jra@samba.org
Subject: Re: [PATCH 1/4] driver core: Support two-pass driver shutdown
Message-ID: <ZZRQ4oSUdP/i4Pfg@jeremy-HP-Z840-Workstation>
References: <20231221172257.2234320-2-jallison@ciq.com>
 <20231227203337.GA1509884@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231227203337.GA1509884@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_100736_495432_0C0F2032 
X-CRM114-Status: GOOD (  14.68  )
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 27, 2023 at 02:33:37PM -0600, Bjorn Helgaas wrote:
>On Thu, Dec 21, 2023 at 09:22:54AM -0800, Jeremy Allison wrote:
>> From: Tanjore Suresh <tansuresh@google.com>
>>
>> This changes the bus driver interface with an additional entry point
>> to enable devices to implement two-pass shutdown. The existing
>> synchronous interface to shutdown is called, and if a shutdown_wait
>> method is defined the device is moved to an alternate list.
>>
>> Once the shutdown method is called for all devices, the
>> shutdown_wait method is then called synchronously for
>> all devices on the alternate list.
>
>Christoph and Sagi noted that the objective is similar to "fire now
>and wait for completion later."
>
>Would it be practical to actually *do* that, e.g., add a global
>shutdown workqueue, have the .shutdown() method of nvme and similar
>drivers add items to it, and have the driver core wait until
>everything on that workqueue has completed?
>
>But I'm not a workqueue expert and I do see the scary warning at
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/workqueue.h?id=v6.6#n619,
>about not flushing system-wide workqueues, so maybe this wouldn't be
>workable.

This is a bigger change than I'm comfortable with
(or indeed understand :-) right now. Can we fix
the immediate problem first please and then look
for improvements later ?

