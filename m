Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD71EC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 03:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gYA8TbA/2Ugidtah56dUhtBGGalu8/NG0wUScZCuyoQ=; b=hGWmuuvWgWkhkM19a8ZuB/103A
	+ddGJQjNQNqrWsRdT6nb5TgBIsshqPDEC+CAdk+eq9RyR0gM8C8Y7Svvv7Exvq0zBiiGZ4xS85xwx
	eY5Th5bKOKMprDpedM+tXCu1ZtYX9cnRq6yOw2BADId4xg4PmchT8NZbLQkKQLZvEKrDjj3mDDzN4
	ElxukrU3/jQE3dc3mr1KDXbXuIR2W4/WcGJkXTU8F03ex/jFobL9ccnSPOm6TVZcUnIcrG6OH/lzW
	CmsEF6r8XhyG3olDFvh6e0/zBw0BgZnmXhyVInim2AS8mzJNRbdVhS3v7XW1brOsw33V+Iet6Vp4w
	xluKLLhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHEyN-0000000AwGB-0yQj;
	Wed, 12 Jun 2024 03:48:31 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH7A3-00000009zkp-49Nf;
	Tue, 11 Jun 2024 19:28:05 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VzJc26ZdMzlgMVS;
	Tue, 11 Jun 2024 19:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718134074; x=1720726075; bh=gYA8TbA/2Ugidtah56dUhtBG
	Galu8/NG0wUScZCuyoQ=; b=EdKe51ZYqmfiPrpKkhPZ4ZF3PIbJwSbtn3RaaOF4
	ofhW5+7WMGPdWrsE2RMUMe4iOqCcKHfWsBE3jV1OI639Mq7dV1i23L3heMui5/1M
	qnw7wzx3me2m0nYbh4wIXdkzvzP1wJeBO9R+vxMKtan9+zubixL4PI1lPSTjLtQo
	fiVS5xI+5EIjbwxGLfn4YEaQCSjam9kUL6ZrBJ399SkJbGkj6meDfAJdNRLPTK4J
	cHr7uNkLCLE6LFJeypIVrgAn7huEmidRUea5q5IRH9I+kWNO+72D6ry2ZEj0M5Y2
	xKogQ+lj25MniDZvtXiYa8/diDPnTI2EYnDYd8bY8qFhAA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3RE5VBL2zIbE; Tue, 11 Jun 2024 19:27:54 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VzJbg1ZPszlgMVR;
	Tue, 11 Jun 2024 19:27:42 +0000 (UTC)
Message-ID: <ec31fd62-8a1d-44b2-8c0d-d6cca64f752e@acm.org>
Date: Tue, 11 Jun 2024 12:27:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/26] loop: regularize upgrading the lock size for direct
 I/O
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Richard Weinberger <richard@nod.at>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai3@huawei.com>, Vineeth Vijayan <vneethv@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20240611051929.513387-1-hch@lst.de>
 <20240611051929.513387-6-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240611051929.513387-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_122804_077131_D0DD5CA8 
X-CRM114-Status: UNSURE (   7.93  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 11 Jun 2024 20:48:17 -0700
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

On 6/10/24 10:19 PM, Christoph Hellwig wrote:
> The LOOP_CONFIGURE path automatically upgrades the block size to that
> of the underlying file for O_DIRECT file descriptors, but the
> LOOP_SET_BLOCK_SIZE path does not.  Fix this by lifting the code to
> pick the block size into common code.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

