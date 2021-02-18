Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589ADC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 08:49:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012B364E79
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 08:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012B364E79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NmwB5TiuIcaR8wOgLW9vqDjhbnxjWsU4Hn4nEKsi74I=; b=GnFUvpYTiUNT6OA4zGgKYmb1W
	0cu8yTG/0LT8MGVTXhug31QOA8f5eiIApbIyHmSve23n4nVDEwaPcWKstaX1dJpsMTZjgb0+/B26/
	KzKd4ng4HKlJYmkk0KkIhwsB03CHs/8lmWq74VSK7/bNEa4pzTSfUiIQc0xrxmT9K5MKO412Hp+lL
	L34282nETDY0Kkr3ocabLLagXJGmEEEIyW42VyAO9FoWYx0wQdMnLCeLJdQchyxeKZFX279si9t/y
	i/mDQzS0OuoSKePQXta7qGjGeaAUAu21N8nv29RLuOxK37KQyd0sEgtushZSe/Jmx491SV/XFSlPi
	q11WWjZsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCezL-0000fE-Tm; Thu, 18 Feb 2021 08:48:43 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCezI-0000ec-PG
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 08:48:42 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20210218084819euoutp02ca0e61251de841324a07f06162a8b40a~ky01PIKHl2856728567euoutp025
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 08:48:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20210218084819euoutp02ca0e61251de841324a07f06162a8b40a~ky01PIKHl2856728567euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1613638099;
 bh=YWPhlMgLYO3XIXBafNnZK5pxwcrxTQYBw2t7oQQVFUg=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=CTW7DbXiKTIllEx0mgliCGJPtih5gdsNFaIfVeva9THFYB46smNvq4QEIyvY+0IB4
 zNl3XIaLGgAZ9tiEJMTG9dpDUVJ+cyfZ61sY8kodEgEeAY/ir1omezGkbWo3YEjNOR
 TjEW6NFL4JjMruQbDtMVFw6w/zXDMI/HG9e4mOUo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20210218084814eucas1p2e6d988196dfb7d3cb9339bfcf86f65a2~ky0wcU5Kj0908709087eucas1p2K;
 Thu, 18 Feb 2021 08:48:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 07.22.44805.EC92E206; Thu, 18
 Feb 2021 08:48:14 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20210218084813eucas1p2cb943df68a1eddcf53ac1e8bdcb82f7b~ky0wDHrSN0908809088eucas1p2M;
 Thu, 18 Feb 2021 08:48:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210218084813eusmtrp23f9a6bca20f347d99e2a713ffcef1ee9~ky0wCghCy2740227402eusmtrp2O;
 Thu, 18 Feb 2021 08:48:13 +0000 (GMT)
X-AuditID: cbfec7f4-b4fff7000000af05-a2-602e29ce7a1f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 04.32.16282.DC92E206; Thu, 18
 Feb 2021 08:48:13 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210218084813eusmtip25ef12624a2a188edfc64dc4bc4bfd93c~ky0v1B6qi0900909009eusmtip2e;
 Thu, 18 Feb 2021 08:48:13 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 18 Feb 2021 08:48:13 +0000
Received: from localhost (106.110.32.47) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1320.4 via Frontend
 Transport; Thu, 18 Feb 2021 08:48:13 +0000
