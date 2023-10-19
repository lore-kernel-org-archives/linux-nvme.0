Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4848ACDB482
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 09:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ihe7k6eaw1LkAmKuxgBQTbkLrjMPOT8Z23FmiBUz2uI=; b=Tv4e/YPJ4KZFdw7DcgYPloNxO9
	mbbCUS/5jMGBVnSfXQ4ifAZxRAPk4PsdDLOVrcDp6d6pqL/oaF8u1ZtvWIUpFxJ7gzrjKp90VtT9g
	wNJAzL78dfyH5bhsnklkGfr/jtXA48gtr4dB+9QexPZOL2PAGI8QBgidjmBU/AlldsuaRsB9JkWlc
	RUCKFN+2oO+ptynvRRtl9naA43jSffDJP79sk8VrotkFt+Uw1mJSAZ7b0PApRPsKBr3ClIA26KfgB
	cEkaN6pD7bYsbnOLsQ7HJyF7t+ghyS7sDPVi5GrIH2Qbz336zE4pasmKrOn4cS5rz497y5Vs3c1vg
	BOjbL7Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtPoA-00GtPe-0c;
	Thu, 19 Oct 2023 09:59:14 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtPo6-00GtOh-1w
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 09:59:12 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231019095904epoutp04901cd8359fd2beecabb846647caccc6d~PedYBBjkt0201102011epoutp04R
	for <linux-nvme@lists.infradead.org>; Thu, 19 Oct 2023 09:59:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231019095904epoutp04901cd8359fd2beecabb846647caccc6d~PedYBBjkt0201102011epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697709544;
	bh=Ihe7k6eaw1LkAmKuxgBQTbkLrjMPOT8Z23FmiBUz2uI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=u1k1WmYrlfoVVssiHQp0iR1Pi+MpDghQESpZpngEkJgWBwgaSz8MQNpaifPHSD1Dl
	 0cPPo+HKhvS7wRQoa7GLU1HyFCuyTLFjOafSQYHc4KNTTBH3lf2hiqpzlhb8obVjrg
	 xmnaIBiskoZIn/BkiqFOlGtoXfzZP6raE1aE8luY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231019095904epcas5p31db802e73f76617008b2a67358d46c98~PedXtld8Y0947809478epcas5p3o;
	Thu, 19 Oct 2023 09:59:04 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SB38R13flz4x9Pw; Thu, 19 Oct
	2023 09:59:03 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A5.D1.08567.6EDF0356; Thu, 19 Oct 2023 18:59:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231019095902epcas5p3c4705cbd3a44d45563d7971f9ea38fe0~PedWWG8e22836528365epcas5p3B;
	Thu, 19 Oct 2023 09:59:02 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231019095902epsmtrp2febd9113241cd85ddf0e904e55e8e1be~PedWUZIrH0877208772epsmtrp2b;
	Thu, 19 Oct 2023 09:59:02 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-d9-6530fde6171c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	14.74.07368.6EDF0356; Thu, 19 Oct 2023 18:59:02 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019095901epsmtip12cb84b6ab51838cac64264b063232654~PedVOc_p51953319533epsmtip1Z;
	Thu, 19 Oct 2023 09:59:01 +0000 (GMT)
