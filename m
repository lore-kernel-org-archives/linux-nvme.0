Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA47606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=c4/DGUpP;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WX93+sMm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=T1rIzJ27c6rMtFc7tmv5MhVtaOfOgICGGa6xTBWBHE0=; b=c4/DGUpPdXr3RcaP3Wa/qHHv3o
	yprkFordigDtFhEalnHvun5HYYXDOFoG0ycn1apw05/TJcZ6rv8HmOLtZhRtsGwmA9Nkm1v+m7o37
	POeqGzVtNoE/xlNkyyhM/r5ony65W7UluMRnwsGiscmkR0C+ace/nZYkvHzVTEmMt1Dt00L+kzseG
	GIoTBEgIFxpSw7JRqqGSMU3SLM+5UPISQ3zob4COjHR9iSi+6Iee2J8LrrkeeHXKq+9WEx2RRQWG+
	rjYJZ8/WKpLKdOIoaX60dU5DnCQPUdsvyfTZDFBVieQ0VotTkplRVxUtbzPI5tu218Toa0dBkr9iu
	Jg2pDv5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6TM-00000008fV3-0jMB;
	Wed, 25 Nov 2026 06:27:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6TL-00000008fUr-2KOk
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 06:27:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EE165408A5;
	Wed, 25 Nov 2026 06:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0CA1F000C4;
	Wed, 25 Nov 2026 06:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795588034;
	bh=T1rIzJ27c6rMtFc7tmv5MhVtaOfOgICGGa6xTBWBHE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WX93+sMmQdYXSt+/wt5tqgjhHk22K1+8G84tO2Nv6AY34Fv0WFqQ09mwq8DDc+rcW
	 2B3JDitxbtmiceddSFnq+pwq6TsjKqh/2Nog1APRvyBVoEv3tCCoHfmAERRZhBfOg5
	 T3fLMrvsWlGmpNnbkT22NNuG1yiCHUdpuMiKDJmQZ25KvEbdmL5X2iKskAaCKywZBW
	 FqlDnXjz6SKPW9VC512coRsS9UMYy0phSLr+Ve9qOcxlXw81cHw+PKo62AzwGk8R3Z
	 pCDJdJQR69BkVZGWNtRp2dNZGgP00GisMGRfxeFDpaUl569Q7rHrue9C0s+QmXLadN
	 0xCUDLb4egF0Q==
Message-ID: <sashiko-outbox-232691@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvmet: zero the reservation report tail beyond NUMD
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261125061453.230238-1-kanie@linux.alibaba.com>
References: <20261125061453.230238-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 06:27:14 +0000
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
- [Critical] nvmet: torn read of rkey in nvmet_pr_update_reg_rkey() [1]
--

commit 58bea4d71647eb54c1d0685be4714b3cb40c9a6f
Author: Guixin Liu <kanie@linux.alibaba.com>

nvmet: zero the reservation report tail beyond NUMD

This commit zeroes any remaining bytes in the command SGL beyond the
requested reservation report size in nvmet_execute_pr_report() so that
uninitialized kernel memory is not returned to the host.

> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
> index 8c818f24815bd..63ea607d48646 100644
> --- a/drivers/nvme/target/pr.c
> +++ b/drivers/nvme/target/pr.c
> @@ -900,6 +900,9 @@ static void nvmet_execute_pr_report(struct nvmet_req =
*req)
> =20
>  	put_unaligned_le16(num_ctrls, data->regctl);
>  	status =3D nvmet_copy_to_sgl(req, 0, data, num_bytes);
> +	if (!status && req->transfer_len > num_bytes)
> +		status =3D nvmet_zero_sgl(req, num_bytes,
> +					req->transfer_len - num_bytes);
>  	kfree(data);
>  out:
>  	nvmet_req_complete(req, status);

[Severity: Critical]
This problem wasn't introduced by this patch, but can RCU readers such as
nvmet_execute_pr_report() observe a torn 64-bit reg->rkey [1] on
32-bit architectures?

When the target registrant is not the current reservation holder,
nvmet_pr_update_reg_attr() updates the live entry in pr->registrant_list
in place via nvmet_pr_update_reg_rkey():

drivers/nvme/target/pr.c:nvmet_pr_update_reg_rkey() {
	reg->rkey =3D *(u64 *)attr;
}

drivers/nvme/target/pr.c:nvmet_pr_update_reg_attr() {
	...
	if (reg !=3D holder) {
		change_attr(reg, attr);
		return NVME_SC_SUCCESS;
	}
	...
}

On 32-bit systems, the 64-bit store to reg->rkey splits into two 32-bit
stores, so a concurrent RCU reader can observe half of the old key and
half of the new key, corrupting the reported key or causing reservation
validation failures.

[1] https://sashiko.dev/#/bug/linux-b537252d-fab1-48b2-bcc6-de089d7cd907

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125061453.2302=
38-1-kanie@linux.alibaba.com?part=3D1

