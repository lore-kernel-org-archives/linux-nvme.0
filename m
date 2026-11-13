Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F54606A32D
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=f1+cqmjS;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=s+lZvKVc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=; b=f1+cqmjSvPzApI8ecEuGU0ANuO
	QpzMv8BJ8qy4A0spxYBqFlAY+Fr1RlOMxxHkiRqfRXXIZZTiTV7XUHWye+AXwbBRT2s8yVKtpiMFr
	2L/1goTV8u/yS3BUV39cU0L1Sn2LrKP4u/2zorxgkSTwhMLh4E0eFReX/SwU9vGcugTRM/eF4c6jm
	AFU1lZZNCQqdFW4KxW7Bjte8nkWXAlHJRh7jQ348c2Fo9wZktuvr/c0Jv/D7eOIqAfTC8cQlfk3ea
	ZfVG2uVvZY2mZltHgCOGHdxenIGeVOnCO6zzIIafUopUwG44yPtR0w/hLOcbYDs5yLlxTvBKdMNiT
	lgvvPoog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3d-0000000EDLN-11sq;
	Fri, 13 Nov 2026 19:35:33 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoLx-0000000CKTv-38OD
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:17:56 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso10701205e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565072; x=1795169872; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
        b=s+lZvKVckLCP5VP0PPMDhyrhULLdUJiiE6glBReWjP1433mUa5cqDx9HKeNAbeWyYV
         7ioQk/rHkLf+ZGlumBYPwJLJc+YkO2XSMKU252TizuBIBOrZB2kOVNHjInT9co0/7pc9
         Lor1pkzk7iUWvZzmXCFd1ezIk2N4i/kKILO93SAmVNU5Cnhl/yOt/nKyoCQOFINgelgh
         lnalkP0bZUpg7Mb4KlLCbe4WwP2E3Z2E0sL4lCydfoUBCPUaHeq5vNEgHOoJcTtCe23H
         agDA43l/mQGrixb71un2+SfGpMu29gmu4ECk10CmqAa2HuEyUgMK8qETOvtXVUS8fzPw
         oElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565072; x=1795169872;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
        b=Ji3EjDlHbamMhNrcCIsvjlKz30Jv/WLtVCENNigK/PtePKVlLBLNc0Cwll9iiK2fOW
         iHKxEMGvazr0qoQ+HBotutSQb9mflv+80qZt3aiB/u4CQwSlLB8o7HundOzfGHpz6aQS
         tS/ky1oLjj2T3LGhG1dE7MoGnWq/ja5ulJhYl8IT0Nck48XwQVdpXafhy60tBeRpzkW4
         757udAw9LhBDHmsffN2bag2Hdd4LyFph1YqoMEhjccYntKCq2AV4+kSrcy53CA0Gdcbz
         61oU1zZPa8U3Vz2SkGEjXpQfCYWHEOaCK9D0/XVcXmT7ezRETOVEwKxET2jEQme03Q5t
         0HaQ==
X-Forwarded-Encrypted: i=1; AL+hErETzKXNZnoK6nV0cCL7VwhvXbWFwk3eSfVjG+7wTmKL7cK3DOvDDHXL8CybRzt31A9GIRYmpPPn3+oQ@lists.infradead.org
X-Gm-Message-State: APuU4Z/zPkmCQc44mYI60mS5YTZ+N+l9Az/ozrt1lxvmnY39K8Y3/jNG
	bLnohnWrsiC8Hv8hk5QWwiquv0ImfoFwe1YW0JRiIYTTB3aHmhquL4YFdF+/0I3aNsvqhPEjr3M
	MzGFXwq5UlXM=
X-Gm-Gg: AYBFou2Ri07UBCMaSGdrmSzrWyR1tTG+MZONmUZFZVORm7OXhsgqdshZBfMOyLTL1Ie
	RrGONQCopyfwiJpyUMDaGjqNr57MgEswnk3jkkAB22MDcwAyWow900lY7pqByc4bgzoVgRSg6SA
	igOs72S5tha65wzRUoMNdUFW5dOyyV20MxCRNgqeGBT0XYNALS/aZG8c2AmUL7P0zaP40xbAAig
	HmIB83xueQJxRxc3TyhObHndPkghVzeeQyqK6Lus32W0mbDPpqIm7UCpxkXFPbsRP4H7cqBKBSr
	pF34sNDOhSUuP/vgVkNwFtAxTdsTB9IxmUdQh7ahGCnSeOIJZhfqGMtaIbrz6iN2wME6QScPXGZ
	zW37RPiyb+oWpeJ+0QnJDSblT9O4lg2KDQAjsxRVl9sYTUZFnJQLbieq/EywGO0uvQAzjdpeolX
	7rH6mCiVEPu6/7nJVcLWvvi5uzHsuzoc0O4SStOc1kjDSoWZeVUxwTDcGJOD8UbX5H4GdrP07Xb
	muRf+qBA8LNbh2hKLDbboWrkqE05knaPIWQ49MirA7psd+Dkakf7bjfRegg/HgsDKDHoozhT/qd
	wY3yjsfpBV+t9Z4XqXzvNornsq91yhEOf9mSY5fQ1ayHrvY5x7+pkNFcjLt3NWc=
X-Received: by 2002:a05:600c:45d4:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4bb559f6f31mr43851425e9.2.1794565071804;
        Fri, 13 Nov 2026 02:17:51 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm3937770f8f.5.2026.11.13.02.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:17:51 -0800 (PST)
Message-ID: <7cde6f3091f9d90593e4a6441723b6b889cc4024.camel@amutable.com>
Subject: Re: [PATCH RFC 35/41] zloop: refuse zone files on pseudo filesystems
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:17:48 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_021755_371998_81E49848 
X-CRM114-Status: GOOD (  13.22  )
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Fri, 13 Nov 2026 11:35:09 -0800
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> zloop opens its zone files by name below the base directory but a
> bind
> mount can put any file there, including a procfs or sysfs file.
> Refuse
> files on pseudo filesystems as zone files just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/zloop.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index 65634a39b0bf..dcc06dd47b04 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -1137,6 +1137,11 @@ static int zloop_init_zone(struct zloop_device
> *zlo, struct zloop_options *opts,
> =C2=A0		goto out_fput;
> =C2=A0	}
> =C2=A0
> +	if (file_is_pseudo(zone->file)) {
> +		ret =3D -EINVAL;
> +		goto out_fput;
> +	}
> +
> =C2=A0	if (zlo->block_size) {
> =C2=A0		ret =3D zloop_get_block_size(zlo, zone);
> =C2=A0		if (ret)

