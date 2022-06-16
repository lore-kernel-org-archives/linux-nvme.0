Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37B2C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jun 2022 10:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SNZKke2AUzG3V8CFrqXh/S1Uz32bt9gnCWWev1s381g=; b=Pp/bfTcb7Opo02
	DtcbUk+z/c+5xYhJ1U9/tdLtc2pW2vUb9x7Hf7jvAdlFhl86EROMvqC8oVNh79SmTBmheTEL2IEfT
	siLClkCNkzSfv7HoWbh4V8fLSJY/OEvcH8ViOm81SUvAIq/7Q3QRfWY9n27IaprlFv9IlTaDYMSA9
	E7eqtHn6A13Z8b7I2M14AMH53w0X09m24t3x/KvYjo7j3bISv+GiFfVAOMC7z6Ptwiiud/Z7jSfjj
	QP6aESTqweRWaeaE4PWWAFjIFAyK08ZdOxrCPHnkX7PL+cApCOK2YJhC3cx98cte/UlDgOCWGFQgC
	KTrDimMUzpyMaq5VoI2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1mRp-001p6K-E1; Thu, 16 Jun 2022 10:09:57 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1mRm-001ozP-DP
	for linux-nvme@lists.infradead.org; Thu, 16 Jun 2022 10:09:56 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220616100945euoutp02abec45a82725a13325e1d361d57afe49~5Eg0nmles0459604596euoutp02I
	for <linux-nvme@lists.infradead.org>; Thu, 16 Jun 2022 10:09:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220616100945euoutp02abec45a82725a13325e1d361d57afe49~5Eg0nmles0459604596euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655374185;
	bh=SNZKke2AUzG3V8CFrqXh/S1Uz32bt9gnCWWev1s381g=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=qvbb4SK/9smZywa6v/TDbYBXZG9Q/QlL4HhdW4hT7CvAZ4VdHXE2Y/QtBgmYLtbqn
	 LB2k7afcx/ZQl9xKj0xMQ+iKI+mNSQc0IQuKvHGJgme6dM6y2xNQii2DibxFaHNtU8
	 WohBjVmQmtMCTPVGOXjEMH/ZeFp4GG3/wo9hh8Y8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220616100945eucas1p16ff092593c3eb81dd46a4cf3be3997aa~5Eg0SG-ds0058100581eucas1p1j;
	Thu, 16 Jun 2022 10:09:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id B3.8D.09580.9610BA26; Thu, 16
	Jun 2022 11:09:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220616100944eucas1p15c06e5002e0f2cd08babcd1217fd63c6~5Egz281Dc0058100581eucas1p1i;
	Thu, 16 Jun 2022 10:09:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220616100944eusmtrp1c6ff48f087ed07ae172bf766a0ec7b31~5Egz2GWCJ0211102111eusmtrp1i;
	Thu, 16 Jun 2022 10:09:44 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-52-62ab0169c443
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B6.16.09038.8610BA26; Thu, 16
	Jun 2022 11:09:44 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220616100944eusmtip12c538773222f85799ce3294eb6f54db1~5EgzpPmzg1755917559eusmtip16;
	Thu, 16 Jun 2022 10:09:44 +0000 (GMT)
Received: from [192.168.1.12] (106.210.248.244) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 16 Jun 2022 11:09:38 +0100
Message-ID: <e04db101-5628-2a1d-6b5c-997090484d7d@samsung.com>
Date: Thu, 16 Jun 2022 12:09:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
	Thunderbird/91.9.1
Subject: Re: [dm-devel] [PATCH v7 02/13] block: allow blk-zoned devices to
 have non-power-of-2 zone size
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, <hch@lst.de>,
	<snitzer@redhat.com>, <damien.lemoal@opensource.wdc.com>, <axboe@kernel.dk>
