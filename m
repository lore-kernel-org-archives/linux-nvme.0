Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FD5C004D4
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 06:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q7J3VGAjCV3Vp98KtlGDxqDrYUoLy6GEBE9Y67ghQEs=; b=hH9Tgosi5+en5KX4f3AwsFJeRa
	GRVjrXT2/n3Hpu5A8sbvM2HOqDd2ks0IMN+eQpiwNg7uuHNnyNupfJOjGgbkw7PRxn5PsJYTohN7y
	XeltHPmjpUVG1OP4teO09yj1OeXs6ymMhC5LhAvLNZrqaQH8aZ7a9NM446JMqUnQoUY3a7jkL2LXj
	hDG3KGD7bR7ODRDz8VKOBJi3V893Ag+/CqP3xirb6Gqqjdr8vPJM4wJ2KmAmHTqCvXXfPCIyS5CGQ
	v2h74/j72jsqHRItRoon6ZVz1JazUoYe5v8NESfJ+VyOM2sVFwpMjT4xDDHbvgU9JU+SK1yUCnYL0
	WtEehT4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI2Eg-00H7qh-BY; Wed, 18 Jan 2023 06:47:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI2Ee-00H7qJ-Iq
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 06:47:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3D8B361698;
	Wed, 18 Jan 2023 06:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3876C433D2;
	Wed, 18 Jan 2023 06:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674024466;
	bh=+e8Tu1yzNoIuZRv3cfV5EujT7Y0Ki8eK75d8fyjGjYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=up1oXAKUJlDbL/vu1dR4uq8tknJjJA23u+OsMvEiOFOxbAVe+XYnvnejYPlUGbgDo
	 lyEe1ps9KO6JDBm4ID1AsIgfS2qHN/ICu64ZJQ5+oY3hEmnohorCfK4BCb4qFCFrjX
	 FjJwR91gNSiiwXNqo5HSvTS4Q3ZP6pVTv8xTy7oBt4rZdxU4nR1dgnvnJQ8V50TRQH
	 m3ajM+v+eAcHBgs/CxO7qx6Xs+6d8Be90kZ809xg6cvUXLVKCrBoFUx/Kh+dQ1bxCn
	 UPMPI6OL3LbjH/9q8wLMCa9nwbOXoqN35WN+81n52gI/+QQCatBVN06vsdwRFLsEj1
	 2zEWpihkxf+Nw==
Date: Tue, 17 Jan 2023 22:47:44 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Bryan Tan <bryantan@vmware.com>,
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
	Israel Rukshin <israelr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@fb.com>,
	Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vishnu Dasa <vdasa@vmware.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 00/13] Add RDMA inline crypto support
Message-ID: <Y8eWEPZahIFAfnoI@sol.localdomain>
References: <cover.1673873422.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1673873422.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_224748_743577_428FC75B 
X-CRM114-Status: GOOD (  22.99  )
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

Hi Leon,

On Mon, Jan 16, 2023 at 03:05:47PM +0200, Leon Romanovsky wrote:
> >From Israel,
> 
> The purpose of this patchset is to add support for inline
> encryption/decryption of the data at storage protocols like nvmf over
> RDMA (at a similar way like integrity is used via unique mkey).
> 
> This patchset adds support for plaintext keys. The patches were tested
> on BF-3 HW with fscrypt tool to test this feature, which showed reduce
> in CPU utilization when comparing at 64k or more IO size. The CPU utilization
> was improved by more than 50% comparing to the SW only solution at this case.
> 
> How to configure fscrypt to enable plaintext keys:
>  # mkfs.ext4 -O encrypt /dev/nvme0n1
>  # mount /dev/nvme0n1 /mnt/crypto -o inlinecrypt
>  # head -c 64 /dev/urandom > /tmp/master_key
>  # fscryptctl add_key /mnt/crypto/ < /tmp/master_key
>  # mkdir /mnt/crypto/test1
>  # fscryptctl set_policy 152c41b2ea39fa3d90ea06448456e7fb /mnt/crypto/test1
>    ** “152c41b2ea39fa3d90ea06448456e7fb” is the output of the
>       “fscryptctl add_key” command.
>  # echo foo > /mnt/crypto/test1/foo
> 
> Notes:
>  - At plaintext mode only, the user set a master key and the fscrypt
>    driver derived from it the DEK and the key identifier.
>  - 152c41b2ea39fa3d90ea06448456e7fb is the derived key identifier
>  - Only on the first IO, nvme-rdma gets a callback to load the derived DEK. 
> 
> There is no special configuration to support crypto at nvme modules.
> 
> Thanks

Very interesting work!  Can you Cc me on future versions?

I'm glad to see that this hardware allows all 16 IV bytes to be specified.

Does it also handle programming and evicting keys efficiently?

Also, just checking: have you tested that the ciphertext that this inline
encryption hardware produces is correct?  That's always super important to test.
There are xfstests that test for it, e.g. generic/582.  Another way to test it
is to just manually test whether encrypted files that were created when the
filesystem was mounted with '-o inlinecrypt' show the same contents when the
filesystem is *not* mounted with '-o inlinecrypt' (or vice versa).

- Eric

