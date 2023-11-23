Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48719C61D85
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Nov 2023 18:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=boZ+Cj1J5VHKo8ljoASTIiF1YNfM7uxAE2r7pkFxkQ8=; b=4VkbkhrUdaKxXHIyrsN4lMIr5c
	FWsTWk1mMWNiL495Dmcn6oqlF+kPFVosJnNOmWXWLHmdKxGPVuEdb3sFdyfrGOhydmECRutW8k+lY
	I2VcsBEvmkXiqh3DFuaiPfmjL5hPo2EDa888KAzLVh+zaBcLSLIxhH1Ws6Q8TlBHCyTUkQCWNelmw
	Hlb4IJI1k13yNTsggKhXYZ28BW+aSCSkjPhbyrk/qZ0S2St5zQydG7j8dfl+hvYx2/BPNsy7TVuyj
	vadZsx/Rlypvmel7yxeovvvFLnb3gBqL/biPpas3K5CCsSzCthYbPMuE50yU6fd9ktYlF7BLsgm4J
	tUz6qohg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6EGv-005UxD-39;
	Thu, 23 Nov 2023 18:17:53 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6EGs-005Uw8-31
	for linux-nvme@lists.infradead.org;
	Thu, 23 Nov 2023 18:17:52 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231123181740epoutp04a52d782f5a0b8d812f61bac8b2b602d6~aU1sq9HVE1778517785epoutp04c
	for <linux-nvme@lists.infradead.org>; Thu, 23 Nov 2023 18:17:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231123181740epoutp04a52d782f5a0b8d812f61bac8b2b602d6~aU1sq9HVE1778517785epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1700763460;
	bh=boZ+Cj1J5VHKo8ljoASTIiF1YNfM7uxAE2r7pkFxkQ8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=VfHHV+5Wo64dYI1HJLtgv2TvfnZbaCublP8fxsLVX6DftEKxR8ovfLroxpoJdPV2e
	 9LAUfJYwnvvlZxZ5LpBZHbUYDqZTFon2fnwsHthfjFaEl2/pk77TqAFVfqYJKbwT+q
	 e1od39r3HIi6Rjm/Da+IJNcQ12il3kQLiV0oq7IU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231123181739epcas5p127a69cb42fcda3c42680f5bf6a935308~aU1sFSiqG0039700397epcas5p1Q;
	Thu, 23 Nov 2023 18:17:39 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SbmYZ3G0hz4x9Pv; Thu, 23 Nov
	2023 18:17:38 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	84.F7.09672.2479F556; Fri, 24 Nov 2023 03:17:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231123181737epcas5p3b61420060d23ce7c454a9a5798ac01d2~aU1qZk4pS2141821418epcas5p3c;
	Thu, 23 Nov 2023 18:17:37 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231123181737epsmtrp29270dfba3ad8cb29b6dc985cb7707695~aU1qWeEXJ2197021970epsmtrp2M;
	Thu, 23 Nov 2023 18:17:37 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-a6-655f9742ded4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B6.EC.08817.1479F556; Fri, 24 Nov 2023 03:17:37 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231123181736epsmtip1c1ed365d71a33c569a7b29da74d1ef8a~aU1plEpyc0932709327epsmtip15;
	Thu, 23 Nov 2023 18:17:36 +0000 (GMT)
