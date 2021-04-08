Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95FEC433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 07:12:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5546115B
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 07:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5546115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F+HivpaDK3gKOyx7zoFNtc01VCPeuAqRQPoiv76FDQE=; b=liH6nBViHHjLxmHh/rMhwQX/w
	yMFVAdyeKPU/qIPY0Modfd8NmrDKhL6YeadbHOWRo0cE7WpbCylL808pdHYPSrc/9gHMZDLibmlSO
	ik1GacORfZSDI6sK61wPfk403aqH2n8E73rF5YRMFncNTPZc0bppKPtTD6h7FKnkJnOR0ZSTE4d1K
	od5S1lNhHNlvRhGNRmg2EixpMLosZNsxngk8FEAiu4v+gC0LdgT69byj11cPoWVKh/HfSs8nCUCUM
	yFvwkUauW7WJiyHmAYkScVvR5FHDuNRGoC+7Wjt67U+/UKjkuemxt85/jvtJIl2nOFd0yn32OxY/z
	pJWHMkYlA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUOpZ-0079zx-3l; Thu, 08 Apr 2021 07:11:57 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUOpL-0079wt-Bt
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 07:11:53 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20210408071130euoutp01bc760073a1c1d536ada96f2c1ecc8f81~z0HSSXkzT2676626766euoutp014
 for <linux-nvme@lists.infradead.org>; Thu,  8 Apr 2021 07:11:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20210408071130euoutp01bc760073a1c1d536ada96f2c1ecc8f81~z0HSSXkzT2676626766euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1617865890;
 bh=UVGOXIAcGhOysIc4UMycqZz0OtKHWWnvlVngHdXvYWQ=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=Uy0kNhoKtM4YHCuZCMcUqlkTiFuW3DD/u3dKD6Lh2ohpcdWaMlu5e2tm76oRK4AW1
 2d9LGs1FjWXwpOnJjxKTIkAt3aJ/GnEPuW58VUKmZ3DkU6pgcji8nzyd+7Bktek767
 DoqeKV8oRsIDS+0mjGkDHYy3OUohflN6UyHttoBY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210408071129eucas1p19136bbf92da710a471571de183887d9e~z0HRvmq9T2203022030eucas1p1c;
 Thu,  8 Apr 2021 07:11:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 7E.99.09452.1ACAE606; Thu,  8
 Apr 2021 08:11:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20210408071129eucas1p1d5a6317582bb3efd8e682af568f54e04~z0HRWWi0l1571915719eucas1p1j;
 Thu,  8 Apr 2021 07:11:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210408071129eusmtrp104303aab777cbfdb74a467f08d293ddf~z0HRVqnH80997909979eusmtrp1w;
 Thu,  8 Apr 2021 07:11:29 +0000 (GMT)
X-AuditID: cbfec7f2-ab7ff700000024ec-b6-606eaca14af0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id C4.EC.08696.1ACAE606; Thu,  8
 Apr 2021 08:11:29 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210408071129eusmtip1014eef4a99d845ae20b228bdc442f24a~z0HROYrKb3082530825eusmtip1G;
 Thu,  8 Apr 2021 07:11:29 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 8 Apr 2021 08:11:28 +0100
Date: Thu, 8 Apr 2021 09:11:28 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Minwoo Im <minwoo.im.dev@gmail.com>, <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi Grimberg
 <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>
