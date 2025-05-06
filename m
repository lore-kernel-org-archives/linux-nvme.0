Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21863C3ABAC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 07:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VkZrOOrwesoOfCNxjVHlBlb8TSpQI4ooMhqJRD1ib8I=; b=nf4tE3NZR5sTI0lVN8tg4+HPVw
	3Vr0HHxUQYJmVJiX+sxl7crWHLnDEjD4p4p0nSxwQ5RU6Sk9z99tt2nj6wZu11FaMPJ8vnxra+Y09
	T4hw8VSX5q+DuGqwAEOl8E31dRCr4iIWmwLl+jM5GDoAVRZ3yg9KcaQ8AfSw+jl6gCS5Z1dSgu1t8
	IR78p1YXArlu5l7eqzNZ+Lq7F260u5If1mNGCr2ySskNanRqzOE1bMIQ/I3duIzCSurvwyELDp7e+
	9jkHzeRaoBVYWBcGPLS9mjy592g1MpTWURjLPY6mW579P1S6+Q/t2M2EQLvaVA9FRrn42Pt0rxH8t
	tPdb7/Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCCOi-0000000AqDA-3bGX;
	Tue, 06 May 2025 07:07:24 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCCOg-0000000AqAI-0oZL
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 07:07:24 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250506070716euoutp02cacf75663ea0d16de03a84b7cbfa353d~83lrEXcZq1113211132euoutp02s
	for <linux-nvme@lists.infradead.org>; Tue,  6 May 2025 07:07:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250506070716euoutp02cacf75663ea0d16de03a84b7cbfa353d~83lrEXcZq1113211132euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746515236;
	bh=VkZrOOrwesoOfCNxjVHlBlb8TSpQI4ooMhqJRD1ib8I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=RYfJoffqph09IlDMbCSJcsfKbKP8vL/CPsLERb0qXkPfDrVLVzJhoxeqtkKv/eHzk
	 w5UbQmXSflOMsjVl4HwqiDWMXRhJjLeG6RcbvSYGkvC5s0Q9Yhn3tiSLsLK8j6VZKu
	 6ogkTKnr3w6Hi/gpM65rgT7l8JMp0HzY1SSuokUI=
Received: from eucas1p2.samsung.com (unknown [182.198.248.175]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250506070716eucas1p257951b1b54d5574db3b2e96388030c99~83lqu2o521162711627eucas1p2C;
	Tue,  6 May 2025 07:07:16 +0000 (GMT)
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250506070716eucas1p11f1abcd2b3bf5b31e361a5fc93098b8e~83lqVGATx3272832728eucas1p1i;
	Tue,  6 May 2025 07:07:16 +0000 (GMT)
Received: from CAMSPWEXC02.scsc.local (unknown [106.1.227.4]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250506070716eusmtip1e1fdbd638b79a548e31eaa1f5cfdab45~83lqRVm3b2241222412eusmtip1C;
	Tue,  6 May 2025 07:07:16 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSPWEXC02.scsc.local
	(106.1.227.4) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 May
	2025 08:07:15 +0100
Date: Tue, 6 May 2025 09:07:15 +0200
From: Javier Gonzalez <javier.gonz@samsung.com>
To: Laurence Oberman <loberman@redhat.com>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, "Judy
 Brock" <judy.brock@samsung.com>, "Ballard, Curtis C (HPE Storage)"
	<curtis.ballard@hpe.com>, Hannes Reinecke <hare@suse.de>, "hare@kernel.org"
	<hare@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, "wagi@lst.de"
	<wagi@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/2] nvme: handle partially unique NID value
Message-ID: <7lafwfw4xdsqjr5dddd6td6jfumawnayze3bvb7dmn7szvwrxx@rwnx4ksaep56>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0da89e8321755b798b47d17da76b7e28d28c43b9.camel@redhat.com>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSPWEXC02.scsc.local (106.1.227.4) To
	CAMSPWEXC02.scsc.local (106.1.227.4)
X-CMS-MailID: 20250506070716eucas1p11f1abcd2b3bf5b31e361a5fc93098b8e
X-Msg-Generator: CA
X-RootMTR: 20250502082359uscas1p1e2a9858dcc9200ab1d1d863c4495fc0a
X-EPHeader: CA
cpgsPolicy: EUCPGSC10-065,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250502082359uscas1p1e2a9858dcc9200ab1d1d863c4495fc0a
References: <PH0PR84MB1358448342C273E7C7BA808898BC2@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
	<CGME20250502082359uscas1p1e2a9858dcc9200ab1d1d863c4495fc0a@uscas1p1.samsung.com>
	<eee8de0a44074dd3bfb0fc6ec425b647@samsung.com>
	<20250502102505.GA13055@lst.de>
	<27a99b458f0144fba094726e4f470552@samsung.com> <aBWRfiwJkeYGB0Og@kbusch-mbp>
	<r5b5gwy6vf56ropgbcx6fyi6qvgnwtzvdz5xjnofln3jvcx2zm@d4dvfkawab2x>
	<20250505111111.GB11508@lst.de>
	<heivqjw2a33ero36rit3uyu3h377jym35caeg3amnkhk5ra7wf@eodk7wld4j6b>
	<0da89e8321755b798b47d17da76b7e28d28c43b9.camel@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_000722_808155_00581C88 
X-CRM114-Status: GOOD (  23.15  )
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

On 05.05.2025 09:49, Laurence Oberman wrote:
>On Mon, 2025-05-05 at 15:08 +0200, Javier Gonzalez wrote:
>> On 05.05.2025 13:11, Christoph Hellwig wrote:
>> > On Mon, May 05, 2025 at 11:51:39AM +0200, Javier Gonzalez wrote:
>> > > I think we should let HPE distros carry this quirk for drives
>> > > where they
>> > > would not want to roll a FW update.
>> >
>> > Or just goddamn people to upgrade the broken firmware.  Without it
>> > their data is at risk, so they'd better do it.
>> >
>> > Also maybe this is a lesson to SSDs vendors (and I really mean all
>> > of
>> > them) that if they can't push back ob broken "features" due to
>> > market
>> > dynamics they should at least OEM brand the devices in the identify
>> > data so that the blame gets deflected to the right party.
>>
>> Agree. The dynamics of how OEMs want to apply FW updates is up to
>> them,
>> but there is no doubt this has been a mess. Hope we have learned a
>> lesson...
>>
>
>Seems what I sent last week is the same issue.
>For now we will fix this in a RHEL only kernel until the vendor gets
>F/W fixes out.

This is great. Thanks for the support Laurence!

Curtis,

With SUSE and RedHat picking this quirk, is it enough on your end?


