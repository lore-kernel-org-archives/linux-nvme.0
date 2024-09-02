Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA60C54FC6
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 05:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j48tXrfPFLQpQy7ehDudz1ll+W1pF1dhPhX8Mc3nQqc=; b=n49fJkdEYxy1pm6QCEnSnGkoRI
	XVOMtM79nxRtrpVlqqSsWjHVMKikuV+NVB16FGenMtGShSYHdRcmiIYr0fq4pbBLNeyXuqQnA7p+P
	pCAlhhgNWoUUjlbUWqeHmu7sGkADYlxqnywu2fUNaPmH/3js9K8ti1+9/ZAo9qNwhuL1Hdg+xsodw
	Z8jpEq82+TRu9MaFl9MqOdTFIxVJ2WFxhK4JyF/Q2W5GStSXLLbR41a3WTN2Za2N8AuMLIwF2mehJ
	6Ll4jVPKUoZSouj7wtUim/4sV7+Cnq0qirDE4zPcjtp3PTmSOAPzC5X4rLMjT2uaoNiSPiEdh8wXk
	oJzk20Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1skzSm-0000000D0O9-2mmQ;
	Mon, 02 Sep 2024 05:18:52 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1skzSh-0000000D0Nc-0JTM
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 05:18:49 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240902051839epoutp0152e67c557962ca04ab05a4e17b11530e~xVamiO1j83030030300epoutp01F
	for <linux-nvme@lists.infradead.org>; Mon,  2 Sep 2024 05:18:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240902051839epoutp0152e67c557962ca04ab05a4e17b11530e~xVamiO1j83030030300epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725254319;
	bh=j48tXrfPFLQpQy7ehDudz1ll+W1pF1dhPhX8Mc3nQqc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rCxTO0L7UCcIFdxMmHf8dasIruE4sJkM+JTXoq/XbLrVESVOyEPP+7n3PKTNHm4WZ
	 0713y22C6yeaHHrPuO8vWOATp40SD7nEf9uYWaqiMMbtQl6QPNzwnUAqVYVJ3l9FOx
	 PM6QWs84fHlHYtYIYutJWszH4avkYyo/HMS1QNMs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240902051838epcas5p14c257efc542d4b9a274b9dc4c277d225~xVal_rM6o1678716787epcas5p1Q;
	Mon,  2 Sep 2024 05:18:38 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Wxxqc65zdz4x9Pq; Mon,  2 Sep
	2024 05:18:36 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.2C.09743.CAA45D66; Mon,  2 Sep 2024 14:18:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240902051836epcas5p39b730254365bd2c759417178d2f6da95~xVajpRyl00854708547epcas5p3D;
	Mon,  2 Sep 2024 05:18:36 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240902051836epsmtrp1da38afc11821c9b95fb4d33e235eb199~xVajoayr80087300873epsmtrp1j;
	Mon,  2 Sep 2024 05:18:36 +0000 (GMT)
X-AuditID: b6c32a4a-3b1fa7000000260f-46-66d54aacd6fd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DF.E4.07567.CAA45D66; Mon,  2 Sep 2024 14:18:36 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240902051833epsmtip1f4f6ade22e4a2ede413b18d72ce57cef~xVagrBjGC2920229202epsmtip1s;
	Mon,  2 Sep 2024 05:18:32 +0000 (GMT)
