Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42005C4321E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 23:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mTHt/2+87rUcVFZbYnoj92K24ThZt9NPz43YkmvkwXA=; b=YLgWrrXOHZ3WWDgOQKfLKSbs/H
	+6XRtawXXgy3aupqcPdDs3PM6GEPf0KUCTNkrUvFfMdsmVxfumBcHZmI5kz2jo1odQgBi2SZXveCX
	bdixXcfj7bth95ZeYk14MxacxKKs61k6d+tALWw4VKa8fXkm+PlfJ50Dbyt8lbJ+4lukjWlYXEDZM
	fi/96mpR2gbEJHzOQ6kki7t3eXxtU9LzIT2rr18ASYpBVq2P6gDDH8G+UWX5m7iu9sZbbKYeeHF8Q
	0Yc3YDypzX1b3hg/9oWHmuyt9/ffeBw+6wtWj9uxi5iEYmtIy4XhGiH64NdB5JPvPZnAoWDHTZYR2
	00YHpQqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0WtV-003Ot4-3X; Wed, 30 Nov 2022 23:53:37 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0WYK-003FY9-Q1
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 23:31:49 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221130233137epoutp0431f3fdfc54cc75a1060e603440901e75~sgLnf1UvO1130211302epoutp049
	for <linux-nvme@lists.infradead.org>; Wed, 30 Nov 2022 23:31:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221130233137epoutp0431f3fdfc54cc75a1060e603440901e75~sgLnf1UvO1130211302epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1669851097;
	bh=mTHt/2+87rUcVFZbYnoj92K24ThZt9NPz43YkmvkwXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lAi7F1gTB0RP9tj62w0PPMICOEk3nK0kfrco4/2rlO5JjuV5lQgExPSInrxeHrUH+
	 441PLNADsjDg1//jufCQ4xXEIaWJm+08gRoDdKYLoZwdW9p8OQ9zeMJDAiTI3yitFF
	 yAcDSAf3hdmPE5MVVZLJp306OE9kY9UrxoLHztek=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20221130233137epcas5p203d9444bfe180a08ded258dc29ad4394~sgLm5cjRl2201022010epcas5p2s;
	Wed, 30 Nov 2022 23:31:37 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4NMwT35cZtz4x9Pv; Wed, 30 Nov
	2022 23:31:35 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F3.60.56352.7D7E7836; Thu,  1 Dec 2022 08:31:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20221130233135epcas5p1be60f4ebdc912545d3b0cabcb2619569~sgLlZWmrn2270122701epcas5p1E;
	Wed, 30 Nov 2022 23:31:35 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221130233135epsmtrp292d3349abf357d54484abe6b46b9a48d~sgLlYnw7c1401414014epsmtrp2k;
	Wed, 30 Nov 2022 23:31:35 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-c6-6387e7d77f57
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	23.D9.18644.7D7E7836; Thu,  1 Dec 2022 08:31:35 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20221130233134epsmtip1031810cb09c3d927c072a062131d35ef~sgLkpdUXz1384413844epsmtip1H;
	Wed, 30 Nov 2022 23:31:34 +0000 (GMT)
Date: Thu, 1 Dec 2022 04:50:12 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: don't allow unprivileged Write Zeroes passthrough
 on read-only FDs
