Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29F0C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mSww8MNcP9LQau6omtTYAJnuYJvatHm4P/3v9FrFuEQ=; b=1DCXYPVy/jnHVT
	o/zvf298AiM140tRfhfJ2Fn/W3KQhCtyGloKOjxKYDGx/bdSXBcBrFQXWVhoSLZw5+P24q8OZg8xk
	KR+s9/UBpVdIviL8WKUAfy6L8WHkCIHcD6DsA4lkz4alQmKQQZA2BlHxNqGnDbyqvsnPczyohmmxC
	nTLh4SDFO/BNDTCDNULL7zdaI56EnSBN8D5+9vhBxQpxzuVhi5JWdbhhCZkBON+c4T5R2CQ14FDUS
	8deVgpc9AaJxBvOoV6nQeuM7vxmg/33n8mbip1adr2f34txSJfRmlX/u/6ACaS1ck5li2rVcYcmxa
	SeolcLbDP8LE6WWvu2Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk6TX-007jzg-98; Thu, 28 Apr 2022 15:54:39 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk6TS-007jye-Vm
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 15:54:37 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220428155431euoutp02f93b30152176ba9edfe2d88f06714ae1~qGm2W3gsm2808828088euoutp02E
 for <linux-nvme@lists.infradead.org>; Thu, 28 Apr 2022 15:54:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220428155431euoutp02f93b30152176ba9edfe2d88f06714ae1~qGm2W3gsm2808828088euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1651161271;
 bh=mSww8MNcP9LQau6omtTYAJnuYJvatHm4P/3v9FrFuEQ=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=jX2mVvFSVhV+1u6Dfhpw1ePk0ekW0o6bIDhBkl0cs93PHfA0RNjCvczdJESBLMvmZ
 3QrHyJ6AMVWa9T7Ttoa+2sV0+6JEeCBq7qsfkmz/JuBmT9X5m/AQu4Ozkxz4lzmxsS
 uLrXbc6Oj+Gj296oBFsAmHn1yU8xlXftBVxJTOzo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220428155430eucas1p264e9d46e67a3b87a5f04612884dcf590~qGm195CMC1962619626eucas1p2j;
 Thu, 28 Apr 2022 15:54:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 8E.9C.09887.6B8BA626; Thu, 28
 Apr 2022 16:54:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220428155430eucas1p19843a8820764ea2bff4c8e828ab4c77d~qGm1ejomq0861808618eucas1p1v;
 Thu, 28 Apr 2022 15:54:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220428155430eusmtrp1084ab273f286eb108908e2488bc3d4b6~qGm1dczfx2007420074eusmtrp18;
 Thu, 28 Apr 2022 15:54:30 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-d8-626ab8b6a3f7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id C5.E6.09404.6B8BA626; Thu, 28
 Apr 2022 16:54:30 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20220428155430eusmtip2101d0f2ab9ec7ad016c58052efc89d15~qGm1ROzsV0803308033eusmtip2k;
 Thu, 28 Apr 2022 15:54:30 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.162) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 28 Apr 2022 16:54:27 +0100
Message-ID: <c490bd45-deab-8c2b-151c-c8db9f97e10c@samsung.com>
Date: Thu, 28 Apr 2022 17:54:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 12/16] zonefs: allow non power of 2 zoned devices
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>, <jaegeuk@kernel.org>,
 <axboe@kernel.dk>, <snitzer@kernel.org>, <hch@lst.de>, <mcgrof@kernel.org>,
 <naohiro.aota@wdc.com>, <sagi@grimberg.me>, <dsterba@suse.com>,
 <johannes.thumshirn@wdc.com>
