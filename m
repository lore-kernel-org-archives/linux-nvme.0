Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A78C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=us156qa8MCKGbktJV9qnN9R4FrbkYX7Qn3rv6LbG3K8=; b=0bQpHflUHCm0Ay
	8UoTZ800kyeeGvyMpvax6t3SqGpJTvua2l5BTrozak3yCPACig3nCfItqAqep9Z8prYixZkLDfMqK
	ibloPKuVA715/2jekkJlApaz4VBYb66rsgmdZnSrftRcSwyAWezDBrEAvhR8Lhdokp5CZbHcZBIn0
	jGATzg89L1bQrVbwDhIt8q1zI2atvvhUCXzJSGOis46aFme2doqm7I+3OzWvVovHbPfmYztzsz3OP
	mEgHWN1dS6LgSjW26k4/OjSTJz6hv5w7BYYkA7ON36VdWDWbEdGxOHX6WUgq3gSkCGanv6wN34T1K
	C40SHPcC6phZKUhVIJ9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk6AK-007gh2-G7; Thu, 28 Apr 2022 15:34:48 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk6AG-007geM-Q6
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 15:34:47 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220428153440euoutp020100b04339f48a73671c0d5be87a20e8~qGVhu3t8m0492404924euoutp02w
 for <linux-nvme@lists.infradead.org>; Thu, 28 Apr 2022 15:34:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220428153440euoutp020100b04339f48a73671c0d5be87a20e8~qGVhu3t8m0492404924euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1651160081;
 bh=us156qa8MCKGbktJV9qnN9R4FrbkYX7Qn3rv6LbG3K8=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=XUXJg/WtsWRuaO06yicPsTExN5siCl+GD+3wviC5xlWmIfk0XPQJhtsm9osP1q6yw
 frVfHifnu1Z//t5gk8GNQrrZxgKMo1QpBY2NxaBWzYW6MHHmr76Wy5VgSHAuKWlqg+
 MO3l3+oc3/vlr8lE5i3PA4bP2+3Jrdt/Ra+t6u9M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220428153440eucas1p164ca6b64e70d22c1e77d10eecbad5841~qGVhbpA7q2201522015eucas1p1B;
 Thu, 28 Apr 2022 15:34:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id BB.02.10260.014BA626; Thu, 28
 Apr 2022 16:34:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220428153440eucas1p23b1f7b493670a1ea8dacec25f97b82a0~qGVhAbqRB0275402754eucas1p2Q;
 Thu, 28 Apr 2022 15:34:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220428153440eusmtrp227876620b5d29cebe96d08de989746d0~qGVg-dRLb1518915189eusmtrp21;
 Thu, 28 Apr 2022 15:34:40 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-77-626ab4104416
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 98.F4.09404.014BA626; Thu, 28
 Apr 2022 16:34:40 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220428153439eusmtip18e007633712dd3486388cbf9d7ce0708~qGVgypn2R1761317613eusmtip1p;
 Thu, 28 Apr 2022 15:34:39 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.162) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 28 Apr 2022 16:34:37 +0100
Message-ID: <6bbc0766-63b6-3325-fd62-8309290d9edf@samsung.com>
Date: Thu, 28 Apr 2022 17:34:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 03/16] block: add bdev_zone_no helper
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, <jaegeuk@kernel.org>,
 <axboe@kernel.dk>, <snitzer@kernel.org>, <hch@lst.de>, <mcgrof@kernel.org>,
 <naohiro.aota@wdc.com>, <sagi@grimberg.me>,
 <damien.lemoal@opensource.wdc.com>, <dsterba@suse.com>,
 <johannes.thumshirn@wdc.com>
