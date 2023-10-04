Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89AAE7B5F5
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Oct 2023 11:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5EyetCJEC/MoTj6t1PP+QfnfcAe1AO87KAQSjgTsJTk=; b=OKJ8wewh7erTK03FEm+m1uwaIr
	dxY3VnUO+dSWktCIqcOyS8PvekpNQnt0dESOZ3yEX7ne6A2lp04p7vBAvOwQU5hJ8HXCdPRLqaSjS
	ZDUcNykuo7doN2hs/8eSLzgNidlURrBCDn74ogMeW5Y0V0/98ZSjCVSdl1FbBf4SFQmk/2Krwapbh
	oHbsNc/7+XcrPu24Ek3USoNY3dWxeIPh6dFl/1zOw6tYHey9xRuzaDrGsErpSf3Trggelh8xHB4wt
	33Rw0PKL3Q5YPvXQXNK9DqT3FGp8mH3j0u1z57p1DqqAeZ0lvUIW4XFpz4BrRQs8DOIbDmyx3DMoM
	eljiYisg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo0EO-00HVEO-1A;
	Wed, 04 Oct 2023 11:39:56 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qo0EJ-00HVCB-3A
	for linux-nvme@lists.infradead.org;
	Wed, 04 Oct 2023 11:39:54 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231004113944euoutp01015704250858c20a8343837f0b94a08c~K5J-bakzc0687406874euoutp01T
	for <linux-nvme@lists.infradead.org>; Wed,  4 Oct 2023 11:39:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231004113944euoutp01015704250858c20a8343837f0b94a08c~K5J-bakzc0687406874euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1696419584;
	bh=5EyetCJEC/MoTj6t1PP+QfnfcAe1AO87KAQSjgTsJTk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=d9I5OQ+O4muNMGN68JylDe4bf1znv29ZQHJiAKbeHSRoSYKZXYbj3CdVzF9HorF9g
	 IjomXFljm2M0XsodS+5LdoyBYhYHyzEVKI75O9hNozK7tE5qh0kITRjL8O1JPY7XSV
	 SeBETzB//0hY1WPxg+f/cZDCq+48KdENFxvVbKfo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231004113944eucas1p2dff9bfa6ad520de6293edc191458e4af~K5J-D7na40425004250eucas1p2R;
	Wed,  4 Oct 2023 11:39:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C6.74.11320.00F4D156; Wed,  4
	Oct 2023 12:39:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231004113943eucas1p23a51ce5ef06c36459f826101bb7b85fc~K5J_mFlv82099320993eucas1p2_;
	Wed,  4 Oct 2023 11:39:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231004113943eusmtrp20a065a1aa77a862031c2af256748880e~K5J_lEQs71686816868eusmtrp2T;
	Wed,  4 Oct 2023 11:39:43 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-67-651d4f006761
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 65.6D.25043.FFE4D156; Wed,  4
	Oct 2023 12:39:43 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231004113943eusmtip206e9477e2972dd6b1ec12114cb7617c9~K5J_Y2-6B3057530575eusmtip24;
	Wed,  4 Oct 2023 11:39:43 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 4 Oct 2023 12:39:42 +0100
