Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0E0C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 07:12:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507F761284
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 07:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507F761284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mUjG5VMrFweI91I+o5utR2XUtLwUd8FF8D7l61bYmTA=; b=cuny3YKUoqdJOx9B4Aqx+3ozTD
	yh80FOBkrJuQciEEBNz8KT1q5YpUgtvzb0KKjCf9+e+ZMXYU7SI52uUboYLLz3lff4MR3wEmrHBtt
	8A/GFa/zpEWwMntNk0dPkakY+Vr9GZTaRMiw2qG2FmDcUohJ1axFrYN0V84zD91eQnvyaX0R6rhNJ
	Gsl/HDhNLvNJdVySWr3h2nCzfhq0Rm1u7NuRcq8yZ14ZNiL9Hj5foa+wnC0NHmwnghdjpGY0NsSUH
	hhEMMSEFNauyuJ/6e4billpAvxln2NrR8t+r2qHZPiGQBKHBR4uxTGw8+uI/zOEwn9zy4Wz8aMU98
	c7XWuxiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llREO-003nlq-FX; Tue, 25 May 2021 07:12:00 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llREL-003nl9-73
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 07:11:59 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20210525071154euoutp01cda157f2db878a76f48161fc3e1c4857~CPcDhzD7H2489624896euoutp01f
 for <linux-nvme@lists.infradead.org>; Tue, 25 May 2021 07:11:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20210525071154euoutp01cda157f2db878a76f48161fc3e1c4857~CPcDhzD7H2489624896euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1621926714;
 bh=K64ofQ4PwwIIhZ+PYsgXqPsTTXag3yoMGLswlD29b+E=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=qS5IwI+KCmcBbm/mUizaWP3Vr4hrPIHjdZbvd/FPUEY5udOhExnnD2Y1FoHdCVLiR
 j+Egu49wrwc0GaKCIoSS9lJnm9hjV0WlUimPF10bAlLsb6UXny1ENLq6rTHjOTt4B9
 l2i3nF0E+oDchIipywzHEbfqMp4Xbtk5cyZT3CrQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210525071154eucas1p1871a1f16ae905d0c1b14d17e647eece8~CPcDOrL2T2074220742eucas1p1Z;
 Tue, 25 May 2021 07:11:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id D3.7E.09444.933ACA06; Tue, 25
 May 2021 08:11:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20210525071153eucas1p2a3b4ac40b26da2aaea590fc57259f6c6~CPcC2eSlT0354603546eucas1p2U;
 Tue, 25 May 2021 07:11:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210525071153eusmtrp10f9a9bf8a1da1a6225f2688a0ef3ead9~CPcC1zXlC2922829228eusmtrp1x;
 Tue, 25 May 2021 07:11:53 +0000 (GMT)
