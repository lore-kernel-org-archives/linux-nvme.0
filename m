Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E7606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MfMfF64t;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htqwd27A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3dtS1lgHuK2JefZETiWpXEJQW6X0gc6PrWWneEKG8BU=; b=MfMfF64tXJ8tG8BEbX1BjTHrG+
	4ts2nOhS48DBAyo7MX1yU1C5XkWSBR/mFENXgWJzRTWlCRFsUhV8qea3aotGg0/Py9wA3vamxPQYd
	S1B0P0dhsaHn1Hpam5Jd0sSETogGFSFztNexT1CoDEj2kmN7gkI45sU17gejpCfYVEtCQEaUVvzQG
	P201rXHB7g3puP6lM5v+LqrT2MPF+dYUIPn/JM0Vo/3EkagfC4geE1k6y2Tf559/W6lFN+LjXjGOE
	bMWY0g6Sqx+Xb8QpswLvixXBMSx3BllfLjkK83PIJMX50SxJBhNIT+P6i4mLWpW+SfwzOhAseYDPM
	34NOiUuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXoM-00000004MBQ-0brp;
	Mon, 23 Nov 2026 17:26:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXoK-00000004MB0-2DWG
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:26:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 00F34623BD
	for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 17:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6030D1F000C4;
	Mon, 23 Nov 2026 17:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454795;
	bh=3dtS1lgHuK2JefZETiWpXEJQW6X0gc6PrWWneEKG8BU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=htqwd27ANSo8rToS1jQZh71mLQoKiWPWEPgK4SbdXzOB5vsp6jrEP+sVUdH3y6Eia
	 RNOMR6UOIQ+RnlNXWGMcixIGJAV0kedqyeNc9fqJqfElxRp2PB8LblVx5xzvv6pZio
	 uaob/opnuWXelrP6eqXo1nz28suPIYMI5A0yuLUqI7UJyUOHzs8zBn7OFPBLsCXVPF
	 io4mnW6HV0SKt0198dUt8tCN7kq5xD29QUeu7jFV+Sf71W0rtl+S8ddTXT7TwzbYtT
	 JFJQBY5a6ex2a2asbnAujzXwTjUdb9UszqzeHTgNgJyEu6PIZuIaHqd3n8wi2icQzn
	 KXvskusgFztQQ==
Message-ID: <sashiko-outbox-229738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/9] nvme: parse dhchap keys during option parsing
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123-dhchap-keyring-v4-v6-4-5082a49715ab@kernel.org>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123-dhchap-keyring-v4-v6-4-5082a49715ab@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 17:26:34 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] nvme: dhchap_key_show() and dhchap_ctrl_key_show() return 0
  instead of none
- [Low] nvme-auth: log of unassigned ctrl->host_key in
  nvme_auth_init_ctrl()
--

commit bfaa9fb3c74e5de5eb5e03ecba9893bb438923f7
Author: Hannes Reinecke <hare@kernel.org>

nvme: parse dhchap keys during option parsing

This commit creates DH-HMAC-CHAP keys during fabric option parsing to store
struct key pointers instead of plain text secrets in nvmf_ctrl_options, and
adds dhchap_key and dhchap_ctrl_key sysfs attributes exposing their key
serial numbers.

> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 0ddf3834f4ea2..26e8f321650e7 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
[ ... ]
> @@ -1029,40 +1024,100 @@ static void nvme_ctrl_auth_work(struct work_stru=
ct *work)
[ ... ]
> +	pr_debug("%s: using dhchap host key %08x\n",
> +	       __func__, key_serial(ctrl->host_key));
> +	if (ctrl->host_key)
> +		nvme_auth_clear_host_key(ctrl);
> +	ctrl->host_key =3D host_key;

[Severity: Low]
Should this pr_debug() pass key_serial(host_key) instead of
key_serial(ctrl->host_key)?  Because ctrl->host_key has not been assigned
yet, it logs 00000000 instead of the new key serial.

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index a5c1511e49ac2..6fab0d217e749 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
[ ... ]
> @@ -925,6 +985,52 @@ static ssize_t dhchap_ctrl_secret_store(struct devic=
e *dev,
> =20
>  static DEVICE_ATTR_ADMIN_RW(dhchap_ctrl_secret);
> +
> +static ssize_t dhchap_key_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> +	struct key *key;
> +	ssize_t count =3D 0;
> +
> +	mutex_lock(&ctrl->dhchap_auth_mutex);
> +	key =3D ctrl->host_key;
> +	if (key) {
> +		down_read(&key->sem);
> +		if (key_validate(key))
> +			count =3D sysfs_emit(buf, "<invalidated>\n");
> +		else
> +			count =3D sysfs_emit(buf, "%08x\n",
> +					   key_serial(key));
> +		up_read(&key->sem);
> +	}
> +	mutex_unlock(&ctrl->dhchap_auth_mutex);
> +	return count;
> +}
> +static DEVICE_ATTR_ADMIN_RO(dhchap_key);
> +
> +static ssize_t dhchap_ctrl_key_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> +	struct key *key;
> +	ssize_t count =3D 0;
> +
> +	mutex_lock(&ctrl->dhchap_auth_mutex);
> +	key =3D ctrl->ctrl_key;
> +	if (key) {
> +		down_read(&key->sem);
> +		if (key_validate(key))
> +			count =3D sysfs_emit(buf, "<invalidated>\n");
> +		else
> +			count =3D sysfs_emit(buf, "%08x\n",
> +					   key_serial(key));
> +		up_read(&key->sem);
> +	}
> +	mutex_unlock(&ctrl->dhchap_auth_mutex);
> +	return count;
> +}
> +static DEVICE_ATTR_ADMIN_RO(dhchap_ctrl_key);

[Severity: Low]
Should dhchap_key_show() and dhchap_ctrl_key_show() emit "none\n" when key
is NULL?  The Documentation/ABI/stable/sysfs-nvme entry added in this patch
states that reading dhchap_key and dhchap_ctrl_key returns "none" if not
set, matching dhchap_secret_show() and dhchap_ctrl_secret_show(), but both
functions currently return 0 (empty output).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-dhchap-key=
ring-v4-v6-0-5082a49715ab@kernel.org?part=3D4

