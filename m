Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBE9C5475B
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Mar 2024 06:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LpEQ15/BcP/fjuXF4e27uGFBrsT+jVtbbeHCru6Nh3o=; b=bO23ScWwQJrtB3esKT3QXisuwm
	huZjNr6P+iirni/12BM/wUAZOWwVxVIzot4lIGAvLeQwCoBhWGs3czJkUolTbVsCLkx/S5peGOgrA
	CTK6PN2d8CKTZBFkYgbska5nmXCslauKAj4eCDL08FnNdYRs6QCLpnSxwePJFQzBHKDxgeQZRvPnb
	eHhoV0CpKQaWH3nH7GBLbNq+DO0rZWovm3P0gxRujZwf6JP13e7X6GrlmxkPrRRWInldry6oDFQGs
	0fym72fRB4pGcAjZ/D3Pt/6j/QjNd7Gi3tp7VSJScUF2ihY6V9ZUxs/VcMDgKZHfs/tPTgahjx7UD
	vxQtdiww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkeLr-0000000DC33-2kiq;
	Thu, 14 Mar 2024 06:14:03 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkeLl-0000000DC0Z-34nd
	for linux-nvme@lists.infradead.org;
	Thu, 14 Mar 2024 06:13:59 +0000
X-UUID: 87f24640804442478ab4c0c41f2ed086-20240314
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:6431f97b-90c6-43f5-83bc-0e24c63277cb,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.37,REQID:6431f97b-90c6-43f5-83bc-0e24c63277cb,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:dbb96390-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240314141347PQQTX76M,BulkQuantity:0,Recheck:0,SF:64|66|38|24|17|19|4
	4|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 87f24640804442478ab4c0c41f2ed086-20240314
Received: from node2.com.cn [(39.156.73.10)] by mailgw
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 657671404; Thu, 14 Mar 2024 14:13:46 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 5C173B80758A;
	Thu, 14 Mar 2024 14:13:46 +0800 (CST)
X-ns-mid: postfix-65F2959A-259172168
Received: from [172.30.60.81] (unknown [172.30.60.81])
	by node2.com.cn (NSMail) with ESMTPA id 1CA6CB80758A;
	Thu, 14 Mar 2024 06:13:40 +0000 (UTC)
Message-ID: <c934831a-ec84-4ea4-a156-782880086ffe@kylinos.cn>
Date: Thu, 14 Mar 2024 14:13:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix bogus request queue reference put
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240117065043.79192-1-mengfanhui@kylinos.cn>
 <b926d754-130d-424e-b099-001e14badc50@grimberg.me>
 <20240117143952.GA27918@lst.de>
From: mengfanhui <mengfanhui@kylinos.cn>
In-Reply-To: <20240117143952.GA27918@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_231358_234060_70279F91 
X-CRM114-Status: UNSURE (   9.09  )
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

Purpose that to check if we ever added a live path (using
NVME_NS_HEAD_HAS_DISK flag) and if not, clear the disk->queue
reference.The purpose is to perform security checks and remove the disk.


=E5=9C=A8 2024/1/17 22:39, Christoph Hellwig =E5=86=99=E9=81=93:
> On Wed, Jan 17, 2024 at 04:04:12PM +0200, Sagi Grimberg wrote:
>> How did you see this? disk->queue is allocated in blk_alloc_disk calle=
d
>> in nvme_mpath_alloc_disk... I don't understand how you saw the same
>> dereference that was addressed by this commit.
>=20
> This looks like a backport of an old patch of yours to a geriatric
> kernel to me..

