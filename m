Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F1AC54E64
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 06:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C985hnG5BWgc6HOHx0yopfBbfsUvxRfwLqfL8Xpy8CI=; b=jeUWbtlTE++0bq5P4jP5pOvIHH
	Afgo53HkOAYEuw/lD7l5xeBBndcRqAWPIZatqowdNK4d3qc7gpluOir07JNjlDnN6oU1+FbU9QFnC
	iXkwd/BjxBbtArlwreH38Zn1DH5QSxobTL0TvzlpgxcL1yNGkDSy5Dipuw3TsIWwommZaOuOKrWUN
	eB/Tr5+d6Md8XTunqA979Z/SDcr/ofQrmWhad/X115bGEC88hu4VKBC4X0PMs+XkIJzdB+XSDDaQE
	UqsaLTjFdJfzkdIMxIfLoeAcWbCMcTOemJb41NwlYubWOTB2HQXzS98kKUB+leQp1e/oG4h0EV+y9
	aN9XFXRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjKF-0000000Cj8l-1RqG;
	Thu, 28 Mar 2024 06:33:23 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjKC-0000000Cj7Y-24rR
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 06:33:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 54A8ECE293E;
	Thu, 28 Mar 2024 06:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450C5C433F1;
	Thu, 28 Mar 2024 06:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711607597;
	bh=pnn1rBwl7okz5KQPjjIbUYL83lIbFWVfob8arJ3eTdc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DEOpjtjoDphsjzqdfmc+oW2z5RKEb/O3BRxBr+5ZaPPENY5oyeQdFzZM4kznRPHly
	 NG+N+UvvDvfLwggfdcHnalD2qpotFzOqdXGXXQz0hkPjuc08RHBs/j6Rxd9UQW6oAF
	 hKlu+ho4Zssg+R2jls0h3rulj4p/NkKKu1ej/n9O/rfI/ZlEECWGyIXlzv2d3MsC7y
	 jJiGqZeOXzH+kRUlg6xtyyDw46kgezKugWLBDWDqS5ESBAwLG6r85hR18XiXHUtuXl
	 UN6h+8WRofRiDFWJjrB+7C6ioGaLyWE/UJ6a0/zVzRjp640N5ktClLgXY+pkDNj8rU
	 AoWGvpq7X2C5g==
Message-ID: <0d54c569-f586-4b75-a8a3-509e3f3717e2@kernel.org>
Date: Thu, 28 Mar 2024 15:33:13 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240328062237.GA17225@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_233320_746294_D5A18E5A 
X-CRM114-Status: GOOD (  13.64  )
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

On 3/28/24 15:22, Christoph Hellwig wrote:
> On Thu, Mar 28, 2024 at 03:18:46PM +0900, Damien Le Moal wrote:
>>> Yes, bt it can use kfree_rcu which doesn't need the rcu_head in the
>>> zwplug.
>>
>> Unfortunately, it does. kfree_rcu() is a 2 argument macro: address and rcu head
>> to use... The only thing we could drop from the plug struct is the gendisk pointer.
> 
> It used to have a one argument version.  Oh, that recently got renamed
> to kfree_rcu_mightsleep.  Which seems like a somewhat odd name, but
> it's still there and what i meant.

Ha. OK. I did not see that one. But that means that the plug kfree() can then
block the caller. Given that the last ref drop may happen from BIO completion
context (when the last write to a zone making the zone full complete), I do not
think we can use this function...

-- 
Damien Le Moal
Western Digital Research


