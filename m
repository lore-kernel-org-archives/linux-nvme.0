Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B84AC4361B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 02:01:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF83923E23
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 02:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF83923E23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ShEGCClaRj8nF4JUIRKaSioNemnQusNzICg4u3WBIrc=; b=Vg3FPTJdDa/NjTHgA5v1zK0xl
	RHHoFpmSeVOZqT/kmhTPWhBrffPV0oRK5YI2tJAZ5UVzrd0of6Xb7W7BbpmKFVh7nbu0iYhWnWi2z
	HkocDzx9a6hk8M6Ijrc6dPG4nQ0t2qCJOggIOe7/0UZ4OfWYZs0DHTA7GAmMCS8AKy+m9LguDT7YT
	PiC/LKcih+/x68XayAaKl7TjFrA8iNLGPaLX7gSEU+/3ppm2GJfLIwX8VdYqNfz6HGsdkK0WgAZh/
	gLQwwKMr8Vgqr9ZNj/yv4SmCr/da5aUc6M79WG3gAzcUYQwXsi6zw6aJawDeY/2t3AbYwyY+Uu4fR
	VAHhKZxsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knXkB-00059H-AB; Fri, 11 Dec 2020 02:01:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knXk7-00058l-NS
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 02:01:12 +0000
Date: Thu, 10 Dec 2020 18:01:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607652070;
 bh=U3G+zi7pmaYGKuSH8xCXbxcIkSxlzauUGmc+rVx93Kc=;
 h=From:To:Cc:Subject:In-Reply-To:References:From;
 b=jU1hEJtdDilAgpRuotPOe5kC6RiSjucat+/ZOh8js0NC2U58tJ57d77obbN0CK3Fd
 eEq3hsegQcNn3dL46R4fesrcCziiB4gXybrFOgvVldlFmrqf3318EQhK7XSHFnSt3e
 rwnY4eJHpQwCtaU/vtJqvl6mU2efLX99NxH6PaXAndxsYjZZFTE4SykYIzsLlWJbJ7
 Dq1zYme95OODaaLuH+d9StH0FdpN9Th5E1g642p09gro4/+Svh+iQ7mbMS4zsOby7c
 qIprwoxYuBFG/YojcP05pEU4T8PIT66Llhrz26qnd00MQEKup1fbppXWTbHOnd0gsg
 FLEN1bfid9OPg==
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH v1 net-next 02/15] net: Introduce direct data placement
 tcp offload
Message-ID: <20201210180108.3eb24f2b@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <921a110f-60fa-a711-d386-39eeca52199f@gmail.com>
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-3-borisp@mellanox.com>
 <6f48fa5d-465c-5c38-ea45-704e86ba808b@gmail.com>
 <f52a99d2-03a4-6e9f-603e-feba4aad0512@gmail.com>
 <65dc5bba-13e6-110a-ddae-3d0c260aa875@gmail.com>
 <ab298844-c95e-43e6-b4bb-fe5ce78655d8@gmail.com>
 <921a110f-60fa-a711-d386-39eeca52199f@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_210112_004564_581FD436 
X-CRM114-Status: GOOD (  13.18  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Yoray Zack <yorayz@mellanox.com>, sagi@grimberg.me, yorayz@nvidia.com,
 Boris Pismenny <borisp@nvidia.com>, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, edumazet@google.com,
 linux-nvme@lists.infradead.org, davem@davemloft.net, axboe@fb.com,
 Boris Pismenny <borispismenny@gmail.com>, ogerlitz@nvidia.com,
 viro@zeniv.linux.org.uk, netdev@vger.kernel.org, kbusch@kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, benishay@nvidia.com, saeedm@nvidia.com,
 hch@lst.de, Boris Pismenny <borisp@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 9 Dec 2020 21:26:05 -0700 David Ahern wrote:
> Yes, TCP is a byte stream, so the packets could very well show up like this:
> 
>  +--------------+---------+-----------+---------+--------+-----+
>  | data - seg 1 | PDU hdr | prev data | TCP hdr | IP hdr | eth |
>  +--------------+---------+-----------+---------+--------+-----+
>  +-----------------------------------+---------+--------+-----+
>  |     payload - seg 2               | TCP hdr | IP hdr | eth |
>  +-----------------------------------+---------+--------+-----+
>  +-------- +-------------------------+---------+--------+-----+
>  | PDU hdr |    payload - seg 3      | TCP hdr | IP hdr | eth |
>  +---------+-------------------------+---------+--------+-----+
> 
> If your hardware can extract the NVMe payload into a targeted SGL like
> you want in this set, then it has some logic for parsing headers and
> "snapping" an SGL to a new element. ie., it already knows 'prev data'
> goes with the in-progress PDU, sees more data, recognizes a new PDU
> header and a new payload. That means it already has to handle a
> 'snap-to-PDU' style argument where the end of the payload closes out an
> SGL element and the next PDU hdr starts in a new SGL element (ie., 'prev
> data' closes out sgl[i], and the next PDU hdr starts sgl[i+1]). So in
> this case, you want 'snap-to-PDU' but that could just as easily be 'no
> snap at all', just a byte stream and filling an SGL after the protocol
> headers.

This 'snap-to-PDU' requirement is something that I don't understand
with the current TCP zero copy. In case of, say, a storage application
which wants to send some headers (whatever RPC info, block number,
etc.) and then a 4k block of data - how does the RX side get just the
4k block a into a page so it can zero copy it out to its storage device?

Per-connection state in the NIC, and FW parsing headers is one way,
but I wonder how this record split problem is best resolved generically.
Perhaps by passing hints in the headers somehow?

Sorry for the slight off-topic :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