Date: Wed, 4 Oct 2023 13:39:41 +0200
From: Pankaj Raghav <p.raghav@samsung.com>
To: John Garry <john.g.garry@oracle.com>
CC: <axboe@kernel.dk>, <kbusch@kernel.org>, <hch@lst.de>,
	<sagi@grimberg.me>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<djwong@kernel.org>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<chandan.babu@oracle.com>, <dchinner@redhat.com>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-xfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <tytso@mit.edu>, <jbongio@google.com>,
	<linux-api@vger.kernel.org>, Alan Adamson <alan.adamson@oracle.com>,
	<p.raghav@samsung.com>
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
Message-ID: <20231004113941.zx3jlgnt23vs453r@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-22-john.g.garry@oracle.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7djPc7oM/rKpBm3fxS329J9islh9t5/N
	4vXhT4wWl47KWZx9NZfd4vITPouVq48yWZzc/57NYtGNbUwWF37tYLSYdOgao8Xm7x1sFntv
	aVvs2XuSxeLyrjlsFvOXPWW32PVnB7vF8uP/mCzWvX7PYtHa85Pd4vzf46wOoh4LNpV6nL+3
	kcXj8tlSj02rOtk8Jiw6wOixeUm9x+6bDWweTWeOMnt8fHqLxeP9vqtsHp83yXlsevKWKYAn
	issmJTUnsyy1SN8ugSvj4I9jjAUrOSvajnexNDAeY+9i5OSQEDCR2Dj5AHMXIxeHkMAKRomm
	l+cZIZwvjBK7Gn6zQzifGSVO/f/NCtMy+9oNFojEckaJZcteMcJVbXr4gxXC2cwo0fG9E6iM
	g4NFQEXiQ7M0iMkmoCXR2MkOYooIaEgcOSQNUs0ssJpFYsrnt2ALhAXMJI7svsIMYvMKmEv8
	WfGIFcIWlDg58wkLiM0soCOxYPcnNpA5zALSEsv/cYCYnAIOEg8XxUOcqSTRsPkMC4RdK7G3
	+QDUx984Jbbv84ewXSRW3bjCBmELS7w6vgWqRkbi/875TBB2tcTTG7/BISQh0MIo0b9zPdha
	CQFrib4zORA1jhKzZn5nhAjzSdx4KwhxJJ/EpG3TmSHCvBIdbUIQ1WoSq++9YZnAqDwLyVuz
	kLw1C+GtBYzMqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQJT5el/x7/sYFz+6qPeIUYm
	DsZDjBIczEoivOkNMqlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEebVtTyYLCaQnlqRmp6YWpBbB
	ZJk4OKUamAKlOlnPJ3yQLWNY+jKqbS/vEvaitb/r9+fuUL9Zcq537r9toQF1oZ6pe57MbfMv
	b3I6UijnInRpb/BiGY4Xs0NrdunU7n/157fhMiuz7u+imvp8VqcfxEUtCpj8bgGHsMouUUFO
	j6cO9+P5729eKhkw7+NcA5X/Bj/Tlk7LDVjro7Sba43cNUWWlrzea1cWHhVeHiy4pyB+m+ir
	j8bnJv3NDVN11Ju5cVHx3B0qTguiP3hUOaj/mP02drER6/rPz9ntJbc/Tf2VWpK2eNXGrezJ
	20UKhOeesUx5+O7NqyIf5hd9dzovTTka/OlF8vWO/tK5smplK3yTYjNvHXjtJ7xrgV/p8y2f
	+pLuRX6UKFRiKc5INNRiLipOBADfaNVWBAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e/4Pd3/frKpBlfazCz29J9islh9t5/N
	4vXhT4wWl47KWZx9NZfd4vITPouVq48yWZzc/57NYtGNbUwWF37tYLSYdOgao8Xm7x1sFntv
	aVvs2XuSxeLyrjlsFvOXPWW32PVnB7vF8uP/mCzWvX7PYtHa85Pd4vzf46wOoh4LNpV6nL+3
	kcXj8tlSj02rOtk8Jiw6wOixeUm9x+6bDWweTWeOMnt8fHqLxeP9vqtsHp83yXlsevKWKYAn
	Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j4I9j
	jAUrOSvajnexNDAeY+9i5OSQEDCRmH3tBksXIxeHkMBSRolbFx6zQCRkJDZ+ucoKYQtL/LnW
	xQZR9JFR4s21c1Admxklfv7fA+RwcLAIqEh8aJYGMdkEtCQaO9lBTBEBDYkjh6RBqpkFVrJI
	/Dx8jRlkprCAmcSR3VfAbF4Bc4k/Kx6B7RISKJHoPfmLBSIuKHFy5hMwm1lAR2LB7k9sIDOZ
	BaQllv/jADE5BRwkHi6Kh7hSSaJh8xmo62slOl+dZpvAKDwLyaBZSAbNQhi0gJF5FaNIamlx
	bnpusZFecWJucWleul5yfu4mRmDK2Hbs55YdjCtffdQ7xMjEwXiIUYKDWUmEN71BJlWINyWx
	siq1KD++qDQntfgQoykwGCYyS4km5wOTVl5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6Yklq
	dmpqQWoRTB8TB6dUA1P8s7qDx2ufL/vxeEP8tUWRYo4BKu967rAEGb7SvKmm+Cbw62WnR5+P
	rG16LXvvoNia2hks0+v++lp9bl1W5cnEZ6x2/vqfOGu2UuH40+xv7+fd0b4nKxd0Y4n5wpuf
	ps39YRa65VLZi88XU+66PAvRO7FHSOwyp+j8SQm9F3Lu/fuzoUBl96FVS8OF1O8dWd/jeL1z
	1hIOW3GTLxP/Xfq07tD6Wz+uGIdMS8zV+3H/X9p1P77v+/NmLT0mWqj8lME4c2G++oFPkk9F
	nZfVn9mRa9nJ++fPN+1QqbYmN3n/PpHDixq4ps7j5VJ4Mb9Iff9Lk9eSHL+n8VWdUQxm5nTk
	3bItm1u25qNIFHfwPbtEJZbijERDLeai4kQADCX/S6IDAAA=
X-CMS-MailID: 20231004113943eucas1p23a51ce5ef06c36459f826101bb7b85fc
X-Msg-Generator: CA
X-RootMTR: 20231004113943eucas1p23a51ce5ef06c36459f826101bb7b85fc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231004113943eucas1p23a51ce5ef06c36459f826101bb7b85fc
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
	<20230929102726.2985188-22-john.g.garry@oracle.com>
	<CGME20231004113943eucas1p23a51ce5ef06c36459f826101bb7b85fc@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_043952_282886_91B895A4 
X-CRM114-Status: GOOD (  13.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +++ b/drivers/nvme/host/core.c
> @@ -1926,6 +1926,35 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	blk_queue_io_min(disk->queue, phys_bs);
>  	blk_queue_io_opt(disk->queue, io_opt);
>  
> +	atomic_bs = rounddown_pow_of_two(atomic_bs);
> +	if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf) {
> +		if (id->nabo) {
> +			dev_err(ns->ctrl->device, "Support atomic NABO=%x\n",
> +				id->nabo);
> +		} else {
> +			u32 boundary = 0;
> +
> +			if (le16_to_cpu(id->nabspf))
> +				boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
> +
> +			if (is_power_of_2(boundary) || !boundary) {
> +				blk_queue_atomic_write_max_bytes(disk->queue, atomic_bs);
> +				blk_queue_atomic_write_unit_min_sectors(disk->queue, 1);
> +				blk_queue_atomic_write_unit_max_sectors(disk->queue,
> +									atomic_bs / bs);
blk_queue_atomic_write_unit_[min| max]_sectors expects sectors (512 bytes unit)
as input but no conversion is done here from device logical block size
to SECTORs.
> +				blk_queue_atomic_write_boundary_bytes(disk->queue, boundary);
> +			} else {
> +				dev_err(ns->ctrl->device, "Unsupported atomic boundary=0x%x\n",
> +					boundary);
> +			}
> 

