Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3139D5CC9C
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 11:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OzObsVJKazVgcN/sx4nDHJ63Yo33iupzEMEKYB9KAo8=; b=c56jmJ8rjLIK8D87KJ+x39fpYV
	e+rWUTDNUv/9ajWOGnwVg3BgibzoRwmkrTXh6ZGF7IEfYx2+QJkGRWwv3JY9q1iDz0OeQ8yirG/23
	6ZrZijEgLnArxaOWAdBowCnG9YR0NM8hpw8GkUU8MtyZB1XgcoNyvxqyagFUlwzM0fIvMZJEKzSoV
	CKy2NoLzkfsmcFNoZw71hKizsnuMDLuv3Z+xXIPRT81HPAfCk6t/LIYGQPybYWDA2b04sE03SfHLz
	0FNMuiOXvn7CZpCTUhL94wa8hU+pHxyyuWA//RfKLTwoN0Xlpto1EryUTPe3i851YVXjk0Ev2puu0
	GCEZZ8Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t673C-00000000ArR-3MXB;
	Wed, 30 Oct 2024 11:39:46 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t66hc-000000006Mg-4BZJ
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 11:17:31 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241030111717epoutp0365aecdbc0417e658d50a7821ec3e1ca7~DNuSwR3Hv1789917899epoutp03R
	for <linux-nvme@lists.infradead.org>; Wed, 30 Oct 2024 11:17:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241030111717epoutp0365aecdbc0417e658d50a7821ec3e1ca7~DNuSwR3Hv1789917899epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730287037;
	bh=OzObsVJKazVgcN/sx4nDHJ63Yo33iupzEMEKYB9KAo8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ZlYbgbWIFcDAS1lhBQZkC3kI49kLlv8+s8ulBNrNrt3Kg4GXRvATsZreTbyLOZbez
	 ww2gLN7jum2vjjKy+PC35HKlrYfDnRCmRolVnB6eWAPxevjpeDjGXCINoF1rfuhLfE
	 UhpLuJ731723XJDZZa6dpmw6cUnxP6VW7wVnu22c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241030111716epcas5p3a994daa648427069bbd00eb1f4650c90~DNuR0GVe80206702067epcas5p3k;
	Wed, 30 Oct 2024 11:17:16 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Xdl2g3ykXz4x9Pw; Wed, 30 Oct
	2024 11:17:15 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A5.E1.18935.BB512276; Wed, 30 Oct 2024 20:17:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241030111714epcas5p43427b28045729bf2a3e8b5f8eb89721a~DNuPyYXi50427004270epcas5p4u;
	Wed, 30 Oct 2024 11:17:14 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241030111714epsmtrp2bd805bfc1033e94261a0f82b9b75f1a6~DNuPxiVnR2729027290epsmtrp2v;
	Wed, 30 Oct 2024 11:17:14 +0000 (GMT)
X-AuditID: b6c32a50-a99ff700000049f7-45-672215bb2293
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	27.46.18937.AB512276; Wed, 30 Oct 2024 20:17:14 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241030111712epsmtip2062d4a5833ae6808d34c5cd6b34aedde~DNuNfow6l1561015610epsmtip2I;
	Wed, 30 Oct 2024 11:17:11 +0000 (GMT)
