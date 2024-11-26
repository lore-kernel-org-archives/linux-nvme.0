Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5ADD3B9A2
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2024 15:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iWfRC+PQ9KIwj5n4FH55KQet8oTgZcDhDUi2rwxK0qc=; b=ioBl0dc/bwBlW2PzicWK0Aeatu
	9Y4YMpV3gxw1tXMBl4sdJ3yejlukovlhbwemOFSB5m15/qaJzFj7HcrK8Kg1oGJOo/7fyi12A/t1d
	kawwiTFQ68U0JQEW/5EsU0ZWPOsTKjQhms6dOYMBte1S8rzn9UdB53Cr7AsGQVklT7lF3imlRKuMU
	EKyliHI4eWnzikj2ZrPae8ROhauIb+KSraUJwmQgM4DKF+0XYvnVgNejavADPOVpfBcjvwrZHRPed
	4DZse3M+JQrZrrapcNynPOemnalkZgg6A+HDBi4W9oW5hpLupbJCD8EfYNP7euA22zA1BBgfwxHLV
	4uEMJ1Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFxKA-0000000AyWp-3ZQ3;
	Tue, 26 Nov 2024 15:17:58 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFxK3-0000000AyQy-3dXY
	for linux-nvme@lists.infradead.org;
	Tue, 26 Nov 2024 15:17:53 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241126151745epoutp025d8a92df34e95c5073e9956eea5684aa~Lja9OjLvo0896008960epoutp02c
	for <linux-nvme@lists.infradead.org>; Tue, 26 Nov 2024 15:17:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241126151745epoutp025d8a92df34e95c5073e9956eea5684aa~Lja9OjLvo0896008960epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1732634265;
	bh=iWfRC+PQ9KIwj5n4FH55KQet8oTgZcDhDUi2rwxK0qc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mw5WKJHVgZAGfs/ooJp9TJQO1AW76ypQ1bv+08MV5Jyrw91ctv5/wdFN9TLeyLi/e
	 vQnQ+ixr1mJnTbY3mfkirdou+JmSziPKQYLitxQG06aa8lr9X6iedvYQ+3fuOe1LhC
	 aoXZAgIUNQya76ASJudTq4bZrDh8mLnKbqQ8Ahn4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241126151744epcas5p1a5994cb5ff9ac2b171b37311e8bfd9ba~Lja8IfcVq0152001520epcas5p1N;
	Tue, 26 Nov 2024 15:17:44 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XyR5f5mX5z4x9Pt; Tue, 26 Nov
	2024 15:17:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	70.F9.29212.696E5476; Wed, 27 Nov 2024 00:17:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241126140212epcas5p2dd99d32c1b3ce9c4b45692e185b9daa9~LiY-P1dsx1356413564epcas5p2o;
	Tue, 26 Nov 2024 14:02:12 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241126140212epsmtrp128ad1c77f1334fcf367a628ad7f326d4~LiY-OvIH12045120451epsmtrp1i;
	Tue, 26 Nov 2024 14:02:12 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-fb-6745e696aeac
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	44.8C.18949.4E4D5476; Tue, 26 Nov 2024 23:02:12 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241126140209epsmtip181b3a32d97164eaecf95f9e1d6448f7a~LiY85tUSC2763027630epsmtip1w;
	Tue, 26 Nov 2024 14:02:09 +0000 (GMT)
Date: Tue, 26 Nov 2024 19:24:23 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, anuj1072538@gmail.com, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v10 06/10] io_uring: introduce attributes for read/write
 and PI support
