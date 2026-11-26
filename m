Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9405D606A336
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yw1/SjLb;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YxL/fGey
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=44+itDmYdIDZq1m1y3tMLBmpTy1usswVb9CLkDorUXk=; b=yw1/SjLbYlwSUJXTrXhTAgwmhj
	JE/5RcG9RCFlhQayFUsS3nITAA2/9CoePQkE/D2DT3AWw+L4jVrDP0uj6D4Y78BoEtowdGRIn5kjL
	KDQ9pB9QqSK4F4TgD5kxvvVjXopwS1QHbxZXFrvkD8kACTd7vH1HmbLFecxehelCPAJEqKhx92624
	ZW4qpBsexMF0d3MRbYHwkDHaq2rMcaxCHNdI1wgrjgvhxj1NnDO3M5k9Yiyz0ztzvd95rw1yj9xUh
	3XBnm5nXqUJr1p7kwZumMDfe/ri4TbbXZ3zKl9kbnrMOdru+ElK4wz9597lRTRG+w9/o3eiQ486xA
	bqQnoA5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWbwQ-0000000DqYk-11mq;
	Thu, 26 Nov 2026 16:03:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWbwP-0000000DqXp-1Tw4
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 16:03:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id C698A601EC;
	Thu, 26 Nov 2026 16:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B7D4F1F000D3;
	Thu, 26 Nov 2026 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795709000;
	bh=44+itDmYdIDZq1m1y3tMLBmpTy1usswVb9CLkDorUXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YxL/fGeyNanXqI/SWB0bmXra+66k/Y0eoThFxEuDWTtG8VnilgB9tDBnRVSh5ro12
	 tb3FWEhuSM9OkwEMaj0sUhydCFW4+f9dGYKjWmx6rSl4xVZ/Dx0BKas1TwpxKrNckr
	 Q5Q2jHqElBcmlvugK9UnGuv5aMiknonIwrvtaNayD+Z9sHM0eOCeIriEfGe2nxMI9M
	 zebQYYTRXidZQSVdQLOeUC01YN0vxf7yvgxGkY51Q7fUae2caL65IS688YWbQVaLGw
	 DwO3rCLnvnfQpLa8zeAf/Hyd8dIwPtJviclkObHpHTpAjBm0HZtIQbqpk0pydj5pzc
	 jDisSJIyHwVkA==
Date: Thu, 26 Nov 2026 18:03:16 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Eric Biggers <ebiggers@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Martin Belanger <martin.nvme.dev@gmail.com>
Subject: Re: [PATCH v7 00/14] nvme-auth: switch to use the kernel keyring
Message-ID: <awhYRJ3mktQEcQOQ@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <awhXg41rBQL982qk@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awhXg41rBQL982qk@kernel.org>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 06:00:08PM +0200, Jarkko Sakkinen wrote:
> Without looking into detail to the changes, it'd be best if key type
> semantics would align with [1]. See the preparation patches for other
> subsystems.
> 
> I'll send updated patch set after v7.5 merge window. The only reason
> I'm not moving forward sooner is to gather as many bug fixes as
> possible for the "previous world", which LLM bots kindly provide.
> 
> Otherwise, this needs to be refactored very soon after the patch set is
> merged.
> 
> [1] https://lore.kernel.org/keyrings/20261112040242.247168-1-jarkko@kernel.org/

I'm not saying that this could not be merged first or try to put that
type of causality in place. The point is that it would be best if this
was prepared as size-fit as possible with best effort.

See e.g., S390 changes in the patch set above to see most complicated
upgrade.

Br, Jarkko