Message-ID: <457b635b-a3b5-48bb-b2ac-b129c5d3d30d@samsung.com>
Date: Wed, 30 Oct 2024 16:47:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] fs, iov_iter: define meta io descriptor
To: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, martin.petersen@oracle.com,
	asml.silence@gmail.com, anuj1072538@gmail.com, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20241030050355.GA32598@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCJsWRmVeSWpSXmKPExsWy7bCmhu5uUaV0g7t3pS0+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBaTDl1jtNh7S9tiz96TLBbz
	lz1lt+i+voPNYvnxf0wW5/8eZ7U4P2sOu4Ogx85Zd9k9Lp8t9di0qpPNY/OSeo/dNxvYPD4+
	vcXi0bdlFaPHmQVH2D0+b5Lz2PTkLVMAV1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGh
	rqGlhbmSQl5ibqqtkotPgK5bZg7QO0oKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpSc
	ApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IzeaY3sBR+YKh7PfsDYwLiKqYuRk0NCwETixftd
	jF2MXBxCAnsYJaZvvsMC4XxilFh66yMrnDP/wAMWmJbV706wQyR2MkrcPjmdCcJ5yygx+fp3
	sCpeATuJ7f9/gS1hEVCVePzrKDtEXFDi5MwnYDWiAvIS92/NAIsLC7hKtHw8zwhiiwDZpx5c
	ZAYZyizwhUni8N1WsCJmAXGJW0/mAw3l4GAT0JS4MLkUJMwpoCPxfstqRogSeYntb+eA9UoI
	vOGQuPvwJSvE2S4Sh5omMULYwhKvjm9hh7ClJD6/28sGYWdLPHgE82aNxI7NfVC99hINf26w
	guxlBtq7fpc+xC4+id7fT8DOkRDglehoE4KoVpS4N+kpVKe4xMMZS6BsD4mH+++CbRISuM8o
	0fXQegKjwiykUJmF5MlZSL6ZhbB4ASPLKkap1ILi3PTUZNMCQ9281HJ4jCfn525iBCd3rYAd
	jKs3/NU7xMjEwXiIUYKDWUmE1zJIMV2INyWxsiq1KD++qDQntfgQoykwfiYyS4km5wPzS15J
	vKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUwRt9qXHYoPOcigFOlg
	/DLkW8KiuYtMbM7lhrDfym1ynF7bXvaH/9HTjUWCExvKXa5eEueeycPJ6alSxPCL5WScYe+G
	Jwu8E+rEKh5cZntW4l/XpXrjkt71ssVR0f//SmXoPmToPrX6NUtStPee01nb3ttH3nipKO5R
	zv5Thcfz4ZwutrOz+X/mKTmu+uVqxs4+4dKnFVwZrGlFYba5rrvTLlzYubO8cv0N048/dFyL
	fswK6ZLbVH5xxaepfl2rJt/dEPdwO/PG3tmbAg+6Ha8ValPyeuPyoMtmRqn2x+WHru95/+6g
	7O2HVXqK804z35viuZJj3w6hteUC67ZPVfKVFN+47ddGtUWhB7ZeZGJSYinOSDTUYi4qTgQA
	erqqjncEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7bCSvO4uUaV0g+f3JSw+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBaTDl1jtNh7S9tiz96TLBbz
	lz1lt+i+voPNYvnxf0wW5/8eZ7U4P2sOu4Ogx85Zd9k9Lp8t9di0qpPNY/OSeo/dNxvYPD4+
	vcXi0bdlFaPHmQVH2D0+b5Lz2PTkLVMAVxSXTUpqTmZZapG+XQJXRu+0RvaCD0wVj2c/YGxg
	XMXUxcjJISFgIrH63Qn2LkYuDiGB7YwSq9c0skEkxCWar/1gh7CFJVb+ew5V9JpRYvfrHSwg
	CV4BO4nt/3+BTWIRUJV4/OsoO0RcUOLkzCdgNaIC8hL3b80AiwsLuEq0fDzPCGKLANmnHlxk
	BhnKLPCFSWLlw1nMEBvuMkqcOPIZ7AxmoDNuPZkPtIGDg01AU+LC5FKQMKeAjsT7LasZIUrM
	JLq2dkHZ8hLb385hnsAoNAvJHbOQTJqFpGUWkpYFjCyrGEVTC4pz03OTCwz1ihNzi0vz0vWS
	83M3MYIjWCtoB+Oy9X/1DjEycTAeYpTgYFYS4bUMUkwX4k1JrKxKLcqPLyrNSS0+xCjNwaIk
	zquc05kiJJCeWJKanZpakFoEk2Xi4JRqYHJW2FSz7yzz7ba52RtkT/SvFc+OWyv6+6rVm6c3
	D72PP3Iy0ELoyrUdS7OsuTSWu/Yt0dh50oU3ZVlrrvweeXd/7UmhZ+/4hfMn7v6s4Drv79eJ
	TA4v5m39OqXBeWejg9q9V7MvfRGX9+AIs2vmexD5UfG5pNsCrqw8G7tlb5cvYAgp63N/mXqi
	2Tj4brS/CIdhn5Ypg6jk4cd6MiV7mblY3PQiLiWdfvRlx4opVa7vM6Ot5jFkds6SfPJP2vzf
	3diok8lVXGH2bgzKs6ITVVv2Nxt/YL99yEdWPKexeO1FMxmLdepWn8JzyzUqncr+PQ9cxFUo
	LKSw2NFQ8UKAyNU/DwO/vPv7uWy75o7FSizFGYmGWsxFxYkASVkO2U8DAAA=
X-CMS-MailID: 20241030111714epcas5p43427b28045729bf2a3e8b5f8eb89721a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241029163220epcas5p2207d4c54b8c4811e973fca601fd7e3f5
References: <20241029162402.21400-1-anuj20.g@samsung.com>
	<CGME20241029163220epcas5p2207d4c54b8c4811e973fca601fd7e3f5@epcas5p2.samsung.com>
	<20241029162402.21400-5-anuj20.g@samsung.com>
	<20241030050355.GA32598@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_041729_536841_25EC58A2 
X-CRM114-Status: GOOD (  10.56  )
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

On 10/30/2024 10:33 AM, Christoph Hellwig wrote:
> .. but these aren't.  Leading to warnings like:
> 
>   CHECK   block/bio-integrity.c
> block/bio-integrity.c:371:17: warning: restricted uio_meta_flags_t degrades to integer

For some reasons this does not show up in my setup.
But that only means setup needs to be fixed. Apart from dropping the 
__bitwise.