Message-ID: <20221130232012.GA24451@test-zns>
MIME-Version: 1.0
In-Reply-To: <20221129090016.1311006-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmlu715+3JBl1XtS1Wrj7KZDHp0DVG
	i/nLnrJbrHv9nsWBxeP8vY0sHptWdbJ5bF5S77H7ZgNbAEtUtk1GamJKapFCal5yfkpmXrqt
	kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
	Rn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG3vWlBWf4KvYsOsDawLiMp4uR
	k0NCwETizsPNTF2MXBxCArsZJXoX3WCFcD4xSjzZOoEVpEpI4DOjxIU/sTAdc36vYIQo2sUo
	8e/GDxYI5xmjxJUdjWAdLAIqEk2PXwLN5eBgE9CUuDC5FCQsIqAk8fTVWUYQm1nAXWLpsU/s
	ILawQLzEqq5lbCA2r4CuxPqvx1kgbEGJkzOfgNmcAkYSG09OZgaxRQWUJQ5sOw52toTAPXaJ
	h7PXs0Jc5yKxePJzZghbWOLV8S3sELaUxOd3e9kg7GSJSzPPMUHYJRKP9xyEsu0lWk/1M0Mc
	lyHx9vYPKJtPovf3E7BfJAR4JTrahCDKFSXuTXoKtVZc4uGMJVC2h8Tc+9OgAdfKKDGrQXEC
	o9wsJO/MQrIBwraS6PzQxDoLaAOzgLTE8n8cEKamxPpd+gsYWVcxSqYWFOempxabFhjnpZbD
	Yzg5P3cTIzgJannvYHz04IPeIUYmDsZDjBIczEoivB2f25KFeFMSK6tSi/Lji0pzUosPMZoC
	Y2cis5Rocj4wDeeVxBuaWBqYmJmZmVgamxkqifMunqGVLCSQnliSmp2aWpBaBNPHxMEp1cDk
	Nc2/qubudMFqhQ2l6z4t+Fe8bIvAObEUjxc7XrDHuE9aOO3orwOyu+QWKK9Zwb6dp+Dy1apT
	gV6zZ3M3hjn6dJ71vSO/98YVtpyuOXz/oxh/Tlq1POpTwT2WhI0eiapZp558YF4U+LFe713o
	yxrpmro9cU6882vWz4u0zI6a73n+5ZJK0c6CuGCJhKAVoSc1D2gfbXMQ8/y2xY77QCFXnhHr
	jmx3rSVHNxyZ2f2a4fKny7nJMvu70vK4FKfVPLrgWBGlzv4gft90hoywo5a12yU39XckfxFc
	//a3Q97Mrqmv4vMs1nw/Iq/TtMXY+k601btd1YbLJNesWpn9yPS8Ftcvie956wxfmaxOfbRb
	iaU4I9FQi7moOBEAYoXYRQsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSnO715+3JBlO/iFisXH2UyWLSoWuM
	FvOXPWW3WPf6PYsDi8f5extZPDat6mTz2Lyk3mP3zQa2AJYoLpuU1JzMstQifbsErowvp/IL
	/nFXnD+0gq2B8RNnFyMnh4SAicSc3ysYuxi5OIQEdjBKPJ94ixUiIS7RfO0HO4QtLLHy33N2
	iKInjBJHD+9mA0mwCKhIND1+ydTFyMHBJqApcWFyKUhYREBJ4umrs4wgNrOAu8TSY5/A5ggL
	xEus6loG1soroCux/utxFoiZrYwSUz/uZIJICEqcnPmEBaLZTGLe5ofMIPOZBaQllv/jAAlz
	ChhJbDw5mRnEFhVQljiw7TjTBEbBWUi6ZyHpnoXQvYCReRWjZGpBcW56brFhgVFearlecWJu
	cWleul5yfu4mRnBga2ntYNyz6oPeIUYmDsZDjBIczEoivB2f25KFeFMSK6tSi/Lji0pzUosP
	MUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYArVMxCom7Lla0JdgoY2+7Knm19lJa/y
	tN6SKf7W58HtoCDOjfXlmVo/39Q1zfdxTq4/M8/AYO6c0zoe6e+qvVPqQrvrRTZNf5MafsWb
	V4P5cEmH48EP9Zv3PY85OsOK0fiNflX3NtlVXgknbfQ36aU3BnEKf5/LJ2zz03zXvCStRaZv
	xPsvX7RP2bRw2YkfNsfe121h0xA+LSUaPYv/a9+aDoF/P36+OFqka32ndeInu0C9eZ7ba0+f
	yKpf4CXrVy6yLnvDhWP9vR0/AuZI100/FVNbFRrbtYLTalvzvpjmJ1LvVV9UqUucyOqwNHld
	+TrG/dX+HJ113wKWvWjLijgQFvGxUfau6puwKV7ZSizFGYmGWsxFxYkAgcIwv9sCAAA=
X-CMS-MailID: 20221130233135epcas5p1be60f4ebdc912545d3b0cabcb2619569
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_837c0_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221129090709epcas5p21176e0faa7914cea52aab2e8fa95c2db
References: <CGME20221129090709epcas5p21176e0faa7914cea52aab2e8fa95c2db@epcas5p2.samsung.com>
	<20221129090016.1311006-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_153145_530661_8E96F1F4 
X-CRM114-Status: GOOD (  20.34  )
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

------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_837c0_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Tue, Nov 29, 2022 at 10:00:16AM +0100, Christoph Hellwig wrote:
>Unfortunately Write Zeroes is coded as a no data transfer opcode in NVMe,
>so don't allow it on a read-only FD for unprivileged users.
>
>Fixes: 855b7717f44b ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>---
> drivers/nvme/host/ioctl.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>index 9550a69029b368..8aefe9c904dc9a 100644
>--- a/drivers/nvme/host/ioctl.c
>+++ b/drivers/nvme/host/ioctl.c
>@@ -45,7 +45,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
> 	 * special file is open for writing, but always allow I/O commands that
> 	 * transfer data from the controller.
> 	 */
>-	if (nvme_is_write(c))
>+	if (nvme_is_write(c) || c->common.opcode == nvme_cmd_write_zeroes)
> 		return mode & FMODE_WRITE;
 

I was thinking why check for write_zeroes should not go inside nvme_is_write
itself. Then I saw various callers of nvme_is_write, and that killed the
thought.

Another thought is - does it make sense to include nvme_cmd_flush too?
That is also declared as no-data-transfer in spec. Flush alone can't
make any difference when writes are not allowed in first place. So this
is about whether we care for empty flushes.

And on spec - not sure whether the criteria has changed of late. copy
command also does not involve data-transfer but bit is set there.


------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_837c0_
Content-Type: text/plain; charset="utf-8"


------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_837c0_--

