Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAE1C47DAF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GQvvkex27Kab9JJEcmamoqa2rRt5dZYjQNBRxRqEusY=; b=zjgvxGJL/pyKJYYVD0iOm9HZUJ
	yXYvtkqSSB66dGb/fCldyRUANq2LMtGG4s+BuMHlCBRZj86E0ofSJYVyU2mYkM36uURLyz/cXiG5K
	wmBEhYU5A/poovODbO7fSXLq8GQ5vuSZYoR5xgob7Rqyvx0sDP5ORvyF3f54UtLtz5Hz2JRC1uGBv
	btZm7cHRXf6DPRWE0qTOp/upke6mxxctyqD73SvnTmI/P8XnvOUeko4v6uQElqwQlIp63qMFJxDPG
	G3ZzfWqHndSapJSlg+IdRJhiNddBs7rOBJId3/r+8cvAKNheiWKAdfQx8K+Mf1wwsN/wnoRk439WS
	QyKougDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRx3T-00Cvl1-16;
	Mon, 22 Jan 2024 16:21:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRx3S-00CvkL-1Z
	for linux-nvme@bombadil.infradead.org;
	Mon, 22 Jan 2024 16:21:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=GQvvkex27Kab9JJEcmamoqa2rRt5dZYjQNBRxRqEusY=; b=nbaW6abSvImowTmopTrPNDcZNJ
	pK47TPAVzxlHNoJG4KTMO50NGPxvMV1uANj1Wvcn3MGLZ5beIYIWVbnC4/txzZ2QbvgAiC9klb8hC
	ef6Doy9VRzNZYJhk8cUxwr6aSukeppiYiELa+s+/g7Z2K6xJrnDGovJLaxLC9F856rziA5aTgVsF4
	nPXcBk7svHT0iXXc1WMm0FfCpe77UZytcRcJqD/gxKC08OA6YKZHCexTrh8rElB1uysikpMqAISSv
	ZkGLs+ng3/hmOToBzXsB70bCnQMmRz9Y93rYEtYHY+LFN7ApqhTfVZ5d06kF4wQF73eHgw5WXFOAA
	3JVbMv9A==;
Received: from 46-117-114-124.bb.netvision.net.il ([46.117.114.124] helo=[10.100.102.14])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRx3P-00000000ODu-2mED
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 16:21:45 +0000
Message-ID: <088abd29-0f01-49f7-ac6f-d9ce138be9fb@grimberg.me>
Date: Mon, 22 Jan 2024 18:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Test
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
References: <20240122154712.1235940-1-sagi@grimberg.me>
Content-Language: en-US
In-Reply-To: <20240122154712.1235940-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 1/22/24 17:47, Sagi Grimberg wrote:
> Test test test
> 

test test test2

