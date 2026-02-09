Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109A3E81BD3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 17:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wWRw45vxPzMf6IUhlILMEm7Zh4ZyPMbWLX+8yExKoms=; b=Gt3LN/9jj46GQg2JgKgn3UyP0E
	BvGPclczADPd1ly7HUIpa4YX18FTBY37JKdiYZYrpM7o5knPRTfM0vVdmgxZkvmOrxyJW+7to3yNq
	MwVEftOd75OafthQpk5gJvaxat5rDisboA34xFjV07ZBOjBskGhY6uPEQk11OFVzsKEgju6yw3xAs
	m9X0RBS0kLFHpr9irTThdAndlabDlBSP3KlfSXr73OwEm5oVC1z2ItV+P0nD3ORoSVwk9Jo8xsLVu
	KPfyqX70yt80Wjap1zGMzBw09coNeRhXcRbWcgjPdRtOknEWYvM64hwA8HmkKvZK89g30sxppkCt6
	x4lTo3Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpVQd-0000000FnoP-00GO;
	Mon, 09 Feb 2026 17:52:07 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpVQZ-0000000Fnns-2340;
	Mon, 09 Feb 2026 17:52:04 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4f8shf57YhzlfjRv;
	Mon,  9 Feb 2026 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770659519; x=1773251520; bh=wWRw45vxPzMf6IUhlILMEm7Z
	h4ZyPMbWLX+8yExKoms=; b=nP4ebFiQQ+2ePiCZoz4k648cjcCDTBFzscyxKGIn
	7b3wEZiVYGWZxiPLtNJ1UL/6bcRmGZbbHqY1WKp4rN0wrTg1uHy3tVV/gE6qjk5G
	UOD2vJFwRLVUcnS6oETEE5cp7e0hVKxLzGfXcgWHH+mW8HdlywkrO95VhDWhHm37
	4nL0KlB2K1irwnzrgipoTFRGaBql2aGnkJJ7EECoaSVwmUMR/JaUEoXLlY2jXCYE
	jQF4PjrRZXveqvZ3b3iP/+qgYrAAMWXiFM9C0KmCuXzdiKJcDoY4o5M6KbscGm/r
	jtI2RWcxUXMmmHfoDcj3+FLDel7wRkpGE8t7E9VDcKScOA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id toXWEeWDQ0M2; Mon,  9 Feb 2026 17:51:59 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4f8shX1QN1zlfdCr;
	Mon,  9 Feb 2026 17:51:55 +0000 (UTC)
Message-ID: <b2069052-ac7d-46f6-bdd5-a96533144f9c@acm.org>
Date: Mon, 9 Feb 2026 09:51:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] blk-mq: use blk_queue_enter/exit to protect debugfs
 file creation
To: Keith Busch <kbusch@kernel.org>
Cc: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, sven@kernel.org, j@jannau.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, tj@kernel.org,
 nilay@linux.ibm.com, ming.lei@redhat.com, neal@gompa.dev,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-5-yukuai@fnnas.com>
 <6b18e0bc-efa7-4bd5-b12b-a313941d2ba1@acm.org> <aYoaWwI-sl5hK6s_@kbusch-mbp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aYoaWwI-sl5hK6s_@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_095203_563699_F160F612 
X-CRM114-Status: UNSURE (   8.13  )
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

On 2/9/26 9:33 AM, Keith Busch wrote:
> I had to look up the original commit that introduced the WARN,
> 65d466b629847. The commit message says "Creating new debugfs entries can
> trigger fs reclaim", so that must be the path that enters back into the
> block layer request_queue.

Thanks Keith. It's probably a good idea to integrate this information in
the source code comment above the blk_queue_enter() call.

Bart.