Subject: Re: [PATCH V2 1/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210408071128.pps76zydao3oufqn@mpHalley.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407171400.GA32592@lst.de>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRT06253F0hxqdeLV2LxiimgUWMjnnjVK/IDNWKibXSlWCimC4JG
 AkIkUgGxGJGKIIllsUBFRKkiikUwlWoFBW+JWlAxHtQTI0Xbxei/eW9mvjeTfBQmzhOOpqI1
 8YxWo4yREL74xeY+R1BJhUYx/UT3BNnAlWZCdqa8SSBzvG8UyPTWDiQrLu0iZT8z/WTmdx/x
 RaT8SPoHUn7J8IyUO56fw+XVpkxCfv50irzuUSoRTkT6ztvOxETvZrQhCxS+KsujsF1pZJKV
 qxOkoltCHaIooGfBV9s+HfKlxHQZgpJrz4T88AVBTWknwQ+fEVw1leE65ON1FBt1gwSHILe/
 XeghvKreHAVP1CA4/NSJeQicngiOt7WEBxP0QmgrfezdD6cl0NVzG3kMGH0XgbvgvFc0jF4J
 Tcd7BR4sosOghasjeRwAtgKnNwZGz4XMT2neEhg9Bjg35Vn70FJwNWQRfLdA4PLX8qGTobLZ
 TnpOAf2Ggp+OxkHNUiiyL+E1w6DnZg3J47HQkpeF8/p0BPaK+xg/ZCH4pS9DvDkUcuwxvGEx
 dDpLBt/0h4fvA/iU/qC/mI/xaxEczBDz6slgSbuAclGg4b9ehv96Gf71OoUwExrFJLCxUQw7
 Q8MkBrPKWDZBExW8LS62Gv35Ny3umy4LOtnTG2xFAgpZEVCYZLjIkq1WiEXblXv2Mtq4rdqE
 GIa1ojEULhklMp2o2Cqmo5TxjJphdjHav6yA8hmdKphf9lLSmm26XdC3bs6dPfXVUvEA9nRk
 v0+9JJhCR2c6KiJcffXZ8m/aVWeB3pI0ftJq45JNTffVPwzrA9eZbwWFV+m++RPq0GSXqXV2
 nka1f2xueKMzxdJ+KEfVbYzMVLw6pFZrpuj0wsT+ci0sz9gZ6lyR4WZLo1ckFl7/0cbdG3dE
 Fplkbh2atrYqbmkEHdpjsz0JUHxvGrhSWBgQ9sB5Q2oc8mKbqnxNrbs95esBc1FHcoO0iHub
 bjvWUCtZtsVVaLZNEOj98zv9zjR3+Nmm3Svpini9IWRo0N2QzeZKMbeDe/G4Rrc8BR/BOh1M
 fNtGu1xafPlwN2lsxKZKcFalnDEN07LK34RbHyWmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xu7oL1+QlGKzdxm3xf88xNouVq48y
 WZx/e5jJYtKha4wW85c9Zbf41cltse71exYHdo+Jze/YPXbOusvucf7eRhaPTas62Tw2L6n3
 2H2zgS2ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjf
 LkEvY8dNp4Im9opDy3czNTCeYu1i5OSQEDCRmL+0i62LkYtDSGApo8TtyeuZIBIyEp+ufGSH
 sIUl/lyDKfrIKPFxUgsrhLOFUWL/2m9gVSwCKhLnX25nA7HZBOwlLi27xQxiiwgoSTx9dZYR
 pIFZ4AKjxL+Zm8GKhAU8JY7O+Ai2jlfASeL08t3sEFNXMkuc/ToZKiEocXLmExYQm1nAQmLm
 /PNAkziAbGmJ5f84QMKcAjoSnw70sIGEJQSUJZZP94W4ulbi1f3djBMYhWchGTQLyaBZCIMW
 MDKvYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIy9bcd+btnBuPLVR71DjEwcjIcYJTiYlUR4
 d/RmJwjxpiRWVqUW5ccXleakFh9iNAUGxURmKdHkfGD055XEG5oZmBqamFkamFqaGSuJ85oc
 WRMvJJCeWJKanZpakFoE08fEwSnVwDR7xisR/VqFRRnnNs34kHn3C9/nne8Cj4TvlReoX3+m
 dlcR/6zJImY+CeWhqh0Ptl8wco8/qNW8OHSe+TzGmzZ6axkD09du0Z3rUSvVWs2a7riE+f33
 mxcrncO8Du7WY3Jhenjuxjph3UeHs/UV1zCenim4yNFp3V8Fl9okpmeW2l6eXRIWvEE5Nkpn
 b218eKF3k03+yWOR5qncfpK611Xjf0dU7hBP0+TV/l8RfIVpLmvkVif/v+ufm8csPrj/zLXP
 afs2reqRUnh+ddquK/Eeep/Yr8r+02DSlfr94bZPsuYeeevT98Pzl669/F43Kdr3TWFXUfs2
 Rhmurb8ncFa8f1D230q+/0Gm5cnNK5VYijMSDbWYi4oTAV+7crJGAwAA
X-CMS-MailID: 20210408071129eucas1p1d5a6317582bb3efd8e682af568f54e04
X-Msg-Generator: CA
X-RootMTR: 20210407171407eucas1p2e8bf869cecf13d6810d797515afff126
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210407171407eucas1p2e8bf869cecf13d6810d797515afff126
References: <20210406064841.103393-2-minwoo.im.dev@gmail.com>
 <20210407131527.GA15142@lst.de> <20210407141128.GB2805@localhost>
 <20210407142152.GA20466@lst.de> <20210407153536.GA8667@localhost>
 <20210407154730.GC8667@localhost> <20210407164818.GA31878@lst.de>
 <20210407170905.GB9994@localhost>
 <CGME20210407171407eucas1p2e8bf869cecf13d6810d797515afff126@eucas1p2.samsung.com>
 <20210407171400.GA32592@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_081145_648732_9AC13AFC 
X-CRM114-Status: GOOD (  15.19  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 07.04.2021 19:14, Christoph Hellwig wrote:
>On Thu, Apr 08, 2021 at 02:09:05AM +0900, Minwoo Im wrote:
>> On 21-04-07 18:48:18, Christoph Hellwig wrote:
>> > I've force pushed the branch with the updates, let me know if this
>> > looks good to you.
>>
>> One more thing I'd like to discuss is that the current branch does not
>> create generic cdev in case that nvme_update_ns_info fails.  And this is
>> the one of the use cases of the generic devices, so do you think it
>> should approach as an another patch ?  Or, should we make it supported
>> in the current patch ?
>
>It should create the ng devices when nvme_update_ns_info fais with
>-ENODEV, which should handle all the ZNS cases is was created.  Or did
>I mess that up?

This would be useful for devices with metadata that is not supported by
the block layer, i.e., nvme_configure_metadata().

What do you think?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
