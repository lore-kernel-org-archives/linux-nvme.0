Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3679EC54EBE
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jan 2023 09:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3Cf+DCWYAmzSB65N/ulwd8ALWX5sTIUaVfbs/6Q9LCg=; b=zmlLYsJdhjBL2K
	AJpUt6K3+RbQNgqMEqOH9jA6LO2zNGWXx2CgkUVoDNMRGZxK6T25dcVSfX6s2mrL+lXGj0G7KpM+k
	cQlzfLpZSlmEsa3qrv/tEzNmsjwmPxzm50GAkYu7MuS8ercLZjzZm9qVXuCQmnjXKUiUmpmuN1Hux
	K9nDhZq7YMeEKK/wP5jZXCq/OsPWrCPO2YPgkgCl5EReiwmbdtxVMBKOpwLAF5Y8fIQP/Cy2L8LKL
	qIrNS9MPYUTXfIdl4SOX9RH879HSV432G9jYNFZ66r4rt/udvgiIREUZmq1HJdZkQSD8znhce2haL
	m94mkrc75rdovxu7UebQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFAaV-005zVm-9Z; Tue, 10 Jan 2023 09:06:31 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFAaS-005zU6-70
	for linux-nvme@lists.infradead.org; Tue, 10 Jan 2023 09:06:30 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230110090624euoutp016933168174d80f5aecbff28cdfa1ff4a~4504yHa3S2087820878euoutp01B
	for <linux-nvme@lists.infradead.org>; Tue, 10 Jan 2023 09:06:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230110090624euoutp016933168174d80f5aecbff28cdfa1ff4a~4504yHa3S2087820878euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1673341584;
	bh=3Cf+DCWYAmzSB65N/ulwd8ALWX5sTIUaVfbs/6Q9LCg=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=k1RjNnZ34QJhAESzBJQbAzM61irDC4sNH8N21bvJSisYE4GpOTFXGw8FPPn1Yy6eS
	 oZiqII7QFnA2pUELR1vmFyyzOhJZkdYUgzaWJnKgReYtVRJyro0LKVGEy7f9pG0wrD
	 /qW75OXbUs5zZlLxKbrmIdTJ6YDQksdouzCiU7po=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230110090624eucas1p1a99a687265afdabbd20f8c8d3e3aa446~4504neOvB2747527475eucas1p1w;
	Tue, 10 Jan 2023 09:06:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id A3.BB.43884.09A2DB36; Tue, 10
	Jan 2023 09:06:24 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230110090624eucas1p23074c6f9d41a5005e499906e01e58f3c~4504PejtP1569015690eucas1p2R;
	Tue, 10 Jan 2023 09:06:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230110090624eusmtrp1d651397f9466392829008648dc6eae9c~4504Ou5Kq1446914469eusmtrp1Z;
	Tue, 10 Jan 2023 09:06:24 +0000 (GMT)
X-AuditID: cbfec7f5-25bff7000000ab6c-a6-63bd2a90b6c9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 60.77.52424.F8A2DB36; Tue, 10
	Jan 2023 09:06:23 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230110090623eusmtip1acb75198ba36a03190e868d77e94b077~4504Cfj-20739907399eusmtip1K;
	Tue, 10 Jan 2023 09:06:23 +0000 (GMT)