Message-ID: <20241126135423.GB22537@green245>
MIME-Version: 1.0
In-Reply-To: <2cbbe4eb-6969-499e-87b5-02d19f53258f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA03Tf0wbZRgHcN+76/Uggxy/5BUCI6dktgi0QPE6x+bcWM5ptMa4ONSwS3tp
	kdLWXituc7E6OjImY1uGbpUNpm5IcRt2iEXoJAXG+DEamUo2M5e5FocIEeYmgoAtV8z++7zv
	Pd+793nf9wg0dgxPIkoMFs5sYPUUHom1dUskmR+NFWplTdVSevrePEbXOdsA3XyjBqcnumcA
	fa2rHaGbmnsReso+jNGffLwXoXuXJnH6iPcnQHuuZ9Cdnn6Mrj8TENMHRt043di3iNC+hT4R
	7XPUiZ+OYdodN8TM1StWxuXcjzMXPn+P6bhmw5npwHWMOdjqBMxQQ4+YuetKZVz+SUQVWVS6
	TsexGs6cxhnURk2JQVtAPfdy8aZiRb5MnilX0k9SaQa2jCugNj+vytxSog+2Q6W9zeqtwSkV
	y/NU9vp1ZqPVwqXpjLylgOJMGr0pz5TFs2W81aDNMnCWtXKZLEcRLNxRqps6V4OZBiPeqfba
	xDYwK64CEQQk8+BXfUtIFYgkYslOAF1fHMWFwQyA3ywdx0NVseR9AG8OvLaSOHz6r3DCA2CT
	u1UkDMYAPHVpbDmBkemwouWOKGScXAN7frODkOPJDDgx6hWHAihZjcILsx8ioQdx5BvwzP3A
	clEUmQnrh8cRwTGw/7gfCzmCLICVny4uO4F8FHa19S0vA5J+Avoq/CJhfZvhxfpZXHAc/L2v
	NdxpEhyv2Re2Fs5eDSCCTXDvpYtA8AZoH6hBQ0ZJHfzefzT8nhRYO3AOEeajYfW8P5yNgu6T
	K6ZgZVNd2BB6hm1hM/ByYycmbNEUgPYr9dghsNrxQHOOB74n+AnY0DETNBF0MmxcJARK4Plv
	sxuAyAmSOBNfpuXUCpM808CV/3/mamOZCyxfeKnKDZpbFrK8ACGAF0ACpeKjohM3aWOjNOzO
	XZzZWGy26jneCxTB4zqMJiWojcE/xmAplucpZXn5+fl5ytx8OZUYNWE/oYkltayFK+U4E2de
	ySFERJINkaajR/w/S4b0v5SIXXZWWQbLndWbpKPO734sRf/cod69zZZ4S/Fu9EnRK8yG6R55
	oLYlcMC8cXBgV2PusYe9HSecnpg6x8RSSspD7FaVTf2lJ73i7/mcVYfmirf9m10RndA6517v
	jX/W/nrJ7YV/zkpQVenoi3Pl2z1/rBkqGnkrayG98amR3obdcS/sS22+81Kt8taqQC6RG299
	pMg32G109L5Z19WCZysGCn3PqHc+lvXqCFDye27eq/e1r9ak8vGS/Vsq3c6Dp5J7yj/7YJxP
	qWrumZo/u2e77bJaUvi+ujbj8a0/GJN143d/zcmVZR8bkfb77RPk7bWO85MjX59GN1IYr2Pl
	UtTMs/8BGq1QRnkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfyyUcRzH933ucffczdXjZL5Ytu5q2YlCf3xbodXaHmaF/mlW8pSnY865
	3XVEzY8ki0mMWUfOrpCzVU4zcsaOGOMwIqRs3YV0KaEUVzm1+u+9z/v1+nz++BAsQS3uTsTL
	LjMKGS0Vsnl4U6fQ08c8ekJyQNO/HX1e+YGjCl0TQPXThWy00LkE0ERHC4bq6p9j6GOOCUfl
	ZdkYev7TykbFxjGA2ia9kaGtF0eaGgsH5Y83s1Ftjw1Dgxs9DmhQXcE56kS1qKc51MiAitLr
	brGpxgcZVOtEJpv6bJnEqdtPdYDqr+riUF/0npTebMXCeVG8I7GMND6ZUewPiuHFLVUN4vJ8
	zpWStQFOJhh2yANcApIHYVH1MpYHeISAbAWw8P4UtlVA2DdfA7ayM6yzzXK2IDOA2tI19maB
	k3vgjSdz9k1sci/sms2xCztIb7gwbrQLLLKQBdtW39i3OpPnYM2qxQ7xSR+oMc3/Of0RwKzr
	U/hW4QR775rtmUWK4UvbJkT8zh6w1kZsjrlkIMzV2uyICymCHU092B3gpP7PVv9nq//ZVYCl
	A26MXJkoSVT6yf1lTIqvkk5UqmQS34tJiXpg/6VY3AwMuk++RoARwAggwRLu4G9zPS4R8GPp
	1DRGkXReoZIySiPwIHChK391oSBWQEroy0wCw8gZxd8WI7jumRjXenOFqRQEi4eiz+SVdofE
	pHCSTobp0lURnesm7SD/1BNty7cGGEVT4aOuCSbR0u606SHbsLb1+6vXTFf740v72uecmkMf
	WardHilEuvmGsvHXgXTGQ9YHw7rV2+hTw3977A5plk6Hi/Lqmvb46DNCRvxHIl8Ex05WaCL2
	roWd/joZxF2sCtjlVVl4u3N40Zg2BAyhh/tKz0YDWblKNNM4FqJfdaEnNBujBWvZvnhkQHHv
	oYjIWrd05F9CVaSKC2ZsfnG5pgJ5wM977xcXLV1Byfi7JXWDqXoMm03x6n627IEbroqbqZzM
	4ZIo2Xico+6xTV507dzOC45ZQlwZR/uJWQol/QsBgZ5yOgMAAA==
