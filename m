Return-Path: <SRS0=nAjD=O2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE5AC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 10:05:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28B16113E
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 10:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B28B16113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XOdAc/O5XBuG8QAcXmcYcBTVP39FDfpinXD0fMbToVg=; b=ViIBfKrFF/IZoxv/fS7jWYkATK
	LA204c1uLsNtK9GjApiMh4OdJ9lj4zdSk88OdzjtDV+b36gR/CD3Q5SQpC1WP3thYLCcmU9MQ8E0u
	VLOmHy/AaYyQWZpp1G8Lcck77b9xR9ZKdfe1Pihtw1mPaRYQWP51Om+T7BWPeRNM026s1MW1CLdP/
	h+RxhbC+P2rXjk1IUtj5m9AhvzUP/uSiQSuk9ZuTFKuRWC2CgzlogtSgaJlZ0QOOTFVa8U498U4Y+
	nxB/lxi91FJ5uWAetC5MQKEk5DDCOdokocwIZfW9M4HSonrckUM0O3osa8z/tHotrSIrQYJzNQvKs
	lscm91nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mY3nm-00DotP-Mc; Wed, 06 Oct 2021 10:05:30 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mY3nk-00Dook-45
 for linux-nvme@lists.infradead.org; Wed, 06 Oct 2021 10:05:29 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20211006100525euoutp018e6211eae783e9b2556a131c808336c3~raP0G6jCo1405514055euoutp01m
 for <linux-nvme@lists.infradead.org>; Wed,  6 Oct 2021 10:05:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20211006100525euoutp018e6211eae783e9b2556a131c808336c3~raP0G6jCo1405514055euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1633514725;
 bh=8UeUB7ujFp054c6NYv5PnL9PcSTwN20u+c3tPWoZ/Ts=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=avcp1oua8BhCsycRT2GuU3Wa9D7L2/jxeo8x2fxU07m1NaMxh2nkjP+DgQfMHc5rW
 vO6QUuhNsRj75hady99JIdFB+MF6GID/JELFR0/67lYPlfmbY+W1EKmVe0gQf35UPG
 qPo8hpO/0FgW80bPc41Ho/JoPOb7P3lnLe3zWkBA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20211006100525eucas1p11a0dd5d9be9e7517aa477f007d64a89f~raPzzOT322660526605eucas1p1p;
 Wed,  6 Oct 2021 10:05:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 05.36.45756.5E47D516; Wed,  6
 Oct 2021 11:05:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20211006100524eucas1p2a1686056cf4a213dc42af4da610ddb67~raPzQbfZM3035530355eucas1p2m;
 Wed,  6 Oct 2021 10:05:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20211006100524eusmtrp1f259da37f2d056536891022ee35c0c12~raPzPegq41327913279eusmtrp1w;
 Wed,  6 Oct 2021 10:05:24 +0000 (GMT)
X-AuditID: cbfec7f2-7d5ff7000002b2bc-04-615d74e51519
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 84.78.31287.4E47D516; Wed,  6
 Oct 2021 11:05:24 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20211006100524eusmtip128bb89f78867a5936408df4c49982d42~raPzBqDMU0572405724eusmtip1Y;
 Wed,  6 Oct 2021 10:05:24 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 6 Oct 2021 11:05:23 +0100
