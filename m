Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B22CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CnqUBA9LStlL9Yrbyg+7kegUbFbqmLcirWP2ZgCm848=; b=YdkiM/QDXTzBin2qVoFWyRC2NP
	13ZapbEeKdDlANk6b/WPR7p4ErgL+ETztg5i4g4lOvKuTfaPG1VT8qCu4YAGocsSGXKrEsA3Cjwjd
	8swnKcegcD47X2dj1nfImeIDBsZAfa9H730dHCevYkCD2yq5/7JpFlEehkQsJzMi5gqj51Ocl/Yyt
	hzyI/gUfObq/20a+8M+LCfQVyyvMcJgfnJYcKacpkDxK5joaHDQHDDHe32oPKEkh047dtDDdd0Ydg
	ykGT4HAw8saaGKo5SMBXLD/XkVqQDM3Qw8yt0TIsx0H/wMV7BTW4AgTXHaQ3EnSGkFddQCf6zBIcJ
	mZLNJf6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrfpq-0000000Ble2-449k;
	Tue, 02 Apr 2024 15:14:02 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrfpm-0000000Blbc-1ySL
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 15:14:01 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240402151352epoutp02146051c6c87db937a26af25a472d48e3~Cf1oBbf9B2951129511epoutp02P
	for <linux-nvme@lists.infradead.org>; Tue,  2 Apr 2024 15:13:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240402151352epoutp02146051c6c87db937a26af25a472d48e3~Cf1oBbf9B2951129511epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712070832;
	bh=CnqUBA9LStlL9Yrbyg+7kegUbFbqmLcirWP2ZgCm848=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WhCf71B+P6V4+uqageQovqnc4qsb30E8tXkWoZ5VSALmdD0cHKySrhZ6NRqBzWhAr
	 BqTr/Gn5xONbqJHuzTxh89C0MMuxJYCtvzSuLIW1HFN4K4EWN6jUW3hY0TGaBB3Y10
	 D9j4drN0mzwA0/akxitYPLMPI1Kvc7sJOyJUWyHQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240402151352epcas5p473e0480cb54a12539cd694b92ba90014~Cf1n1FUKf1143111431epcas5p4B;
	Tue,  2 Apr 2024 15:13:52 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4V8BH26ywWz4x9Pp; Tue,  2 Apr
	2024 15:13:50 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.B2.09688.EA02C066; Wed,  3 Apr 2024 00:13:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240402151350epcas5p3ddb2ac7f6b62f793f57bbb0cb4337557~Cf1lzwCPP1717317173epcas5p3O;
	Tue,  2 Apr 2024 15:13:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240402151350epsmtrp2c9f50e8734893bf8fb131eab90d3a981~Cf1lzK_en2914329143epsmtrp2j;
	Tue,  2 Apr 2024 15:13:50 +0000 (GMT)
X-AuditID: b6c32a4a-837fa700000025d8-e7-660c20aeebcc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	38.3F.08924.EA02C066; Wed,  3 Apr 2024 00:13:50 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240402151349epsmtip1d2db58afcb0c125512d58ab0fd0d8cf4~Cf1lBZ2h02482224822epsmtip1X;
	Tue,  2 Apr 2024 15:13:49 +0000 (GMT)
