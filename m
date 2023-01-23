Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5619C54EAA
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 22:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3gwL+6PjAZ565HqhC72kb/Vc812ULcX6FAQUsIH90B4=; b=Dd4CGau81XFc5kZgK6tzgFu/HU
	KpNf9PNIGfbnJxhcbLnX2F+hKT04y/YkPXZnVQcl5ovJkcJ/zHZBDyMQdYospuyDt7X6dM/gp4jA0
	9PWblZgcTfzzwXXcIAHBzGVnFIus/HaBDvr9rWng3iipUJm4vWxcA80CmTGVApN3uJLjspVMeSYFP
	9ikYA/njGCLUzzkO5hoi7QemV9MW+lMsphnFupjTuQV50cXZMl8pNs0OxMXjIJriBuin7ycsL4t//
	h8nKvCqbe0u+QVJenHsgLVqzE0ITam55qsYAGua/pGEaeYgVVYPjlf4QwvhS9iMh3k9bNl0EXH28M
	/DEaNXZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK5N7-001izj-Q3; Mon, 23 Jan 2023 22:33:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK5N4-001izC-JQ
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 22:32:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ED6696116E;
	Mon, 23 Jan 2023 22:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D6AC433D2;
	Mon, 23 Jan 2023 22:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674513177;
	bh=ce3Fi87oaRT9h+fNOdiAr/ICmhsILZ9XDh7dtWnGVwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jlXmLEiKJE1xHRWHjjmK+s9aPtkgvvj/s51G4/BZDzF2eIbGaf7U9xsbP3zI81UoP
	 pORcl0HEMxDZM9INaStz8qmyFCysBscs6WaUqJIw583RtzqHv9uAp+8GCvWlFu3OXc
	 kV3pmP+4rshC/wS3H7OKeYfrNnvTtxo0kS/QQi+2LbhcrZFghydH7fh9ATsWNP+EzG
	 TBzoljJ0sgT7nRACi31PEjKXhWi2r4fAwu/JTLxZnMwLXC6C98J8vjhhVOLvK93tGL
	 5JmxbM4VIkd0y+MvIr81V7EtkYO49tNuPI7vMc6G7rFf3XjOW+xAmBDj651qQytarw
	 e9WyxFDdnVpag==
Date: Mon, 23 Jan 2023 14:32:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com
Subject: Re: [PATCH v9 02/25] net/ethtool: add new stringset
 ETH_SS_ULP_DDP_{CAPS,STATS}
Message-ID: <20230123143256.0666646d@kernel.org>
In-Reply-To: <253r0vlrtld.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
References: <20230117153535.1945554-1-aaptel@nvidia.com>
	<20230117153535.1945554-3-aaptel@nvidia.com>
	<20230119183646.0c85ac52@kernel.org>
	<253r0vlrtld.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_143258_704144_D3CDAB86 
X-CRM114-Status: GOOD (  12.44  )
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

On Mon, 23 Jan 2023 20:31:10 +0200 Aurelien Aptel wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> > This should be in uAPI and used as attribute IDs.  
> 
> Following the discussion from [1] ("you can add the dynamic string set
> if you like.") we deliberately did not expose the enum to userspace so
> that ethtool doesn't have to be updated or recompiled to list newer
> kernel ULP DDP statistics.
> 
> Should we change this approach?
> 
> 1: https://lore.kernel.org/netdev/20230111204644.040d0a9d@kernel.org/

Not at all, but the names are really mostly for human consumption.
If any programmer wants to use the stats (and assuming they use C/C++)
it will be more convenient for them to use attribute ids from the enum.
Without having to resolve them using stat names.

This is how other stats are implemented in ethtool-netlink.