X-AuditID: cbfec7f4-dd5ff700000024e4-1f-60aca3392403
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 26.92.08705.933ACA06; Tue, 25
 May 2021 08:11:53 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210525071153eusmtip1ae91008ed040388537ae6c9b457cd0d6~CPcCs_9HX0331203312eusmtip17;
 Tue, 25 May 2021 07:11:53 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC02.scsc.local
 (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 25 May 2021 08:11:53 +0100
Date: Tue, 25 May 2021 09:11:52 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Guoqing Jiang <jgq516@gmail.com>
CC: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <minwoo.im.dev@gmail.com>, <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: fix potential memory leaks in nvme_cdev_add
Message-ID: <20210525071152.h6elcxtydr4qh4aa@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210521073239.722341-1-jiangguoqing@kylinos.cn>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djP87qWi9ckGFx+Z23xf88xNouVq48y
 WTQ/3cBkMenQNUaL+cueslv86uS2WPf6PYsDu8fE5nfsHjtn3WX3OH9vI4vHplWdbB6bl9R7
 7L7ZwBbAFsVlk5Kak1mWWqRvl8CV8fGiX8Fi3oqzt7awNDDe4e5i5OSQEDCRuLK3nR3EFhJY
 wSjx9KdbFyMXkP2FUaLx+CtGCOczo0T/kjVsMB0njj2GSixnlGh5/pAJrmrO7cXMEM5WRonm
 05dYQVpYBFQlZr86zQRiswnYS1xadosZxBYRUJFY8fMwWDezQAejxLH2l0BzOTiEBdwkfu5O
 A6nhFbCRWD35KjOELShxcuYTFhCbWcBKovNDEytIObOAtMTyfxwQYXmJ5q2zwco5Bewk7jXP
 BiuREFCWWD7dF+KBWolTW26BbZUQ+M8hsfF9IyNEwkXizv/ZTBC2sMSr41vYIWwZidOTe1gg
 GpoZJc6sucIM4fQwSvyZtIIRYoO1RN+ZHIgGR4m2R63MEGE+iRtvBSFu45OYtG06VJhXoqNN
 aAKjyiwkj81C8tgshMdmIXlsASPLKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMBEdPrf
 8S87GJe/+qh3iJGJg/EQowQHs5II79++lQlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZO2rIkX
 EkhPLEnNTk0tSC2CyTJxcEo1MM3z4pxtd/DehE28s9cvX9p3V01ftFW3u3fq73LDub+jxVz0
 ND/+e+35miWyymX/QUNrx4wP2iI8kyzEevae2sly/6ZrkEN1m+XDk16VAQKHei87cW16Krd4
 pkXW77Ufji2vvui0zrtI+e30pBMnrz9VveGw0HBS+Xr+pLtvmGutDF4e+R0cf/nhXLZXy3M2
 88wRqN07KdTu5UPeF6f251m7yPzOy30Q56O+Y0Wi1O1tQQs8Z/XtvS+9cP0Lo0uZrovmnag/
 U3DOL2TisqJNdxWcGx17n16NTnxR5nvy5wE1l4CdB858X6HD77ah7Mr1v5KPD1dEq54WlpzK
 uzfupaBs1p71m98eUrYM6pg+fbqlEktxRqKhFnNRcSIA5pKFt7MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7qWi9ckGKzZr27xf88xNouVq48y
 WTQ/3cBkMenQNUaL+cueslv86uS2WPf6PYsDu8fE5nfsHjtn3WX3OH9vI4vHplWdbB6bl9R7
 7L7ZwBbAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRv
 l6CX8fGiX8Fi3oqzt7awNDDe4e5i5OSQEDCROHHsMWMXIxeHkMBSRomp01YzQyRkJD5d+cgO
 YQtL/LnWxQZR9JFR4uLqBcwQzlZGif7NDWBVLAKqErNfnWYCsdkE7CUuLbsFNklEQEVixc/D
 TCANzAIdjBLH2l8C7ePgEBZwk/i5Ow2khlfARmL15KtQQycySnTMW8oIkRCUODnzCQuIzSxg
 ITFz/nmwXmYBaYnl/zggwvISzVtng+3iFLCTuNc8mxWkREJAWWL5dF+IB2olPv99xjiBUWQW
 kqGzkAydhTB0FpKhCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG6rZjPzfvYJz36qPe
 IUYmDsZDjBIczEoivH/7ViYI8aYkVlalFuXHF5XmpBYfYjQFhtBEZinR5HxgqsgriTc0MzA1
 NDGzNDC1NDNWEufdOndNvJBAemJJanZqakFqEUwfEwenVANTWGjTdZHNWV1nExefivYqkFOQ
 usqRsa1rEfsuqc+qln0HLx7Z6LKnZLHoUvnCzL+ym389Zdz58LH9v4nCz3fGFfhM1PbwybRZ
 2Fm5PrJ8vtn9iTyxFmLsvkyxLys4Hlffuvrm6d8Fz2+rzrjvM/uUjESYsfPbn9Z9P941HX56
 7751RsH/e7zr2G3Pv3nj/+RC72GTu/LalXOVl+wXfyy3X/FxaoXspQfLN0tvlXt+fsUGZcZ7
 en5L9te+VOp2S7j4/UaxON9Dv4lrS0M5bldPEF94bbenuwXHJmEdzsCQ6y8zi59cLWhcYyW+
 8aDN/a/+j76p+r9jVLZQez3lc+2XPxvcHjuEly/5H/B24p8Vf5VYijMSDbWYi4oTARE7qvFd
 AwAA
X-CMS-MailID: 20210525071153eucas1p2a3b4ac40b26da2aaea590fc57259f6c6
X-Msg-Generator: CA
X-RootMTR: 20210521073456eucas1p297f8812fe2815b01c3ae15a2b1633409
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210521073456eucas1p297f8812fe2815b01c3ae15a2b1633409
References: <CGME20210521073456eucas1p297f8812fe2815b01c3ae15a2b1633409@eucas1p2.samsung.com>
 <20210521073239.722341-1-jiangguoqing@kylinos.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_001157_789628_669AAB9F 
X-CRM114-Status: GOOD (  10.95  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjEuMDUuMjAyMSAxNTozMiwgR3VvcWluZyBKaWFuZyB3cm90ZToKPldlIG5lZWQgdG8gY2Fs
bCBwdXRfZGV2aWNlIGlmIGNkZXZfZGV2aWNlX2FkZCBmYWlsZWQsIG90aGVyd2lzZQo+a21lbWxl
YWsgaGFzIGJlbG93IHJlcG9ydC4KPgo+WzwwMDAwMDAwMDI0YzcxNzU4Pl0ga21lbV9jYWNoZV9h
bGxvY190cmFjZSsweDIzMy8weDQ4MAo+WzwwMDAwMDAwMGFkMjgxM2VkPl0gZGV2aWNlX2FkZCsw
eDdmZi8weGUxMAo+WzwwMDAwMDAwMDM1YmM1NGM0Pl0gY2Rldl9kZXZpY2VfYWRkKzB4NzIvMHhh
MAo+WzwwMDAwMDAwMDZjOWFhMWU4Pl0gbnZtZV9jZGV2X2FkZCsweGE5LzB4ZjAgW252bWVfY29y
ZV0KPls8MDAwMDAwMDAzYzRkNDkyZD5dIG52bWVfbXBhdGhfc2V0X2xpdmUrMHgyNTEvMHgyOTAg
W252bWVfY29yZV0KPls8MDAwMDAwMDA4ODlhNThkYT5dIG52bWVfbXBhdGhfYWRkX2Rpc2srMHgy
NjgvMHgzMjAgW252bWVfY29yZV0KPls8MDAwMDAwMDAxOTJlNzE2MT5dIG52bWVfYWxsb2NfbnMr
MHg2NjkvMHhhYzAgW252bWVfY29yZV0KPls8MDAwMDAwMDA3YTFhNjA0MT5dIG52bWVfdmFsaWRh
dGVfb3JfYWxsb2NfbnMrMHgxNTYvMHgyODAgW252bWVfY29yZV0KPls8MDAwMDAwMDAzYTc2M2Mz
NT5dIG52bWVfc2Nhbl93b3JrKzB4MjIxLzB4M2MwIFtudm1lX2NvcmVdCj5bPDAwMDAwMDAwOWZm
MTA3MDY+XSBwcm9jZXNzX29uZV93b3JrKzB4NWNmLzB4YjEwCj5bPDAwMDAwMDAwMDY0NGVlMjU+
XSB3b3JrZXJfdGhyZWFkKzB4N2EvMHg2ODAKPls8MDAwMDAwMDAyODVlYmQyZj5dIGt0aHJlYWQr
MHgxYzYvMHgyMTAKPls8MDAwMDAwMDBlMjk3YzZlYT5dIHJldF9mcm9tX2ZvcmsrMHgyMi8weDMw
Cj4KPkZpeGVzOiAyNjM3YmFlZDc4MDEgKCJudm1lOiBpbnRyb2R1Y2UgZ2VuZXJpYyBwZXItbmFt
ZXNwYWNlIGNoYXJkZXYiKQo+U2lnbmVkLW9mZi1ieTogR3VvcWluZyBKaWFuZyA8amlhbmdndW9x
aW5nQGt5bGlub3MuY24+Cj4tLS0KPiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCA0ICsrKy0K
PiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPmRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMKPmluZGV4IDUyMmM5YjIyOWY4MC4uMmU4ZGExM2M4NDJjIDEwMDY0NAo+LS0tIGEvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jCj4rKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPkBAIC0z
NDg1LDggKzM0ODUsMTAgQEAgaW50IG52bWVfY2Rldl9hZGQoc3RydWN0IGNkZXYgKmNkZXYsIHN0
cnVjdCBkZXZpY2UgKmNkZXZfZGV2aWNlLAo+IAljZGV2X2luaXQoY2RldiwgZm9wcyk7Cj4gCWNk
ZXYtPm93bmVyID0gb3duZXI7Cj4gCXJldCA9IGNkZXZfZGV2aWNlX2FkZChjZGV2LCBjZGV2X2Rl
dmljZSk7Cj4tCWlmIChyZXQpCj4rCWlmIChyZXQpIHsKPisJCXB1dF9kZXZpY2UoY2Rldl9kZXZp
Y2UpOwo+IAkJaWRhX3NpbXBsZV9yZW1vdmUoJm52bWVfbnNfY2hyX21pbm9yX2lkYSwgbWlub3Ip
Owo+Kwl9Cj4gCXJldHVybiByZXQ7Cj4gfQo+Cj4tLSAKPjIuMjUuMQo+CgpMb29rcyBnb29kLgoK
UmV2aWV3ZWQtYnk6IEphdmllciBHb256w6FsZXogPGphdmllci5nb256QHNhbXN1bmcuY29tPgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
