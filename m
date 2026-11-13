Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB2606A8AA
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zQnfqVQD;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZ0nGwjw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MhfgKwbasrCVcesvtSIzmyPCwlK0O+X4pOMtLALs5hM=; b=zQnfqVQDLmIa2kILXdOaxTSXqK
	1uFQaBEQGNZs+1PR+kJBUDvOdGy/oZymjlYmDzXUbiN/Y387Mgr1W0EgGmnBDCKc9EiZ5s4GHaJb5
	ns/bmImuhJIZZnCKDF1b/JKRqx+TERrrsMMDKdtrenmBSCPCidqRffzaiDGAKKjycXCUkxPgRtk37
	OroAWPZmnXocWFGAN6k7F27RXaLAE4lab75JUN/FPXA6BufdED+WSVOzR0TgCFr+ZkOQfTXM3KFnk
	8V7tXDcKopkAqZFARidnTvy7VPwuIhNj0ayBLpBSg27OJ+k+71vd/X3LJlJDLQX/xUde6ZqIB5aVB
	asbKaI6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoZ4-0000000CNNZ-1LTp;
	Fri, 13 Nov 2026 10:31:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoZ1-0000000CNMa-2FhY
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:31:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 215B8466AA;
	Fri, 13 Nov 2026 10:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E59E1F000C4;
	Fri, 13 Nov 2026 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565883;
	bh=MhfgKwbasrCVcesvtSIzmyPCwlK0O+X4pOMtLALs5hM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QZ0nGwjwbFT5/0UqQlQOqloIqVpmJQtyPKbypXiHH4u9UmV35jhvS0moU8HiPhERK
	 OYtkqSX92q69Km9I4E8xNYYOMsxYyYzOmXoSgwzTwneQy18R5aX22/n969sGiVNwUL
	 6SUjKYMS3YUWhkS730JAWOH945Y/h8aFp/ldtTYn9DZ7LL5i9bkSEEiu0YEONnjq3D
	 xBjU3Kng985IW7lsgwiiD5Yt8IncJNsiU+zlT2ZFITzjjNszvDT0Fj1S2FOGNp1Y+p
	 NHoypfS8qMH5/GUnYxyMB7mSIDnAR6qBjDTfSdABUy8fdWSXOA2F2oVUD+QatOiZtK
	 wJ1580x/47tmQ==
Date: Fri, 13 Nov 2026 11:31:17 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Arthur Simchaev <arthur.simchaev@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, Andres Freund <andres@anarazel.de>, Pankaj Raghav <pankaj.raghav@linux.dev>, GOST <gost.dev@samsung.com>, Daniel Gomez <da.gomez@samsung.com>, Avi.Shchislowski@sandisk.com, Alex.Lemberg@sandisk.com
Subject: Re: [PATCH RFC 2/2] nvme: enable multiple atomicity mode
Message-ID: <20261113104220.2-da.gomez@kernel.org>
In-Reply-To: <20261103093856.203861-1-arthur.simchaev@sandisk.com>
References: <20260929-nvme-mam-v1-2-48dcbe79cece@samsung.com> <20261103093856.203861-1-arthur.simchaev@sandisk.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: lorebird
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026-11-03T11:38:56+02:00, Arthur Simchaev <arthur.simchaev@sandisk.com> wrote:
> On Tue, Sep 29, 2026 at 01:17:12PM +0200, Daniel Gomez wrote:
> [...]
> > @@ -993,6 +993,9 @@ static bool nvme_valid_atomic_write(struct request *req)
> >  	struct request_queue *q = req->q;
> >  	u32 boundary_bytes = queue_atomic_write_boundary_bytes(q);
> >  
> > +	if (q->limits.features & BLK_FEAT_ATOMIC_WRITE_MULTI)
> > +		return true;
> > +
>
> With the flag set this skips all checks. Since each REQ_ATOMIC bio carries
> exactly one RWF_ATOMIC write (blkdev and iomap reject atomic writes that need
> more than one bio), could it instead check every bio of the merged request with
> __rq_for_each_bio(), using the existing size and boundary checks? That would
> keep the safety net described in the comment above the function, at the cost of
> a few comparisons per bio.

I don't think this is really necessary in NVMe. But I agree with the
suggestion to honor the request and potentially other drivers that may
be more strict.

>
> [...]
> > +static bool nvme_mam_compliant(struct nvme_id_ns *id)
> > +{
> > +	if (id->nabspf != id->nawupf)
> > +		return false;
> > +	if (id->nabsn && id->nabsn != id->nabspf)
> > +		return false;
> > +	if (id->nawun && id->nawun != id->nawupf)
> > +		return false;
> > +	return true;
> > +}
>
> This deliberately accepts NABSN == 0 and NAWUN == 0. I assume this is because
> Linux only uses the power-fail values (NAWUPF/NABSPF) for atomic writes? If so,

I'll work on the clarification.

> a comment would help. Still, NVM Command Set 1.1 Figure 9 requires NABSN to
> equal NAWUN (or AWUN when NAWUN is not reported) and NABSPF in MAM. NABSN == 0
> means no boundary for normal operation while the device claims MAM, and NAWUN ==
> 0 would need NABSN == AWUN, which the driver does not track today. Would it be
> safer to treat both as inconsistent, as your QEMU series does?

I'd need to double check this.

>
> [...]
> > +		if (id->nsfeat & NVME_NS_FEAT_MAM) {
> > +			if (nvme_mam_compliant(id))
> > +				lim->features |= BLK_FEAT_ATOMIC_WRITE_MULTI;
> > +			else
> > +				dev_warn_once(ns->ctrl->device,
> > +					"Inconsistent MAM parameters, ignoring\n");
> > +		}
>
> Minor: dev_warn_once() uses one static flag per call site, so only the first
> affected controller is reported. Maybe dev_warn() (this runs on namespace scan,
> not in the I/O path), and print the four values to make the report actionable?

Do we need the 4 values when users can check them out with nvme-cli?



