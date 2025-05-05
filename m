Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B246BC3ABB0
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 13:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WXxjmZzTZfEBHh+6lNJEO/2R0ym+HESIpAkBG5qWpKA=; b=IbVBFug3AldFi9LZ7Vauy1aZoD
	YQt4H1Eu1RfYal4gexDhUIGp4h1ExTs28rRp7JejmtwthIKS3VG93lRsm1/ZrN9FEprAiARajDWNs
	QbkiT/+TBz5XiM7mX/lJo0DIJ47WulOm27q8kYKxbQe1rdt90BpfhoT5EN2D/Vg5C26MxEvl4tcrs
	+77D/TMy0OjjKRUkCjS0W4uUMWVxuFi0DUP7ry2qU0WvEV1JnXRKOKNVDFCNRInvyvo1Yjt6sZSg4
	ZWI8hixPDdGqYCSED+1vWAmT3MHXAGvZsdGQyNJuAlVYyaSmTlfvmlHjwnVWlQaAioWTBHnjFrP/P
	eGpQl/3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBvkn-00000007S5v-0HZl;
	Mon, 05 May 2025 13:21:05 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBvYN-00000007Qh9-0Txu
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 13:08:17 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250505130807euoutp01b321ce96b546c2b05396299e9d8bcf78~8o3ceIX8O0514305143euoutp01P
	for <linux-nvme@lists.infradead.org>; Mon,  5 May 2025 13:08:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250505130807euoutp01b321ce96b546c2b05396299e9d8bcf78~8o3ceIX8O0514305143euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746450487;
	bh=WXxjmZzTZfEBHh+6lNJEO/2R0ym+HESIpAkBG5qWpKA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Tc5piz5nJbLpFSzb8y5lM2nHWcBXmxK4Zee96yGe/VCA0ACHTwqXf6/QDdALCoar/
	 uV/cQ0FdS/I6s6+pC0xej3WaukeNMudMQ/6tOhvs5YxMBdDhSzy2kRt6dz5P04EBoG
	 LxbPXmi4bigceLWAaUEXw7nPCcUAQ78+CChZ+Ow8=
Received: from eucas1p1.samsung.com (unknown [182.198.248.177]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250505130807eucas1p180739e2b967a7f4c662af18a97f15366~8o3cPGD8A2478524785eucas1p1O;
	Mon,  5 May 2025 13:08:07 +0000 (GMT)
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250505130807eucas1p16879714c1ddf294099f336159a37d1ac~8o3b-oe2M1786317863eucas1p1V;
	Mon,  5 May 2025 13:08:07 +0000 (GMT)
Received: from CAMSPWEXC02.scsc.local (unknown [106.1.227.4]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250505130806eusmtip233af277787ca1e2cc67accc31179c936~8o3b8cVY-1986119861eusmtip2T;
	Mon,  5 May 2025 13:08:06 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSPWEXC02.scsc.local
	(106.1.227.4) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 May
	2025 14:08:06 +0100
Date: Mon, 5 May 2025 15:08:06 +0200
From: Javier Gonzalez <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Judy Brock <judy.brock@samsung.com>,
	"Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>, Hannes Reinecke
	<hare@suse.de>, "hare@kernel.org" <hare@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, "wagi@lst.de" <wagi@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/2] nvme: handle partially unique NID value
Message-ID: <heivqjw2a33ero36rit3uyu3h377jym35caeg3amnkhk5ra7wf@eodk7wld4j6b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <20250505111111.GB11508@lst.de>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSPWEXC02.scsc.local (106.1.227.4) To
	CAMSPWEXC02.scsc.local (106.1.227.4)
X-CMS-MailID: 20250505130807eucas1p16879714c1ddf294099f336159a37d1ac
X-Msg-Generator: CA
X-RootMTR: 20250502082359uscas1p1e2a9858dcc9200ab1d1d863c4495fc0a
X-EPHeader: CA
cpgsPolicy: EUCPGSC10-065,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250502082359uscas1p1e2a9858dcc9200ab1d1d863c4495fc0a
References: <3e6fb1f6-d6f0-4f33-9389-dff37daae7b0@suse.de>
	<20250414114128.GA13822@lst.de>
	<PH0PR84MB1358448342C273E7C7BA808898BC2@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
	<CGME20250502082359uscas1p1e2a9858dcc9200ab1d1d863c4495fc0a@uscas1p1.samsung.com>
	<eee8de0a44074dd3bfb0fc6ec425b647@samsung.com>
	<20250502102505.GA13055@lst.de>
	<27a99b458f0144fba094726e4f470552@samsung.com> <aBWRfiwJkeYGB0Og@kbusch-mbp>
	<r5b5gwy6vf56ropgbcx6fyi6qvgnwtzvdz5xjnofln3jvcx2zm@d4dvfkawab2x>
	<20250505111111.GB11508@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_060815_709947_15302C1F 
X-CRM114-Status: GOOD (  12.99  )
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

On 05.05.2025 13:11, Christoph Hellwig wrote:
>On Mon, May 05, 2025 at 11:51:39AM +0200, Javier Gonzalez wrote:
>> I think we should let HPE distros carry this quirk for drives where they
>> would not want to roll a FW update.
>
>Or just goddamn people to upgrade the broken firmware.  Without it
>their data is at risk, so they'd better do it.
>
>Also maybe this is a lesson to SSDs vendors (and I really mean all of
>them) that if they can't push back ob broken "features" due to market
>dynamics they should at least OEM brand the devices in the identify
>data so that the blame gets deflected to the right party.

Agree. The dynamics of how OEMs want to apply FW updates is up to them,
but there is no doubt this has been a mess. Hope we have learned a
lesson...

