Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68B8606A31A
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Oct 2026 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Dk7P/7ES;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OI71pfDh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UhzV9ABZjCUBnUIA4jYv3y82UfrD2BwXbsKcZe+VJpY=; b=Dk7P/7ES5Lyh0RG4eUKBLmIww+
	H3SuQyAkdwH1wA9rz9hDdBGU0vj/d9mNDIF7ES4VqYmqKkpIx8PLD2kGxEzmLSX0JnhpiEPGyZ3b3
	cnSFv4dHILx26MR65nLOOv9QA6URTR8xp/wUphFdciyouTA3kRkZaDpPF9xYPdpKozMywNWEzoW/d
	Gtw3f2XyPhurHZAzlVbRh1A+GPhA+6FWDxb5/3smOOGMVcj9MANVJpwfjI8Xf+yBfUOV70n177vgF
	p7NuU64iyUKh6RK0m3mTkapEXNvTANxTMjojL8OnJ94kaGBRMWFfyQLb/DrL4VdAKmiakFYIQCull
	rglT6PwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN5h0-0000000DAos-1lQI;
	Sat, 31 Oct 2026 09:48:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN5gy-0000000DAo7-3LNy
	for linux-nvme@lists.infradead.org;
	Sat, 31 Oct 2026 09:48:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7FFA2438D1;
	Sat, 31 Oct 2026 09:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0011F00919;
	Sat, 31 Oct 2026 09:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440084;
	bh=UhzV9ABZjCUBnUIA4jYv3y82UfrD2BwXbsKcZe+VJpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OI71pfDh8FNFrVRMqjIn+IYtt8miWK15P+Sosms6k9hiiXnXIy/t6QNorcRyh0HdV
	 t+czWaRZgu3tl6B4gHsi9ZPzzJPsRJtwNYGramvxyzQIsKYkb93ZoIvzGi7xrFjtyf
	 Zhg4Q2VMyTsJdCsfg1LLQpiz4+mWuta/rncf7LB2t3141ug26OqqNWOnzD3lXW9Rcg
	 Z1ZRxYgcDEN9MKPC4M8lub58qQM6sMS/aCXctOnWer6zTWUE69WVPDrRsEyIR9tJRO
	 3O1LjBW6ymh4Qu3MHvII6O9AjjVhbDUWFIkj5l6INszhzA06Cq9QvZZZEjuqfr1QrO
	 qmcwLSqV96pkg==
Message-ID: <sashiko-outbox-191877@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] nvmet: preserve ANA log page copy errors
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261031093420.3017-1-sreekuttan2156239@gmail.com>
References: <20261031083505.4767-1-sreekuttan2156239@gmail.com>
 <20261031093420.3017-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 09:48:03 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] nvmet: skipped partial ANA descriptor copy in nvmet_execute_get_lo=
g_page_ana()
--

commit d3533edc412b03d8943fd7010d72c42247b5d211
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

nvmet: preserve ANA log page copy errors

This commit preserves descriptor-copy and allocation errors in
nvmet_execute_get_log_page_ana() instead of overwriting status when copying
the ANA log page header, and skips copying ANA group descriptors when their
length exceeds the remaining transfer length.

> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
> index 26028be8fe4d8..b0bcfbc94b930 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -542,17 +542,23 @@ static void nvmet_execute_get_log_page_ana(struct n=
vmet_req *req)
>  	u32 grpid;
>  	u16 ngrps =3D 0;
>  	u16 status;
> +	u16 header_status;
> =20
>  	status =3D NVME_SC_INTERNAL;
>  	desc =3D kmalloc_flex(*desc, nsids, NVMET_MAX_NAMESPACES);
>  	if (!desc)
>  		goto out;
> =20
> +	status =3D NVME_SC_SUCCESS;
> +
>  	down_read(&nvmet_ana_sem);
>  	for (grpid =3D 1; grpid <=3D NVMET_MAX_ANAGRPS; grpid++) {
>  		if (!nvmet_ana_group_enabled[grpid])
>  			continue;
>  		len =3D nvmet_format_ana_group(req, grpid, desc);
> +		if (offset > req->transfer_len || len > req->transfer_len - offset)
> +			break;
> +
>  		status =3D nvmet_copy_to_sgl(req, offset, desc, len);
>  		if (status)
>  			break;
> @@ -572,7 +578,9 @@ static void nvmet_execute_get_log_page_ana(struct nvm=
et_req *req)
>  	kfree(desc);
> =20
>  	/* copy the header last once we know the number of groups */
> -	status =3D nvmet_copy_to_sgl(req, 0, &hdr, sizeof(hdr));
> +	header_status =3D nvmet_copy_to_sgl(req, 0, &hdr, sizeof(hdr));
> +	if (!status)
> +		status =3D header_status;

[Severity: High]
As reported by Sashiko on v1 [1], in nvmet_execute_get_log_page_ana() in
drivers/nvme/target/admin-cmd.c, when a host issues a Get Log Page command
for NVME_LOG_ANA with req->transfer_len ending partway through an enabled A=
NA
group descriptor (offset < req->transfer_len < offset + len), does breaking
out of the loop before calling nvmet_copy_to_sgl() leave the trailing
[offset, req->transfer_len) portion of req->sg unwritten?

In drivers/nvme/target/core.c, nvmet_copy_to_sgl() wraps
sg_pcopy_from_buffer():

u16 nvmet_copy_to_sgl(struct nvmet_req *req, off_t off, const void *buf,
		size_t len)
{
	if (sg_pcopy_from_buffer(req->sg, req->sg_cnt, buf, len, off) !=3D len) {
		req->error_loc =3D offsetof(struct nvme_common_command, dptr);
		return NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
	}
	return 0;
}

Previously, when offset < req->transfer_len and offset + len >
req->transfer_len, sg_pcopy_from_buffer() still copied the first
req->transfer_len - offset bytes of desc to fill req->sg up to
req->transfer_len before returning a short count, and the final header copy
at offset 0 reset status to 0.

Because nvmet transports allocate req->sg with capacity req->transfer_len
without zeroing it and transmit the full req->transfer_len on completion,
skipping nvmet_copy_to_sgl() when len > req->transfer_len - offset omits the
partial descriptor bytes that fit in the buffer and exposes req->transfer_l=
en
- offset bytes of uninitialized kernel memory to the host.

Also, since req->sg has total capacity req->transfer_len,
sg_pcopy_from_buffer() only returns less than len when off + len exceeds
req->transfer_len. With the pre-check ensuring offset + len <=3D
req->transfer_len, can nvmet_copy_to_sgl(req, offset, desc, len) ever return
a non-zero status here?

[1] https://lore.kernel.org/r/20261031083505.4767-1-sreekuttan2156239@gmail=
.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031093420.3017=
-1-sreekuttan2156239@gmail.com?part=3D1