Message-ID: <3343ecc2-6c19-e509-5f17-ceaa4f88efae@samsung.com>
Date: Mon, 2 Sep 2024 10:48:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/5] fs, block: refactor enum rw_hint
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com, brauner@kernel.org, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <0cfd7841-ea11-48c6-93fb-7817236c81c8@acm.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJJsWRmVeSWpSXmKPExsWy7bCmpu4ar6tpBnv6tS1W3+1ns3h9+BOj
	xbQPP5kt/t99zmRx88BOJouVq48yWcye3sxk8WT9LGaLjf0cFo/vfGa3+LlsFbvFpEPXGC32
	3tK2uLTI3WLP3pMsFvOXPWW36L6+g81i+fF/TBbrXr9nsTg/aw67g4jH5SveHufvbWTxmDbp
	FJvH5bOlHptWdbJ5bF5S77F7wWcmj903G9g8Pj69xeLRt2UVo8eZBUfYPT5vkgvgicq2yUhN
	TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAF6UkmhLDGnFCgU
	kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnfHl3yH2
	gpksFWeu32JsYFzB3MXIySEhYCJx8sUC9i5GLg4hgd2MEv/W3GKCcD4xSnTPmMcG4XxjlPh4
	ajUjTEvLn5ksEIm9jBLHV39gA0kICbxllPjfGwti8wrYSWz6shWogYODRUBF4uvVIIiwoMTJ
	mU9YQGxRgSSJX1fngM0UFrCR2Ph7FdhJzALiEreezAe7QkRgKpPEgT8tYMuYQea/nrWAGWQo
	m4CmxIXJpSANnALWEsdOvYJqlpdo3jqbGaReQmA6p8TPG90sEFe7SDxfuR/qaWGJV8e3sEPY
	UhIv+9ug7GyJB48eQNXXSOzY3McKYdtLNPy5wQqylxlo7/pd+hC7+CR6fz9hAglLCPBKdLQJ
	QVQrStyb9BSqU1zi4YwlULaHxOVfy6Hh9o5Rov3JTpYJjAqzkMJlFpL/ZyF5ZxbC5gWMLKsY
	JVMLinPTU4tNC4zyUsvhEZ6cn7uJEZwHtLx2MD588EHvECMTB+MhRgkOZiUR3qV7LqYJ8aYk
	VlalFuXHF5XmpBYfYjQFxs9EZinR5HxgJsoriTc0sTQwMTMzM7E0NjNUEud93To3RUggPbEk
	NTs1tSC1CKaPiYNTqoEp6mTPe+2fi6JPnXmmNNljf2fPniXNGsF3aq47fS5suD9pN89n723b
	f4Qcm/nK1G1TVAdv7Xf5QNeOjWJXmU7vj+qRdXc+0PK67ahJyl6R/20t/noT1eq829cKm6bs
	Pyr4UGsbt96CwJ99kQ1BsycZ7XhSw7ND4RNrd3s7T9jGOfkJp55t/R7GtZstWkZHJfv/coMb
	e7Qu8PGazFH88kn2xa+3ry+eLnK/Oc3+QLuOm0iO6/WCf75lfEv3dVyekvn2wmv+72+nWMjJ
	6J7nNGIoDefh2a9usO+e2YbFAk96Mk+/5J3ReNUrY5rsnWzDAoH9q/aLcl33+DflvM06n4XG
	adzqGywf5CzJaW/JNRdVYinOSDTUYi4qTgQAYNIahYwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsWy7bCSnO4ar6tpBtc3s1usvtvPZvH68CdG
	i2kffjJb/L/7nMni5oGdTBYrVx9lspg9vZnJ4sn6WcwWG/s5LB7f+cxu8XPZKnaLSYeuMVrs
	vaVtcWmRu8WevSdZLOYve8pu0X19B5vF8uP/mCzWvX7PYnF+1hx2BxGPy1e8Pc7f28jiMW3S
	KTaPy2dLPTat6mTz2Lyk3mP3gs9MHrtvNrB5fHx6i8Wjb8sqRo8zC46we3zeJBfAE8Vlk5Ka
	k1mWWqRvl8CV8eXfIfaCmSwVZ67fYmxgXMHcxcjJISFgItHyZyYLiC0ksJtRomu1GURcXKL5
	2g92CFtYYuW/50A2F1DNa0aJxw3nmUASvAJ2Epu+bGXsYuTgYBFQkfh6NQgiLChxcuYTsJmi
	AkkSe+43gpULC9hIbPy9CmwvM9D8W0/mM4HMFBGYyiSx8sVVsAXMAm8ZJVoPHGGB2PaOUeLy
	wVvMIBvYBDQlLkwuBenmFLCWOHbqFdQkM4murV2MELa8RPPW2cwTGIVmITlkFpKFs5C0zELS
	soCRZRWjZGpBcW56brJhgWFearlecWJucWleul5yfu4mRnDMa2nsYLw3/5/eIUYmDsZDjBIc
	zEoivEv3XEwT4k1JrKxKLcqPLyrNSS0+xCjNwaIkzms4Y3aKkEB6YklqdmpqQWoRTJaJg1Oq
	gSm31EDtqie79SJx27+567d0x+9nKnY855R8YEvz7Hseq70UJ0ml5ziZuu0SnpNrPfXgBOfY
	LWxiR5buDf64VVOqaJfudYtyw3YRn0MvUrZdfd5QnqZoZKOx9tTO6jgRfrsTCoLc/30kC2Kj
	GE6daZyyTjBaufXrlDJVLY87HXMvFaYs5rasuTztfn7XxYy6U9E584RnnY1l67h5eYve9G5L
	ruZFPsHKPd+Pnjfbvia2VKvKxPzE7MINluWvvT5v235pwm+uHkd1C+GI18o37f4+UVln9se8
	4Ne7L3G6lq/dJH8+feC7Kd1umvu2svO/YmZ2RpzheNdpGve5ZmHVht0r2/znrDgX767Bz/tx
	hRJLcUaioRZzUXEiAMk9H9loAwAA
X-CMS-MailID: 20240902051836epcas5p39b730254365bd2c759417178d2f6da95
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240826171413epcas5p3f62c2cc57b50d6df8fa66af5fe5996c5
References: <20240826170606.255718-1-joshi.k@samsung.com>
	<CGME20240826171413epcas5p3f62c2cc57b50d6df8fa66af5fe5996c5@epcas5p3.samsung.com>
	<20240826170606.255718-2-joshi.k@samsung.com>
	<0cfd7841-ea11-48c6-93fb-7817236c81c8@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240901_221847_771182_23EAFBBB 
X-CRM114-Status: GOOD (  15.41  )
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

On 8/30/2024 5:47 PM, Bart Van Assche wrote:
> On 8/26/24 1:06 PM, Kanchan Joshi wrote:
>>   /* Block storage write lifetime hint values. */
>> -enum rw_hint {
>> +enum rw_life_hint {
> 
> The name "rw_life_hint" seems confusing to me. I think that the
> name "rw_lifetime_hint" would be a better name.
> 

I can change to that in next iteration.
This change needs to be consistent in all the places. But more important 
in patch #3 (as we expose TYPE_RW_LIFE_HINT to userspace). Do you have 
comments on the other parts?

