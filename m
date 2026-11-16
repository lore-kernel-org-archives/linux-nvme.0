Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C036A606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ml9s4ZZF;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLudT9G/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=R4DtCUdjl2uA3sgFINroQ/qu4hVFi5SvYSZI2MDVAVo=; b=ml9s4ZZFt2rLKGQi6vF7QKFgsk
	NsOBWhK9DdzW2ci8kyux1UShOe3Bq6EZ8q7PpLkCa2kOWPanjVXQKA/2yoJc1DfYNk1dr5RtjbcPP
	d1DorxEZOfQHzG3wb7xnYrMp/rv99ufeUDtRsIZV3G/Fzm5PqDq16LhDtIT6gSaQFiwpVyl4NJOAT
	gAUqB6w4fGVD9z5+Hh0MXquQBi8Xox6F8q6FMgkNaTYdDAmUGMzR7lyl52lzCd9N5sbiQmMo9gHK/
	T+RqlypacUXog++uIpoOZQI/+oF7nXUgR52AMcqX67RjXYf4UFjBqFwqep1pl3oN14pk5CiFEzC5B
	uHyPcrCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xStiw-00000001vXc-0CDU;
	Mon, 16 Nov 2026 10:14:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xStiu-00000001vXR-3dMO
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 10:14:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CD15860E23;
	Mon, 16 Nov 2026 10:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9AB1F000C4;
	Mon, 16 Nov 2026 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824043;
	bh=R4DtCUdjl2uA3sgFINroQ/qu4hVFi5SvYSZI2MDVAVo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XLudT9G/xec6NfJcbJMVi9mjMJt74TNzRXlk3A8BP3bu6xlrjwGC+8sA6ex4zND9J
	 0clUbBncpISOepNj8s+Kefxb1b50fowd7Q/hnSEjgCAW89RYliUkK1rfWp4UuK5QeU
	 RM3uEGrbhsT0OOcEMKSLY4Zqj1ZDOKBD7FPHb0KexpCoEOdhhaO6avNPDdr6uZp5Yl
	 o82lUQLf+GgC/oXvnM1yvJTfJMwWXhYFhg0reTTLlwCczJKkZLCizBJwYQysL0YVwL
	 2Pbal1S5S0ee54b89WP3xwcrp2FiYdbRUqRgdtLpCbHzcV8SUzvrYniF80Rpdf4R89
	 rZxOu8/PBLPNQ==
Message-ID: <sashiko-outbox-216698@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] nvme-sysfs: use kfree_sensitive() for DH-HMAC-CHAP
 secrets
To: "Martin George" <martinus.gpy@gmail.com>, linux-nvme@lists.infradead.org
In-Reply-To: <20261116100244.7824-2-marting@netapp.com>
References: <20261116100244.7824-1-marting@netapp.com>
 <20261116100244.7824-2-marting@netapp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:14:02 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] nvme: double-free and use-after-free in
  nvme_ctrl_dhchap_secret_store() [1]
--

commit 86ec9e603dccdb522db4b07402c30b2c18b2a11b
Author: Martin George <martinus.gpy@gmail.com>

nvme-sysfs: use kfree_sensitive() for DH-HMAC-CHAP secrets

This commit replaces kfree() with kfree_sensitive() when freeing DH-HMAC-CH=
AP
secret strings in dhchap_secret_store() and dhchap_ctrl_secret_store().

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 10018c6356b62..5a195b8971f21 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -849,10 +849,10 @@ static ssize_t dhchap_secret_store(struct device *d=
ev,
> =20
>  		ret =3D nvme_auth_parse_key(dhchap_secret, &key);
>  		if (ret) {
> -			kfree(dhchap_secret);
> +			kfree_sensitive(dhchap_secret);
>  			return ret;
>  		}
> -		kfree(opts->dhchap_secret);
> +		kfree_sensitive(opts->dhchap_secret);
>  		opts->dhchap_secret =3D dhchap_secret;
>  		host_key =3D ctrl->host_key;
>  		mutex_lock(&ctrl->dhchap_auth_mutex);

[Severity: Critical]
This problem wasn't introduced by this patch, but can concurrent sysfs acce=
sses
[1] trigger a double free or use-after-free on opts->dhchap_secret and
ctrl->host_key?

In dhchap_secret_store(), opts->dhchap_secret is freed and replaced without
holding a lock, and ctrl->host_key is read before acquiring
ctrl->dhchap_auth_mutex:

CPU0                                  CPU1
dhchap_secret_store()                 dhchap_secret_store()
  kfree_sensitive(opts->dhchap_secret)
                                        kfree_sensitive(opts->dhchap_secret)
                                          <-- double free
  opts->dhchap_secret =3D dhchap_secret
  host_key =3D ctrl->host_key
                                        host_key =3D ctrl->host_key
  mutex_lock(&ctrl->dhchap_auth_mutex)
  ctrl->host_key =3D key
  mutex_unlock(&ctrl->dhchap_auth_mutex)
  nvme_auth_free_key(host_key)
                                        mutex_lock(&ctrl->dhchap_auth_mutex)
                                        ctrl->host_key =3D key
                                        mutex_unlock(&ctrl->dhchap_auth_mut=
ex)
                                        nvme_auth_free_key(host_key)
                                          <-- double free

A concurrent dhchap_secret_show() or strcmp() in dhchap_secret_store() can
also read opts->dhchap_secret while it is being freed, causing a
use-after-free.  The same unlocked accesses exist in
dhchap_ctrl_secret_store() and dhchap_ctrl_secret_show() for
opts->dhchap_ctrl_secret and ctrl->ctrl_key.

[1] https://sashiko.dev/#/bug/linux-d9bcd9ea-2b96-4998-b954-e0e2557a158a

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116100244.7824=
-1-marting@netapp.com?part=3D1

