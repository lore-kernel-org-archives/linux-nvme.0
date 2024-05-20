Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412C2C25B77
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 22:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ditZiWOn7hLJUcVL8ZGmOB5KFrac2puNeESvY7Sy76I=; b=GIs+pPK/M8QciKkLRCyNsd4aoE
	h9HyDEmtBDVU6ttvZva+XeTg1xlKDvmWa9P6jJEPz0qCqhE0mf8O47jgaJos/X0Mw324bshD6KIuO
	YbwsEcRhqis8p54Y0oAoIVbXce1EEqGrldpxNJ1GLKBNlO1KQvTL31dMQ9EAO3JW05GK1MfNIK+sq
	kChI0sCXSK8Usa89cJJHng+69SnHY8eo8iOrsMo17i/TDA5YY0mpozOd7+n16g2Cjz27LEdq6pYMI
	R2Z2uwwQ7kdMghH2g0LzOW9EQdQgV+sm9BMazP5IUR+2elvXc15cnDtQjNNlKVoaw7y8IDYZVO1vF
	ERrmE6Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Bts-0000000Fjla-1Ue1;
	Mon, 20 May 2024 22:54:36 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Bto-0000000FjkH-3HdB
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 22:54:34 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VjtDS1LFmz6Cnk8t;
	Mon, 20 May 2024 22:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716245664; x=1718837665; bh=ditZiWOn7hLJUcVL8ZGmOB5K
	Frac2puNeESvY7Sy76I=; b=N76ds2VdkoJmHd1jG09JVM0JcdkE4e8L/BR83/0u
	cH1cBSsqz73IdPb13CN2jkZ1TxKhGzjF7KpzQKYU4Jfzcf6sC/RDGQJ/BPLgh/mF
	UQ7mu0Rpcr8kINyu6mA3/XZL0KRNO/YLyH9Cqd8NNKmFVk9EAKPIz4PKqDyiljLs
	T6hX7k66/7ckCKqP+3Nd0t7czRyRhfDIjbCa2KoV+v6kmiY4bglg5iKxBJRJvy5V
	jBGqqWIweAoEnGOAcRt3yADoAdBj7+nghVxqqCh0rjL7BtrdX5VcA3Q9vfRLVXor
	3Tao430X8PGm+xlT0M2i6oao9GfyD6XGmA0vS5cLE1KzFg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hlmfe--IqVC7; Mon, 20 May 2024 22:54:24 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VjtD956Wjz6Cnk8s;
	Mon, 20 May 2024 22:54:17 +0000 (UTC)
Message-ID: <87f92553-04dc-48c9-be8b-f7fd4cd259b2@acm.org>
Date: Mon, 20 May 2024 15:54:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 00/12] Implement copy offload support
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
References: <CGME20240520102747epcas5p33497a911ca70c991e5da8e22c5d1336b@epcas5p3.samsung.com>
 <20240520102033.9361-1-nj.shetty@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_155432_978023_29F39692 
X-CRM114-Status: UNSURE (   6.93  )
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
> 4. This bio is merged with the request containing the destination info.

bios with different operation types must never be merged. From attempt_merge():

	if (req_op(req) != req_op(next))
		return NULL;

Thanks,

Bart.


