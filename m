Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB10D606A327
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hVw1Z2ih;
	dkim=pass (2048-bit key, unprotected) header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b=tK8+6UlZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mSIOrvwCljTuyfqFX+dIixZrw7yR8HkFNXQP1Zue3go=; b=hVw1Z2ihDkqwFT
	qLUVmXzAnjvSK6Fb9kGQFPBION43LsUeaanrCrQUlnfSq8eox5Yl1L9hDgJaBL15WMEhL8jXn/WQj
	b+/Y/VFpnOyCkTfuIcoi5IlbgHaMkGBk/4GfDFI/+S2VnPQLEXyBDn8IIpD/3j3VnE/Aqeie6/6VT
	E8WSRc2tRHv6RYHr3MxQYP8JF43WMvsHyFqbRV/a0zcrQszsheFwqBs0dDZWN2mPppOKTwhRiurYX
	rjBh5jlILYxQmvosWXyN3gzKBj3J6l9iNix20s6kIkLGbkRK+SwbBjqkLc6f7p9rr53jDqgzoC0Yc
	sMNxzgTacbiLZmbQlUnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOAyw-00000001lws-2iru;
	Tue, 03 Nov 2026 09:39:06 +0000
Received: from esa.hc6817-7.iphmx.com ([216.71.154.88])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOAyt-00000001lw3-4B7n
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 09:39:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1793698743; x=1825234743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zBreZxYH0dOG14vJK5tWIMeKPJMWwqSlb7VxpR6aVnQ=;
  b=tK8+6UlZCBCl+aWT6o5ZTF96kxcWJ1Gy7gsMN7mvJOO8BDQ47mfp61pE
   u9Alyw1RceI/MorYYsts+hiaUX9vP+9+ew2K4pYB+mcmDyNYdn8n1Arhe
   L+hz4lXOKqVfPiFEcMT3bjAONE5vsdNZ6KV1jUWX3KoSvMtkqGO2lVOhO
   ZLTurTj6sMUo9f1HVuRx0OFAAAbdYUtaQEv0LESWjxbMRZliG2smfaJzK
   RpWhDC6drdUNxQ/TNiy7xPIOnB9/OBEzSqwlSTRs1YruI3+uq0heDAVtd
   hLFcDHvq8ReSn5mrG6qo9AxMw3V/R9EVj19bfSiv4Zfx011q6WD/ZZLTr
   g==;
X-CSE-ConnectionGUID: iyg/JkqUTRW0dLS7vUohGg==
X-CSE-MsgGUID: pygKvoxxSo+rffo500kE6g==
Received: from unknown (HELO uls-op-esaep03.corp.sandisk.com) ([129.253.192.43])
  by ob1.hc6817-7.iphmx.com with ESMTP; 03 Nov 2026 01:39:03 -0800
X-CSE-ConnectionGUID: sEnfVlLJRr+etljIN9EN1g==
X-CSE-MsgGUID: ADX3diwKQferIEn4FkNnMw==
IronPort-SDR: 6ae9abb7_yJDFh2yRdQRSrgs2NzOwkrIiFJtlOAfg3Z0hBZJPDI1XxVY
 HAmPOjsT9md9sxfwliuz3940I+3AZyWwVjozOeg==
Received: from unknown (HELO uls-op-esaip04.corp.sandisk.com) ([10.15.0.10])
  by uls-op-esaep03.corp.sandisk.com with ESMTP; 03 Nov 2026 01:39:03 -0800
X-CSE-ConnectionGUID: YyJbVwm8T5OsfVdkoZ50MA==
X-CSE-MsgGUID: I9QSv+peTUeEftWkqLk7pg==
SanDiskIronportException: Internal
Received: from ulssdxvpxsnip.corp.sandisk.com (HELO WDAP-ez2C89klLd.corp.sandisk.com) ([10.9.34.160])
  by uls-op-esaip04.corp.sandisk.com with ESMTP; 03 Nov 2026 01:38:59 -0800
From: Arthur Simchaev <arthur.simchaev@sandisk.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Andres Freund <andres@anarazel.de>,
	Pankaj Raghav <pankaj.raghav@linux.dev>,
	GOST <gost.dev@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Avi.Shchislowski@sandisk.com,
	Alex.Lemberg@sandisk.com
Subject: Re: [PATCH RFC 2/2] nvme: enable multiple atomicity mode
Date: Tue,  3 Nov 2026 11:38:56 +0200
Message-ID: <20261103093856.203861-1-arthur.simchaev@sandisk.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929-nvme-mam-v1-2-48dcbe79cece@samsung.com>
References: <20260929-nvme-mam-v1-2-48dcbe79cece@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_013904_072848_8E8850C0 
X-CRM114-Status: GOOD (  15.12  )
X-Spam-Score: -4.4 (----)
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Sep 29, 2026 at 01:17:12PM +0200, Daniel Gomez wrote:
[...]
> @@ -993,6 +993,9 @@ static bool nvme_valid_atomic_write(struct request *req)
>  	struct request_queue *q = req->q;
>  	u32 boundary_bytes = queue_atomic_write_boundary_bytes(q);
>  
> +	if (q->limits.features & BLK_FEAT_ATOMIC_WRITE_MULTI)
> +		return true;
> +

With the flag set this skips all checks. Since each REQ_ATOMIC bio carries
exactly one RWF_ATOMIC write (blkdev and iomap reject atomic writes that need
more than one bio), could it instead check every bio of the merged request with
__rq_for_each_bio(), using the existing size and boundary checks? That would
keep the safety net described in the comment above the function, at the cost of
a few comparisons per bio.

[...]
> +static bool nvme_mam_compliant(struct nvme_id_ns *id)
> +{
> +	if (id->nabspf != id->nawupf)
> +		return false;
> +	if (id->nabsn && id->nabsn != id->nabspf)
> +		return false;
> +	if (id->nawun && id->nawun != id->nawupf)
> +		return false;
> +	return true;
> +}

This deliberately accepts NABSN == 0 and NAWUN == 0. I assume this is because
Linux only uses the power-fail values (NAWUPF/NABSPF) for atomic writes? If so,
a comment would help. Still, NVM Command Set 1.1 Figure 9 requires NABSN to
equal NAWUN (or AWUN when NAWUN is not reported) and NABSPF in MAM. NABSN == 0
means no boundary for normal operation while the device claims MAM, and NAWUN ==
0 would need NABSN == AWUN, which the driver does not track today. Would it be
safer to treat both as inconsistent, as your QEMU series does?

[...]
> +		if (id->nsfeat & NVME_NS_FEAT_MAM) {
> +			if (nvme_mam_compliant(id))
> +				lim->features |= BLK_FEAT_ATOMIC_WRITE_MULTI;
> +			else
> +				dev_warn_once(ns->ctrl->device,
> +					"Inconsistent MAM parameters, ignoring\n");
> +		}

Minor: dev_warn_once() uses one static flag per call site, so only the first
affected controller is reported. Maybe dev_warn() (this runs on namespace scan,
not in the I/O path), and print the four values to make the report actionable?

Regards,
Arthur

