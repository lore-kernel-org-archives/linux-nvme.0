Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B980BC54E71
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 02:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PjjczS54NogO0z+rb8DGB1jcxiUuzEJDgOVttCWNf7Q=; b=CBITr6fujhr2Sw4iSnc63bDxD1
	FInBykqNajXdQ5DGRBblnJE699kHwJQPxtCpvi8JNTootW7WEaODzo+DRlFt3GKIX1nG0QTm1reBZ
	SvtAa8hv/AtMgRZBgSiqHj8z5dqp2z1J/TJXJpiRgQxxdRfSsBOT0wXatI675gTCUy8cg4DyErZDB
	23PLy7ExyBp7YKYpJ/zcLX+BKdWWwI9WYhiXACdArwfizj3yRzpG1Wa4SDtH6VvXGE1KA6t9sttM5
	JybV5VEfoaN9+zKXbRm/NSrtK/xL943wuPbMjtxVqX4GCgb8p2uv3FTqrw+9eFf84v7vEQ/ffy9jL
	+XeSatwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmlKQ-0000000Ezks-16mr;
	Wed, 20 Mar 2024 02:05:18 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmlKM-0000000EzXl-3Qrz
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 02:05:16 +0000
X-UUID: 31e0712471394ab2a45d5f3a5156d8c5-20240320
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f39104b1-0722-46ae-85ff-dcacc47790f9,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.37,REQID:f39104b1-0722-46ae-85ff-dcacc47790f9,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:54d9b281-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240320100359XVS0S5PH,BulkQuantity:0,Recheck:0,SF:24|17|19|44|64|66|3
	8|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 31e0712471394ab2a45d5f3a5156d8c5-20240320
Received: from node2.com.cn [(39.156.73.10)] by mailgw
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 568160103; Wed, 20 Mar 2024 10:03:58 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 6073AB803C9B;
	Wed, 20 Mar 2024 10:03:58 +0800 (CST)
X-ns-mid: postfix-65FA440E-300850206
Received: from [172.30.60.81] (unknown [172.30.60.81])
	by node2.com.cn (NSMail) with ESMTPA id 72654B80758A;
	Wed, 20 Mar 2024 02:03:55 +0000 (UTC)
Message-ID: <4b9e1f54-9032-48b6-bfbb-d47a4b7857e3@kylinos.cn>
Date: Wed, 20 Mar 2024 10:03:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix bogus request queue reference put
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240117065043.79192-1-mengfanhui@kylinos.cn>
 <b926d754-130d-424e-b099-001e14badc50@grimberg.me>
 <20240117143952.GA27918@lst.de>
 <c934831a-ec84-4ea4-a156-782880086ffe@kylinos.cn>
 <2db9e75c-7c17-4f1d-9328-5eb18fd86d23@grimberg.me>
From: mengfanhui <mengfanhui@kylinos.cn>
In-Reply-To: <2db9e75c-7c17-4f1d-9328-5eb18fd86d23@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240319_190515_186163_79455F9C 
X-CRM114-Status: UNSURE (   5.94  )
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

In this scenario. upstream should also appear.

=E5=9C=A8 2024/3/17 15:33, Sagi Grimberg =E5=86=99=E9=81=93:
>=20
>=20
> On 14/03/2024 8:13, mengfanhui wrote:
>> Purpose that to check if we ever added a live path (using
>> NVME_NS_HEAD_HAS_DISK flag) and if not, clear the disk->queue
>> reference.The purpose is to perform security checks and remove the dis=
k.
>=20
> Does this issue happen in upstream? If it isn't I don't see a reason to=
 fix
> a non-existing bug here.