Date: Wed, 6 Oct 2021 12:05:23 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Chaitanya Kulkarni
 <Chaitanya.Kulkarni@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "dm-devel@redhat.com"
 <dm-devel@redhat.com>, "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "msnitzer@redhat.com" <msnitzer@redhat.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "roland@purestorage.com"
 <roland@purestorage.com>, "mpatocka@redhat.com" <mpatocka@redhat.com>,
 "hare@suse.de" <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "rwheeler@redhat.com" <rwheeler@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 Adam Manzanares <a.manzanares@samsung.com>, SelvaKumar S
 <selvakuma.s1@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>, "Kanchan
 Joshi" <joshi.k@samsung.com>, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Message-ID: <20211006100523.7xrr3qpwtby3bw3a@mpHalley.domain_not_set.invalid>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c2d0dff9-ad6d-c32b-f439-00b7ee955d69@acm.org>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTG9957e3tbBlwLC29Et6zTberE4czyRo3iZPE2pmTTDfeF0Iy7
 SiyttrC5D7Wjxq3VCVYjWAIaolQoX2sVGaModYMh1Q0tExCrrmVT5ENK2cpG2dpezfjvd855
 nvecJ3kpXGQg51I5yjxWrZQpxKSQaGyfurp0MC9D9nLQAJHlViGJjj2cwpHp5gMC2UdLechj
 /RdDLRVGDFVZfsRQ0ODGkNHxK0D2/iXoROUgHx240USi1gd2HJk7ZjB0+OseDF01TZPokruH
 QJZphKp+x9DQha0p8cx110bmsG6Uz1y/ks9Yq/UkYzu1lznSawbM931akinx+UnmhvM8xowP
 9hNM491v+MxYa09I1vU5M2F9mvnq4gHsjdj3hKuzWUXOx6x62Zos4bbTjm58hzNqV6DgGE8L
 fhAYgICC9ArYfr8NGICQEtFnACz3XOZxhR/AuvGjWFgloicA9HnQY8dA8CafE5kBdBuGHxUh
 kct/+dFbZwFscBWBsIWgF8CGAS0ZZpJeC69V9uNhjqdfhH/eMRNhA06XU9B/u5kID56gWbhv
 uI0f5jhaApsaCiN3RNNSWFbcx+N4Duw87o3ocXol1D8sCPWpECdC8wzFtZ+BunOlkV0CehW8
 dbs5IoH0c9BcLOXS7Ia17c5IAEifFsLAtW9JbpAKp+z1PI7j4FDHWT7H82DXkYMEZ9AB6Kxx
 4VxxEMBp4xnAbVgFDzkVnGEdPH/0Ls61Y2DvyBzuthhobCzGi8BC06w0pllpTP+nMc1KcxIQ
 1SCBzdfkyllNspL9JEkjy9XkK+VJH6pyrSD0XbtmOnxNoGxoPMkBMAo4AKRwcXy0am2GTBSd
 Lfv0M1atylTnK1iNAyRShDghurq0JlNEy2V57HaW3cGqH08xSjBXiwnu6ep/Nr2Z3brko2df
 aIhJ6NP/tIDZuCxjzDdi01eumZ+ir0u7uG61KqH8XpZIYtzQY07xSSzpu6L+kVQd9yXu6bRM
 irG0J7+Yx3re1wmlbYujbG63duFwb1vhhKven5pb9Jp8/6X+lj9obwny7V2OKl7a8pv93Pqc
 +96ynI6CpzqzuucvktYsSn69aES927b8+fVRryytNX2QuYk3Sqh2BrauRCXvDOj2TwalgjjF
 CVB75VBfZbPty/Sh7yRBZWxs4OSr+3QoNX3nW5Nl0pZ3S8ZNlurUC95AfK2uNVn899unNkxa
 PXV/VXiFUmJsRfedqrRfprzbmzWb5W56i2UPISY022TJi3G1RvYfXce2Jx0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsVy+t/xu7pPSmITDc5u07dYfbefzWLah5/M
 FrNuv2ax2PtuNqvF403/mSz2LJrEZLFy9VEmi79d95gsJh26xmix95a2xfxlT9ktuq/vYLPY
 93ovs8Xy4/+YLCZ2XGWyODfrD5vF4XtXWSxW/7GwWPmMyeLV/jgHEY/LV7w9Jja/Y/e4fLbU
 Y9OqTjaPzUvqPSbfWM7osftmA5vHjE9f2Dyun9nO5PHx6S0Wj20Pe9k93u+7ClR2utrj8yY5
 j/YD3UwB/FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6
 dgl6GUsPXWQuOMNd8aNpGmsD4xHOLkZODgkBE4k7f2+zdzFycQgJLGWUmPDkDRtEQkbi05WP
 7BC2sMSfa11sEEUfGSW+dGxhhXC2MEo8v90JVsUioCKx4U4DWDebgL3EpWW3mEFsEQENiW8P
 lrOANDALzOOQ+HJ/FwtIgkEgVaLlzUGwZmEBT4kdG/qZQGxeAV+JudNvQm34wSRx4GYvG0RC
 UOLkzCdgzcwCFhIz559n7GLkALKlJZb/44AIy0s0b50NtphTwFri7v1drCAlEgLKEsun+0J8
 Uyvx6v5uxgmMorOQDJ2FZOgshKGzkAxdwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzAl
 bTv2c/MOxnmvPuodYmTiYDzEKMHBrCTCm28fmyjEm5JYWZValB9fVJqTWnyI0RQYXBOZpUST
 84FJMa8k3tDMwNTQxMzSwNTSzFhJnHfr3DXxQgLpiSWp2ampBalFMH1MHJxSDUz5D4/J/m5b
 rutbZPpGbkurskns0fMnbDqaGqpe+l3fO19aV6GAJXCdy1RvDe5+yUhHvUL25sWKPhMsypmb
 mR+veLpuxbNXC9/b6slzXJYrn7OSu2vfmt0BHLcuvnVjeNVadFVCX7JDKqrP5tzfP9ujm5fE
 Fzb/bit4POdcAcM6+8baM+GH/8aJvZ88jW/qWsvqffMj06uUbwoJlX1b+yq859L1tslumz7f
 OuK0yjjqQk31kvvcMRuX/iyTW23O+T7WaNP7tyzfJnvd2rVDT8ZfWJ55WbTRG6bpuqw79lUy
 uCxmXRCwpWvl3L9K06JEpjCwnF3tzrsruPEQg3bMWcH3LDP1VDcHB3lMr1iVtk+JpTgj0VCL
 uag4EQABnR0A0gMAAA==