Received: from [192.168.8.107] (106.210.248.241) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 10 Jan 2023 09:06:22 +0000
Message-ID: <e8326ea7-a354-e627-195f-dcd02b13accc@samsung.com>
Date: Tue, 10 Jan 2023 10:06:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.4.2
Subject: Re: [PATCH 6/7] dm-zone: use generic helpers to calculate offset
 from zone start
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
CC: <axboe@kernel.dk>, <kernel@pankajraghav.com>,
	<linux-kernel@vger.kernel.org>, <hare@suse.de>, <bvanassche@acm.org>,
	<snitzer@kernel.org>, <dm-devel@redhat.com>,
	<damien.lemoal@opensource.wdc.com>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <gost.dev@samsung.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20230110065738.GE10289@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.241]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djPc7oTtPYmG6y/J2ax+m4/m8W0Dz+Z
	LX6fPc9ssffdbFaLPYsmMVmsXH2UyeJv1z0mizMvP7NY7L2lbXF51xw2i/nLnrJb3JjwlNHi
	xC1pB16Py1e8PS6fLfXYtKqTzWPzknqP3Tcb2Dx2tt5n9Ti70tHj/b6rQOHT1R6fN8l5tB/o
	ZgrgjuKySUnNySxLLdK3S+DK6O7+z1hwl7di+ZybrA2MG7i7GDk5JARMJHrP72bqYuTiEBJY
	wSjx+lsrI0hCSOALo8TX30UQ9mdGiS1PuboYOcAaXl2UgKhfzijRd+84G1zNii5uiMRuRom1
	G6YxgyR4Bewk3i5YwAJiswioSmxpv8oOEReUODnzCVhcVCBKounCTzBbWCBa4uG882C9zALi
	EreezGcCsUUElCSevjrLCLKAWaCRWeLDj/uMIBexCWhJNHaCzeQU0JH4PeUgK0SvpkTr9t/s
	ELa8xPa3c5ghPlaWWHzhGiOEXSux9tgZdpCZEgKXOCV27l3OBvGli8ThP+UQNcISr45vYYew
	ZSROT+5hgbCrJZ7e+M0M0dvCKNG/cz1Ur7VE35kcCNNRYsm2cgiTT+LGW0GIa/gkJm2bzjyB
	UXUWUkDMQvLwLCQPzELywAJGllWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBie70v+Nf
	dzCuePVR7xAjEwfjIUYJDmYlEd6VnHuShXhTEiurUovy44tKc1KLDzFKc7AoifPO2Do/WUgg
	PbEkNTs1tSC1CCbLxMEp1cC0Zronyz2ftXwzHt1oNGHrvPMtw7Zyu3HvSo2zH6o69K9wyior
	CFhuc6urXv406UrItAnnfjoztP/sqnH9NmvRHa4954V8P6uti/lusESLx0ppptrZ7/feSzko
	XlSYecpmJfeHOTFfOpXOB7OqK70zd14z+ZNb/NOjgjMebf3xnOHEnHd+y8V2cxx8yv8hsnfW
	ktVP3dYfOFZXI/rVV1MiU00yWm7d6p+yZywrzUxes6dH53PcVg9IOnDHcYMDT5RlpoR6+3Td
	/uvdNe+EWf3t/r26VmPxIOnWrmmHGxWvCP5Onj6xePfvAhOGqp5d/zLZ15toOiTvdCuuFykP
	r1P4lMcmEPJn4sxLqtIuukeVWIozEg21mIuKEwEC6Xp64wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42I5/e/4Xd1+rb3JBrvWWVisvtvPZjHtw09m
	i99nzzNb7H03m9Viz6JJTBYrVx9lsvjbdY/J4szLzywWe29pW1zeNYfNYv6yp+wWNyY8ZbQ4
	cUvagdfj8hVvj8tnSz02repk89i8pN5j980GNo+drfdZPc6udPR4v+8qUPh0tcfnTXIe7Qe6
	mQK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy
	urv/Mxbc5a1YPucmawPjBu4uRg4OCQETiVcXJboYuTiEBJYyStzc8Iy1i5ETKC4j8enKR3YI
	W1jiz7UuNoiij4wSG5e+ZIdwdjNKPLh3FayDV8BO4u2CBSwgNouAqsSW9qvsEHFBiZMzn4DF
	RQWiJG6ef8gEYgsLREs87VnACGIzC4hL3HoyHywuIqAk8fTVWUaQBcwCjcwSH37cBysSErjL
	KPF9SRHI2WwCWhKNnWDzOQV0JH5POcgKMUdTonX7b3YIW15i+9s5zBAfKEssvnCNEcKulXh1
	fzfjBEbRWUjOm4XkjFlIRs1CMmoBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwDSx7djP
	LTsYV776qHeIkYmD8RCjBAezkgjvSs49yUK8KYmVValF+fFFpTmpxYcYTYFhNJFZSjQ5H5io
	8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamIqVoie/vHqSL2tD
	sq+w+YkKvib2B6f/hel+TGe/K/39+MPIl+cEtJTt0/rOT+FNS0nstD+9YkOH3Xt9+9nu33m3
	5rL2MMW7s/VUSiu1NTXuWqyygofth8kSfmGei0f4w1Iz5zn/cHHZMG3iF2kJa8/F/mqZ5vdY
	smf53Gb78reuvHPCki09YaoCjH84tfMN8zPtZ/7/PCla7HDdi0mffE9eXibvKajF8Od1nUD/
	akP7lOkBF9bcj+MyMBPnn84ZU7f33/ufjnFyH95P25fzndvWKDK2Y15T3JUPU+zOB9z4f31+
	04Wyn44F3Md+hb83/NnAFd6sKnTtJnvD8toHKVe3HN8TlvWGMUl8a2qxEktxRqKhFnNRcSIA
	0ga3ZZwDAAA=
X-CMS-MailID: 20230110090624eucas1p23074c6f9d41a5005e499906e01e58f3c
X-Msg-Generator: CA
X-RootMTR: 20230106083322eucas1p1ce3ca7b02ca87bb2be8543291e223338
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230106083322eucas1p1ce3ca7b02ca87bb2be8543291e223338
References: <20230106083317.93938-1-p.raghav@samsung.com>
	<CGME20230106083322eucas1p1ce3ca7b02ca87bb2be8543291e223338@eucas1p1.samsung.com>
	<20230106083317.93938-7-p.raghav@samsung.com>
	<20230110065738.GE10289@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230110_010628_879454_80E7E550 
X-CRM114-Status: GOOD (  19.77  )
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

On 2023-01-10 07:57, Christoph Hellwig wrote:
> On Fri, Jan 06, 2023 at 09:33:16AM +0100, Pankaj Raghav wrote:
>> Use the bdev_offset_from_zone_start() helper function to calculate
>> the offset from zone start instead of open coding.
>>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
>> ---
>>  drivers/md/dm-zone.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
>> index 3dafc0e8b7a9..ac6fc1293d41 100644
>> --- a/drivers/md/dm-zone.c
>> +++ b/drivers/md/dm-zone.c
>> @@ -390,7 +390,8 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
>>  	case REQ_OP_WRITE_ZEROES:
>>  	case REQ_OP_WRITE:
>>  		/* Writes must be aligned to the zone write pointer */
>> -		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
>> +		if (bdev_offset_from_zone_start(md->disk->part0,
>> +						clone->bi_iter.bi_sector) != zwp_offset)
> 
> I can't see how this actually cleans antyhing up, while it does add an
> overly long line.
>
While I do agree with the overly long line comment, I feel it makes the
intent more clear, as it is easy to overlook this math operation.

>>  		if (clone->bi_status == BLK_STS_OK &&
>>  		    bio_op(clone) == REQ_OP_ZONE_APPEND) {
>>  			orig_bio->bi_iter.bi_sector +=
>> -				clone->bi_iter.bi_sector & mask;
>> +				bdev_offset_from_zone_start(disk->part0, clone->bi_iter.bi_sector);
> 
> Same here.

