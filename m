Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4047DC53209
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZheSaNgHeOAB2uoTnWJoErBgw1OSg4botxZ264U/G2U=; b=oNbiVA5jiFTXofMVPieYaaT/dH
	6EFbYpgKv/jufe9bXvVFP/Bt90L1W4ErDekL5/kyQQJ2wgYH/gHSP99w/VYAZ7boc+MEC0lns8xC2
	nKybvwgMRoE+7yP6pgGJ+GMVh7HQcUUv8iv8UgIHX5tVSXxJroI5HMVoX+b2y0STMz5uHrQCaqyl0
	koulm2kSPgGcshSvpzbno+BmRbZzoBvUQlkTkzICLrM0Jq4cAG0h8Eu9Z5kKK+9kWGW39g7C2TaT0
	cpQ0XofTfZlWdyFMp6qHWB/Mq2QpzTYrITU3+Fczomc0+w92bWzRsI/yjg5iuxIjRgkugF9JPfX2r
	3cEtyUcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woLQc-00000002rdR-16jT;
	Mon, 27 Jul 2026 13:31:34 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woLQZ-00000002rcl-02gM
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 13:31:33 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260727133120epoutp019a60e4f443aefd1a5be84f09d7282f5f~GKLmxnJ2r2662726627epoutp01j
	for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2026 13:31:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260727133120epoutp019a60e4f443aefd1a5be84f09d7282f5f~GKLmxnJ2r2662726627epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785159080;
	bh=ZheSaNgHeOAB2uoTnWJoErBgw1OSg4botxZ264U/G2U=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=MlE9GDQgPpNECnshKnGVLieC8WlQFhaefk6ZrmLcmOaEbf49k1jNJ4ZKcrlgQb+Dz
	 jB0KR64uFbeV4YgpdkvYHfqK1bNPW1X9BtD5PvACY1Onrha8tG+a8RuuriMVEig7iM
	 6gmKoTxHFVEA3iqc8IFFJa64XqX6KxKTY0VARZ/A=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260727133119epcas5p357219960b64ad6df82701504be2b1ff4~GKLmRD8mj2121821218epcas5p32;
	Mon, 27 Jul 2026 13:31:19 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4h7zyG5hbWz2SSKY; Mon, 27 Jul
	2026 13:31:18 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260727133118epcas5p37b42a06ff71c22e769ce7d3c516aa7c1~GKLk7dwu62121821218epcas5p30;
	Mon, 27 Jul 2026 13:31:18 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260727133116epsmtip10a0d9d475d5739a337ad81ea59aa4f88~GKLjjIuIf2283822838epsmtip1h;
	Mon, 27 Jul 2026 13:31:16 +0000 (GMT)
Message-ID: <7c3e3243-0c9a-436b-b5c2-e6092e181435@samsung.com>
Date: Mon, 27 Jul 2026 19:01:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: fix racy access to FDP placement ID array
To: Hari Mishal <harimishal1@gmail.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260725135111.14041-2-harimishal1@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260727133118epcas5p37b42a06ff71c22e769ce7d3c516aa7c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260725135125epcas5p26801513d440f066295ef2d44035ce3db
References: <20260725135111.14041-1-harimishal1@gmail.com>
	<CGME20260725135125epcas5p26801513d440f066295ef2d44035ce3db@epcas5p2.samsung.com>
	<20260725135111.14041-2-harimishal1@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_063131_699217_2E384E19 
X-CRM114-Status: GOOD (  16.77  )
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

On 7/25/2026 7:21 PM, Hari Mishal wrote:
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1018,15 +1018,19 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>   	if (req->cmd_flags & REQ_RAHEAD)
>   		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
>   
> -	if (op == nvme_cmd_write && ns->head->nr_plids) {
> -		u16 write_stream = req->bio->bi_write_stream;
> -
> -		if (WARN_ON_ONCE(write_stream > ns->head->nr_plids))
> -			return BLK_STS_INVAL;
> -
> -		if (write_stream) {
> -			dsmgmt |= ns->head->plids[write_stream - 1] << 16;
> -			control |= NVME_RW_DTYPE_DPLCMT;
> +	if (op == nvme_cmd_write) {
> +		scoped_guard(spinlock, &ns->head->fdp_lock) {
> +			u16 write_stream = req->bio->bi_write_stream;
> +
> +			if (ns->head->nr_plids) {
> +				if (WARN_ON_ONCE(write_stream > ns->head->nr_plids))
> +					return BLK_STS_INVAL;
> +
> +				if (write_stream) {
> +					dsmgmt |= ns->head->plids[write_stream - 1] << 16;
> +					control |= NVME_RW_DTYPE_DPLCMT;
> +				}
> +			}

It will be nice not to have the impact on the fast-path performance.
The spin-lock is being taken for each write, regardless of FDP-enabled 
config. And for fdp-enabled config also, bi_write_stream may just be 0.


