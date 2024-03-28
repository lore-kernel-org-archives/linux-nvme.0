Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF32CD1284
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Mar 2024 00:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=36/Ly45a62cOKo9gqcrLLgo3Q7Yzztn5H2fGXzXc4ZU=; b=uUkG8WE1SnBFOCl1J8zi4J5E+1
	eXM9aWDvpa8pCAKB75aeUMAbgJGnXonuGeMo4bGHOkWDnPBYFPvZCT/7VjMr3tp8WDVbrJDN2BYKJ
	gU2wCtrrGo0Lv3bFUkFSQ/3gzTbO663BpAmPq+DJfwSTEpcDz08lz9fLJrg72yUMdjXKEcs07GLJz
	OBDj4yUbx7Rx7bKA+bYewVnOXHOlaNP7KuRwS4jiUT2ORkmdV8SrJcXOHhUF+ji0Ba0mkRK9D762x
	R8kPBNmV+Zsnhtt88+peBz/BDP4ky8URjvhsTBri71CBvsGUgx3YhbhCXdPvS5EUsUx4BWKARYibn
	W/xryruw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rq0Bx-0000000GGUz-300g;
	Fri, 29 Mar 2024 00:33:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpzFV-0000000G5do-2ZwP
	for linux-nvme@bombadil.infradead.org;
	Thu, 28 Mar 2024 23:33:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=36/Ly45a62cOKo9gqcrLLgo3Q7Yzztn5H2fGXzXc4ZU=; b=DlhpG2+JwwZcvT0YnWKl3Yq8gy
	yC5yIExd+j3AL3vSvstQ9IMXQGB1kWaemBa47AimtN35F33DOz6Z8bjylqyPaaX5a0hSV/8xIi7Qb
	yEOM94KMhu3+KkDrjmUJte0cbvsSsgN17RxopOREctBhWkJ/IM4tgvNipVYXqzbzSwsluiHepZU3s
	HVxsGjFYVm5xdb00lqBSwdRz4AbjDIghpbbvwuEHsbE9PXgp7sBqSxj4KOGD17UOO2PillyhRh+dT
	sg5K0ITJDS16EIMpUJprVfk70pjsf4DaHNRH93mRbWw/0r+qQWo6/PemWp6cMak7EDgawAjK06b4A
	MYGwGx1Q==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpzFR-00000001Elh-2x4F
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 23:33:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E429361844;
	Thu, 28 Mar 2024 23:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CC0C433C7;
	Thu, 28 Mar 2024 23:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711668807;
	bh=acNr/7O7ETr3TVm8FMiSAjIE6RNlrjgxYatCP/czSgY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ZwdjxtMyLSc1vFLmryHzC6HyLefkMtf0FbDRkSNmGWTy63yDMS+hsfBm30dAPUPFf
	 jjoWq1w+RHmU/8dWoAuz8zqgcyiXhAx4A4NGGUfcwmqKxhkNDiEcLtLRzxVZnApnDu
	 sIPBAUM27CCfiGlDt5xuxfsysRje32c1+E+XSXETdvhMQ4IEeA+hhDdwRr2TZfO7mb
	 ordLpdn1ldkZfHftj1KnqxeJSpUR7duoCZCtv82sTMqIglxWynNUoHfTdMl7QtyJW9
	 EJgKCbjWNG9beviXgKvp8SUGYpMus3FJ+7+QXcsQSmdzJWVxhHKR2v+QGpvmfgxhjS
	 yu3GTnE37ruRg==
Message-ID: <942f4fa7-217b-4551-8215-3b1acf97a7ba@kernel.org>
Date: Fri, 29 Mar 2024 08:33:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 00/30] Zone write plugging
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <171166712406.796545.15002324421306835511.b4-ty@kernel.dk>
 <67a6eeea-253f-4568-b73d-aa05173cdb41@kernel.org>
 <0b15c2ad-71c0-4cc6-b00b-293966525a97@kernel.dk>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <0b15c2ad-71c0-4cc6-b00b-293966525a97@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_233330_433314_6DB0A991 
X-CRM114-Status: UNSURE (   9.38  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/29/24 08:27, Jens Axboe wrote:
> On 3/28/24 5:13 PM, Damien Le Moal wrote:
>> On 3/29/24 08:05, Jens Axboe wrote:
>>>
>>> On Thu, 28 Mar 2024 09:43:39 +0900, Damien Le Moal wrote:
>>>> The patch series introduces zone write plugging (ZWP) as the new
>>>> mechanism to control the ordering of writes to zoned block devices.
>>>> ZWP replaces zone write locking (ZWL) which is implemented only by
>>>> mq-deadline today. ZWP also allows emulating zone append operations
>>>> using regular writes for zoned devices that do not natively support this
>>>> operation (e.g. SMR HDDs). This patch series removes the scsi disk
>>>> driver and device mapper zone append emulation to use ZWP emulation.
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [01/30] block: Do not force full zone append completion in req_bio_endio()
>>>         commit: 55251fbdf0146c252ceff146a1bb145546f3e034
>>>
>>> Best regards,
>>
>> Thanks Jens. Will this also be in your block/for-next branch ?
>> Otherwise, the series will have a conflict in patch 3.
> 
> It'll go into 6.9, and I'll rebase the for-6.10/block branch once -rc2
> is out. That should take care of the dependency.

OK. Thanks. I will wait for next week to send out v4 then.

-- 
Damien Le Moal
Western Digital Research