CC: <pankydev8@gmail.com>, <gost.dev@samsung.com>,
	<jiangbo.365@bytedance.com>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<dm-devel@redhat.com>, <jonathan.derrick@linux.dev>,
	<Johannes.Thumshirn@wdc.com>, <dsterba@suse.com>, <jaegeuk@kernel.org>,
	"Luis Chamberlain" <mcgrof@kernel.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <857c444a-02b9-9cef-0c5b-2ecdb2fd46f6@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.244]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7djP87qZjKuTDBa0CFisvtvPZjHtw09m
	i99nzzNb7H03m9Xiwo9GJouVq48yWTxZP4vZoufABxaLv133gGItD4FKbmlbXN41h81i/rKn
	7BY3JjxltFhz8ymLRdvGr4wOAh6Xr3h7/Duxhs1j56y77B6Xz5Z6bFrVyeaxsGEqs8fmJfUe
	u282AOVa77N6vN93lc1j/ZarLB6fN8l5tB/oZgrgjeKySUnNySxLLdK3S+DK2P/yO2PBPKGK
	J5vusTYwNvN3MXJySAiYSLQ8aWLrYuTiEBJYwSjx+N9uFgjnC6PEgh2HWCGcz4wSjY8eMsO0
	NKx8wAyRWM4o8eP+VXa4qrVv/0P172KUeDPpFytIC6+AncTuvv9ALRwcLAKqErt3FkCEBSVO
	znzCAmKLCkRIrGx9wwJSIiyQJTFnZjxImFlAXOLWk/lMICNFBFoZJY5O3A3mMAvcY5JoO3Od
	EaSBTUBLorGTHaSBU8BaYsmpO8wQzZoSrdt/s0PY8hLNW2eDnSAhoCzxbyfUM7USa4+dAbtf
	QuAbp8TEb21sEAkXiUM916BsYYlXx7ewQ9gyEqcn97BA2NUST2/8ZoZobmGU6N+5ng1igbVE
	35kciBpHiScXOqHCfBI33gpCnMMnMWnbdOYJjKqzkEJiFpKXZyH5YBaSDxYwsqxiFE8tLc5N
	Ty02zkst1ytOzC0uzUvXS87P3cQITJSn/x3/uoNxxauPeocYmTgYDzFKcDArifCaBa9MEuJN
	SaysSi3Kjy8qzUktPsQozcGiJM6bnLkhUUggPbEkNTs1tSC1CCbLxMEp1cBk+m6K/6UVngb8
	Aqxpu2ax7ryitXPexT/LZ2iFXJs+xfDokc1KRh612hqpG52SrQ0233jE2+h2ZXaC9axgixfV
	8xjsbrs7ZHBpeqX+r/omdD3punX+7KD8r07Xvs5nfbat5bVT7i63n5rT3h0tUvjwbq2zvJt0
	ib4rl/SJBCvBAwJi3Zmia8XYwyYJLG2rkDvUdssp3bjd6OG9c4ecLlZfra9rTVCL2xB/abpz
	+uLXT6IztvUnKtROjvoq8ii3ea98tqRMxKPG6kOfFR/v5Oo1zEtLvLVwf8tqPW4tTx8OD8bN
	j6w/GvIo3+mNDZ40uTxL8CFz6d2Qb9sSJucf/9gzZ/I/lrWzz9/Wja0ov6fEUpyRaKjFXFSc
	CABNZ45nAwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsVy+t/xu7oZjKuTDNauMLBYfbefzWLah5/M
	Fr/Pnme22PtuNqvFhR+NTBYrVx9lsniyfhazRc+BDywWf7vuAcVaHgKV3NK2uLxrDpvF/GVP
	2S1uTHjKaLHm5lMWi7aNXxkdBDwuX/H2+HdiDZvHzll32T0uny312LSqk81jYcNUZo/NS+o9
	dt9sAMq13mf1eL/vKpvH+i1XWTw+b5LzaD/QzRTAG6VnU5RfWpKqkJFfXGKrFG1oYaRnaGmh
	Z2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsf/ld8aCeUIVTzbdY21gbObvYuTkkBAwkWhY
	+YC5i5GLQ0hgKaPEvXV3WCASMhKfrnxkh7CFJf5c62KDKPrIKLHjwQWojl2MEvu2bwCr4hWw
	k9jd9x8owcHBIqAqsXtnAURYUOLkzCdgQ0UFIiQ+LZvAClIiLJAlMWdmPEiYWUBc4taT+Uwg
	I0UEWhklbq/8wgriMAvcY5J49ekbK8SyD4wS109cBVvAJqAl0dgJtpdTwFpiyak7zBCTNCVa
	t/9mh7DlJZq3zgYrlxBQlvi3kxnimVqJV/d3M05gFJ2F5LxZSO6YhWTSLCSTFjCyrGIUSS0t
	zk3PLTbSK07MLS7NS9dLzs/dxAhML9uO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8JoFr0wS4k1J
	rKxKLcqPLyrNSS0+xGgKDKKJzFKiyfnABJdXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliS
	mp2aWpBaBNPHxMEp1cDEcbjl5B8W68Jee/8/r69LMV4LKkrYuXZ29ceFv/5LMfR15ducvXjq
	d/66y4VLeStOla89tF1VlltKfk3htsKHXtXVCxSs+cUuf3x/6+iZix+kT16alGfgumOVCuu8
	r1NWiQZsOpD7qupVs07t1LLTXTdf38u6JK0W2rW57rHonYa9n5QF9y2ovmz/ZtHeEI6TP8y1
	iqyX2jutM5s0qcLRyHBZj3d2fKdkNf/klSqX9nNOPGZzfmJzcP1vu4uLPD8mBv7UfqKXrsgW
	YLWq7enr17Ompp64brDf6Wbss+ezdVi0a2cEek9fLtXsYSt0Qb1nkfi199VPf7567XiE871U
	y7eHx6cJ1XW+mmH9UyedT4mlOCPRUIu5qDgRABEoH/e4AwAA
