Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1258C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:30:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F0820784
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qTi9HVuJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DaNnHIMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F0820784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4GByTy1nvCN1GiMb7fkOvXXjeaw4GRqv1MFAm7Kg3Wg=; b=qTi9HVuJyGmm4u
	Fh9JTd8oUZq2JLmvZx8Z0VD+NzAethXa/E05CfFIZi++hgIjG95ZiUqe14ZVb+S4Wb0ai6+ph8lCE
	AtQfkZ/mHtF5yGrqArM0Zw16ibds2Ip9W0V1qLQNh8Klag3FsvuuY6jcmxaNFyLrqiGWmuuDVVsBo
	BXo3Lighkjo1sKFwbFQxUwA/x1OQ0sbmKCvs3/kYkhPjvxy3HEWK0HSwPzSl5ObR7zoVuBQygYTDU
	sLXT00lg8N087lLLIc2vp4tb89u+DD+9/WV6jhjA7gZTBtpLqfUFIGhfoRm1bAv5ryGEbCPY2CkUU
	d0EmwYuXd9KgQxjDHXnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJJmS-0004Cc-MY; Tue, 31 Mar 2020 16:30:24 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJJly-0001Vo-Sf
 for linux-nvme@bombadil.infradead.org; Tue, 31 Mar 2020 16:29:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=SKjKjglOdMnZPOrtuAe8O3llPBojIrALyuGOXq6aFDA=; b=DaNnHIMfWKnidKQjBFPhMfEmuG
 i1z5A/tLFOFa39Z43iMHa16SkIi6UcWaKA+e5r01MbIL2i9sLe/bDN9RPENY8Ro6KnxcNW7lT1AyE
 6qjdpkEQXt45yh8zClZReejTxLlVBy3b2Sx7vAftxBc7M12ArZZ5j7IiCH+Q4iClIgnWt5KvmelUM
 XM6ki5BPyLIKA4QaD2d+5OGCIUemk4U+uNrhHnKXEOAwPBWQjtG/2Ce/KVruPvu6y4FcmC+eFMQvH
 obB0j+1ZDq4iOjt4IP2k3l3IhsEIbwDAa2CUNO4qrONxfyJPNqpIm+3K1f/gyYIDK6Se2GlaIyocY
 Nw0KIGTg==;
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJITG-0004um-Tw
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 15:06:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0F0EF68BFE; Tue, 31 Mar 2020 17:06:27 +0200 (CEST)
Date: Tue, 31 Mar 2020 17:06:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v4 1/1] nvmet-rdma: use SRQ per completion vector
Message-ID: <20200331150626.GA20691@lst.de>
References: <20200326181512.58053-1-maxg@mellanox.com>
 <80ff5951-caad-1130-43d4-6239b9f6a143@grimberg.me>
 <6149129e-eacb-7b16-0540-13166dc10e8e@mellanox.com>
 <9ce666b9-d4c1-ecff-36e3-d20ea8e3fe0e@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9ce666b9-d4c1-ecff-36e3-d20ea8e3fe0e@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 shlomin@mellanox.com, jgg@mellanox.com, kbusch@kernel.org, hch@lst.de,
 bvanassche@acm.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 31, 2020 at 05:43:11PM +0300, Max Gurtovoy wrote:
> Hi Sagi/Christoph,
>
>>
>>
>>>
>>> Other than that, looks good Max,
>>>
>>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>>
> Can this be merged to 5.7 and we'll progress merging T10 support to 5.8 ?

This doesn't look like a bug fix to me, so I plan to queue it up for
5.8.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