X-CMS-MailID: 20211006100524eucas1p2a1686056cf4a213dc42af4da610ddb67
X-Msg-Generator: CA
X-RootMTR: 20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c
References: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
 <PH0PR04MB74161CD0BD15882BBD8838AB9B529@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CGME20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c@eucas1p2.samsung.com>
 <20210928191340.dcoj7qrclpudtjbo@mpHalley.domain_not_set.invalid>
 <c2d0dff9-ad6d-c32b-f439-00b7ee955d69@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211006_030528_466535_86E4B7FB 
X-CRM114-Status: GOOD (  13.35  )
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

T24gMzAuMDkuMjAyMSAwOToyMCwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOgo+T24gOS8yOC8yMSAx
MjoxMyBQTSwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPj5TaW5jZSB3ZSBhcmUgbm90IGdvaW5n
IHRvIGJlIGFibGUgdG8gdGFsayBhYm91dCB0aGlzIGF0IExTRi9NTSwgYSBmZXcgb2YKPj51cyB0
aG91Z2h0IGFib3V0IGhvbGRpbmcgYSBkZWRpY2F0ZWQgdmlydHVhbCBkaXNjdXNzaW9uIGFib3V0
IENvcHkKPj5PZmZsb2FkLiBJIGJlbGlldmUgd2UgY2FuIHVzZSBDaGFpdGFueWEncyB0aHJlYWQg
YXMgYSBzdGFydC4gR2l2ZW4gdGhlCj4+Y3VycmVudCBzdGF0ZSBvZiB0aGUgY3VycmVudCBwYXRj
aGVzLCBJIHdvdWxkIHByb3Bvc2UgdGhhdCB3ZSBmb2N1cyBvbgo+PnRoZSBuZXh0IHN0ZXAgdG8g
Z2V0IHRoZSBtaW5pbWFsIHBhdGNoc2V0IHRoYXQgY2FuIGdvIHVwc3RyZWFtIHNvIHRoYXQKPj53
ZSBjYW4gYnVpbGQgZnJvbSB0aGVyZS4KPj4KPj5CZWZvcmUgd2UgdHJ5IHRvIGZpbmQgYSBkYXRl
IGFuZCBhIHRpbWUgdGhhdCBmaXRzIG1vc3Qgb2YgdXMsIHdobyB3b3VsZAo+PmJlIGludGVyZXN0
ZWQgaW4gcGFydGljaXBhdGluZz8KPgo+R2l2ZW4gdGhlIHRlY2huaWNhbCBjb21wbGV4aXR5IG9m
IHRoaXMgdG9waWMgYW5kIGFsc28gdGhhdCB0aGUgcGVvcGxlIHdobyBhcmUKPmludGVyZXN0ZWQg
bGl2ZSBpbiBtdWx0aXBsZSB0aW1lIHpvbmVzLCBJIHByZWZlciBlbWFpbCB0byBkaXNjdXNzIHRo
ZSB0ZWNobmljYWwKPmFzcGVjdHMgb2YgdGhpcyB3b3JrLiBNeSBhdHRlbXB0IHRvIHN1bW1hcml6
ZSBob3cgdG8gaW1wbGVtZW50IGNvcHkgb2ZmbG9hZGluZwo+aXMgYXZhaWxhYmxlIGhlcmU6IGh0
dHBzOi8vcHJvdGVjdDIuZmlyZWV5ZS5jb20vdjEvdXJsP2s9YmE3ZTVkOWEtZTVlNTY0ZDUtYmE3
ZmQ2ZDUtMGNjNDdhMzBkNDQ2LTA3YTQ3ZjNmNTNjYmZlNTMmcT0xJmU9YzM5NzNiZGMtYjZmZC00
M2ZiLTgwZTYtMGM4NmNiNmI0ZDVmJnU9aHR0cHMlM0ElMkYlMkZnaXRodWIuY29tJTJGYnZhbmFz
c2NoZSUyRmxpbnV4LWtlcm5lbC1jb3B5LW9mZmxvYWQuCj5GZWVkYmFjayBvbiB0aGlzIHRleHQg
aXMgd2VsY29tZS4KClRoYW5rcyBmb3Igc2hhcmluZyB0aGlzIEJhcnQuCgpJIGFncmVlIHRoYXQg
dGhlIHRvcGljIGlzIGNvbXBsZXguIEhvd2V2ZXIsIHdlIGhhdmUgbm90IGJlZW4gYWJsZSB0bwpm
aW5kIGEgY2xlYXIgcGF0aCBmb3J3YXJkIGluIHRoZSBtYWlsaW5nIGxpc3QuCgpXaGF0IGRvIHlv
dSB0aGluayBhYm91dCBqb2luaW5nIHRoZSBjYWxsIHRvIHRhbGsgdmVyeSBzcGVjaWZpYyBuZXh0
CnN0ZXBzIHRvIGdldCBhIHBhdGNoc2V0IHRoYXQgd2UgY2FuIHN0YXJ0IHJldmlld2luZyBpbiBk
ZXRhaWwuCgpJIHRoaW5rIHRoYXQgeW91ciBwcmVzZW5jZSBpbiB0aGUgY2FsbCB3aWxsIGhlbHAg
dXMgYWxsLgoKV2hhdCBkbyB5b3UgdGhpbms/CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
