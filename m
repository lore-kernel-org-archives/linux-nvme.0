Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CFBC25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 24 May 2024 20:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=89lfuEma9nN+jYDLe/Yu26+hMarY1kIWqJc2bu+34j0=; b=dRaQ7gvc2yfn1THO/tYCxhoyT0
	fSBzhGQGNdcQJu4sTlQKEZrYT0pZ4/NVr1G+eYbUotZHfEpo7DhB4+2Wu5S4RDRtfU3vappOIdYGR
	551UCkuw+1dOiJgFZICBEUAmndgZ84345Of5eAU965veAqXPRP2lXZAmDCh3AobjfgphKAqZwaF4M
	R2pncft1sS+babSltn0Vn48lnGw/0TyQRAx0trexIubSBi1+F+3U7MCgfoM8SnGk66zOdmwJpStM0
	jI9CC00f5lQHEZDg6IgCW1jAmIUCPyqjklIMfNo/2bJC3pKwp/wkUKkO1nwwSovaQQTF0+lBnFX6K
	XBs0elnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAbc5-00000009oYi-28vL;
	Fri, 24 May 2024 20:34:05 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAbc2-00000009oXc-2HAc
	for linux-nvme@lists.infradead.org;
	Fri, 24 May 2024 20:34:04 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VmGwQ4PPNz6Cnk9V;
	Fri, 24 May 2024 20:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716582828; x=1719174829; bh=89lfuEma9nN+jYDLe/Yu26+h
	MarY1kIWqJc2bu+34j0=; b=M27wMpgpOKeNFIAKHVb8suAHfQt17wAx1wt9QoRm
	Nu/5Ed/S7hBQizyRp4kEdJtAe1OXTegKp0LVily/w/yqNA5af1r/IOtEm+Do5cli
	GjpGy8R80rvjzpvxfK8avBD5h8vt9GMJPTx0KXZDIEtytnIcbNxNaIy/aV67bLUu
	92p0S1cfx2fxEvK2F0qQDbmdTRK/6B2Ksd97L3xZZ77G8tq4ngIQ5UpkH+JULSMA
	1w5/OxmTDX1UXdo99vpNIqeHi81k2KrC9JTmdsFdbSvwihwhtXyZwUHyJaAYQpVa
	I7MpY8HfIJeUIkrhcXJBwXuth555oIdftO5h2Yxo484Ejg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9ySzBQtH-Jqr; Fri, 24 May 2024 20:33:48 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VmGw54jRCz6Cnk9B;
	Fri, 24 May 2024 20:33:41 +0000 (UTC)
Message-ID: <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
Date: Fri, 24 May 2024 13:33:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
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
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520102033.9361-3-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_133402_761213_939233C1 
X-CRM114-Status: GOOD (  14.73  )
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
> We add two new opcode REQ_OP_COPY_DST, REQ_OP_COPY_SRC.
> Since copy is a composite operation involving src and dst sectors/lba,
> each needs to be represented by a separate bio to make it compatible
> with device mapper.
> We expect caller to take a plug and send bio with destination information,
> followed by bio with source information.
> Once the dst bio arrives we form a request and wait for source
> bio. Upon arrival of source bio we merge these two bio's and send
> corresponding request down to device driver.
> Merging non copy offload bio is avoided by checking for copy specific
> opcodes in merge function.

In this patch I don't see any changes for blk_attempt_bio_merge(). Does
this mean that combining REQ_OP_COPY_DST and REQ_OP_COPY_SRC will never
happen if the QUEUE_FLAG_NOMERGES request queue flag has been set?

Can it happen that the REQ_NOMERGE flag is set by __bio_split_to_limits()
for REQ_OP_COPY_DST or REQ_OP_COPY_SRC bios? Will this happen if the
following condition is met?

dst_bio->nr_phys_segs + src_bio->nr_phys_segs > max_segments

Is it allowed to set REQ_PREFLUSH or REQ_FUA for REQ_OP_COPY_DST or
REQ_OP_COPY_SRC bios? I'm asking this because these flags disable merging.

 From include/linux/blk_types.h:

#define REQ_NOMERGE_FLAGS (REQ_NOMERGE | REQ_PREFLUSH | REQ_FUA)

Thanks,

Bart.

