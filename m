Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E48606A31F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cXfvm5cA;
	dkim=pass (2048-bit key, unprotected) header.d=arkamax.eu header.i=@arkamax.eu header.a=rsa-sha256 header.s=mail1 header.b=ZM9s7tSx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/r0AxVVWGLZRXANdtf3mhSCkftv12XEmvpE4y1kyZFE=; b=cXfvm5cAYZbUDT64UHAG+7LOEC
	Di2oR8T8c+tW5/uoYR1D11nBJO8czILaqXha0Yi1gypaF+q1gy1aXzB7BaAwGcsuR1e4XQrxn6ktR
	7S7rGVbAVktsRoz1/eNnvlPz9awgBvNCIiOvVDbyEHXhd2XKwuaXVP6DlJ5O5HRRM+BnnC56K7YMc
	8pQuUWTYFD3GEma+npOX4jKR6li1P/tsYLjE4Aq2FWySXd6OqwKtcRk4C1B7gKHBwyeXili/2vNdC
	TV6J2zvU1b3OyofxjOf/jujh4ecBPeXkFRiWDZbo43nRKowiTCNzEvNapOnoDQ8NRJr67czwabWgx
	/D4k7tDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJWuI-0000000C2Bj-3kaR;
	Wed, 21 Oct 2026 14:03:06 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJWuC-0000000C2Ah-2BPh
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 14:03:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=Uke4Cy4YCZOUDu
	A/rCbWYHMHT4sU8wffe55QX/Y+8xk=; h=in-reply-to:references:subject:cc:
	to:from:date; d=arkamax.eu; b=ZM9s7tSxTTv5A2+xzTaxDhNjGwuY60LWr+mDKEuV
	3tFbZ9hCuAfZK0JdhVKuhpkcXGe4xJUz7+MpPPyv+1xn3ULEyKva9tTkMpKuozcrOtDCTW
	73++HmX0V3WieEGS3KbZmlvuAjSynJonGlPuTP3tBcRV6a3zVKyYnqfEqILdapOuKH+Y5j
	/twF/IbCZM3XNFEpwOMsrB5HHucm11sW6fOmjtpfzBiZw/i23vifHsHvaeQQrlDHtOvWvE
	06t8mi68kFz45nB0yJuCUPrCxQmzYWa9wDGNBeBZfdO6b/Ex/NnUVGIGMz7iATgzhpG4tK
	T57zI2rM36uhvjYMFggs3w==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 9a5ef087 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 16:02:56 +0200 (CEST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 16:02:55 +0200
Message-Id: <DMAKLXGB0BLV.1S3CO480V3JJM@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Yu Zhang" <yuz08559@gmail.com>, "Keith Busch" <kbusch@kernel.org>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Chaitanya Kulkarni" <kch@nvidia.com>
Cc: "Maurizio Lombardi" <mlombard@arkamax.eu>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvmet: take subsys->lock while force-reconnecting in
 nvmet_subsys_attr_qid_max_store()
X-Mailer: aerc 0.22.0
References: <20261014054727.53183-1-yuz08559@gmail.com>
 <20261020025047.88297-1-yuz08559@gmail.com>
In-Reply-To: <20261020025047.88297-1-yuz08559@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_070300_904219_B493B7DC 
X-CRM114-Status: GOOD (  14.04  )
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

On Tue Oct 20, 2026 at 4:50 AM CEST, Yu Zhang wrote:
> nvmet_subsys_attr_qid_max_store() sets subsys->max_qid and then walks
> subsys->ctrls to force every controller to reconnect, but it holds only
> nvmet_config_sem (for write).  subsys->ctrls is protected by subsys->lock=
:
> nvmet_alloc_ctrl() adds an entry under subsys->lock, and nvmet_ctrl_free(=
)
> removes it under subsys->lock with list_del() + kfree() (not kfree_rcu).
> The free path takes no nvmet_config_sem, so the two locks are independent=
.
>
> A controller teardown (host disconnect, keep-alive timeout or fatal error
> -> nvmet_sq_destroy() -> nvmet_ctrl_put() -> nvmet_ctrl_free()) can
> therefore list_del() an entry while qid_max_store() is iterating the list=
,
> corrupting the walk.
>
> KASAN, concurrent "echo 128 > .../subsystems/<nqn>/attr_qid_max" racing
> nvme-loop controllers connecting and disconnecting, panics in seconds:
>
>   BUG: KASAN: null-ptr-deref in nvmet_subsys_attr_qid_max_store+0x10d/0x1=
b0
>   Read of size 8 at addr 0000000000000090
>   Call Trace:
>    nvmet_subsys_attr_qid_max_store+0x10d/0x1b0
>    configfs_write_iter+0x1a7/0x250
>    vfs_write+0x5df/0x940
>    ksys_write+0xfd/0x1e0
>
> (also seen as a general-protection fault dereferencing a LIST_POISON
> pointer at the same instruction.)
>
> Take subsys->lock around the list_for_each_entry() loop, matching every
> other subsys->ctrls accessor.  ->delete_ctrl() only queues asynchronous
> controller teardown, so it does not re-enter subsys->lock under the loop.
>
> Fixes: 3e980f5995e0 ("nvmet: expose max queues to configfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yu Zhang <yuz08559@gmail.com>
> Tested-by: Yu Zhang <yuz08559@gmail.com>
> ---
>  drivers/nvme/target/configfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index 2b69ffc..23418fa 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1684,8 +1684,10 @@ static ssize_t nvmet_subsys_attr_qid_max_store(str=
uct config_item *item,
>  	subsys->max_qid =3D qid_max;
> =20
>  	/* Force reconnect */
> +	mutex_lock(&subsys->lock);
>  	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
>  		ctrl->ops->delete_ctrl(ctrl);
> +	mutex_unlock(&subsys->lock);
>  	up_write(&nvmet_config_sem);
> =20
>  	return cnt;

Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>

