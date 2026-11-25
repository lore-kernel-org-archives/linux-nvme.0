Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E21606A32D
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rW5KUHva;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYPUE/f6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=V6WOBrzmCfH5hpSxFxaUheVHaQaP2UIXKIQ+UaVWFnI=; b=rW5KUHvaGmY0o24BDR4Xwwbac0
	kw6v4HjhMGKNJsgv4XJmQCXHVJnAdkcdTgK43ZIXSlDaxiSJ16lqFnRMSWJjExNH9WPJEfcyfrR6i
	iZ8t66cTIoo93q5+je/it9KUCv1aGhl7PyXUQ8tbTcOJ2sSElfeoAw5GCyhBu4RcMdKs4Fh8Q/0lK
	CEYPslmSGss+Qd15iJ2WCGBKQu/uRpT/ymq6djGy6Xw1/RTCb8gczXEtXthiD9QZ6avdRbZ3KuuNf
	iszSSEJ8OiGIY//A/TBbgXqpzVcTuYIRi8HAvjO9ySIVnKYeW2B8YmXQ7j8L1Bvy22F7pcye4P5u5
	pyCG8kxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWBu8-00000009meA-3pjf;
	Wed, 25 Nov 2026 12:15:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWBu7-00000009md5-0eLu
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 12:15:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5776862731;
	Wed, 25 Nov 2026 12:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15351F01562;
	Wed, 25 Nov 2026 12:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795608914;
	bh=V6WOBrzmCfH5hpSxFxaUheVHaQaP2UIXKIQ+UaVWFnI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RYPUE/f6NKOZt6Q0iEvO/C9Fs2WSreMvkukb2nLoOuTVAD8yq8obqI1Rm1uJTJi8B
	 fGH3VU33rPqTuMvPP+JMwcI/6EQyruUS6mytxfHEKK2OXpg9Qty5283LwH0CKCklad
	 vmt7LCbS0LXC7aYmJgwpKEMUtGPZ2Y9+7I/EiL8TCEO/EQcz0p5BeKQebrLEoRj4NA
	 xDU7Sy0EevOsR1a0zw8Kelpc+U9SOXlA5fFI5zfYGQNI5MkpEPeSpa6Eqg9oruhmWr
	 ZW6g5+eTpwG28g+IQi/bFZDE77KpHfn72hs4FjkVc7R1AqK4XQe2+FTTP6v4efpjet
	 DIJajHu6NmcjA==
Message-ID: <sashiko-outbox-233339@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvmet-fc: hold queue reference while freeing FCP IOD
To: "Bin Luo" <luob87709@gmail.com>, linux-nvme@lists.infradead.org
In-Reply-To: <20261125115444.783-1-luob87709@gmail.com>
References: <20261125115444.783-1-luob87709@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 12:15:13 +0000
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
- [Low] nvmet-fc: redundant back-to-back kref_get() and put in
  nvmet_fc_free_fcp_iod()
--

commit 6c7c03981acb44ae799c2343512f506b50503766
Author: Bin Luo <luob87709@gmail.com>

nvmet-fc: hold queue reference while freeing FCP IOD

This commit holds a reference on the target queue in
nvmet_fc_free_fcp_iod() until after queue list operations and deferred
work submission complete.

> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 5d6c1c79508af..0b3a44886c3df 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -733,6 +733,9 @@ nvmet_fc_free_fcp_iod(struct nvmet_fc_tgt_queue *queu=
e,
> =20
>  	tgtport->ops->fcp_req_release(&tgtport->fc_target_port, fcpreq);
> =20
> +	/* Hold queue across the FOD reference put and queue/list accesses. */
> +	kref_get(&queue->ref);
> +
>  	/* release the queue lookup reference on the completed IO */
>  	nvmet_fc_tgt_q_put(queue);
> =20
> @@ -742,6 +745,7 @@ nvmet_fc_free_fcp_iod(struct nvmet_fc_tgt_queue *queu=
e,
>  	if (!deferfcp) {
>  		list_add_tail(&fod->fcp_list, &fod->queue->fod_list);
>  		spin_unlock_irqrestore(&queue->qlock, flags);
> +		nvmet_fc_tgt_q_put(queue);
>  		return;
>  	}
> =20
> @@ -774,6 +778,7 @@ nvmet_fc_free_fcp_iod(struct nvmet_fc_tgt_queue *queu=
e,
>  	 */
> =20
>  	queue_work(queue->work_q, &fod->defer_work);
> +	nvmet_fc_tgt_q_put(queue);
>  }

[Severity: Low]
Can nvmet_fc_free_fcp_iod() drop the early nvmet_fc_tgt_q_put(queue)
instead of pairing it with a kref_get(&queue->ref) right above it?

Since nvmet_fc_tgt_q_put() calls kref_put(&queue->ref, ...), taking
queue->ref and immediately putting it performs two back-to-back atomic
operations on queue->ref that cancel each other out on every FCP I/O
completion.  Removing the early nvmet_fc_tgt_q_put() and letting the two
new puts at the exit paths release the completing FOD's lookup reference
directly would avoid the extra atomic operations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125115444.783-=
1-luob87709@gmail.com?part=3D1

