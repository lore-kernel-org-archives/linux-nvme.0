Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CD5C25B77
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 23:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ijJgz4CBGLhb/HVy0yww/S8sCF0i5ebWHafePyrDQfQ=; b=useuopj1G0UJh+Y06ivI313Ebf
	GWqYoICGWqQRaj8pFq2ld+LH5s//zZ78dolr01rDaipzU7mQTS64ESdSfSR7UHa05+bSxP5M+nzt8
	Zl3hWEtaoqq3qUOfWsPGHMq0QH28prYnt9N3xMG1hHqBQJEGy+0VZ8eJiIoPcthkNu/7jhNCHkeEf
	xNthr9P/3TmTCNQwoSuELT7hRt0WGMlqWhlfXEDHXhRDHQQHTu/XDBKe/HOUWAQ3TgWjQ9Jh+Q3De
	edhfbw38YRrY6RFLcg5z1w+LoTl8hqorivFVBnSj1C4xi9sYmMWwaGtl2GFy3SyE1KiNzOWsgwbMy
	s77w2THg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9CNd-0000000FnFn-20O3;
	Mon, 20 May 2024 23:25:21 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9CNa-0000000FnEh-1dqT
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 23:25:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vjtvx5QCMz6Cnk8t;
	Mon, 20 May 2024 23:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716247511; x=1718839512; bh=ijJgz4CBGLhb/HVy0yww/S8s
	CF0i5ebWHafePyrDQfQ=; b=1/EwDtHV0WPmqtf8mplzj1czPHU6HOd2g2nDQaoh
	J166e8sXbsEPka3Wveo2nm0+5su3HFv//Qve0LRX9/AHRWrDeFlAqfmcFr/37feT
	NHzJVUf9VZxQE76xUSi0cEaT9pmXVrXbTKuc1Lwh5wTk3CX9LuuCE8CSSkpoVVpt
	BhrLRwGJ1cig5Jr6kZixW2G72zykgYIPibiIFxmsk6lcvlqUAENMezqYJ+OfAUxp
	FYtzfptMZcNSFCbbQD2xbhDLRNyYeRlcp7MQ/nw5ORwEv4qSGgjWTtRtn8zXFra0
	0GdpBdqmsAh/XgGsKgSiovwE+jMaenvMaMg4dc2gL4DNRQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id q3O6tu1vG9Fr; Mon, 20 May 2024 23:25:11 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Vjtvh4pRCz6Cnk8s;
	Mon, 20 May 2024 23:25:04 +0000 (UTC)
Message-ID: <017a9853-6e42-4250-9cfa-1d6ad5786556@acm.org>
Date: Mon, 20 May 2024 16:25:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 10/12] dm: Enable copy offload for dm-linear target
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520103016epcas5p31b9a0f3637959626d49763609ebda6ef@epcas5p3.samsung.com>
 <20240520102033.9361-11-nj.shetty@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520102033.9361-11-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_162519_079896_F766D360 
X-CRM114-Status: UNSURE (   8.15  )
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

On 5/20/24 03:20, Nitesh Shetty wrote:
> Setting copy_offload_supported flag to enable offload.

I think that the description of this patch should explain why it is safe
to set the 'copy_offload_supported' flag for the dm-linear driver.

Thanks,

Bart.


