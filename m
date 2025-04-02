Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4FEC28B20
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 13:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E4a4QPkVxLQnQSAJ3gMsfo/vKUKAMQjCjdoWo1bROC0=; b=zr+UEQAOm0TdOvjIDFwbaM/AS3
	FBttFHeRo1BGgGpcA4tyUkLLHIMM7ejR+5ewCz4SOsB9ZD0irbdRyd4ve1YzHnjp2fHMA8/atO6hF
	d9Yp6TQdGkMgUanNpGxpIpPp1W4zGxcRIu+JykXrClZRtaT9NeSzPvfMeS11NSZSqpuoolG/XyTt4
	b1Tms5OaDCSLZA0drNL3f8HHsN4GgiLTn7lElWiT214trySEsIcG4YxXiOTsiPTLsewIvNh2UxWfW
	GJ9PDB27Gh2y30R/Udzi+zdONvupfTgwe+yinlC/ivbcwxwIfbC7YjjcrPrnmkfu1sy543iIPmVWG
	T1xJiUiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzy28-00000006DkG-1BNa;
	Wed, 02 Apr 2025 13:21:32 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzy23-00000006Dix-2nWw
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 13:21:30 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250402132117epoutp0178f52589b55f39dfd00c379ff14aa684~ygwhFEGfc0059600596epoutp014
	for <linux-nvme@lists.infradead.org>; Wed,  2 Apr 2025 13:21:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250402132117epoutp0178f52589b55f39dfd00c379ff14aa684~ygwhFEGfc0059600596epoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1743600077;
	bh=E4a4QPkVxLQnQSAJ3gMsfo/vKUKAMQjCjdoWo1bROC0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Fx4SQlT6xpR1gLFnURpCdtu9hnIM2YWEci4Ovxm4Le9XQcVhqMZ9UZbaE5ENOnBo6
	 ohf5KjtZ6k0NaFzkVV2vW03aRTv7d8B1eYHoyjrd/aBZJJFwqkdyckEoabhHIkoHNA
	 91Mcf3Bv/bvp5QG5H3y3l4pC8uPSYc0ySyUFAhBo=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250402132116epcas5p36172588119bb80373180f5a4c1d05e6b~ygwgzGXiT0421804218epcas5p3B;
	Wed,  2 Apr 2025 13:21:16 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ZSQVg0LzTz6B9m4; Wed,  2 Apr
	2025 13:21:15 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D5.53.09853.AC93DE76; Wed,  2 Apr 2025 22:21:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250402132114epcas5p3dd1ea9335fb7e7b851820410c29b9265~ygweLXxh10400704007epcas5p3W;
	Wed,  2 Apr 2025 13:21:14 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250402132114epsmtrp1365f215a05329a109fd4f445cee78f4f~ygweKqyhm0388903889epsmtrp16;
	Wed,  2 Apr 2025 13:21:14 +0000 (GMT)
X-AuditID: b6c32a4a-048e07000000267d-6c-67ed39ca0049
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	87.5B.08805.9C93DE76; Wed,  2 Apr 2025 22:21:14 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250402132112epsmtip164f0a3332ab9afbd1a6783e64129bfaa~ygwcqGxk82563025630epsmtip1g;
	Wed,  2 Apr 2025 13:21:12 +0000 (GMT)
Message-ID: <8b7085de-cc9b-45dc-b5bf-1800085fd01d@samsung.com>
Date: Wed, 2 Apr 2025 18:51:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] nvme/ioctl: move fixed buffer lookup to
 nvme_uring_cmd_io()
