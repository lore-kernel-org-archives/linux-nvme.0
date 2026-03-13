Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E6B106FD6F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 04:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wcqldhRqO3jBnLmkV6cEDn073YqeYg59rbLqYeyL5R4=; b=qGcX1GX0sblJeEc2WarkZe00vJ
	YW+OIs2RQkMXrU96bCz6xsY6n5z7fEoADo3kM4idOItK0UwVsvR3FJdS9wjESXkYJIwU+TknB69F4
	G4b1xYTJnWQ8x0vBgdknbfOCzjCTgyl4ljjEXh3Vin26yIDLdren4ghRlrWb8MdTakjskQtH0Fx4t
	27wO7nQCpVOYMbpEwX4e0kYaBxxuB3ODh1aBdkW4aBxVa34mAP2zjJkr4PQJO2Uank+TBQYTGKu5t
	RB3pDPaVfAL3LFtmoIm/L/SEmmZdb10dAr7RUAczWY2jNJAM2iRsmtlQxupmKf6q5qEY4+ImZ/CcP
	y4jK2UgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0u2l-0000000GUFj-1asO;
	Fri, 13 Mar 2026 04:22:35 +0000
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0u2i-0000000GUFM-2Bro;
	Fri, 13 Mar 2026 04:22:32 +0000
Message-ID: <604ed82b-afe7-467d-a6e2-98d15604ea9a@infradead.org>
Date: Thu, 12 Mar 2026 21:22:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp.h: correct kernel-doc comments
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20260312051431.684352-1-rdunlap@infradead.org>
 <20260312070354.GA27358@lst.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260312070354.GA27358@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 3/12/26 12:03 AM, Christoph Hellwig wrote:
> On Wed, Mar 11, 2026 at 10:14:31PM -0700, Randy Dunlap wrote:
>> Mark reserved fields as "private:" so that kernel-doc comments are
>> not required for them.
> 
> I'm honestly not sure the kerneldoc makes any sense for an on-disk
> structure that has an external specification.  So insteada of these
> hacks, what about just dropping the kerneldoc comment entirely?
> 

Sure, I'll do that.
Thanks.

-- 
~Randy


