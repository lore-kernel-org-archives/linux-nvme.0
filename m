Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF94606A333
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3iagspkH;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QmtNw7xh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=G9VfqJ+XWxAllnzsArSXxWjkRCkNU1/oIdgGJDZxQ9k=; b=3iagspkHUfC0u8S1SvoadCmtAg
	Nxh9sHUQSWkS05TvUzpxn0KWig547Qu6Q+z3b0Zaoeb1w4u1Brrp6O24UDqWs0ESDvYOMos29M8Ua
	xS8cTD2egFxcV2c9JtE2IsXnBdAldvp/paIVUZ911admh3xTR+8KPotyl1tzLfi2rxJ8S5/JvIb8R
	VYO/Xq0bIwsQKp46bnrKs7bWWxYl6QOnSOYcnbVLArB+zTnWJehGL2PuTyoWp+8OvsYzKsNjLwR2Y
	ErT0FYgwPZip08clAIPJkLUbdR0Bwm2c8pq/j2LNNazI39y3YnoF/QsUuCn46FpSTTNL6RUOLdMJm
	6QoQkCiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGaI-00000002zZH-2SDk;
	Tue, 03 Nov 2026 15:38:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGaH-00000002zYx-0gLA
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 15:38:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D7FF043B2C;
	Tue,  3 Nov 2026 15:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700F61F00A16;
	Tue,  3 Nov 2026 15:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720280;
	bh=G9VfqJ+XWxAllnzsArSXxWjkRCkNU1/oIdgGJDZxQ9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QmtNw7xhhFhysqUAkJpDFKbVFSlf8bi818bztC2CU7CpAU/i/geKicJEnbVqte2Y4
	 g8lejir/gP+wrhVUP7qnSVw2RbSVwnK6MQaZGA8sHep7Il4bDCSQdoolk+XGfat+5I
	 2QGp1Y2mflcbb4CzlLIuUhHMsWflfMYWXMM47O9Y02EghmjdohHuUIFBiCOLjNqSOQ
	 MlJ8Bc/iPR5WKuuip0t2mVuMGjgjwzwRnleVErSnlttocCVlMnvNCHzw45dIp2deGz
	 P9/StyaLgPhXjMrFgD1BZwBudz6Bzmg69ToyNSDpn1yucX7MZ00Ax6zx5JpmloCgpa
	 J5RUPLaakSigg==
Date: Tue, 3 Nov 2026 08:37:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Cc: hare@suse.de, hch@lst.de, kch@nvidia.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH v2] nvmet: use appropriate types for authentication
 payload lengths
Message-ID: <aun_15SXOxpzPZXT@kbusch-mbp>
References: <20261031075932.4345-1-sreekuttan2156239@gmail.com>
 <20261031081751.4583-1-sreekuttan2156239@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031081751.4583-1-sreekuttan2156239@gmail.com>
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

On Sat, Oct 31, 2026 at 08:17:51AM +0000, Sreeraj S Kurup wrote:
> The authentication payload length is obtained as a u32 value from the
> NVMe command, but nvmet_auth_challenge() and nvmet_auth_success1()
> accept it as a signed int.
> 
> Use u32 for the payload length parameters in both functions to keep
> their types consistent with the value returned by
> nvmet_auth_receive_data_len() and avoid an unnecessary conversion
> from unsigned to signed.
> 
> Also, use size_t for data_size in nvmet_auth_challenge(), since the
> calculation includes sizeof(), which returns size_t. This avoids
> implicitly narrowing the calculated payload size to int.
> 
> These changes make the payload length handling consistent with the
> underlying types and avoid potential signedness and narrowing issues.

Thanks, applied to nvme-7.4.

