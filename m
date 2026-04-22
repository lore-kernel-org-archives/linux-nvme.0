Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85DEF94CC3
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 05:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=loOUS5E6VOrm5T8+Ff+XfP0gT76n8lLCxYJvTx2vS2U=; b=BMn0B3avowiejF3Yl92y7eEcMr
	ZwWs0njqrI5Aql0Gms/pB3ZYCOUrxeH8iOx8pwrMAE84axY6RrHn6hFHOvC6SN2rCno5jJndwQPZ4
	hGPkwgNB0/TexQrp4ML/i6/XojrrzbTyCtUiM7eW76Wr+H+cIqj6q65ISnT3iMhya6LlZ315VqylG
	7Lq7euXnpdZ3M9T0AY8zDJTR7pDUa15cqpTXzpYBixx9+j+/AgYdSekSmkYRWsFFXKzcXSIiIs/zn
	1ePm2J33pyuKmQwVaEu05Cy+Dumkn/fsXzJoZTePUNy+fBfCIY6dyDO0h+ExMp58Vn1kwFYZQEa5Z
	kQ8qbmNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFQFi-00000009cHC-3CJe;
	Wed, 22 Apr 2026 05:35:58 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFQFe-00000009cGM-0LyH
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 05:35:56 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260422053541epoutp0329a5eb243c1517e8f8e9ac8385d1f6c3~olw5lrNP72130321303epoutp037
	for <linux-nvme@lists.infradead.org>; Wed, 22 Apr 2026 05:35:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260422053541epoutp0329a5eb243c1517e8f8e9ac8385d1f6c3~olw5lrNP72130321303epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776836141;
	bh=loOUS5E6VOrm5T8+Ff+XfP0gT76n8lLCxYJvTx2vS2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XiMxAHBddcgoaGSAejXZeG6mmlqLgwWRbwjZ++hoOKhvJzP9dfr4zLogMHh1IO4/j
	 jeuXUxMS4LpdlSuZW7CmvLixjxHIFHvyo/oTQraXsAzjTuNBLyJyyQ4oJh0a0HUigB
	 qsPG7b4Sxg26eIaoZ5EhLJWzQ1flajHdTcyiwNKo=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260422053540epcas5p39f4e1d11fd779659a4b994ec75142669~olw5ZtbKV1946519465epcas5p3V;
	Wed, 22 Apr 2026 05:35:40 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.89]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4g0nxl5LnLz6B9mF; Wed, 22 Apr
	2026 05:35:39 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260422053539epcas5p17a529dd8e361d903389eaa76d8626a03~olw31Cg1e1824418244epcas5p1_;
	Wed, 22 Apr 2026 05:35:39 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260422053537epsmtip15ecd16b5ed208f01e6b0ad913717187c~olw2G6xo91451414514epsmtip1s;
	Wed, 22 Apr 2026 05:35:37 +0000 (GMT)
Date: Wed, 22 Apr 2026 11:00:57 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "song@kernel.org" <song@kernel.org>, "yukuai@fnnas.com"
	<yukuai@fnnas.com>, "linan122@huawei.com" <linan122@huawei.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-raid@vger.kernel.org"
	<linux-raid@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Kiran Modukuri <kmodukuri@nvidia.com>
Subject: Re: [PATCH V3 1/3] block: clear BLK_FEAT_PCI_P2PDMA in
 blk_stack_limits() for non-supporting devices
Message-ID: <20260422053057.fuj3nqkystzeqhq2@green245.gost>
MIME-Version: 1.0
In-Reply-To: <a2a14d08-cb31-453a-9ddd-71f7dd4d6992@nvidia.com>
X-CMS-MailID: 20260422053539epcas5p17a529dd8e361d903389eaa76d8626a03
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----njBzzhCGtS-aHlIth.2Pj0w1Th4tsb8PwJn50ZNtPKFt4kYn=_33152_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260417101607epcas5p204981188700b5f9e3135d80ed7f16eb1
References: <20260416212633.72650-1-kch@nvidia.com>
	<20260416212633.72650-2-kch@nvidia.com>
	<CGME20260417101607epcas5p204981188700b5f9e3135d80ed7f16eb1@epcas5p2.samsung.com>
	<20260417101127.uku7q65akj6gwwh4@green245.gost>
	<a2a14d08-cb31-453a-9ddd-71f7dd4d6992@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_223554_782821_8F3BE5A6 
X-CRM114-Status: UNSURE (   7.71  )
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

------njBzzhCGtS-aHlIth.2Pj0w1Th4tsb8PwJn50ZNtPKFt4kYn=_33152_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 21/04/26 10:30PM, Chaitanya Kulkarni wrote:
>On 4/17/26 03:11, Nitesh Shetty wrote:
>> On 16/04/26 02:26PM, Chaitanya Kulkarni wrote:
>>> BLK_FEAT_NOWAIT and BLK_FEAT_POLL are cleared in blk_stack_limits()
>>> when an underlying device does not support them.  Apply the same
>>> treatment to BLK_FEAT_PCI_P2PDMA: stacking drivers set it
>>> unconditionally and rely on the core to clear it whenever a
>>> non-supporting member device is stacked.
>>>
>>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>>> ---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------njBzzhCGtS-aHlIth.2Pj0w1Th4tsb8PwJn50ZNtPKFt4kYn=_33152_
Content-Type: text/plain; charset="utf-8"


------njBzzhCGtS-aHlIth.2Pj0w1Th4tsb8PwJn50ZNtPKFt4kYn=_33152_--

