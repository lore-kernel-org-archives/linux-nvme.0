Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89C606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mHtXcW5Z;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S5DQGIbG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XVOxur87GV70ySVkoJrwg3Gyp56PlLec0yC+KsExP+M=; b=mHtXcW5Zs7bqnAyrqkGcYToiHX
	uOKL6rmE5VQbBBfh89UL/GnamHi+1ZP2VJPpEZAhSsRbN6+A2zYGShF6pQjTlMXxWjNHU0vBmfdA5
	qt0c1fdfO0GTaNPt33/7UW4WxLCeML27edG8i3e+hPZ0FHnK/4+7pFbwuznPNp/hol781TxQnRHXi
	nCrInEfhJax4gr8ylKEhQsrq4P8iNXPSm7cQfSVAhpqp3nXk2CNcqODVb3ayKLLGTki2XaWbru2jb
	P6LSsVr6iBijJjD2q564n8vLvZAaUFlNAbAwIJea7relL7y66PZw6c0zjToh2bcC0PoBwXk+eY6wD
	G7m5YG2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWCHj-00000009rfo-3Ivv;
	Wed, 25 Nov 2026 12:39:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWCHh-00000009rfE-0Cgh
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 12:39:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8116242E2A;
	Wed, 25 Nov 2026 12:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511401F000D2;
	Wed, 25 Nov 2026 12:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795610376;
	bh=XVOxur87GV70ySVkoJrwg3Gyp56PlLec0yC+KsExP+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S5DQGIbGdiNjXzon6vPFH0/KjkpXANmCKkikzXBAlIBg9FCblD+QpbyVWdVZaqOnU
	 DjQ6djFUkL7UO7A0g0olbfHcs7ZwHTptDv5sssNGZbvbHmGRatiZYwZlmEoQzMBqaz
	 4sSTSsfHRsjHYmT2k2tbG5bimY5ExnFDOC/ufARzFj0NealuPXwIxYKa61Q6isY8my
	 bpjltfnxzwgu9r1zMx6Pt+Ua8nry/MhN0aYP+xPeY2qoRN7Ei24iiSbqMd15E2yvpM
	 i+YFsgCHM1jHPPmdRzsk7gyH9YRosuVikIFnNiIiviIyHt3uNV3ykI+qZLF/vEnc4z
	 isGSIWKnes41g==
Message-ID: <sashiko-outbox-233382@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] nvme-multipath: serialize ana_log_buf lifecycle with
 ana_lock
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261125122446.1122253-1-kanie@linux.alibaba.com>
References: <20261125122446.1122253-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 12:39:35 +0000
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
- [High] nvme-multipath: ana_work re-queued with NULL buffer after
  nvme_mpath_uninit()
- [Medium] nvme-multipath: stale ana_log_buf parsed against shrunk size
  on reset
--

commit 6951dbeaa851be5d302a81751db149aaf0a1b322
Author: Guixin Liu <kanie@linux.alibaba.com>

nvme-multipath: serialize ana_log_buf lifecycle with ana_lock

This commit serializes ctrl->ana_log_buf and ctrl->ana_log_size updates
under ctrl->ana_lock across nvme_mpath_init_identify() and
nvme_mpath_uninit(), and adds a NULL buffer check to nvme_parse_ana_log().

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 27facdbb3d4c0..91ba71ab1c614 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -867,6 +867,9 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl,=
 void *data,
> =20
>  	lockdep_assert_held(&ctrl->ana_lock);
> =20
> +	if (!ctrl->ana_log_buf)
> +		return 0;
> +
>  	for (i =3D 0; i < le16_to_cpu(ctrl->ana_log_buf->ngrps); i++) {
>  		struct nvme_ana_group_desc *desc =3D base + offset;
>  		u32 nr_nsids;
> @@ -1589,13 +1592,22 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ct=
rl, struct nvme_id_ctrl *id)
>  		goto out_uninit;
>  	}
>  	if (ana_log_size > ctrl->ana_log_size) {
> +		void *buf;
> +
>  		nvme_mpath_stop(ctrl);
> -		nvme_mpath_uninit(ctrl);
> -		ctrl->ana_log_buf =3D kvmalloc(ana_log_size, GFP_KERNEL);
> -		if (!ctrl->ana_log_buf)
> +		buf =3D kvzalloc(ana_log_size, GFP_KERNEL);
> +		if (!buf)
>  			return -ENOMEM;
> +		mutex_lock(&ctrl->ana_lock);
> +		kvfree(ctrl->ana_log_buf);
> +		ctrl->ana_log_buf =3D buf;
> +		ctrl->ana_log_size =3D ana_log_size;
> +		mutex_unlock(&ctrl->ana_lock);
> +	} else {
> +		mutex_lock(&ctrl->ana_lock);
> +		ctrl->ana_log_size =3D ana_log_size;
> +		mutex_unlock(&ctrl->ana_lock);
>  	}
> -	ctrl->ana_log_size =3D ana_log_size;
>  	error =3D nvme_read_ana_log(ctrl);
>  	if (error)
>  		goto out_uninit;

