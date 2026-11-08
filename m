Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2151606A326
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eITw84T9;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vk9nNIcZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZOaH1T4j6iP+c7Um2ZMTbLe681u2iyfuCqiIs0/2p4I=; b=eITw84T9NEl4AeYXiagiZEuRi/
	5UZotkAeFFLi1Ho/0LFGr0xeZwv/b/N+e1+l9YBpvKrKTFlYA8PNysuAvkOsjygJwkqA8/Kwfmrlr
	HgVtKNplKmMMAkm+98sR9rXYWCZIrhGhqxeyJ9Ejz11UfzejKK/hlqR+RM0iPqtAb+teaNJK8zqtv
	llmqDOkW3/dr1ouwVIozS3QmH15WrV0KkN1riuWAyCSgv6uTHwuAvF4ByTe4tvrAuiavd0UfGqNoJ
	UPY/ypdfpzMT+Vg59PN5HRGyaFAi03ZVmWcy7yj44ySHko+VbTUWlqwCzKLSeLO2GSni7m0JLU/5t
	jLmEX4dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQA2M-0000000Gewf-1XEK;
	Sun, 08 Nov 2026 21:02:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQA2L-0000000GewF-05Wu
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 21:02:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 06E7B60D0E;
	Sun,  8 Nov 2026 21:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA431F008A2;
	Sun,  8 Nov 2026 21:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794171767;
	bh=ZOaH1T4j6iP+c7Um2ZMTbLe681u2iyfuCqiIs0/2p4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vk9nNIcZkyDrBaeyeKPZjfBLKeKCmns+EiVR7yDIl1G2hbJ3IQXsAgddoyk32XypB
	 W2L1kVth/SLQ+YV21z0FpFuBxJleNnq7R6YesnMetTuIpP9E/fV6p1TJhi1wDvp/+4
	 VIEFRbdpGvBdVKkVhkP19VtLP/kNfhAnLw5Q9T4edk6qiKF9+dr7dsIWoq4UJHgdzK
	 g0VBGmSaSx4voZmDxEn3Xt0vG+dKf7LUFQNVmSRz3y0sepm6I0IdbO+N/4aEav3tYA
	 kKe0nCzvICOuQS76CVD0IE7sBEFGMiG8ObNzLrbFlKK4rxNDZiSDpA7YwR4zLZCIHl
	 kjUH9xIq4H6Gw==
Message-ID: <sashiko-outbox-204045@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/29] scsi-multipath: introduce basic SCSI device
 support
To: "John Garry" <john.garry@linux.dev>, james.bottomley@hansenpartnership.com, mkp@kernel.org
Cc: hare@suse.com, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, snitzer@kernel.org, jmeneghi@redhat.com, bmarzins@redhat.com, dm-devel@lists.linux.dev, hch@lst.de, michael.christie@oracle.com
In-Reply-To: <20261108204733.557995-13-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
 <20261108204733.557995-13-john.garry@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 21:02:46 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Low] scsi: CONFIG_SCSI_MULTIPATH depends on SCSI_MOD instead of SCSI
- [Low] scsi: duplicate MODULE_DESCRIPTION and MODULE_LICENSE in
  scsi_multipath.c
- [Low] scsi-multipath: off-by-one truncation check in
  scsi_mpath_unique_lun_id()
--

commit 006413118882829d81f9e30417cb6f7346390426
Author: John Garry <john.garry@linux.dev>

scsi-multipath: introduce basic SCSI device support

This commit introduces struct scsi_mpath_device, the scsi_mod.multipath
module parameter, and per-device multipath allocation and release hooks
during SCSI LUN scanning and device teardown.

> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 90b65bebec703..2491fdf6f563e 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -76,6 +76,16 @@ config SCSI_LIB_KUNIT_TEST
> =20
>  	  If unsure say N.
> =20
> +config SCSI_MULTIPATH
> +	bool "SCSI multipath support (EXPERIMENTAL)"
> +	depends on SCSI_MOD
> +	select LIBMULTIPATH
> +	help
> +	  This option enables support for native SCSI multipath support for
> +	  SCSI host.
> +
> +	  If unsure say N.
> +

[Severity: Low]
Should SCSI_MULTIPATH depend on SCSI instead of SCSI_MOD?

SCSI_MOD defaults to y when SCSI=3Dn and BLOCK=3Dy:

drivers/scsi/Kconfig:
    config SCSI_MOD
    	tristate
    	default y if SCSI=3Dn || SCSI=3Dy
    	default m if SCSI=3Dm
    	depends on BLOCK

When CONFIG_SCSI=3Dn and CONFIG_BLOCK=3Dy, CONFIG_SCSI_MULTIPATH=3Dy can be
enabled, which selects CONFIG_LIBMULTIPATH=3Dy while skipping scsi_mod.o and
drivers/scsi/scsi_multipath.o.

[ ... ]

> diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
> new file mode 100644
> index 0000000000000..97f7513b47122
> --- /dev/null
> +++ b/drivers/scsi/scsi_multipath.c
> @@ -0,0 +1,150 @@

[ ... ]

> +static int scsi_mpath_unique_lun_id(struct scsi_device *sdev)
> +{
> +	struct scsi_mpath_device *scsi_mpath_dev =3D sdev->scsi_mpath_dev;
> +	int ret;
> +
> +	ret =3D scsi_vpd_lun_id(sdev, scsi_mpath_dev->device_id_str,
> +				SCSI_MPATH_DEVICE_ID_LEN);
> +	if (ret < 0)
> +		return ret;
> +	else if (ret =3D=3D 0)
> +		return -EINVAL;
> +	else if (ret > SCSI_MPATH_DEVICE_ID_LEN)
> +		return -EINVAL;
> +
> +	return 0;
> +}

[Severity: Low]
Should the truncation check test ret >=3D SCSI_MPATH_DEVICE_ID_LEN instead =
of
ret > SCSI_MPATH_DEVICE_ID_LEN?

In scsi_vpd_lun_id(), a T10 Vendor ID designator with 252 or more bytes is
clamped to id_len - 4 (252) and formatted with snprintf(id, id_len,
"t10.%*pE", ...), which truncates device_id_str at 255 characters plus the
NUL terminator and returns 256 (SCSI_MPATH_DEVICE_ID_LEN). Testing
ret > SCSI_MPATH_DEVICE_ID_LEN accepts that truncated identifier.

[ ... ]

> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("scsi_multipath");

[Severity: Low]
Does linking scsi_multipath.o into scsi_mod.o emit duplicate MODULE_LICENSE
and conflicting MODULE_DESCRIPTION entries in scsi_mod's .modinfo section?
drivers/scsi/scsi.c already defines MODULE_DESCRIPTION("SCSI core") and
MODULE_LICENSE("GPL") for scsi_mod.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108204733.5579=
95-1-john.garry@linux.dev?part=3D12