X-CMS-MailID: 20220616100944eucas1p15c06e5002e0f2cd08babcd1217fd63c6
X-Msg-Generator: CA
X-RootMTR: 20220615101931eucas1p15ed09ae433a2c378b599e9086130d8eb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615101931eucas1p15ed09ae433a2c378b599e9086130d8eb
References: <20220615101920.329421-1-p.raghav@samsung.com>
	<CGME20220615101931eucas1p15ed09ae433a2c378b599e9086130d8eb@eucas1p1.samsung.com>
	<20220615101920.329421-3-p.raghav@samsung.com>
	<857c444a-02b9-9cef-0c5b-2ecdb2fd46f6@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220616_030954_751889_14D91F22 
X-CRM114-Status: GOOD (  21.84  )
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

On 2022-06-15 22:28, Bart Van Assche wrote:
isk_name, zone->len);
>> +        if (zone->len == 0) {
>> +            pr_warn("%s: Invalid zone size", disk->disk_name);
>> +            return -ENODEV;
>> +        }
>> +
>> +        /*
>> +         * Don't allow zoned device with non power_of_2 zone size with
>> +         * zone capacity less than zone size.
>> +         */
> 

> Please change "power_of_2" into "power-of-2".
> 
Ok.
>> +        if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
>> +            pr_warn("%s: Invalid zone capacity for non power of 2
>> zone size",
>> +                disk->disk_name);
>>               return -ENODEV;
>>           }
> 
> The above check seems wrong to me. I don't see why devices that report a
> capacity that is less than the zone size should be rejected.
> 
This was brought up by Damien during previous reviews. The argument was
that the reason to allow non power-of-2 zoned device is to remove the
gaps between zone size and zone capacity. Allowing a npo2 zone size with
a different capacity, even though it is technically possible, it does
not make any practical sense. That is why this check was introduced.
Does that answer your question?
>> +        /*
>> +         * Division is used to calculate nr_zones for both power_of_2
>> +         * and non power_of_2 zone sizes as it is not in the hot path.
>> +         */
> 
> Shouldn't the above comment be moved to the patch description? I'm not
> sure whether having such a comment in the source code is valuable.
> 
Yeah, I will remove it. Maybe it is very obvious at this point.
>> +static inline sector_t blk_queue_offset_from_zone_start(struct
>> request_queue *q,
>> +                            sector_t sec)
>> +{
>> +    sector_t zone_sectors = blk_queue_zone_sectors(q);
>> +    u64 remainder = 0;
>> +
>> +    if (!blk_queue_is_zoned(q))
>> +        return false;
> 
> "return false" should only occur in functions returning a boolean. This
> function returns type sector_t.
> 
Good catch. It was a copy paste mistake. Fixed it.
> Thanks,
> 
> Bart.