Message-ID: <977364c0-bb02-614e-0e8d-47fa28190f14@samsung.com>
Date: Thu, 19 Oct 2023 15:29:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] nvme: fine-granular CAP_SYS_ADMIN for nvme io/admin
 commands
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231019054910.GH14346@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmlu7zvwapBt/6GC1W3+1ns7h5YCeT
	xcrVR5kszr89zGQx6dA1Rov5y56yW6x7/Z7Fgd1j56y77B7n721k8bh8ttRj06pONo/NS+o9
	dt9sYPPo27KKMYA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
	xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
	aomVoYGBkSlQYUJ2xtWfSxkLLnNV/J47kaWB8Tx7FyMnh4SAicS/tY1MXYxcHEICuxklZra+
	ZYRwPjFKnOiZwgLhfGOU+PD3KCNMS8+hT1AtexklPq5rBpslJPCWUWLjiygQm1fATuL/sn1g
	DSwCqhJ3+leyQcQFJU7OfMICYosKJEn8ujoHrEZYIFziyPZrYDXMAuISt57MZwKxRQSUJJ6+
	Ogt2ErNAK6PE519rgIo4ONgENCUuTC4FqeEU0JHovDyDBaJXXmL72znMIPUSAlM5JK6s2cYC
	cbWLxNmlu5kgbGGJV8e3QANASuLzu71sEHayxKWZ56BqSiQe7zkIZdtLtJ7qZwbZywy0d/0u
	fYhdfBK9v58wgYQlBHglOtqEIKoVJe5NesoKYYtLPJyxBMr2kLjxspsdEm63GSUWLDvOOIFR
	YRZSsMxC8v4sJO/MQti8gJFlFaNkakFxbnpqsmmBYV5qOTzCk/NzNzGCk6uWyw7GG/P/6R1i
	ZOJgPMQowcGsJMKr6mGQKsSbklhZlVqUH19UmpNafIjRFBg/E5mlRJPzgek9ryTe0MTSwMTM
	zMzE0tjMUEmc93Xr3BQhgfTEktTs1NSC1CKYPiYOTqkGJtMS1ZcPDjZfi9bhP1eVv9v5eo7r
	hL15FqHmf1gLkuRE3Vd+mqnxcAP386jTn4x4XU43ztD7/CdE/ZjRG1Ovl1Y86zi2Cx+8bTv5
	vEXpcvbnWiFHdfm1JdqPeScoXJ6tFXD+J+Nqo+lTQ/Psky9ccmDeYJw6rcHN8uu5Y4Z/v55g
	dmp/JLzXpnBV5RNh/YdCaV1yzY+nP5vTsvCy6/aWW26V3KvE9B4fjd9VcWHb1v+5nm8SnaIq
	FocvTaua1mBc23ial6/cSm3rymn3Y6NnBJfP+iJlvJCHd49tpw1fcPT36mULKhxlFT0K9PO3
	aEWZr3x3Y5Fc3A3DIGaJ9980Q2u7TJk7khaW5Fyo3lmmxFKckWioxVxUnAgAw4m9pjcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJTvfZX4NUg+3/NS1W3+1ns7h5YCeT
	xcrVR5kszr89zGQx6dA1Rov5y56yW6x7/Z7Fgd1j56y77B7n721k8bh8ttRj06pONo/NS+o9
	dt9sYPPo27KKMYA9issmJTUnsyy1SN8ugSvj6s+ljAWXuSp+z53I0sB4nr2LkZNDQsBEoufQ
	J6YuRi4OIYHdjBKrNh9mhEiISzRf+wFVJCyx8t9zdoii14wSWw4eYAJJ8ArYSfxftg+sgUVA
	VeJO/0o2iLigxMmZT1hAbFGBJIk99xvB6oUFwiWObL8GVsMMtODWk/lgcREBJYmnr84yQsRb
	GSVeX9CGWHabUWLT5jlAgzg42AQ0JS5MLgWp4RTQkei8PIMFot5MomtrF1SvvMT2t3OYJzAK
	zUJyxiwk62YhaZmFpGUBI8sqRsnUguLc9NxkwwLDvNRyveLE3OLSvHS95PzcTYzgSNLS2MF4
	b/4/vUOMTByMhxglOJiVRHhVPQxShXhTEiurUovy44tKc1KLDzFKc7AoifMazpidIiSQnliS
	mp2aWpBaBJNl4uCUamDiZopjVctb5Lf0kodrKNPEep7DzXz8oZvat/ob/u69abFqZV3y24j3
	1o+5Lgi+0A5MPJlpqfO9/qICd8KcKecVXXWKNx85F++uf9pg8ion1qdZblffvZuy8q3tSbka
	3wni608Wz53wzuDTgjCjc+XRn6/amK5lm971i189l71K2/b7I4UGXYaqsBC5fXIV29cYLvor
	veacw4zT16+5td8y/XTmACPjFuHkj1tPL552/Ev2uTSnr7MbX5uUVdlfPiPLxed7UuTNNrct
	U1LzJ25ZG371eO5rrsuvZMUMgrs2X/3GY2DGIHRnfVPbr3VxnM17JrG6J3u/EJ5a6RdicUvi
	q9OSRSemPFkn+PCw+fEoJZbijERDLeai4kQA6lZBdhMDAAA=
X-CMS-MailID: 20231019095902epcas5p3c4705cbd3a44d45563d7971f9ea38fe0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018183629epcas5p4e11e71226c3990c304765c14c7defe6d
References: <20231018183003.41174-1-joshi.k@samsung.com>
	<CGME20231018183629epcas5p4e11e71226c3990c304765c14c7defe6d@epcas5p4.samsung.com>
	<20231018183003.41174-3-joshi.k@samsung.com> <20231019054910.GH14346@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_025910_995718_70E5251F 
X-CRM114-Status: GOOD (  16.96  )
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

On 10/19/2023 11:19 AM, Christoph Hellwig wrote:
> On Thu, Oct 19, 2023 at 12:00:03AM +0530, Kanchan Joshi wrote:
>> Passthrough commands are guarded by heavy-handed CAP_SYS_ADMIN checks
>> that neglects the file-mode completely.
>>
>> Add a fine-granular policy that considers file-mode and various other
>> parameters for any approval/denial. Also enable few admin commands that
>> are necssary to get the information required to form the i/o commands.
>> The policy is implemented in a new helper 'nvme_cmd_allowed'.
>>
>> I/O commands needing data-transfers are sent only via SGL.
> 
> This looks mostly good to me, but we should not even send the command
> if we know SGLs aren't supported.
> 

I can do this here (and kill the checks from pcie)-

@@ -134,6 +206,15 @@ static int nvme_map_user_request(struct request 
*req, u64 ubuffer,
                 }
                 *metap = meta;
         }
+       /* Data/Meta transfer for unprivileged passthrough is only via 
SGL */
+       if (bdev && !capable(CAP_SYS_ADMIN)) {
+               if (!nvme_ctrl_sgl_supported(ns->ctrl) ||
+                   (*metap && !nvme_ctrl_meta_sgl_supported(ns->ctrl))) {
+                       ret = -EINVAL;
+                       goto out_unmap;
+               }
+               nvme_req(req)->flags |= NVME_REQ_FORCE_SGL;
+       }

