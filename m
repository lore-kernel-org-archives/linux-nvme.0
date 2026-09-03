Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5993AC624A4
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2026 03:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B8tbjwBOcBwbo7WUdq9N5fHu3+dIuQg5wpIJwvIKQF4=; b=fMJzEPQ8PHvQkMmNClnutEthbb
	r9vqZIWUrUzhoMtyL5r7eU3igXk4nTRtNIpd0OIuHj3tSKoEM8z74MdS24GVKVGsmaN7RBuY6O68v
	+ou9kLQLVaNQgRC9WEmn950Mo2x4feJEo2t2nHWdHoNT4YX3sAMWyb+Wk8DZIT9/pcYN/3dpP8TFt
	C3KPJa7gWkv30rQsXq0pFbziprKVr5ZsEyGu6GVq86Q0sIOJEjWqCM03erN2iW39mB1mIcASV5RbC
	fanhZeo2ZEr2FTdUGwxOprNC4dsncKD2jshsi7cQhodgHbCbd/Go7Ks1SrhQArOhkC6//ih7WPZvm
	sycrsA2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1yWi-0000000GIp6-39xG;
	Thu, 03 Sep 2026 03:54:12 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1yWg-0000000GIoK-07j5
	for linux-nvme@lists.infradead.org;
	Thu, 03 Sep 2026 03:54:12 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260903035404epoutp03c0c5b9fc9b432b9857ad0d5a37b9baf7~Rs0cVvAmf3234332343epoutp03M
	for <linux-nvme@lists.infradead.org>; Thu,  3 Sep 2026 03:54:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260903035404epoutp03c0c5b9fc9b432b9857ad0d5a37b9baf7~Rs0cVvAmf3234332343epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788407644;
	bh=B8tbjwBOcBwbo7WUdq9N5fHu3+dIuQg5wpIJwvIKQF4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=MahZkbe2roilkXFPtYUqEafTkLwLizFOttO2Rwi67I531tinb36HIkVoQRqcnyEl6
	 UDAqIPCiFk1PVf2nBeJrFQpXyOS5jDxZ1tyKe7Y3nc+NGtuR3lHv2XY9X/KmX10QZo
	 KhGJRb4GLt6pmXUO42oJwBZ2vqNqSQAIbNhwgdqs=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260903035404epcas5p1db13b36a6a20e4771cd89bcab103d40f~Rs0cJ3Ysg2259322593epcas5p1U;
	Thu,  3 Sep 2026 03:54:04 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.91]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hb5Lg5Lwzz2SSKf; Thu,  3 Sep
	2026 03:54:03 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260903035403epcas5p403f8582851032b5e276ccbb7cc499614~Rs0a1sFkC1883318833epcas5p42;
	Thu,  3 Sep 2026 03:54:03 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260903035400epsmtip28937a2084801fdcafaf19ee58cf9d139~Rs0X0Mu-42016520165epsmtip2r;
	Thu,  3 Sep 2026 03:53:59 +0000 (GMT)
Message-ID: <bc7c089c-9357-448f-b6d4-fbc72b7e3c6c@samsung.com>
Date: Thu, 3 Sep 2026 09:23:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme-pci: fix CMB mapping when CMBSZ Size field is
 zero
To: kangfenglong <kangfenglong@huawei.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	liuyonglong@huawei.com, seven.wangyu@huawei.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260622024129.40800-1-kangfenglong@huawei.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260903035403epcas5p403f8582851032b5e276ccbb7cc499614
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260622031353epcas5p20f6585c6c8c9b2753e6884d99fe6670a
References: <CGME20260622031353epcas5p20f6585c6c8c9b2753e6884d99fe6670a@epcas5p2.samsung.com>
	<20260622024129.40800-1-kangfenglong@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_205410_241226_41F4946B 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
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

On 6/22/2026 8:11 AM, kangfenglong wrote:
>   static void nvme_map_cmb(struct nvme_dev *dev)
>   {
> -	u64 size, offset;
> +	u64 size, unit_size, offset;
>   	resource_size_t bar_size;
>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
>   	int bar;
> @@ -2472,9 +2475,15 @@ static void nvme_map_cmb(struct nvme_dev *dev)
>   	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
>   	if (!dev->cmbsz)
>   		return;
> +	if (!nvme_cmb_size(dev))
> +		return;
>   	dev->cmbloc = readl(dev->bar + NVME_REG_CMBLOC);
>   
> -	size = nvme_cmb_size_unit(dev) * nvme_cmb_size(dev);
> +	unit_size = nvme_cmb_size_unit(dev);
> +	if (!unit_size)
> +		return;
> +	if (check_mul_overflow(unit_size, nvme_cmb_size(dev), &size))
> +		return;
>   	offset = nvme_cmb_size_unit(dev) * NVME_CMB_OFST(dev->cmbloc);

nit: now unit_size can be used in this line.

With that, LGTM.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>



