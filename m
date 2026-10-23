Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF08B606A31B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=krSuhmUn;
	dkim=pass (2048-bit key, unprotected) header.d=arkamax.eu header.i=@arkamax.eu header.a=rsa-sha256 header.s=mail1 header.b=To+f6UD4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mlkUlTBy3gi5X/PNLdqR3eK+uOg/TJTghfW/CD9/gwY=; b=krSuhmUnYolSxr
	Lk8FiPT1tjxKSfbFZfDTKBvFF00dl8sR+IK0Ht9L3L+cxdRT8mqFxjbPFuX7VNEa89FgtfznNmysF
	a8zUrXf7GssbzqlBkqUzojiJGRAQWle/pPPtMiHzf+8uUcXwH2QpXMN6PzMjYNz25LgdFKzpq3EKY
	Tci4KRkHtC1YsOfdSoC9MOlIxi20GZbLikYxR8m+c1bf9UVrq0hslMLvI6zuzcMVcvJ3QIfEog8RR
	yEFbu9OHn+E9H5Jc5+POfGlqhCbdprVtmx2KPx0id0RK/6M66kDIE5vQydv6d7VwYcXtxQLtJ3C/D
	22hD5em92ZOf1J5pjSLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKECT-0000000GHaN-34pS;
	Fri, 23 Oct 2026 12:16:45 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKECQ-0000000GHYY-2nlx
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 12:16:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=IpHhtEj7MQFXuK
	jI807etXOb5FXQT1zBeNAvZ4SdQkc=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=To+f6UD4wqx89wwjicO1lJV9TziT4ctx11TNk
	VVQ+D72bSnhwuFEkE7HoggQvslZt8uwFOLd5Se2xbMGrhsLEikp+wA+NkTGKtQvKQjBUeT
	3d/2DbnlldIDHXAp0FRKPDnSVfl+WZKVSJYHd4yQvxZHnw62kisGWwWKiWjpI8t/trE137
	zwQw+5iuLMWxG+A6tyz02kB+6IjKA6aScpnpJSoV4XrLN94l+eWIrVT0OUYBnqvjauxyNb
	CA/n4KgVTzISJXEjjeiTX606A6N3DCVo1CxaLWfiLVnc4yh1CbCNSk1+BF/RykZKwX9SVi
	zvoV8AFH8TkJ3Jf0UdUQoMMNg==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id ab229737 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 14:16:31 +0200 (CEST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 14:16:30 +0200
Message-Id: <DMC7LJCQ1QZO.M3C252P8IZG4@arkamax.eu>
Cc: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvmet: protect nvmet_ports_list with nvmet_config_sem
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Qing Zhang" <diasyzhangqing@gmail.com>,
 <linux-nvme@lists.infradead.org>
X-Mailer: aerc 0.22.0
References: <179275538809.275862.8334230595898232727@tencent.com>
In-Reply-To: <179275538809.275862.8334230595898232727@tencent.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_051643_379174_9AD588D5 
X-CRM114-Status: GOOD (  19.79  )
X-Spam-Score: -1.1 (-)
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Oct 23, 2026 at 1:36 PM CEST, Qing Zhang wrote:
>>From 554233f4165842a0a104896c30ed4d2e89c11931 Mon Sep 17 00:00:00 2001
> From: Qing Zhang <diasyzhang@tencent.com>
> Date: Fri, 23 Oct 2026 19:29:28 +0800
> Subject: [PATCH] nvmet: protect nvmet_ports_list with nvmet_config_sem
>
> Readers of nvmet_ports_list (e.g. nvmet_subsys_disc_changed()) hold
> nvmet_config_sem and assert it via lockdep.  The writers --
> nvmet_ports_make() and nvmet_port_release() -- do not take the lock;
> they rely on the parent directory's VFS inode lock for serialization,
> which is an implementation detail of configfs and not a guaranteed
> contract.  Align the writers with the lock the readers already require.
>
> Also move list_add() in nvmet_ports_make() to after the port is fully
> initialized: the old position published the port on the global list
> before INIT_LIST_HEAD(&port->subsystems), so a concurrent reader
> could traverse uninitialized list heads.
>
> flush_workqueue() in nvmet_port_release() stays outside the semaphore
> to avoid a lock dependency on nvmet_wq.
>
> Fixes: b662a078576e ("nvmet: enable Discovery Controller AENs")
> Signed-off-by: Qing Zhang <diasyzhang@tencent.com>
> ---
>  drivers/nvme/target/configfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index b03b5d1c2dc3..75cb9e63025f 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -2009,7 +2009,9 @@ static void nvmet_port_release(struct config_item *=
item)
> =20
>  	/* Let inflight controllers teardown complete */
>  	flush_workqueue(nvmet_wq);
> +	down_write(&nvmet_config_sem);
>  	list_del(&port->global_entry);
> +	up_write(&nvmet_config_sem);
> =20
>  	key_put(port->keyring);
>  	kfree(port);
> @@ -2070,8 +2072,6 @@ static struct config_group *nvmet_ports_make(struct=
 config_group *group,
>  			port->ana_state[i] =3D NVME_ANA_INACCESSIBLE;
>  	}
> =20
> -	list_add(&port->global_entry, &nvmet_ports_list);
> -
>  	INIT_LIST_HEAD(&port->entry);
>  	INIT_LIST_HEAD(&port->subsystems);
>  	INIT_LIST_HEAD(&port->referrals);
> @@ -2105,6 +2105,10 @@ static struct config_group *nvmet_ports_make(struc=
t config_group *group,
>  	configfs_add_default_group(&port->ana_default_group.group,
>  			&port->ana_groups_group);
> =20
> +	down_write(&nvmet_config_sem);
> +	list_add(&port->global_entry, &nvmet_ports_list);
> +	up_write(&nvmet_config_sem);
> +
>  	return &port->group;
>  }
> =20

Yes, I was already planning to submit the same fix as part of this
larger patch: https://lore.kernel.org/linux-nvme/DLOGQG9GZC3X.1UZ2MY7S3T5N2=
@arkamax.eu/
but I didn't have time to finish the tests and submit it.

Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>