X-CMS-MailID: 20241126140212epcas5p2dd99d32c1b3ce9c4b45692e185b9daa9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----QQbx9Hk6-Xl4D1oMwM2uYkP7uAkYtjoi7zPie6od2LiHNIsi=_341a9_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241125071502epcas5p46c373574219a958b565f20732797893f
References: <20241125070633.8042-1-anuj20.g@samsung.com>
	<CGME20241125071502epcas5p46c373574219a958b565f20732797893f@epcas5p4.samsung.com>
	<20241125070633.8042-7-anuj20.g@samsung.com>
	<2cbbe4eb-6969-499e-87b5-02d19f53258f@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241126_071752_370372_BF2367BA 
X-CRM114-Status: GOOD (  16.81  )
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

------QQbx9Hk6-Xl4D1oMwM2uYkP7uAkYtjoi7zPie6od2LiHNIsi=_341a9_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Nov 26, 2024 at 01:01:03PM +0000, Pavel Begunkov wrote:
> On 11/25/24 07:06, Anuj Gupta wrote:
> ...
> > +	/* type specific struct here */
> > +	struct io_uring_attr_pi	pi;
> > +};
> 
> This also looks PI specific but with a generic name. Or are
> attribute structures are supposed to be unionised?

Yes, attribute structures would be unionised here. This is done so that
"attr_type" always remains at the top. When there are multiple attributes
this structure would look something like this:

/* attribute information along with type */
struct io_uring_attr {
	enum io_uring_attr_type attr_type;
	/* type specific struct here */
	union {
		struct io_uring_attr_pi	pi;
		struct io_uring_attr_x	x;
		struct io_uring_attr_y	y;
	};
};

And then on the application side for sending attribute x, one would do:

io_uring_attr attr;
attr.type = TYPE_X;
prepare_attr(&attr.x);

------QQbx9Hk6-Xl4D1oMwM2uYkP7uAkYtjoi7zPie6od2LiHNIsi=_341a9_
Content-Type: text/plain; charset="utf-8"


------QQbx9Hk6-Xl4D1oMwM2uYkP7uAkYtjoi7zPie6od2LiHNIsi=_341a9_--

