Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8D8C00140
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Aug 2022 17:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YsxgBHxjS77Oq9S+3/cBzOyzU36AnnpK00W3Ehj5ajI=; b=Nnh4CBgJuBX1GqwJCqKuC0ZJrV
	j/SVEz0Jwmzp3RkfL4D+fsHr1PCF8YKte0IlRYuG2c/8CZRUGXJtGQo0W8w3zXbK52m9151fhlDSf
	iw2NnkKahpCaNMzhuXrIQt4l5hU3WkuIiFWtbWid6p0mpyU2EWvqh89/oKtb2/za21leYDn6Iy0c/
	J3WNQqcLTG5iR5+k+FKD1Bxkaj7wv3qmXGOEjdfNLK5P0rSRB03lj+DmxZQV7b0qvNGLA8zHAYYu9
	OV/87d8/oEZrMq53Fe/IV8bDJoPGRsPfyRRVkPq3aD1dxZ02brdEBKxJxZGbMc8RhblvgqeyGkF+g
	ZLLTY3hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK0wE-00Gz9Y-6o; Fri, 05 Aug 2022 17:16:43 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK0wA-00Gz71-R9
	for linux-nvme@lists.infradead.org; Fri, 05 Aug 2022 17:16:40 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220805171633epoutp01afa91c2e6c44840991975aef85947f65~IglvajkPU3150131501epoutp01W
	for <linux-nvme@lists.infradead.org>; Fri,  5 Aug 2022 17:16:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220805171633epoutp01afa91c2e6c44840991975aef85947f65~IglvajkPU3150131501epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1659719793;
	bh=YsxgBHxjS77Oq9S+3/cBzOyzU36AnnpK00W3Ehj5ajI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=szrDeCYTJQmVaJgYJxGN6EivDBzcYyavIpfdcQ6u2MTuQKAJbO56OkDQ+bVB8GhX7
	 DgD3sfYBY0X8hv55uBg9gux9oKtu3YnzCw4HV+bYSk8mBqtzxuamMvpWmHhniYbTQx
	 3ZT5o2bO79B9sK7b0zqTIMo0wVuZXUsVaMq251OQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220805171633epcas5p25507eed22b4e3f6315e47e502988cc6f~Iglu8zyzQ2817228172epcas5p2o;
	Fri,  5 Aug 2022 17:16:33 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4LzshH3ffrz4x9Pv; Fri,  5 Aug
	2022 17:16:31 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5C.BF.09662.F605DE26; Sat,  6 Aug 2022 02:16:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20220805171630epcas5p445c55201e9ec84e467f551baf4f07176~IglsyU_0u0835108351epcas5p4x;
	Fri,  5 Aug 2022 17:16:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220805171630epsmtrp20b33b5e3fa2e8c9e7da29de5b2d545ff~IglsxlShD0603706037epsmtrp2X;
	Fri,  5 Aug 2022 17:16:30 +0000 (GMT)
X-AuditID: b6c32a49-885ff700000025be-8e-62ed506fe441
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3B.3B.08905.E605DE26; Sat,  6 Aug 2022 02:16:30 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220805171629epsmtip165e2875e2352b6e581ce472bb62cd545~IglreZfRZ0852308523epsmtip1O;
	Fri,  5 Aug 2022 17:16:29 +0000 (GMT)
Date: Fri, 5 Aug 2022 22:37:07 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: hch@lst.de, io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, ming.lei@redhat.com, joshiiitr@gmail.com,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 4/4] nvme: wire up async polling for io passthrough
 commands