To: Keith Busch <kbusch@kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Jens Axboe
	<axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Pavel Begunkov <asml.silence@gmail.com>, Chaitanya
	Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <Z-qoevl5Jaf7WFsQ@kbusch-mbp.dhcp.thefacebook.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmlu4py7fpBtc6bCzmrNrGaLH6bj+b
	xf+Fc1ktVq4+ymTxrvUci8WkQ9cYLZ5encVkcXnXHDaL+cuesluse/2exYHLY+esu+we5+9t
	ZPG4fLbUY9OqTjaPzUvqPXbfbGDz6G1+x+ax7WEvu8fnTXIBnFHZNhmpiSmpRQqpecn5KZl5
	6bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAdyoplCXmlAKFAhKLi5X07WyK8ktL
	UhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjO+npnFVrCKq+Ld1ifMDYz7
	OboYOTkkBEwklu94yNbFyMUhJLCbUWLz553MEM4nRonDPzdDOd8YJdZdn8EG03K6bR8rRGIv
	o8Sm469YIJy3jBK/7r1hAqniFbCTeLv9BguIzSKgIjG7bwMzRFxQ4uTMJ2BxUQF5ifu3ZrCD
	2MICkRI93RsZQWwRAWWJu/Nngm1gFtjPJLHmfRNYA7OAuMStJ/OBFnBwsAloSlyYXApicgrY
	S9x+rAVRIS+x/e0csKslBPZwSNz5e4sR4moXiTNT9jBB2MISr45vYYewpSRe9rdB2dkSDx49
	YIGwayR2bO5jhbDtJRr+3GAF2cUMtHb9Ln2IXXwSvb+fgF0jIcAr0dEmBFGtKHFv0lOoTnGJ
	hzOWQNkeEjd7n0GDaiOTxO2/J9kmMCrMQgqVWUienIXknVkImxcwsqxilEwtKM5NTy02LTDK
	Sy2HR3hyfu4mRnAy1vLawfjwwQe9Q4xMHIyHGCU4mJVEeAu13qYL8aYkVlalFuXHF5XmpBYf
	YjQFRs9EZinR5HxgPsgriTc0sTQwMTMzM7E0NjNUEudt3tmSLiSQnliSmp2aWpBaBNPHxMEp
	1cDE4XZeTGGKzjNGu2VZr+at5/7hKqo9u4ZpoZbJ9hsR8/d/vmzs91a8OHTrAvNN999IGFa/
	uFfwVHpb0/lTNj+y9dWE4uYHF5wWXcTz1+EG95QXM23rxU/MrWrpnGNatt2tLzrKysCAY89W
	vd1b/vVyfTaO8fHorlgZ9Mz0a0t5I4fJeyGGFQHuz+W79rPazbC6WHEkw0vytZOr2Hv19Km7
	Z2vGXV0aLsgqxXnrv77jhs1uHO/XX9z5qM1BNZfZ65Cd/Pab8z98+cTMsKvNX/nBspxdKkmf
	DosWFp2xiJN8vXLZ+lsbchOrko+bbXKKq10xT6jY9pUBR0tA2f3DO6fmTl3Ge6yiKdxxlZnE
	NhElluKMREMt5qLiRADumLO0TwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnO4py7fpBh+eMVnMWbWN0WL13X42
	i/8L57JarFx9lMniXes5FotJh64xWjy9OovJ4vKuOWwW85c9ZbdY9/o9iwOXx85Zd9k9zt/b
	yOJx+Wypx6ZVnWwem5fUe+y+2cDm0dv8js1j28Nedo/Pm+QCOKO4bFJSczLLUov07RK4Mr6e
	mcVWsIqr4t3WJ8wNjPs5uhg5OSQETCROt+1j7WLk4hAS2M0o8eLBZyaIhLhE87Uf7BC2sMTK
	f8/ZIYpeM0qseLwLLMErYCfxdvsNFhCbRUBFYnbfBmaIuKDEyZlPwOKiAvIS92/NAKsXFoiU
	6OneyAhiiwgoS9ydPxNsM7PAfiaJz7ubmCA2bGSSeDlvLVgHM9AZt57MB0pwcLAJaEpcmFwK
	YnIK2EvcfqwFUWEm0bW1ixHClpfY/nYO8wRGoVlIzpiFZNAsJC2zkLQsYGRZxSiZWlCcm55b
	bFhglJdarlecmFtcmpeul5yfu4kRHHlaWjsY96z6oHeIkYmD8RCjBAezkghvodbbdCHelMTK
	qtSi/Pii0pzU4kOM0hwsSuK83173pggJpCeWpGanphakFsFkmTg4pRqYmt8mCRfuSDhe3cnC
	ZPnp5Can/pBjL5Yas+jvYJ9rtrcu/JhlxzMumUMH533/qibtFiprylbZk2my5ee21iVnHd58
	XV5RrXrpwr7TYV9YBOXf+vP2TM++EvJqlu1am3MV/GG2gSKal598WfXowP0oTuazc7RNVYLW
	11/728Vu+dfn8H3p5uq8Z3X53dLsrw2kfi4VcOtLfqG5V9HU68Kpzy1zk7llv86sORJ48tW5
	+5UGaktjmwuijj128d8+L2UKQ+kOb/clJydEd7xXFnupv9JqmtfcSb8WrJOVVF+5mk2leemP
	m8eUT6zY/XpV+MkTBmcmXDDJYRA2NGPh3mJV/ZWz/67O+7/CNhu2uMzeq8RSnJFoqMVcVJwI
	AJ2sI+UrAwAA
X-CMS-MailID: 20250402132114epcas5p3dd1ea9335fb7e7b851820410c29b9265
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250328155548epcas5p2368eb1a59883b133a9baf4ac39d6bac6
References: <20250328154647.2590171-1-csander@purestorage.com>
	<CGME20250328155548epcas5p2368eb1a59883b133a9baf4ac39d6bac6@epcas5p2.samsung.com>
	<20250328154647.2590171-4-csander@purestorage.com>
	<48b9a876-0e3b-4c89-9aa3-b48f502868c3@samsung.com>
	<Z-qoevl5Jaf7WFsQ@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_062128_536392_C1CE40E8 
X-CRM114-Status: GOOD (  20.33  )
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

On 3/31/2025 8:06 PM, Keith Busch wrote:
> On Mon, Mar 31, 2025 at 12:16:58PM +0530, Kanchan Joshi wrote:
>> On 3/28/2025 9:16 PM, Caleb Sander Mateos wrote:
>>> For NVMe passthru operations with fixed buffers, the fixed buffer lookup
>>> happens in io_uring_cmd_import_fixed(). But nvme_uring_cmd_io() can
>>> return -EAGAIN first from nvme_alloc_user_request() if all tags in the
>>> tag set are in use. This ordering difference is observable when using
>>> UBLK_U_IO_{,UN}REGISTER_IO_BUF SQEs to modify the fixed buffer table. If
>>> the NVMe passthru operation is followed by UBLK_U_IO_UNREGISTER_IO_BUF
>>> to unregister the fixed buffer and the NVMe passthru goes async, the
>>> fixed buffer lookup will fail because it happens after the unregister.
>> while the patch looks fine, I wonder what setup is required to
>> trigger/test this. Given that io_uring NVMe passthru is on the char
>> device node, and ublk does not take char device as the backing file.
>> Care to explain?
> Not sure I understand the question. A ublk daemon can use anything it
> wants on the backend. Are you just referring to the public ublksrv
> implementation? That's not used here, if that's what you mean.

got it, I did not think beyond public ublksrv.
The userspace block over nvme char-device sounds interesting.