[Severity: Medium]
When a controller resets with a smaller ana_log_size (or a smaller
ctrl->anagrpmax, which is updated above outside ctrl->ana_lock), does this
else branch leave the pre-reset ANA log in ctrl->ana_log_buf while
shrinking ctrl->ana_log_size?

A concurrent nvme_parse_ana_log() running before nvme_read_ana_log()
overwrites the buffer will validate the old descriptors against the newly
shrunk ctrl->ana_log_size and ctrl->anagrpmax, hitting WARN_ON_ONCE() and
failing with -EINVAL:

CPU0                                  CPU1
nvme_mpath_init_identify()
  ctrl->anagrpmax =3D ...
  mutex_lock(&ctrl->ana_lock)
  ctrl->ana_log_size =3D ana_log_size
  mutex_unlock(&ctrl->ana_lock)
                                      nvme_mpath_add_disk()
                                        mutex_lock(&ctrl->ana_lock)
                                        nvme_parse_ana_log()
                                          offset > ctrl->ana_log_size
                                            <-- WARN_ON_ONCE()
  nvme_read_ana_log()

Zeroing ctrl->ana_log_buf->ngrps (and updating ctrl->anagrpmax) under
ctrl->ana_lock would keep concurrent parsers from walking stale pre-reset
descriptors before nvme_read_ana_log() populates the new log.

> @@ -1615,7 +1627,9 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>  	 */
>  	cancel_work_sync(&ctrl->ana_work);
> =20
> +	mutex_lock(&ctrl->ana_lock);
>  	kvfree(ctrl->ana_log_buf);
>  	ctrl->ana_log_buf =3D NULL;
>  	ctrl->ana_log_size =3D 0;
> +	mutex_unlock(&ctrl->ana_lock);
>  }

[Severity: High]
Can nvme_mpath_add_disk() re-queue ctrl->ana_work after
nvme_mpath_uninit() has already cancelled it and freed ctrl->ana_log_buf?

When nvme_mpath_init_identify() jumps to out_uninit during a reset (for
example, when ana_log_size > max_transfer_size disables ANA with
error =3D=3D 0 so the controller still becomes live), nvme_mpath_add_disk()
can pass its unlocked nvme_ctrl_use_ana() check before ctrl->ana_log_buf
is cleared:

CPU0                                  CPU1
nvme_mpath_add_disk()                 nvme_mpath_uninit()
  if (nvme_ctrl_use_ana(ctrl))          cancel_work_sync(&ctrl->ana_work)
                                        mutex_lock(&ctrl->ana_lock)
                                        kvfree(ctrl->ana_log_buf)
                                        ctrl->ana_log_buf =3D NULL
                                        ctrl->ana_log_size =3D 0
                                        mutex_unlock(&ctrl->ana_lock)
    mutex_lock(&ctrl->ana_lock)
    nvme_parse_ana_log()
      if (!ctrl->ana_log_buf)
        return 0
    mutex_unlock(&ctrl->ana_lock)
    if (desc.state) /* 0 */
    else
      set_bit(NVME_NS_ANA_PENDING, ...)
      queue_work(..., &ctrl->ana_work)
                                      nvme_ana_work()
                                        nvme_read_ana_log()
                                          nvme_get_log(..., NULL, 0, 0)
                                            <-- numd underflows to 0xffffff=
ff

Because nvme_parse_ana_log() returns 0 with desc.state =3D=3D 0 when
ctrl->ana_log_buf is NULL, nvme_mpath_add_disk() treats it as a missing
group descriptor, leaves the namespace stuck with NVME_NS_ANA_PENDING set,
and queues ctrl->ana_work.  nvme_read_ana_log() then calls nvme_get_log()
without checking ctrl->ana_log_buf, passing a NULL buffer and size 0;
nvme_bytes_to_numd(0) underflows to 0xffffffff and submits a 16 GiB
Admin Get Log Page command with no data buffer mapped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125122446.1122=
253-1-kanie@linux.alibaba.com?part=3D1

