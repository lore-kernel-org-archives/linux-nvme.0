Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B48CD11DD
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 08:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YuR4DOOfY22NrGxJZ8kMo+KvVnPRU4N2zVE1Ri1pups=; b=eHRm/yU9BghTdJoKhf+8BsdlvC
	FUfsVmvAnnFxS0z8vZosQf0R/E0wPPEo09CmUHO6VE/H5007DfYXPLxuGtJFq+kE6DenknPTRvHOo
	fQ+nZwdGjxcj20h4aGVlJwg58Z0bSh1nBQ7adsr6C5gwr/zDJcgfrEVNo/H6XK1wMXNI0x+rSKpU1
	adLbzeyFp27vKGL4htMjDt65b+Fgg/q/6MqawHfWx2VzY+aGB/ByoG9HNbl/evuC5yoHcOpntqijQ
	HNVPrMxbkZNa5x0urs/LWgRhzT7WeaAHbdfh/AUjz1E2mqr4M2UNeABlVFCvCRV18bkXnxYCUGQzI
	aAeaCGIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpkjY-0000000CzuQ-3nX9;
	Thu, 28 Mar 2024 08:03:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjbl-0000000CldS-42Xq
	for linux-nvme@bombadil.infradead.org;
	Thu, 28 Mar 2024 06:51:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YuR4DOOfY22NrGxJZ8kMo+KvVnPRU4N2zVE1Ri1pups=; b=kX9c0uoyr+oA6lFWEEtigj9eY1
	B9YIiG8s66JxtJ3lNahz0stmJigjSzTR+yRnv7YaXtOKDsn2kgllT3PhJ6LerIKBZ35Ly0cdeeLn7
	aLpKoqikXYdq8tAqPxRUqS/4/FXhz7gaxhauPF9axJugicgp7TE5ySh6md2zJQGSNWTEsWJJE0g6M
	TniCgBIVJJczG623L4v5vx+2OT81x+9zelddXGkhyTcvME3YWjHDfiV0SVtRa2nse9HQqyPtLlLAI
	cT2yu9ei1KzsAen0YLLsW7CbE8W9XJWRuT0E0kvVfmxAIfsnhCnCLweygO/KIhYqZQ8cc3L8TxwP4
	QVAlq+3Q==;
Received: from sin.source.kernel.org ([145.40.73.55])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjbZ-00000000pay-3J1r
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 06:51:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1C484CE1DF9;
	Thu, 28 Mar 2024 06:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACA3C433C7;
	Thu, 28 Mar 2024 06:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711608672;
	bh=aTzaANG9xoqixNTobM3JZiK2u04Y/OCEwuf/Z1KZ1w0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pv4O/eRb9QBl3AAjajxbG9oGIZoyqT5pWb+5oAjc6+Fg5gQDudUBO5e7G8OyQZaYA
	 CCYE8wkhyLalBuSmlxqMUF7NfEyQSoVoKX4Nfx24F1EUZDGpqK4FnjjsVs63RnbT4Z
	 lP8+zeL28RqpQqhXbZmCxXePPrZ+ZdbMYuTGbq3/lRiFGVpmAIaRni1Yn+5CPcmOPQ
	 3n8v9NS7DxtYhYd23twfxVX7s7mQEWRizdJ/Kg5B0LdrAjeEPA5Qi+9ADJCE8hjFDW
	 HVo02vh2Tb6eiQXHjAREuuNUy5s0WPdebMzVIac7oQyDGbI9fOcftJhrpt8BfjKYDb
	 Yd4GDLFPvuUrA==
Message-ID: <b144a7f1-af29-4c0d-96f7-c0f16b2299b8@kernel.org>
Date: Thu, 28 Mar 2024 15:51:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/30] block: Pre-allocate zone write plugs
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-10-dlemoal@kernel.org> <20240328043016.GA13701@lst.de>
 <714d0cbc-be4d-4aa9-b200-73c6caaa1d18@kernel.org>
 <20240328054652.GA16237@lst.de>
 <7d8f3ec4-c416-445f-92db-7d2b60726821@kernel.org>
 <20240328060357.GA16819@lst.de>
 <ca3fe7b0-7e27-4ac9-b669-5263c3cec550@kernel.org>
 <20240328062237.GA17225@lst.de>
 <0d54c569-f586-4b75-a8a3-509e3f3717e2@kernel.org>
 <20240328063816.GA17642@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240328063816.GA17642@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_065120_228972_0B10C576 
X-CRM114-Status: GOOD (  15.44  )
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

On 3/28/24 15:38, Christoph Hellwig wrote:
> On Thu, Mar 28, 2024 at 03:33:13PM +0900, Damien Le Moal wrote:
>> Ha. OK. I did not see that one. But that means that the plug kfree() can then
>> block the caller. Given that the last ref drop may happen from BIO completion
>> context (when the last write to a zone making the zone full complete), I do not
>> think we can use this function...
> 
> Ah, damn.  So yes, we probably still need the rcu head.  We can kill
> the gendisk pointer, though.  Or just stick with the existing version
> and don't bother with the micro-optimization, at which point the
> mempool might actually be the simpler implementation?

I am all for not micro-optimizing the free path right now.
I am not so sure about the mempool being simpler... And I do see some
improvements in perf for SMR HDDs with the free list. Could be noise though but
it feels a little more solid perf-wise. I have not seen any benefit for faster
devices with the free list though...

If you prefer the mempool, I can go back to using it though, not a big deal.

For other micro-optimizations worth looking at later would be to try out the new
low latency workqueues for the plug BIO work.

-- 
Damien Le Moal
Western Digital Research


