Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB7AC3ABB0
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 09:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QRWDF+E9a5hSQarOSINzYp11q+em4EjvlZO7aeAxMrI=; b=5CiEpjr25aVlZzrLJPe8ZJqw/G
	2fdOQgfoYtTeZbgW6hGQWYUTuHTTCv9WjIis0mhkbedbwLvkEsMIjrZqUuZw75xkivxavNiTvfaIl
	0zN5rs9I/JMsPYa2R2E6faj9fLBRn53YdH+NidWpOBAvdUkQ2iKOpbW4Y7oG9wcA5P8eDlqsAWIOO
	OGEPGmZXTQ5Ot3/kBVPy/UmLaaYFzhOitZj4mPIU0iQ4vdkdm5+t+g4yzVsCpFsdnW7Zwgxu8z44F
	L1/gjJkuKE3Zx3CvJ808Cd4K4Wmd2DgPUJOyywL2oFFmpRJETxEYHRrHFR5Qv0AchHMe0uDQJ8chq
	DEZba8Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBsUK-00000006ye0-1caN;
	Mon, 05 May 2025 09:51:52 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBsUE-00000006yZb-3HZq
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 09:51:50 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250505095141euoutp02bd77073f02906e75467bdc8d97ed3921~8mL76dDL61099910999euoutp029
	for <linux-nvme@lists.infradead.org>; Mon,  5 May 2025 09:51:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250505095141euoutp02bd77073f02906e75467bdc8d97ed3921~8mL76dDL61099910999euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746438701;
	bh=QRWDF+E9a5hSQarOSINzYp11q+em4EjvlZO7aeAxMrI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=A35v5w06mgryYy12VZ3epZennHB7uzuxF+8MZ0s8xwDjW1JKZuExX8vuIDzeBVRDP
	 380lwzkm/F8uS9zTOb93R+YBnEWZjQt23mnEKSqpzdcr2+Tzux898A7feysscLhizV
	 sfvdOpe7zsWQbVeB9oxpuqPwZnrniu0cs3VhD/X4=
Received: from eucas1p2.samsung.com (unknown [182.198.248.175]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250505095141eucas1p1b53ba760cd484c62e3ef5da031a166d9~8mL7iWwVF3210932109eucas1p1g;
	Mon,  5 May 2025 09:51:41 +0000 (GMT)
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250505095140eucas1p2313c22829efd400693a2b97b7b8244e1~8mL7Nb9oD2244922449eucas1p2v;
	Mon,  5 May 2025 09:51:40 +0000 (GMT)
Received: from CAMSPWEXC02.scsc.local (unknown [106.1.227.4]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250505095140eusmtip1343e8f5f6fa46b8e9266233d4d6fbd3d~8mL7KJB-b1130511305eusmtip1d;
	Mon,  5 May 2025 09:51:40 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSPWEXC02.scsc.local
	(106.1.227.4) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 May
	2025 10:51:40 +0100
Date: Mon, 5 May 2025 11:51:39 +0200
From: Javier Gonzalez <javier.gonz@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: Judy Brock <judy.brock@samsung.com>, Christoph Hellwig <hch@lst.de>,
	"Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>, Hannes Reinecke
	<hare@suse.de>, "hare@kernel.org" <hare@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, "wagi@lst.de" <wagi@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/2] nvme: handle partially unique NID value
Message-ID: <r5b5gwy6vf56ropgbcx6fyi6qvgnwtzvdz5xjnofln3jvcx2zm@d4dvfkawab2x>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <aBWRfiwJkeYGB0Og@kbusch-mbp>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSPWEXC01.scsc.local (106.1.227.3) To
	CAMSPWEXC02.scsc.local (106.1.227.4)
X-CMS-MailID: 20250505095140eucas1p2313c22829efd400693a2b97b7b8244e1
X-Msg-Generator: CA
X-RootMTR: 20250502082359uscas1p1e2a9858dcc9200ab1d1d863c4495fc0a
X-EPHeader: CA
cpgsPolicy: EUCPGSC10-065,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250502082359uscas1p1e2a9858dcc9200ab1d1d863c4495fc0a
References: <20250414090959.2015-1-hare@kernel.org>
	<20250414111916.GB13225@lst.de>
	<3e6fb1f6-d6f0-4f33-9389-dff37daae7b0@suse.de>
	<20250414114128.GA13822@lst.de>
	<PH0PR84MB1358448342C273E7C7BA808898BC2@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
	<CGME20250502082359uscas1p1e2a9858dcc9200ab1d1d863c4495fc0a@uscas1p1.samsung.com>
	<eee8de0a44074dd3bfb0fc6ec425b647@samsung.com>
	<20250502102505.GA13055@lst.de>
	<27a99b458f0144fba094726e4f470552@samsung.com> <aBWRfiwJkeYGB0Og@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_025147_394994_464A664E 
X-CRM114-Status: GOOD (  12.53  )
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

On 02.05.2025 21:46, Keith Busch wrote:
>On Fri, May 02, 2025 at 11:26:47PM +0000, Judy Brock wrote:
>> For example, both companies have "admitted failure" but you haven't
>> heard it: the FW in question definitely has a defect. Neither company
>> is holding it out as compliant. Both companies have indicated going
>> forward, the defective behavior has been corrected.
>>
>> Not sure why you keep saying that neither company is willing to fix it.
>
>I'm a little confused. If the conflicting behavior has been corrected,
>why is this being discussed here? A device side fix is surely the best
>possible outcome for everyone here. Requiring a kernel upgrade to work
>around undesirable firmware behavior is a bit unpleasant for end users
>when you already have a solution that works with any nvme capable OS. ?

Agree. I think Hannes' approach to add dynamic quirks was the closest to
an upstreamable solution, as a general quick for the PM177xx is not
acceptable. But I completely understand Christoph's NAK.

I think we should let HPE distros carry this quirk for drives where they
would not want to roll a FW update.

