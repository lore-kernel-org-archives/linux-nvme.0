Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA666EDF148
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 10:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iroPlwkV5bnjqKzEk4osM+YGkP9TUQ9NTxPf6FxaPQI=; b=R/XPcwjOvB8Q+81G6sz7xVZvSf
	2KYvz/xq0N6m1uMHmg0P26OhXT2TrjnWMa0i3LBkI8xZhWNAlCCvk6WFDivqL2nphz3trAnm3N//W
	M94MWF2iUcAhGUlBTG974vqxj/PEcAyHpGXgmikQht9iCuOfr4e4SkOXBcp2VaoCITjb+Uy1daf1P
	jOuHBKQ1+qUyYv4WbreRe3vSakKesS2QKwfZvTi/GPd9opQrS/0596VgCWtMydipKBF7e8Tv7kjgU
	JFP3SMs2GBCjlSOHXhp935huTRTFqDwF3izBgmNjltptgOtHFqztpw/lOt1Jkr1ZXMI/zudjmAFrn
	clqHOvfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqqWp-00000003K5V-2rYv;
	Fri, 13 Feb 2026 10:36:03 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqqWm-00000003K56-3vMC
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 10:36:03 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260213103550epoutp035ea8315c95af41632e94617483bca9d6~Tx-jvaWWa2379723797epoutp03B
	for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 10:35:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260213103550epoutp035ea8315c95af41632e94617483bca9d6~Tx-jvaWWa2379723797epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770978950;
	bh=iroPlwkV5bnjqKzEk4osM+YGkP9TUQ9NTxPf6FxaPQI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=g4N+wsUSVRiqkmSFR8JTqK2BA87uS7AZprElNpcq/PbNHhM4og2pezJMHaPT0FCs6
	 A64X3qUPsXi7vFepnt1cx26JSvhUL/swJ/6Qy+P/hF3xK3wMjH/A8wIEH97PPgg0xJ
	 Sp2q3a3o+wz7vwmt/l6In8zx78hiTPqmuJ+PW2uU=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260213103550epcas5p48c733e08dd1096e3f78ce9b2f2d795d2~Tx-jefQsD1937919379epcas5p4L;
	Fri, 13 Feb 2026 10:35:50 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.94]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fC7qT3KLXz6B9m4; Fri, 13 Feb
	2026 10:35:49 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260213103548epcas5p23447c7483aefe380d799e6bc875d32a2~Tx-iDzKeT0758007580epcas5p2n;
	Fri, 13 Feb 2026 10:35:48 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260213103547epsmtip2c8e7bfb9d2bf94bdd48a4fc165808bb3~Tx-hat_ff0474404744epsmtip29;
	Fri, 13 Feb 2026 10:35:47 +0000 (GMT)
Message-ID: <9ef40515-1f4c-4b12-8243-3084eb287fb0@samsung.com>
Date: Fri, 13 Feb 2026 16:05:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/3] nvme-pci: do not try to add queue maps at runtime
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260212164733.3006071-4-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260213103548epcas5p23447c7483aefe380d799e6bc875d32a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260212164902epcas5p15b0be6076ed178f710bc585f87477fe7
References: <20260212164733.3006071-1-kbusch@meta.com>
	<CGME20260212164902epcas5p15b0be6076ed178f710bc585f87477fe7@epcas5p1.samsung.com>
	<20260212164733.3006071-4-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_023601_477189_56826752 
X-CRM114-Status: UNSURE (   8.82  )
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

On 2/12/2026 10:17 PM, Keith Busch wrote:
> From: Keith Busch<kbusch@kernel.org>
> 
> The block layer allocates the set's maps once. We can't add special
> purpose queues at runtime if they weren't allocated at initialization
> time.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

User may not get an error on adding and, therefore, may feel that 
everything went fine, but such queues cannot be used.
At least, that was my observation on increasing the number of poll 
queues from 0 to !0 value.
I continued getting "not supported" error on issuing hipri I/O from 
io_uring. After this patch, the poll queue became usable.

Tested-by: Kanchan Joshi <joshi.k@samsung.com>


