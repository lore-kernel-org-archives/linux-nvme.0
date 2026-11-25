Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8033B606A68D
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rMUBaRrK;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=IaPqJDfY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xFlN4rclmJ3cTwSoXr8Ud2HB/tsk3Wve0CUo7sMxAvo=; b=rMUBaRrK+J66ZaHDL/o+KQWAAg
	mDBoMh1cd42oflTiqdPw2CcC+Ft81kRz1s5mrk4bwrSmz0tab2V07PXvicQQfzTyv3t6cQ1w6y7LA
	OKaB5Xm9jNDKYFxRZ0ok2FJCN/0F23UBZ69rz6ldSM/jEnkLqoqFLQG/2mUmaQGJdXb08i6RJwFQv
	x4l/bfG9wtoJsInsWp2ulNkoIcJ0Aa1BJ5O6AaGd+cCvazBWuZ1U5HkHHM25vBXSVNxAMTIZYTFnF
	HlN1zRXeCDLr5q8Tkh9JcMdTcYhiwabNkNAloAtzpjWXGn8hoJktwi0ygMDqvDtI2GEwaAt5tZ78B
	YWRg9R9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWAFU-00000009Rsu-3LL9;
	Wed, 25 Nov 2026 10:29:12 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWAFO-00000009Rrx-1DNR
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 10:29:10 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20261125102859epoutp025f8d1fe9c5664625609e6c137a502923~rQv8QoOW53058830588epoutp02M
	for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2026 10:28:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20261125102859epoutp025f8d1fe9c5664625609e6c137a502923~rQv8QoOW53058830588epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795602539;
	bh=xFlN4rclmJ3cTwSoXr8Ud2HB/tsk3Wve0CUo7sMxAvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IaPqJDfY2Ezy3MpR8ljLSiOz0O+P0b4vFneuttWJk9xIn+lvSFVBnb5S9oipbTo7A
	 qCeXi+y4jAXosBQshuTtS3aK+0r3lf2JwN4hFt1aAl9UOPqmRw2ne0wPobijbiakaY
	 GerV6MP3kYoBrjaVl4e5z3EKZZVfh4Hwk9mSunuM=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20261125102859epcas5p1f5a9e8472cf6d472e27e339ec3b48683~rQv8EdnHT0425104251epcas5p1e;
	Wed, 25 Nov 2026 10:28:59 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.91]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4jZGB233Vnz3hhT4; Wed, 25 Nov
	2026 10:28:58 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20261125102729epcas5p13bde0e5ffba2e9660726500efb20ab59~rQuoqdnWa0487904879epcas5p1u;
	Wed, 25 Nov 2026 10:27:29 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261125102728epsmtip1facce2ecf66c1f2173177a007f33f963~rQunpYMbD2682226822epsmtip1S;
	Wed, 25 Nov 2026 10:27:28 +0000 (GMT)
Date: Wed, 25 Nov 2026 15:56:39 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
	Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, Steve Wise
	<larrystevenwise@gmail.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fabrics: limit nr_write_queues and nr_poll_queues
 when parsing
Message-ID: <20261125102639.ikftz2pvdwjuuagd@green245.gost>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261122233951.8912-1-astellman@stellman-greene.com>
X-CMS-MailID: 20261125102729epcas5p13bde0e5ffba2e9660726500efb20ab59
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----oDladO6Vwt0H_RtjxHNT8.74ezodDQj_tEbGsjA-MAFMp74Y=_5226_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261125102729epcas5p13bde0e5ffba2e9660726500efb20ab59
References: <20261122233951.8912-1-astellman@stellman-greene.com>
	<CGME20261125102729epcas5p13bde0e5ffba2e9660726500efb20ab59@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_022908_928670_D8B29625 
X-CRM114-Status: GOOD (  10.32  )
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

------oDladO6Vwt0H_RtjxHNT8.74ezodDQj_tEbGsjA-MAFMp74Y=_5226_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 22/11/26 06:39PM, Andrew Stellman wrote:
>nr_io_queues is limited to num_online_cpus() when the options are
>parsed, but nr_write_queues and nr_poll_queues are stored as given.
>nvme-tcp and nvme-rdma size the queue array with the unsigned int sum
>nr_io_queues + nr_write_queues + nr_poll_queues + 1, which wraps for
>large values, while nvmf_nr_io_queues() limits each term to the online
>CPUs and so asks for more I/O queues than were allocated.
>
>With 4 CPUs and nr_write_queues=2147483647 nr_poll_queues=2147483647 on
>nvme-tcp, the sum wraps to 3, three queues are allocated and 12 I/O
>queues are created:
>

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------oDladO6Vwt0H_RtjxHNT8.74ezodDQj_tEbGsjA-MAFMp74Y=_5226_
Content-Type: text/plain; charset="utf-8"


------oDladO6Vwt0H_RtjxHNT8.74ezodDQj_tEbGsjA-MAFMp74Y=_5226_--

