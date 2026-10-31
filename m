Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF1D606A31C
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Oct 2026 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qQmFwFKj;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmTX1fp6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SlJ2nuAXRS3J78+B743Bvt2saDbJrdU/ZeRQWeafmXI=; b=qQmFwFKjLfXQ/kW5C7YbUyxDQI
	rmzZYzjcUe1Vs3QiVVwa9tqv+5Zm14f0NXsBaSaGAFFgBPFtaKV8PPshj+7M0zd3YygQkGzx8teYs
	rgEtHVtoVGtgfYQyh3JOg9506Tf9SY6+aKG1PUi/M6LU9byNgtq8Gl7zhfNQ0A6GaYQpKSCnP0iaY
	6J/DnzQlj6sR0IgrLCV9NDnDc6B8npSoIg+eU+/T1EXpkODOuEGAh7aGbwXZBsjvY6ib7PZG9U+IA
	7dnGIOx5fR8Z4lO7AstCpw2Y2Q9odTnv+WDnWSc9GD9GTQDBCk10qXBjFxuMmnEYx8oOMx9oX91gE
	dJcLHQ+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN4gI-0000000D58G-1wzv;
	Sat, 31 Oct 2026 08:43:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN4gH-0000000D580-0szE
	for linux-nvme@lists.infradead.org;
	Sat, 31 Oct 2026 08:43:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6116F605C9;
	Sat, 31 Oct 2026 08:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25261F00A15;
	Sat, 31 Oct 2026 08:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793436196;
	bh=SlJ2nuAXRS3J78+B743Bvt2saDbJrdU/ZeRQWeafmXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gmTX1fp6XrUfit3J5lIrjhLN66TtrHLSynYgFsgq4RDczq961hnjMzv0kuu8fpcds
	 TPLRG2BvSruTQ3wbePoaV6k2iCfHlp6yQxQqDwJXfm3q2lDprS6mvvf52ka5cgKBk5
	 c7ISqY4Tox4KqY7aMWRneCYEESbGzHUAygbnl13SlevPetxUVxhRP5Lhn3VmjH7GoM
	 0Lv50xQ57fi1ENvSq/eQ0BDS9t1OtNZzBpqX2AvQEgrl7NVE8MMCdy4by8jp/qT0em
	 XESW1ycG4/8eva7B07iGzOFzHT5OCNO/4FnL6k+adyQKxijg69TaOH8+w4yNSgrrG0
	 m/TwXIc+QfPpQ==
Message-ID: <sashiko-outbox-191840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvmet: preserve ANA log page copy errors
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261031083505.4767-1-sreekuttan2156239@gmail.com>
References: <20261031083505.4767-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 08:43:15 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] nvmet: allocation failure in nvmet_execute_get_log_page_ana() retu=
rns success
- [High] nvmet: nvmet_execute_get_log_page_ana() breaks short ANA log page =
reads
--

commit a674cf164d41aef50b30cbe7f108586cbc265b8d
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

nvmet: preserve ANA log page copy errors

This commit initializes the status variable in
nvmet_execute_get_log_page_ana() to success and only copies the ANA log page
header if no error occurred while copying the ANA group descriptors.

> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
> index 26028be8fe4d8..2bcb6d3de9eca 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -543,7 +543,7 @@ static void nvmet_execute_get_log_page_ana(struct nvm=
et_req *req)
>  	u16 ngrps =3D 0;
>  	u16 status;
> =20
> -	status =3D NVME_SC_INTERNAL;
> +	status =3D NVME_SC_SUCCESS;
>  	desc =3D kmalloc_flex(*desc, nsids, NVMET_MAX_NAMESPACES);
>  	if (!desc)
>  		goto out;

[Severity: High]
If kmalloc_flex() returns null in nvmet_execute_get_log_page_ana() in
drivers/nvme/target/admin-cmd.c, won't jumping to the out label now complete
the request with a success status instead of an internal error status witho=
ut
writing any data to the host buffer?

Previously, status was initialized before kmalloc_flex() so that the error
path on allocation failure would report an internal error:

drivers/nvme/target/admin-cmd.c:nvmet_execute_get_log_page_ana() {
	...
	status =3D NVME_SC_SUCCESS;
	desc =3D kmalloc_flex(*desc, nsids, NVMET_MAX_NAMESPACES);
	if (!desc)
		goto out;
	...
out:
	nvmet_req_complete(req, status);
}

> @@ -572,7 +572,8 @@ static void nvmet_execute_get_log_page_ana(struct nvm=
et_req *req)
>  	kfree(desc);
> =20
>  	/* copy the header last once we know the number of groups */
> -	status =3D nvmet_copy_to_sgl(req, 0, &hdr, sizeof(hdr));
> +	if (!status)
> +		status =3D nvmet_copy_to_sgl(req, 0, &hdr, sizeof(hdr));

[Severity: High]
Does guarding the header copy with if (!status) in
nvmet_execute_get_log_page_ana() in drivers/nvme/target/admin-cmd.c break
short reads of the variable-length ana log page?

In nvmet_copy_to_sgl(), a non-zero status is returned when the copy exceeds
req->sg length (for example, when a host requests only sizeof(struct
nvme_ana_rsp_hdr) bytes to inspect chgcnt and ngrps before allocating a
buffer for the full log page):

drivers/nvme/target/core.c:nvmet_copy_to_sgl() {
	if (sg_pcopy_from_buffer(req->sg, req->sg_cnt, buf, len, off) !=3D len) {
		req->error_loc =3D offsetof(struct nvme_common_command, dptr);
		return NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
	}
	return 0;
}

In nvmet_execute_get_log_page_ana(), when a descriptor does not fit in the
host buffer, the first loop breaks out early and the second loop (added in
commit be1277f5eb17 ("nvme: count all ANA groups for ANA Log page")) counts
the remaining enabled groups specifically so hdr.ngrps holds the total group
count when hdr is written at offset 0:

drivers/nvme/target/admin-cmd.c:nvmet_execute_get_log_page_ana() {
	...
	for (grpid =3D 1; grpid <=3D NVMET_MAX_ANAGRPS; grpid++) {
		if (!nvmet_ana_group_enabled[grpid])
			continue;
		len =3D nvmet_format_ana_group(req, grpid, desc);
		status =3D nvmet_copy_to_sgl(req, offset, desc, len);
		if (status)
			break;
		offset +=3D len;
		ngrps++;
	}
	for ( ; grpid <=3D NVMET_MAX_ANAGRPS; grpid++) {
		if (nvmet_ana_group_enabled[grpid])
			ngrps++;
	}

	hdr.chgcnt =3D cpu_to_le64(nvmet_ana_chgcnt);
	hdr.ngrps =3D cpu_to_le16(ngrps);
	nvmet_clear_aen_bit(req, NVME_AEN_BIT_ANA_CHANGE);
	up_read(&nvmet_ana_sem);
}

With if (!status) before copying hdr, any short read that breaks out of the
first loop skips writing hdr, fails the command, renders the second loop de=
ad
work, and still clears the asynchronous event bit via nvmet_clear_aen_bit()
even though the command fails.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031083505.4767=
-1-sreekuttan2156239@gmail.com?part=3D1