Date: Thu, 18 Feb 2021 09:48:12 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: introduce passthrough ioctl for multipath
Message-ID: <20210218084812.kcibjukwlb37ijji@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210218084014.GA17997@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduzned1zmnoJBi+6OCz+7znGZrFy9VEm
 i0mHrjFazF/2lN3iVye3xbrX71kc2DwmNr9j99g56y67x/l7G1k8Nq3qZPPYvKTeY/fNBrYA
 tigum5TUnMyy1CJ9uwSujNfrfrIWdLBVXPy4k7mB8RlLFyMnh4SAicT55XuZQGwhgRWMEudv
 VHcxcgHZXxgl1t94xAzhfGaUmLfrECNMx7aHexkhEssZJTY3/mWBqzrfdIAdwjnDKLHl0Dmo
 /r2MEvN3XWXrYuTgYBFQlbh9UB5kFJuAvcSlZbeYQWwRASWJp6/OMoKUMAusZpRodgcJCwu4
 SHRsvMMOYvMK2Eic27CUEcIWlDg58wnYD8wCVhKdH5pYIVqlJZb/4wAJcwroSMy/O5EJ4ugb
 HBJLD7BC2C4Shw6fZ4awhSVeHd/CDmHLSPzfOZ8J5GIJgWZGiTNrrjBDOD2MEn8mrQC7TULA
 WqLvTA5Eg6NEx9HFzBBhPokbbwUhzuGTmLRtOlSYV6KjTQiiWk1iR9NWqCEyEk/XKExgVJqF
 5JdZSH6ZhfDLAkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIFJ5vS/4192MC5/9VHv
 ECMTB+MhRgkOZiURXvbPWglCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZO2rIkXEkhPLEnNTk0t
 SC2CyTJxcEo1MLFWOd7fceF57QrNsBmpDRma3GwGN+S4hOX/Cz3Q6HmYPOe32DvH1/N2vBLL
 Cdk0fSq3WWRg09L3K7ZXFC7OzHJ7K7ig8UrF7ok9/BM/Mu+etvjZ3d83GFey/M7wWb7hUtpt
 lTfck10Er7/1P7HUOMw2ZkPn73rb/g6bh7bx9n972/uv7tC+77m99LZ+iddHBvaWMLdj8jld
 NS6Fyo93b+yvWLQjMu3stBWcivPbz10uUXz4pID/7q/FiksfTJK87Rd+o6FnrteUuoI/MSeE
 o4yqVXw0bwiKB1if8Vm6MszHz3ZpgteidPY7kzo/RWz8kP967tZyDde+M/PSeG7PnP08iWuu
 0sGCj4wJThIPliixFGckGmoxFxUnAgAAj4+woQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7pnNfUSDH4f07T4v+cYm8XK1UeZ
 LCYdusZoMX/ZU3aLX53cFutev2dxYPOY2PyO3WPnrLvsHufvbWTx2LSqk81j85J6j903G9gC
 2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Ml6v
 +8la0MFWcfHjTuYGxmcsXYycHBICJhLbHu5l7GLk4hASWMooMWPfDnaIhIzEpysfoWxhiT/X
 utggij4ySry638UE4ZxhlLj/8icrhLOXUWLe8vlAZRwcLAKqErcPyoN0swnYS1xadosZxBYR
 UJJ4+uosI0gJs8BqRolmd5CwsICLRMfGO2DLeAVsJM5tWAp10XZmiT+/frFAJAQlTs58AmYz
 C1hIzJx/HmqOtMTyfxwgYU4BHYn5dycyTWAUmoWkYxaSjlkIHQsYmVcxiqSWFuem5xYb6RUn
 5haX5qXrJefnbmIERta2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrzsn7UShHhTEiurUovy44tK
 c1KLDzGaAj08kVlKNDkfGNt5JfGGZgamhiZmlgamlmbGSuK8JkfWxAsJpCeWpGanphakFsH0
 MXFwSjUwyU7ImPDx6vyTS3SCfOKuqiyIUI2c7Hp8U0qAgFyQ4ZR16xL+WDw7OJ/57trly2KX
 bp+1ws3LhDND836cWtKTCr+zKrMDj1tf1TluknTm/esGwec5QUcsJdWXXpKS+zFr5uPpL9Ss
 ZUK+/b3Quprr5j+hCXuf3l90Zmr1lMrWoBcSAYcur2eI6Wo5f8G+odzoyT2x1/bK++Yp+Cg7
 nv7ygbtqlpj+UfdzW6ab/D4iH3U/6Y2k3NJ/rrtLFIvEl2m8PXwg9Mjp8sX1a96J+nnmWhm8
 3pu20Vv62Bzl3QI8DNIzVm++vKwt9XujtUPplg3/14mGb8y+EnHH3VE1/wjTU2mBEzrPlk5Q
 SitxX/a9uFyJpTgj0VCLuag4EQCLZEN6NQMAAA==
X-CMS-MailID: 20210218084813eucas1p2cb943df68a1eddcf53ac1e8bdcb82f7b
X-Msg-Generator: CA
X-RootMTR: 20210218084022eucas1p296cd6f091da8b347ecb3232a2e0b7383
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210218084022eucas1p296cd6f091da8b347ecb3232a2e0b7383
References: <20210214110126.24023-1-minwoo.im.dev@gmail.com>
 <20210214110126.24023-2-minwoo.im.dev@gmail.com>
 <20210215170233.GA2707454@dhcp-10-100-145-180.wdc.com>
 <20210216095147.GA2601@localhost.localdomain>
 <20210216175722.GC2708768@dhcp-10-100-145-180.wdc.com>
 <20210217021455.GA2251@localhost.localdomain>
 <CGME20210218084022eucas1p296cd6f091da8b347ecb3232a2e0b7383@eucas1p2.samsung.com>
 <20210218084014.GA17997@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210218_034840_968683_6FDBD47F 
X-CRM114-Status: GOOD (  15.67  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 18.02.2021 09:40, Christoph Hellwig wrote:
>On Wed, Feb 17, 2021 at 11:14:55AM +0900, Minwoo Im wrote:
>> > A container could read data from namespaces assigned to a different
>> > container.
>>
>> Now I got your point! Thanks Keith, please ignore this patch :)
>
>Note that Javier has been working on exposing access to namespaces
>with unsupported command sets for ioctls.  If that is what you are
>looking for.

Minwoo, I think this would apply good on top of the char device patches
I posted a while ago. I have a multipath version working on top, but I
am still working out a good way to expose in sysfs.

We can try to merge these and send the char device with multipath in the
following days. This has been hanging on me more than I wanted it to...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