CC: <linux-kernel@vger.kernel.org>, <clm@fb.com>, <gost.dev@samsung.com>,
 <chao@kernel.org>, <josef@toxicpanda.com>, <jonathan.derrick@linux.dev>,
 <agk@redhat.com>, <kbusch@kernel.org>, <kch@nvidia.com>,
 <linux-nvme@lists.infradead.org>, <bvanassche@acm.org>,
 <jiangbo.365@bytedance.com>, <linux-fsdevel@vger.kernel.org>,
 <matias.bjorling@wdc.com>, <linux-block@vger.kernel.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <bfc1ddc3-5db3-6879-b6ab-210a00b82c6b@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.162]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxTVxzd7Xt977Wj5IE1XHFhC34kgwz8Ct4wwuY25GW6SefC5v5Qi7xR
 GCBrxW2KrkodUtxaC6I2RGSiTBQZpcNKrWM1FKEtIF2XDgMOA6JMvgKbZUW3ltcl/HfO+Z3z
 u/fcXAoLv0hEUtn5+1h5vjQ3mhDiLba5ntdaTDkZa7p716DGLhuGrgxoCFQ5NYch+yknD+k0
 Z0jkc/ZgqNd7hIcuX2nnoeFGPYZOtE3h6Jl60K+phjA0P7QW6ay/ATTi1vOQpT8W3bR04sjV
 WkWg6ksjJNJ+8xeGPNoRgE52NPPRtT8ncXSnf/mbkHH9uoV5fucqwZwsniCZnsEmnHE5CxlD
 fSnB1ChPYUxz7deM+XclwXxbPEEwN47d5zOTt9wE02h044y2uYnPzBiimJK2Ml4a/YkwKZPN
 zd7PyuOTdwtlpuIZssBNfelWPiSV4AmhBhQF6Q3wshGpgZAKp38A0NPeSXBkFsA+azFQA4Gf
 zADo+wkFcCAwVz6OcaY6ANUNuiDxm2qrS4LEDGDXExUeiIjoZOj6Rb9wHk6vgi7HIU4Og51n
 hxcsS+mPYaXeQQTwEjoFmhv+XdAxOgL2D1fzAjvFtA9AV/cEP0AwWoXByYd9ZGApQcfAI6Vk
 ICCgN8PRyu8JLvwqPHbdR3L4ZXh9vArjKqzwVygjOXwINtgcZGAnpNuFsLrJyOcG78C5f+YB
 h5fAsQ5jMPAStJefwDl8EI54fBgXVgGoudEYfNXX4XeOXM6zCU6XKINyKPSMh3H3CYW6ltOY
 FqzSL3oL/aLO+kUV9IsqnAd4PYhgCxV5WaxiXT77RZxCmqcozM+K27M3zwD8P9n+vGPWBOrG
 puOsgEcBK4AUFi0WzZplGeGiTOlXB1j53l3ywlxWYQXLKTw6QrQn+0dpOJ0l3cd+xrIFrPz/
 KY8SRCp5NbOPRnVFpab6gZ0f+AzX9u/wmjZ0H+9kvA9uG34u2/p5snbbffKcSjQUn2B9V+eM
 FVfsiDrcJji68XF3yr1RVCNJ3HjQdsuxuq/lLedxiRO23ux6O7XBm6GRvaIXxZ7bLPFWuZ7u
 tFjOgNWPPxSTu1SD5W9clFhyps/LJMs+zevVrchYv2xwxi5KeNZVZU9MEx8m7SG1Iakhho8y
 c0JWpsevn5c/2n02rHnL1UhBW+rSqfRNUwNRp0Pv2orqkkKN91qn4yIvwa3SbFSRuP12vMlb
 diE24X3sPerFdZOaAekff08kDPU9KCiKSbdse2HefPTpWKrmrj7JWKFJW5mSdMATjStk0rUx
 mFwh/Q9mQStiOAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsVy+t/xe7rbdmQlGXz9KWSx/tQxZovVd/vZ
 LKZ9+MlscXrqWSaLSf0z2C1+nz3PbHHhRyOTxcrVR5ksnqyfxWzRc+ADi8XfrntAsZaHzBZ/
 HhpaTDp0jdHi6dVZTBZ7b2lb7Nl7ksXi8q45bBbzlz1lt5jQ9pXZ4saEp4wWE49vZrVY9/o9
 i8WJW9IOEh6Xr3h7/Duxhs1jYvM7do/z9zayeFw+W+qxaVUnm8fChqnMHpuX1HvsvtnA5tHb
 /I7NY2frfVaP9/uusnms33KVxWPC5o2sHp83yXm0H+hmChCI0rMpyi8tSVXIyC8usVWKNrQw
 0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvY0fyZveAqR8XVhmfsDYxv2LoYOTkk
 BEwkfk5+y9zFyMUhJLCUUWLWvwdQCRmJT1c+skPYwhJ/rnWxQRR9ZJRYNf8TI4Szm1HiyKyv
 rCBVvAJ2EpcPzgKq4uBgEVCVuHymFiIsKHFy5hMWEFtUIELiwe6zYOXCAq4Su9f+B4szC4hL
 3HoynwlkpojAb0aJy+fesYI4zAItzBLvn11ih9j2h1Fix8KZYBvYBLQkGjvBzuMUcJN4Pm0R
 G8QkTYnW7b/ZIWx5ie1v5zBDvKAM9Gc31Du1Eq/u72acwCg6C8mBs5AcMgvJqFlIRi1gZFnF
 KJJaWpybnltspFecmFtcmpeul5yfu4kRmMy2Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuH9sjsj
 SYg3JbGyKrUoP76oNCe1+BCjKTCQJjJLiSbnA9NpXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQ
 QHpiSWp2ampBahFMHxMHp1QDU42HXeK/o26lG6Z6tqRGbriU98GmXD43Ut1WbO5O8+d2l1N/
 nYnedqp67033uQyv56otsIuLUlV9Oe+mjmZHRffF36xPy+S3n9y1Z1rXAv5wtqqIzJfCs+rn
 sovPLOG5aXRqoUoqg87fxa+6Tj+JYer5yZp67WDedsvwfyFbcpk2zOlcrTXN2Yzj4fdVrpbp
 e//rpbGZlllIbprv9exjX3mK2Przq/iesizNiIgyZhHfuU9HzjZMsnehh5N6j+Ln1yzxU8+p
 n9Z682zPkhBXi5LrSgvai7bddLq6XaWv56nd1MmpH278PRP791bV8Z28Gv9Ltj8//enfe/0D
 wXOvlDfPlqtZ8qtD2OGTmT1DrhJLcUaioRZzUXEiAIHUKb3vAwAA