Message-ID: <20220805170707.GC17011@test-zns>
MIME-Version: 1.0
In-Reply-To: <769524f5-c725-85f7-e7ac-ca3b2b2d884e@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmpm5+wNskg56p4hZNE/4yW6y+289m
	cfPATiaLlauPMlm8az3HYnH+7WEmi723tC3mL3vKbnFocjOTA6fHzll32T0uny312Lyk3mP3
	zQY2j/f7rrJ59G1ZxejxeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5
	kkJeYm6qrZKLT4CuW2YO0F1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3i
	xNzi0rx0vbzUEitDAwMjU6DChOyM1+fOMhcs46lYvHkBcwPjQq4uRk4OCQETiUt/37J1MXJx
	CAnsZpR4cXkHI4TziVHi6O0PrBDON0aJ9e/ns8G0nP61lwkisZdR4vKVj+wQzjNGiYVvF7OC
	VLEIqEjcvPgfqIqDg01AU+LC5FKQsIiAgkTP75Vg+5gFzjBK7JuwDmyqsECQxIPPW8B6eQV0
	JbbsuscGYQtKnJz5hAXE5hSwlbjV+IkJxBYVUJY4sO042BUSAlM5JOZu/8wCcZ6LxMT996Bs
	YYlXx7ewQ9hSEp/f7YV6IVni0sxzTBB2icTjPQehbHuJ1lP9zCA2s0CGxJmnp1ggbD6J3t9P
	wJ6REOCV6GgTgihXlLg36SkrhC0u8XDGEijbQ2Lm/v/QEPrAKPHy2y+WCYxys5D8MwvJCgjb
	SqLzQxPrLKAVzALSEsv/cUCYmhLrd+kvYGRdxSiZWlCcm55abFpgmJdaDo/l5PzcTYzgtKrl
	uYPx7oMPeocYmTgYDzFKcDArifD+3PE6SYg3JbGyKrUoP76oNCe1+BCjKTB+JjJLiSbnAxN7
	Xkm8oYmlgYmZmZmJpbGZoZI4r9fVTUlCAumJJanZqakFqUUwfUwcnFINTHURlfKzL0ovPff7
	27/6GZ82Wea53jade281k63RTzetyAU503efPH/9j8yJwumu+z7oC1a1XCw15D0nJrTzjOea
	xY7JbnaRFys/63ks2nFk/jtbt6e8W4zrNyvFvgw7dzFxVeNMVln3M5k391p5qu1wLPq1NXen
	Smj9tlPiUzTEGBUXfzu4r+9j/pOoBhVVh6mr5ypeZ+zc0Bl0Z4nZUZvjK1WW5nZc6c9Y0eZw
	YMW24vOaXGHu9YGPFu6ROdh1MqHy8L8z7/azmr+8Ghd1JZlL6oBY0qF/NlIZmUZ3jsz4a/7M
	6MoZrpuTfLi+C6fyx3nmnZsmH3yF6dFyPl9xBV0nc/u3rGtnnYzgdrmt3KnEUpyRaKjFXFSc
	CAAG7V+4NAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSnG5ewNskg8eP9C2aJvxltlh9t5/N
	4uaBnUwWK1cfZbJ413qOxeL828NMFntvaVvMX/aU3eLQ5GYmB06PnbPusntcPlvqsXlJvcfu
	mw1sHu/3XWXz6NuyitHj8ya5APYoLpuU1JzMstQifbsErox12+azFNzgrFjceZitgfEtexcj
	J4eEgInE6V97mUBsIYHdjBJt85Uh4uISzdd+QNUIS6z89xzI5gKqecIoseHVEbAGFgEViZsX
	/wPZHBxsApoSFyaXgoRFBBQken6vZAOpZxY4xyhx7VYTK0hCWCBI4sHnLWA2r4CuxJZd99gg
	hn5glLiz5ShUQlDi5MwnLCA2s4CZxLzND5lBFjALSEss/8cBEuYUsJW41fgJ7AZRAWWJA9uO
	M01gFJyFpHsWku5ZCN0LGJlXMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIER4mW5g7G
	7as+6B1iZOJgPMQowcGsJML7c8frJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeW
	pGanphakFsFkmTg4pRqYOoqVdn18tfO1pcKm1Wuy5JO3trx8/Nuq5pX06lPr58/z93485eDG
	yBopwd0izqslTvu3SX+40TTNI7rwabVK6Hm+s+H3/rSq/1m+ln/Lusg27cx+oxO3emra766f
	vqmsgVuiz2fxT8GZrE0vYhP+JTRr261lZ04TU1O9+reafTmHfU1OV/U+f9WtF5Snyjs5767W
	XV9n0RC16NaX+pfmJYtTtr5yn7v7ocR81Rt7XcISnbyfqBx107Y/Oc+zJ45p+ttTf5ouZvnV
	XF/kMu3y6aD3G7fdOKX/uHzjepetu6/VfevuP8M7SdI8Yuk+IT7tjxbffyuYcrL77Qy1iExh
	OVbp0afVEZCZPPHxrsiHSizFGYmGWsxFxYkAfOBF3AEDAAA=
X-CMS-MailID: 20220805171630epcas5p445c55201e9ec84e467f551baf4f07176
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----WgjG.75RCK0vaugoxekoY7._5exx5H51ZqHYxOO8vRDHiV2S=_4fd8d_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220805155313epcas5p2d35d22831bd07ef33fbdc28bd99ae1d0
References: <20220805154226.155008-1-joshi.k@samsung.com>
	<CGME20220805155313epcas5p2d35d22831bd07ef33fbdc28bd99ae1d0@epcas5p2.samsung.com>
	<20220805154226.155008-5-joshi.k@samsung.com>
	<769524f5-c725-85f7-e7ac-ca3b2b2d884e@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220805_101639_380848_99D15671 
X-CRM114-Status: GOOD (  17.03  )
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

------WgjG.75RCK0vaugoxekoY7._5exx5H51ZqHYxOO8vRDHiV2S=_4fd8d_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Aug 05, 2022 at 11:03:55AM -0600, Jens Axboe wrote:
>On 8/5/22 9:42 AM, Kanchan Joshi wrote:
>> @@ -685,6 +721,29 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
>>  	srcu_read_unlock(&head->srcu, srcu_idx);
>>  	return ret;
>>  }
>> +
>> +int nvme_ns_head_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd)
>> +{
>> +	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
>> +	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
>> +	int srcu_idx = srcu_read_lock(&head->srcu);
>> +	struct nvme_ns *ns = nvme_find_path(head);
>> +	struct bio *bio;
>> +	int ret = 0;
>> +	struct request_queue *q;
>> +
>> +	if (ns) {
>> +		rcu_read_lock();
>> +		bio = READ_ONCE(ioucmd->private);
>> +		q = ns->queue;
>> +		if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio
>> +				&& bio->bi_bdev)
>> +			ret = bio_poll(bio, 0, 0);
>> +		rcu_read_unlock();
>> +	}
>> +	srcu_read_unlock(&head->srcu, srcu_idx);
>> +	return ret;
>> +}
>>  #endif /* CONFIG_NVME_MULTIPATH */
>
>Looks like that READ_ONCE() should be:
>
>	bio = READ_ONCE(ioucmd->cookie);
>
>?
Damn, indeed. Would have caught if I had compiled this with
NVME_MULTIPATH config enabled. Thanks for the catch.

------WgjG.75RCK0vaugoxekoY7._5exx5H51ZqHYxOO8vRDHiV2S=_4fd8d_
Content-Type: text/plain; charset="utf-8"


------WgjG.75RCK0vaugoxekoY7._5exx5H51ZqHYxOO8vRDHiV2S=_4fd8d_--

