Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B91C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 16:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AeMpN3/HkoGEKgWkazauMmOVV7MorD6M70jE/QLwyw0=; b=HIja0/TqMDC3qKA2tyStUmOuB/
	QyObMf099u2d5RKBx0oGqGz0kHNpMnX8IaVcSYvQYM7RlNX0544ndvEMPeaSVmnD4YzoH900PmbMM
	1H0Y5a9mOaSvEIoJ2Nz1EF+5tSQA7vI3DxSBlZG8TwRi4HFJh79r/X4JA0Pg0D457cmJUj5f5Zt7P
	M8tUAs4gL7XrZ8nq5xOEExuZI2x/81rvMU0TaKnUuRV5F67nrogO7cZZDSYWNxGqYNOl0WnZk+Cy5
	ILWTY85fFLxDOGb5RrVJJrOVH6tA3Jld7fHtuslVu6ds42/69QQXdzgFmhJzL7Q3g076cBSeBo3iS
	iqAMx0bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEtOJ-00000006psW-0YAg;
	Wed, 05 Jun 2024 16:21:35 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEtOF-00000006prH-0YVY
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 16:21:32 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VvXlY2Rxnz6Cnv3g;
	Wed,  5 Jun 2024 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717604483; x=1720196484; bh=AeMpN3/HkoGEKgWkazauMmOV
	V7MorD6M70jE/QLwyw0=; b=rPUEUzoZ8+KtwYmYeN7KvwPdY7EOKVynTJK+fuWF
	LaoU5ckjwgRby7kkTKgtKGUiYtVXK9rzxp6GB511AEqNulgxggxdZMkeTTwYWWMx
	s2kwIsnrH87QkEJ+c61r1M955VRxUd5y2xd0Es7OHNE4aQqofgTswIyrpXr2lPsW
	YCBC0snf+ZTwbKYZ6Nx+Swm7H0hiRiOswF6eJPfxPJ9dz/NhAa+A5SOn5VOz7Nc6
	GMmdcIhYn9MUJxRjiLNBiLczbPgsvE3xc8+Q+HJys0PH0GG2UCiWUKmHGmsh2M6I
	FG0Uc9LLYrF0wAMHTKzSNfedf63LMKcqNRtvJHe9pcgUdQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id LdQe7KTkFscU; Wed,  5 Jun 2024 16:21:23 +0000 (UTC)
Received: from [192.168.132.235] (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VvXlM2TnXz6Cnv3Q;
	Wed,  5 Jun 2024 16:21:19 +0000 (UTC)
Message-ID: <2a4ce522-bdc0-41b9-b601-6e001719121b@acm.org>
Date: Wed, 5 Jun 2024 10:21:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] block: remove the BIP_IP_CHECKSUM flag
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240605063031.3286655-1-hch@lst.de>
 <20240605063031.3286655-4-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240605063031.3286655-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_092131_323181_196C5155 
X-CRM114-Status: UNSURE (   7.35  )
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

On 6/5/24 00:28, Christoph Hellwig wrote:
> Remove the BIP_IP_CHECKSUM as sd can just look at the per-disk
> checksum type instead.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