Message-ID: <48134197-75d1-5a4a-c992-5c60a91644ea@samsung.com>
Date: Thu, 23 Nov 2023 23:47:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] nvme-core: fix a memory leak in
 nvme_ns_info_from_identify()
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, emilne@redhat.com
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231123140741.411735-1-mlombard@redhat.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmuq7T9PhUg/mrRCyWrYy2mHToGqPF
	/GVP2S1OT9vM7MDisWlVJ5vH5iX1Hu/3XWULYI7KtslITUxJLVJIzUvOT8nMS7dV8g6Od443
	NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBWqakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVK
	LUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM5Y0jCdrSC94vHJa+wNjGFdjJwcEgImEl+v
	TGfsYuTiEBLYzSgx681xNgjnE6PE5+YuFgjnG6NE35UDzDAtBxb8ZIVI7GWUWLBsNTuE85ZR
	4vqR24wgVbwCdhJ/e7cygdgsAqoSZ5e8Z4KIC0qcnPmEBcQWFUiS+HV1Dli9sECwREf7V1YQ
	m1lAXOLWk/lg9SJAc74/eAwVN5VY+uMFUD0HB5uApsSFyaUgYU4BK4m3X7YxQpTIS2x/O4cZ
	5B4JgWvsEpcWbGWHuNpFon/aNRYIW1ji1fEtUHEpic/v9rJB2MkSl2aeY4KwSyQe7zkIZdtL
	tJ7qZwbZywy0d/0ufYhdfBK9v58wgYQlBHglOtqEIKoVJe5NesoKYYtLPJyxhBWixENi1boC
	kLCQQC+jxOptEhMYFWYhhcksJL/PQvLMLIS9CxhZVjFKphYU56anFpsWGOellsMjOzk/dxMj
	OB1qee9gfPTgg94hRiYOxkOMEhzMSiK8W9hjUoV4UxIrq1KL8uOLSnNSiw8xmgIjZyKzlGhy
	PjAh55XEG5pYGpiYmZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE08fEwSnVwMQ4cRL/hFNM
	v7re+utfUt/rXp6mpSKle87gnJPrG48P6f1BavrxblryfzvM1tReFTqv4LU72GJFtPB9hvvu
	Gww+mv366r/qVn89s5XRkyfR+ox3M/NC1ewX173VfxnCXJGaFPBM5eiWubYWrC+Xz+WVuFyQ
	/7M6KHLK30WmZ8+/idz6YV/Ooyo/e2OJhIDTm1ymehzRqTtwxOhAc/iK3TGNggvymBbf6OQp
	LYzoFNFuFN/S0/9pegj/++9Ji2eI7ZGfaGmsNquuuOlI8zMvtRhRlubwwGl1W7vdpdbtnW3A
	Z9Z90LXqP8M669mbp068+NfMZ1d7EFPbd0f53xNOLhX0fhyweN2mCIa75x/YKbEUZyQaajEX
	FScCAD+CHzgQBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSnK7j9PhUg5WfNC2WrYy2mHToGqPF
	/GVP2S1OT9vM7MDisWlVJ5vH5iX1Hu/3XWULYI7isklJzcksSy3St0vgyljSMJ2tIL3i8clr
	7A2MYV2MnBwSAiYSBxb8ZO1i5OIQEtjNKPHuxXQmiIS4RPO1H+wQtrDEyn/P2SGKXjNKfJpz
	GSzBK2An8bd3K1gDi4CqxNkl75kg4oISJ2c+YQGxRQWSJPbcbwSLCwsES3S0f2UFsZmBFtx6
	Mh8sLgI05/uDx1BxU4mlP14wQizrZZRoO9kHVMTBwSagKXFhcilIDaeAlcTbL9sYIerNJLq2
	dkHZ8hLb385hnsAoNAvJGbOQrJuFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1
	kvNzNzGCw19LawfjnlUf9A4xMnEwHmKU4GBWEuHdwh6TKsSbklhZlVqUH19UmpNafIhRmoNF
	SZz32+veFCGB9MSS1OzU1ILUIpgsEwenVAPTlDDzjuTNKz6tv/f3SayLnZSW3Me0eu3z/5/p
	S14TTpu+qLTH5pd6aXSxeuCJf77OASqFn/76vPf/Y6YUdcj02eZMYd/gZTc36H8qe6YprBI0
	g9Uk3qrPwi4seUrUl1+JW/vMO2r2uhxrroiq6tqxc3FlbZxGSfm9m0YhZjFhHfdkr5gpF3ts
	Ov5Q59zG2wpMr2+UFGZ2ya5hXZ83zaNPh6Pj0j+t8505fzYft2IQcDzCn2uRrBrCvOHBgR7t
	4uBChz0Md5OFuSv+T/N4fNpBXu3vujPNl7R88n+ILP89+cfKK8lJVRVrtJf82B6sPbUlrW/i
	E20RX13hjIpzwdu2twgpJ6fda0l1V/G7pcRSnJFoqMVcVJwIAEOVwNfuAgAA
X-CMS-MailID: 20231123181737epcas5p3b61420060d23ce7c454a9a5798ac01d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231123141207epcas5p124343b534f2b31b0f79f42de2d25dd9e
References: <CGME20231123141207epcas5p124343b534f2b31b0f79f42de2d25dd9e@epcas5p1.samsung.com>
	<20231123140741.411735-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_101751_417808_98F5E1D6 
X-CRM114-Status: UNSURE (   6.92  )
X-CRM114-Notice: Please train this message.
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

On 11/23/2023 7:37 PM, Maurizio Lombardi wrote:

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>