X-CMS-MailID: 20220428155430eucas1p19843a8820764ea2bff4c8e828ab4c77d
X-Msg-Generator: CA
X-RootMTR: 20220427160309eucas1p2f677c8db581616f994473f17c4a5bd44
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160309eucas1p2f677c8db581616f994473f17c4a5bd44
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160309eucas1p2f677c8db581616f994473f17c4a5bd44@eucas1p2.samsung.com>
 <20220427160255.300418-13-p.raghav@samsung.com>
 <bfc1ddc3-5db3-6879-b6ab-210a00b82c6b@opensource.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_085435_480011_CC39D1E8 
X-CRM114-Status: GOOD (  13.82  )
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

On 2022-04-28 01:39, Damien Le Moal wrote:
> On 4/28/22 01:02, Pankaj Raghav wrote:
>> The zone size shift variable is useful only if the zone sizes are known
>> to be power of 2. Remove that variable and use generic helpers from
>> block layer to calculate zone index in zonefs
> 
> Period missing at the end of the sentence.
> 
Ack
> What about zonefs-tools and its test suite ? Is everything still OK on
> that front ? I suspect not...
> 
I don't know why you assume that :). Zonefs had only one place that had
the assumption of po2 zsze sectors:
if (nr_zones < dev.nr_zones) {
	size_t runt_sectors = dev.capacity & (dev.zone_nr_sectors - 1);

In my local tree I changed it and I was able to run zonefs tests for non
po2 zone device. I have also mentioned it in my cover letter:
```
ZoneFS:
zonefs-tests.sh from zonefs-tools were run with no failures.
```
I will make sure to add my private tree for zonefs in my cover letter in
the next rev. But even without that change, a typical emulated npo2
device should work fine because the changes are applicable only for
"runt" zones.