Message-ID: <5de0f607-405b-30c0-84de-e923b509588e@samsung.com>
Date: Tue, 2 Apr 2024 20:43:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v2] nvme: split nvme_update_zone_info
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240402144754.751976-1-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTU3edAk+awcZGc4uVq48yWUw6dI3R
	Yv6yp+wW616/Z3Fg8Th/byOLx6ZVnWwem5fUe+y+2cAWwBKVbZORmpiSWqSQmpecn5KZl26r
	5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
	kV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ3x9dhu1oKJrBVLu36yNDBOZ+li
	5OSQEDCR2PBtCpDNxSEksJtR4vSJJmYI5xOjRPubuVDON0aJ6Z8msMO07J33lBUisZdR4uqi
	k4wQzltGiRX7bgM5HBy8AnYSp15VgTSwCKhIPHrxgBXE5hUQlDg58wnYblGBZImfXQfYQGxh
	AUuJSUueMIPYzALiEreezGcCsUUE3CVmfpjLAhFXkvi8fy47yHg2AU2JC5NLQcKcAoYSd//M
	Y4IokZfY/nYO2NESAh/ZJTa/OAJ1tIvEi2vv2CBsYYlXx7dAxaUkPr/bCxVPlrg08xwThF0i
	8XjPQSjbXqL1VD8zyF5moL3rd+lD7OKT6P39hAkkLCHAK9HRJgRRrShxb9JTVghbXOLhjCVQ
	todE47xGaHi2MEqsXHGCZQKjwiykUJmF5PtZSN6ZhbB5ASPLKkbJ1ILi3PTUYtMCo7zUcnh8
	J+fnbmIEJ0gtrx2MDx980DvEyMTBeIhRgoNZSYT3pzdnmhBvSmJlVWpRfnxRaU5q8SFGU2D0
	TGSWEk3OB6bovJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamExC
	eLSbFkd1lCbpPZ2+f9mdyUcmfLutPJ975lsBwY4YRpc9lianPJxmlbZdN+d6nDhRearBLca3
	AW/3yTIJZy8T264v+cTq2AWvhFnMB9rdV1bk1E5c0NlXXRIrrRbz59CRfypFjkcurWNimVM0
	xSlmaV9pbKeAw9RNKdtee9bd7Dm0I33C5pSgQAZTE353rzuNDoUW05lPcqzbUZMy53Lae8GJ
	P/sqlSM8xfmXh4r7Rdl9rjKbU5wjfNnb7YnN6Wu+q55WZbfl/+U7duPzPSs21+p5l1pC+M7v
	CXlh+/uJ0xKWzSsmqNfZvF6RvrYvuvekIMflsp1V0vYXyo2LPssqWU60uHCft+/bP/dnSizF
	GYmGWsxFxYkA28r/ShkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnO46BZ40g40TJCxWrj7KZDHp0DVG
	i/nLnrJbrHv9nsWBxeP8vY0sHptWdbJ5bF5S77H7ZgNbAEsUl01Kak5mWWqRvl0CV8bXY7tZ
	CyayVizt+snSwDidpYuRk0NCwERi77ynrF2MXBxCArsZJa52fmeDSIhLNF/7wQ5hC0us/Pec
	HaLoNaNE/4LlzF2MHBy8AnYSp15VgdSwCKhIPHrxgBXE5hUQlDg58wnYAlGBZImXfyaCzREW
	sJSYtOQJM4jNDDT/1pP5TCC2iIC7xMwPc1kg4koSn/fPhdrVwijx7+1OdpBdbAKaEhcml4LU
	cAoYStz9M48Jot5MomtrFyOELS+x/e0c5gmMQrOQnDELybpZSFpmIWlZwMiyilEytaA4Nz23
	2LDAMC+1XK84Mbe4NC9dLzk/dxMjOBq0NHcwbl/1Qe8QIxMH4yFGCQ5mJRHen96caUK8KYmV
	ValF+fFFpTmpxYcYpTlYlMR5xV/0pggJpCeWpGanphakFsFkmTg4pRqYltU9bnwcnf3p0i/f
	V+aKK5hvf5Kbs+TM0y2CyiqsH+ds76xN2c64ZssbSY0DQvPtik+zPrjhd+LcfH7O0I3GiW1f
	FvFnHfKVaJMonXn+zpYMyYDtV+VfiWgoL5lYLdeg7M7Q//Cl9eMnU4r/H8u/8StwwexLKWt9
	Ji0OX/1eLszlXadviHS90x31oM2ZWu9W/llcH336vV6Srp5b3f3FSfNX90zKqeO7Y7NlpfHS
	xMm+zwv75H51dDgtWKg1+YiokvGilXtXTirJC5sa49xd/iKDVafuSu7c21u4rtYuiFoo0L2t
	f/W23bPn/tz7cqZWY8DtFR+ulhYnJ3jrsbvYT7Gx7VMuu20WmvZfiufJXiWW4oxEQy3mouJE
	AHPxATb1AgAA
X-CMS-MailID: 20240402151350epcas5p3ddb2ac7f6b62f793f57bbb0cb4337557
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240402144830epcas5p35bdc555afe12fc8eb52a5c8fe0894c38
References: <CGME20240402144830epcas5p35bdc555afe12fc8eb52a5c8fe0894c38@epcas5p3.samsung.com>
	<20240402144754.751976-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_081358_992275_D67D5E86 
X-CRM114-Status: GOOD (  12.93  )
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

On 4/2/2024 8:17 PM, Christoph Hellwig wrote:
> nvme_update_zone_info does (admin queue) I/O to the device and can fail.
> We fail to abort the queue limits update if that happen, but really
> should avoid with the frozen I/O queue as much as possible anyway.
> 
> Split the logic into a helper to query the information that can be
> called on an unfrozen queue and one to apply it to the queue limits.
> 
> Fixes: 9b130d681443 ("nvme: use the atomic queue limits update API")
> Reported-by: Kanchan Joshi<joshi.k@samsung.com>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> ---

Looks good.
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

