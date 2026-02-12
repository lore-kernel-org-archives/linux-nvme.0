Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D0BEE3694
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 14:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GngK59BO0PDzg2TaZM3kSNmbeWQXIlwHqpp9MZlroDA=; b=RhgiLFZ46KbW03zXjbXLBrEYgd
	0sEB13r/+j4+EXvNMlrl+/lyQe3UqwLfDdx0X0UZHnDW8JK5dE1ysKoOKUmAJgjBxOwkSkgGWEclb
	ix1+FPUDbqoMDWICbHIyMdGAIou9WJvnPv6OctvL6i28mcd9ywmRV8bmUheMqL2TXj9sBQV8r4Dbp
	VHPHztn5HIPSbHKv3Z22UklioU7X9yfB42X/2voW/DgmokypWuzQR276V8JYCvQzYKno1Ci5Rz9tF
	qLj22J+d7fcARR2LVqHQ91Cvg6E+dsbu2vfEgZxn7Yg3c5Diy+J6JYRfVmad3x9JTv/MGGDjyD3XE
	lNB9v5JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqY8p-00000002EPb-2XVT;
	Thu, 12 Feb 2026 14:58:03 +0000
Received: from [203.254.224.34] (helo=mailout4.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqY8m-00000002EOV-0qMl
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 14:58:02 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260212145749epoutp04c177a06c0b389b2a2b85790bc9db85e3~Th7AsM2G00556705567epoutp047
	for <linux-nvme@lists.infradead.org>; Thu, 12 Feb 2026 14:57:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260212145749epoutp04c177a06c0b389b2a2b85790bc9db85e3~Th7AsM2G00556705567epoutp047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770908269;
	bh=GngK59BO0PDzg2TaZM3kSNmbeWQXIlwHqpp9MZlroDA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=W9/xb9kSw7CESw6OdSuqnzzUc7rIeeKnKrDtV/AWVJgfCBi6KV8m+q223THF1ZW5Y
	 22MHLTDhao8iOsoVHOs2go1AHu2jry/jWQIkoBbDX4W3lXvpX7o2soFMU7HzNoLJ10
	 z97TAadunhVS49yZqa6G1a7Tl5T++rVSQVwc7Ot4=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260212145748epcas5p1d25065e2d6cb504296bf84b8d8d8293e~Th7ALqQ922459124591epcas5p16;
	Thu, 12 Feb 2026 14:57:48 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.92]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fBdhD00DHz6B9m4; Thu, 12 Feb
	2026 14:57:48 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260212145747epcas5p2cbf9c4c3121cf9c83dbbe32666a30615~Th6_6t16T0171801718epcas5p2f;
	Thu, 12 Feb 2026 14:57:47 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260212145746epsmtip1275246de9b08c2b6255a62111496810d~Th6_PExqo3008130081epsmtip1R;
	Thu, 12 Feb 2026 14:57:46 +0000 (GMT)
Message-ID: <06691cb5-df01-44ae-8a88-5ca4b8e13936@samsung.com>
Date: Thu, 12 Feb 2026 20:27:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-pci: cap queue creation to used queues
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260210193715.2543091-2-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260212145747epcas5p2cbf9c4c3121cf9c83dbbe32666a30615
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260210193835epcas5p2e93107902ab307d7341dd5894bfa59a5
References: <20260210193715.2543091-1-kbusch@meta.com>
	<CGME20260210193835epcas5p2e93107902ab307d7341dd5894bfa59a5@epcas5p2.samsung.com>
	<20260210193715.2543091-2-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_065800_719350_07716560 
X-CRM114-Status: UNSURE (   9.51  )
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

On 2/11/2026 1:07 AM, Keith Busch wrote:
> From: Keith Busch<kbusch@kernel.org>
> 
> If the user reduces the special queue count at runtime and resets the
> controller,

Yes, I did see a crash on doing just that. Which is gone after this 
patch. And I guess you have reasons not to mark this for backport.
So

Reviewed-and-Tested-by: Kanchan Joshi <joshi.k@samsung.com>

