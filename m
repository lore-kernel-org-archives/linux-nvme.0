Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A47606A31B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xDMh4DjL;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+0vJTPu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4ocOhL5uZh6M2c2ncBzha+9solA9N9a7VVVZB9JEhLk=; b=xDMh4DjLbu2+l2i+wLOVopTrdl
	q9vvNRfrOLzPcnt8vrDieNArY8j6oIndlkuqouR2dJzUAlLhVcS3yejvMUUnVYgtRk5o3V1oIA7xv
	QO3FD2ZZ5I+/Vn/A/bc9BSFa4iNzSDyinnFOwwayuyC69A3m6z4z8TI0SS0DcPlyhHCjpKVKKe85T
	KKhIIqxSvT0/DueLG97l3CCqvkYp9iaZk/VOp1+HGCfZZDbL2QU2j4mASAMAiD4xMxSzCgStSS5ak
	CTVdPdexJctHw10Jb2+UjpJke9w8csyKiv+END41apKc6r4mBjNAJhg7XYTVUCyDARKqJR3qunqzA
	RsRWECmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJerQ-0000000Cyzv-0NPU;
	Wed, 21 Oct 2026 22:32:40 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJerP-0000000Cyzk-2JSY
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 22:32:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AE11E60008;
	Wed, 21 Oct 2026 22:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D291F000C1;
	Wed, 21 Oct 2026 22:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792621958;
	bh=4ocOhL5uZh6M2c2ncBzha+9solA9N9a7VVVZB9JEhLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m+0vJTPuiPTOxjW766Mm+LxzSMrj3ERN3MES592krDnOu7EnySb4DpkA4L6hRbRzs
	 a5oznxPLIyNtEtBvJkdKAQeJuBXozAQ4ewC5aBsFoWiuaf/a4OyD6uu7QEpTsYtTdP
	 wZcd9mlWMN3/syeN+B98CKUVv2KYksqc3+gPtR+xl/ITaKD6ThcKsqiJpQTCvc4LL+
	 PqqVZ6Z9Fw8B8RC9zKcF2gcMfoxgE6yJVL3MiC23bkQmWVfrnHQ6IAhkTuoO6GTfpk
	 QrLPognGZW0uh+JrueE9CYaZFsJRmpYYU+cNfXcp66IHkw6aGD8pveOVLPR7RC79Et
	 4p2DHGNgRZwfw==
Date: Wed, 21 Oct 2026 16:32:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: fix use-after-free in
 nvmet_fc_ls_create_connection()
Message-ID: <atk9hM_hGHO8eHSn@kbusch-mbp>
References: <20261017153805.2528275-1-yhlee@isslab.korea.ac.kr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017153805.2528275-1-yhlee@isslab.korea.ac.kr>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 18, 2026 at 12:38:05AM +0900, Yehyeong Lee wrote:
> nvmet_fc_ls_create_connection() looks up the association with
> nvmet_fc_find_target_assoc(), which returns it with a reference held, and
> drops that reference as soon as the target queue has been allocated.
> iod->assoc is then dereferenced again by nvmet_fc_makeconnid() while
> building the connection id.

Thanks, applied to nvme-7.4.

