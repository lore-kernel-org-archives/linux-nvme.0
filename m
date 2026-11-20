Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5B606A320
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qyQddIAd;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRiuJCTA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=R3sU2zm3fa6x6n9OA9GHbiqW2qomQITFuBCU+CMjMjw=; b=qyQddIAdEw6dPAdNOxoxNTgg5t
	AJwDOSfXFR2re1Im1WfgwuTpyFeoG6GXH0e9MfZUI/1VacmTyupkRd00/rWwjjBCxtUSXj+SGy+FE
	9F5ovVqtvNDRJY60fixb/KgvoXbHxCgXsfyO7IxsvPJgfTAKmHAFVGaqpAncDhgkqnr4mhtA8qEZW
	z5m2555uzssLYNFvrhVWFN+Paf5meVqnXIM8Y8pTiUHv0QXD+lyI8yQFsNfKXxMh8f9daFzKW6K9B
	oEK4KiwheZNOGOX/OWvp0S7IDV9rfCZ8P7gAhkcJapBVOrUstEjsmYRdnt4QELau1qabcbhaj5tMY
	1Br0yeaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMl7-0000000Emn2-14Wy;
	Fri, 20 Nov 2026 11:26:25 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMl5-0000000Emmk-3uHa
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:26:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 74EA94062C
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7541F000C4;
	Fri, 20 Nov 2026 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173983;
	bh=R3sU2zm3fa6x6n9OA9GHbiqW2qomQITFuBCU+CMjMjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mRiuJCTApc48TkVqkI4yfMKXV/SoUxUTu8mppPj6mUMcgO7L0DJIVLOlmA+ubSFrh
	 wot/ZmdGS6V5ohSHx/SmOCbONTM9hcdOXW0vZrawNsscfdaQD8XLgiylKDJ3Us8at8
	 lVe4fdcJdGrU+DinFDvPF2goM0/9tEFvB6ukDPShzQdzVH5HGYZXl1lu/vt3XwbvLy
	 j6tg0h+Dkbfy2jEoPfCrrNkf39Iwd/jpW0pvBDELf/CwUV4HJfUywskVcDOwJDqj3i
	 yMg6/uiuaHVCpmh74jltflXxxd2+zA5aBffFwbAA+rCOAdN+97q0O8YtoByV1ssaO0
	 bXwKOQdj37KhA==
Message-ID: <sashiko-outbox-225036@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/9] nvme-auth: wait for authentication to finish
 when changing keys
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261120-dhchap-keyring-v4-v4-7-5f8c7d9926ee@kernel.org>
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
 <20261120-dhchap-keyring-v4-v4-7-5f8c7d9926ee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 11:26:22 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] nvme-auth: asymmetric and undocumented removal of
  synchronize_rcu() in sysfs
--

commit 5f508c67e7480252b016c544aeba6f80edc88b85
Author: Hannes Reinecke <hare@kernel.org>

nvme-auth: wait for authentication to finish when changing keys

This commit flushes ctrl->dhchap_auth_work after queuing re-authentication =
in
dhchap_secret_store() and dhchap_ctrl_secret_store(), and removes two
synchronize_rcu() calls after key_revoke().

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 47caed2ce3978..ce327a018b0d0 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -875,7 +875,6 @@ static ssize_t dhchap_secret_store(struct device *dev,
>  		if (generated) {
>  			dev_dbg(ctrl->dev, "revoke host key %08x\n", key_serial(key));
>  			key_revoke(key);
> -			synchronize_rcu();
>  		}
>  		key_put(key);
>  		kfree_sensitive(dhchap_secret);

[ ... ]

> @@ -973,7 +972,6 @@ static ssize_t dhchap_ctrl_secret_store(struct device=
 *dev,
>  		dev_dbg(ctrl->dev, "revoke ctrl key %08x\n",
>  			key_serial(old_key));
>  		key_revoke(old_key);
> -		synchronize_rcu();
>  	}
>  	ctrl->ctrl_key =3D key;
>  	ctrl->ctrl_key_generated =3D generated;

[Severity: Low]
Why are synchronize_rcu() calls removed from mismatched paths in
dhchap_secret_store() and dhchap_ctrl_secret_store(), and without mention in
the commit message?

In dhchap_secret_store(), synchronize_rcu() is removed from the
key_validate() error path, but kept when revoking old_key under
ctrl->dhchap_auth_mutex:

drivers/nvme/host/sysfs.c:dhchap_secret_store() {
    ...
	if (ctrl->host_key_generated) {
		dev_dbg(ctrl->dev, "revoke host key %08x\n",
			key_serial(old_key));
		key_revoke(old_key);
		synchronize_rcu();
	}
    ...
}

In dhchap_ctrl_secret_store(), it is removed when revoking old_key, but kept
in the key_validate() error path:

drivers/nvme/host/sysfs.c:dhchap_ctrl_secret_store() {
    ...
		if (generated) {
			dev_dbg(ctrl->dev, "revoke ctrl key %08x\n", key_serial(key));
			key_revoke(key);
			synchronize_rcu();
		}
    ...
}

Both functions handle keys of type nvme_dhchap_psk_key_type (whose
user_revoke() callback frees the payload via call_rcu()), so the two store
callbacks should handle key_revoke() symmetrically.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-dhchap-key=
ring-v4-v4-0-5f8c7d9926ee@kernel.org?part=3D7