CC: <linux-kernel@vger.kernel.org>, <clm@fb.com>, <gost.dev@samsung.com>,
 <chao@kernel.org>, <josef@toxicpanda.com>, <jonathan.derrick@linux.dev>,
 <agk@redhat.com>, <kbusch@kernel.org>, <kch@nvidia.com>,
 <linux-nvme@lists.infradead.org>, <jiangbo.365@bytedance.com>,
 <matias.bjorling@wdc.com>, <linux-block@vger.kernel.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <bc18532b-a98f-26f2-4dd1-d189c0415820@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.162]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH7/mxZw+7Zs8GxjekeS7pLm0wo/ILiUFy9XjemaXnSXbEkOdg
 NQZtIGJRM5jFLxlLURYGTo+QCWts8WvhcVPGgk00nCKmprC61MQSjmg623jwjv9enx/v773f
 n/uSmLCRiCLlygJGpZQpxAQP73TOnZNQto8ypf/Ur4TmIScGTddqCFh3fw6Dw4c8KNTXHOFC
 v2cEg+f/3YfCk6YBFE6aDRis6r+Pw0cV14O9spsYfHhzDdQ7LiHQ5zWgsG98NRztbSBgY7OP
 C3X7ZzA4pvMhsHbQyoHtd6Zw6BpflhxJj17cRAdcpwi6tvQelx65bsHpUU8h3dFaTtDHNIcw
 2nriC9p+RUPQ1aX3CLpHe4NDT532ErTZ5sVpndXCoR90iOiv+ivRLdT7vHVZjEK+m1HFrc/g
 5TTZfsLyL+N7Ls64CQ1yC6tAwkhAvQK0Bx/iFQiPFFItCHCNneawxTQCaqwWlC0eIODouRvc
 J5LfftHPs5D6HgGVXRksB5daq1awAjsCvvYMo6EBn1oPyi/3BpkkcSoGdJ8pYtsC8HP9JB7i
 pdQOUGdwEyEOpxLA3Tn/vBSjIsH4ZOO8iQjqIAr6dBNYqMCoYRQEqjq5oUcJahXYVz6PYdTr
 wGUUs9oXgbbLz2V5OSj98duFyM+DuW8qF7KUgDanmxt6ElB9PPDYpSPYQSooOzqysBQObg/a
 FjgaPO5pRFn+FPjG/BgrLgueq8dMhEyAoIkDbgW7kwKqK6cwtr0EjP0lYP0sAfrOw5gOiTEs
 OoVhUWTDogiGRRGaELwViWQK1bnZjDpeyRTFqmW56kJlduyuvNwOJPiHhwODM91Iy+2/Yx0I
 SiIOBJCYOII/bc/JFPKzZMV7GVXeh6pCBaN2IMtIXBzJ3yX/QSaksmUFzMcMk8+onkxRMixK
 g5ZIpXWigYFkoiTNtE10NZN5AzUaj2hTE9OntbvfrrCleSs1K8Q1G/ZMxCU1nT1WOx7d7he8
 lIw92/0u5RrbERBEYattfUZTRvrOWctQ2F7/Zi1fJsl/5qnj8c112xPeKW53HH9tu/a/O7Np
 o3f/2Jpy1ZcjqUhNShnIvuDZENDPJl6S25RbXw1ve+/X2SxOj/e50pgr9rykt6KjL1TLoyTn
 7beK3/zE+UFte+8WS4rgmshHSyYOp8fVFzZI+5eu636hIZ63tmB/Am4t2tY2cabF/PnanScj
 Eof+VPB1n33J3zx9wrnRoDH9/ijR5N50quu7p926l43xI82ikpGzy2F9mVSMq3Nka1ZhKrXs
 fytJ8C4yBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsVy+t/xu7oCW7KSDCaeYbVYf+oYs8Xqu/1s
 FtM+/GS2OD31LJPFpP4Z7Ba/z55ntrjwo5HJYuXqo0wWT9bPYrboOfCBxeJv1z2gWMtDZos/
 Dw0tJh26xmjx9OosJou9t7QtLu+aw2Yxf9lTdosJbV+ZLW5MeMpoMfH4ZlaLda/fs1icuCXt
 IO5x+Yq3x78Ta9g8Jja/Y/c4f28ji8fls6Uem1Z1snksbJjK7LF5Sb3H7psNbB69ze/YPHa2
 3mf1eL/vKpvH+i1XWTwmbN7I6vF5k5xH+4FupgCBKD2bovzSklSFjPziElulaEMLIz1DSws9
 IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MBVv2MBdcZ6m48vUMWwPjI+YuRk4OCQETiQeX
 JrF3MXJxCAksZZQ4s+4CVEJG4tOVj+wQtrDEn2tdbBBFHxklXncshHJ2M0p0fmxjA6niFbCT
 6Ly+i6mLkYODRUBVYsfhcoiwoMTJmU9YQGxRgQiJB7vPsoLYwgKWEm9+/mYCsZkFxCVuPZnP
 BDJTRGAKk8TeCY+ZQRxmgdNMEv96tkHd9wHovpPHwDawCWhJNHayg5icAtYSJxYpQQzSlGjd
 /psdwpaXaN46G+obZYmfk7uhvqmVeHV/N+MERtFZSO6bheSOWUhGzUIyagEjyypGkdTS4tz0
 3GIjveLE3OLSvHS95PzcTYzABLbt2M8tOxhXvvqod4iRiYPxEKMEB7OSCO+X3RlJQrwpiZVV
 qUX58UWlOanFhxhNgWE0kVlKNDkfmELzSuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNT
 UwtSi2D6mDg4pRqYquNXC16bPUHxJMNit3eX3ytLNrOLfd2neJHn4Bq/qaWnDu/95lhr3cd3
 2e/mW9F9Jw6pqzEZnpx99QSXzAwuzU8z+9I112pzn6jpeSQ6OY/ZdSbj/KOnz6mtXbgkdIlJ
 Xr0fc6Py2c5FF3eos/LOmeDt5XfJUUf+kpKO9Xz1LHmufXqi8sZbF2b8Kovw8rUt735Ss1Z5
 /n7LtA7R/N3rL955ZL5wktNGz6pd9VzHTVI+tfgIxOupNc4U6b3h/bfi9BuLHds6OjKUZl/h
 /aLjYezFkP/wR6vYcjahohf6/f8YL66/s9PlpEKnNdfmqRauX7+whblmib2uk+UrcD3osaNt
 xUq57QZ+Bi2FrleUWIozEg21mIuKEwH1NPeU6QMAAA==
X-CMS-MailID: 20220428153440eucas1p23b1f7b493670a1ea8dacec25f97b82a0
X-Msg-Generator: CA
X-RootMTR: 20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38@eucas1p2.samsung.com>
 <20220427160255.300418-4-p.raghav@samsung.com>
 <bc18532b-a98f-26f2-4dd1-d189c0415820@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_083445_144903_2BB04F1C 
X-CRM114-Status: GOOD (  13.32  )
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

On 2022-04-28 01:53, Bart Van Assche wrote:
> On 4/27/22 09:02, Pankaj Raghav wrote:
>> +static inline unsigned int bdev_zone_no(struct block_device *bdev,
>> sector_t sec)
>> +{
>> +    struct request_queue *q = bdev_get_queue(bdev);
>> +
>> +    if (q)
>> +        return blk_queue_zone_no(q, sec);
>> +    return 0;
>> +}
> 
> This patch series has been split incorrectly: the same patch that
> introduces a new function should also introduce a caller to that function.
> 
Acked. I will make sure this happens in the next revision. Thanks.
> Thanks,
> 
> Bart.

