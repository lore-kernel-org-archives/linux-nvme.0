Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7128606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zX2UOfkb;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zl4gLEd0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zbMLBeO8YaZ7CmIsgiRZHC8PlVU0JzY8Du4DFL3FPRM=; b=zX2UOfkbud6QkkqNO78BHiOeBc
	vZoYoI0QnWpCvYFStGI3WTdm7QQUrEEzQfHg77J1h1LdW0VZJzH/FnJVYZSqHtgaTpfD4xjf8xddU
	hJX52ClVGpmc3mKHqbpl95ihQxfwVzDa1dm5TTtW2zodkA1SJLjiNAyH8tXCD7NAH1jY5fSVbLlk6
	Z7IKUGNHa6yDRHa1vcgkWcmxICHZPOX1pCm8B6EIl/irXRld8E8KLeYMvEZPAyEPWQg3/e6DKi8X0
	3x8vk8oQF9hgqZfe0uFzEeasE8ESfaU+vOUou7YmgJvjkfSs96/ljlrsMMjZRc32VG/pJW28qpRjm
	3vcJvhTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5i8-00000007PzK-1HNn;
	Wed, 28 Oct 2026 15:37:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5i6-00000007Pyq-0Kc8
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:37:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D2C6A4229D;
	Wed, 28 Oct 2026 15:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8AB1F01828;
	Wed, 28 Oct 2026 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793201825;
	bh=zbMLBeO8YaZ7CmIsgiRZHC8PlVU0JzY8Du4DFL3FPRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zl4gLEd03jzTt4UkM7tvIi8o3r4O2eHeg4OL8Vb76CzmUsTDKWIdrbNW7nkhAQELF
	 SO9jaG3c+qc17uOcKYza4Ldxs0UfHK1rqNy3eu6a8oXC0GalIY1EMZxC0A0x3FStkA
	 bBsmujB6B6vch/6S9BdU7xE3bzeOX4O8JVfEUzlpNOC9X9UUTvfRVdenw5Aa5jb+yn
	 KSI/uyXG1hz7jnliA4ba2kDlTVUIWMQkftawVaeEguXDFPB9puA0kociJjwapK1VhO
	 KUsGY3kM/zJ16EKf2BP7O0pt2YwnZskeFO+N/vY/BzM4fb12ao5/Q8dLFRg9B5sCHl
	 RFJW00dpX4kYQ==
Date: Wed, 28 Oct 2026 09:37:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: bestswngs@gmail.com
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, xmei5@asu.edu,
	stable@vger.kernel.org, co+e015e82956da641b@bugs.sh
Subject: Re: [PATCH nvme] nvmet-rdma: reject short connection requests
Message-ID: <auIWoGsLbOAXPekV@kbusch-mbp>
References: <20261016172336.286341-3-bestswngs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016172336.286341-3-bestswngs@gmail.com>
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

On Fri, Oct 16, 2026 at 10:23:38AM -0700, bestswngs@gmail.com wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> nvmet_rdma_parse_cm_connect_req() treats RDMA-CM private data as a
> struct nvme_rdma_cm_req but accepts any nonzero private_data_len.  The
> iWARP path allocates exactly the peer-provided length, so a six-byte MPA
> request reaches the parser and the hsqsize load reads two bytes past the
> allocation.

Thanks, applied to nvme-7.4.

The sashiko complaint does not look related to this patch and can be
addressed separately.

