Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4F1C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 07:52:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243A0611BE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 07:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243A0611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s1NdH2Py4eQfIDpvtwNJSBaArYSsbZSLxx3MUQe4Z6U=; b=Bf8o2vlM8xuZKeQXtdoZcRGRd
	KUlovhHvBZ3BW9wPVP5VkTUHpE1Ko+MpZABTVQFXS7cX4532APsDccYYZ1C+p4eZjLazGLulb1PPE
	kQReZMg+PzFwg6edU7g4CwzbzMPPpMygaO+QdXjltp3YKVN2DsmEcHrDBG39GyLy0T2oMT9RpUQOa
	rA4NHJP6QV1iVaCwbB9cUdIGB3CW2ud744LlLzbJcVHBb15Fsbszy+DhhdOgxPF7DDwFk9NUdWzLm
	2LRQXT4BzHSVD7CG46OMtBAlu15zgsydNNueeVLAALWV9XaKfyiDVQW28Rh3y1LlidiEGwbEbOSpf
	B/vlgXbgQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUPSh-007H9x-4r; Thu, 08 Apr 2021 07:52:23 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUPSV-007H7N-G9
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 07:52:19 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20210408075157epoutp02e34dfdd9e4901c482551977cb91cf69e~z0qmm6zHG1582215822epoutp02j
 for <linux-nvme@lists.infradead.org>; Thu,  8 Apr 2021 07:51:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20210408075157epoutp02e34dfdd9e4901c482551977cb91cf69e~z0qmm6zHG1582215822epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1617868317;
 bh=VnMz9v7xjP4SmsCXg2jc9pwyuvEXOL4oz3trMGcAj0k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kIHddKIAUWo48BeL6didzFWfhT7AJHp0tS3JbVlc4pj1gc+Zio4TyB1JxBP+CqjsG
 6fki+glUHdM5YAxlI3zkboHdvQjsDSmgl4k+6uAqOAgIMPjz+T1MLOyBG0xg0OB5Jg
 MfSCqamKvqeZnBIJIJFo2LD2RzLeezzPSe34eVOA=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20210408075156epcas5p17b99892c578de52dae99f540a9896588~z0qmE6dCQ1839918399epcas5p1p;
 Thu,  8 Apr 2021 07:51:56 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 35.B6.39068.C16BE606; Thu,  8 Apr 2021 16:51:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20210408074906epcas5p32380c971a9d8962f3c97542772399128~z0oHgWFGj1189311893epcas5p3D;
 Thu,  8 Apr 2021 07:49:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210408074906epsmtrp289a383cf2c3f69c20b99790e6febed6a~z0oHfextn0674206742epsmtrp2k;
 Thu,  8 Apr 2021 07:49:06 +0000 (GMT)
X-AuditID: b6c32a4a-625ff7000000989c-ae-606eb61cf186
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 34.52.33967.275BE606; Thu,  8 Apr 2021 16:49:06 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20210408074904epsmtip2118b0e332227fb898e43015a731e9b55~z0oF5LYch1944219442epsmtip2j;
 Thu,  8 Apr 2021 07:49:04 +0000 (GMT)
Date: Thu, 8 Apr 2021 13:18:26 +0530
From: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "tasleson@redhat.com" <tasleson@redhat.com>, "tbzatek@redhat.com"
 <tbzatek@redhat.com>, "prakash.v@samsung.com" <prakash.v@samsung.com>,
 "d.palani@samsung.com" <d.palani@samsung.com>, "javier.gonz@samsung.com"
 <javier.gonz@samsung.com>, "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "mohit.kap@samsung.com" <mohit.kap@samsung.com>, "krish.reddy@samsung.com"
 <krish.reddy@samsung.com>
Subject: Re: libnvme questions
Message-ID: <20210408074826.GA12847@test-zns>
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965314610B9338D1D6D32E986759@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7bCmpq7MtrwEgxv/lSxm3X7NYvH26wM2
 i8d3PrNbnGzcw2ox6dA1RouFG5cxWcxf9pTdYs0LZYsrUxYxW1y8d5PdYt6fj+wO3B6bVnWy
 eWxeUu/xft9VNo++LasYPdoPdDMFsEZx2aSk5mSWpRbp2yVwZazc9pa54DdLxeO9U5gbGJey
 dDFyckgImEjseHyTsYuRi0NIYDejRM/pTjYI5xOjxLcPG1kgnG+MEhc+zmCHaem4eosVIrGX
 UWLZx6vMEM4zRon1u8+DVbEIqEhMu9HE1MXIwcEmYCTxvdUWJCwiYCwx/+ZcsBXMAv+YJXZM
 /8sKkhAWkJO4u/ECI4jNK6Ar8bvhIQuELShxcuYTMJtTIFbi84O7YLaogLLEgW3HmUAGSQjM
 5JC4MquZFWSZhICLxJKeYohLhSVeHd8CdbWUxOd3e9kg6psZJfZ9ucIC4UxglJgy/x0TRJW9
 xMU9f8FsZoEMiWOr+6HBJCsx9dQ6qDifRO/vJ1D1vBI75sHYqhKPLxxkg7ClJWav/AQV95DY
 3PoZGqpzmCT6Jj5mncAoPwvJd7OQ7IOwrSQ6PzSxzgJ6iBlo1vJ/HBCmpsT6XfoLGFlXMUqm
 FhTnpqcWmxYY5aWW6xUn5haX5qXrJefnbmIEJy0trx2MDx980DvEyMTBeIhRgoNZSYR3R292
 ghBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeHQYP4oUE0hNLUrNTUwtSi2CyTBycUg1MxUdi1j3f
 bf6Eszr2gsJh38k62v6JWq9u/Irda5bql10kPTHn8IQlOnt/tgTMWcL/JHlxw5vkB9Wqz01+
 TxditI7bxSgxmTXGWEZZd70v228efw1dAX/GM28fiFdd+BF4TpbJ2r1nhsM+E/bdfapLtB/L
 Oy6UvXc32vratDdqj2x4vWa2qj3r/39F/R6v6Mn8ALugHovTopHL3qnE9pYqXGO9fkxLtHGS
 3zo13TOTSy+JxPM+flx1Tm3eZcVFobP0p1btLfadFHrD6Vp9ivnL1wquvn7vIzuc/XhWc0zf
 odlX3ODH/GXx3tkrbIN+9Vt/uszIpbXE9HS8xcRjnybPePlupbXN3c+FWVdMxVuVWIozEg21
 mIuKEwHiSTpOyQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvG7R1rwEg82fBSxm3X7NYvH26wM2
 i8d3PrNbnGzcw2ox6dA1RouFG5cxWcxf9pTdYs0LZYsrUxYxW1y8d5PdYt6fj+wO3B6bVnWy
 eWxeUu/xft9VNo++LasYPdoPdDMFsEZx2aSk5mSWpRbp2yVwZRxe+pCtYC1TRffCLrYGxo+M
 XYycHBICJhIdV2+xdjFycQgJ7GaU2HxuDRNEQlpi38PrLBC2sMTKf8/ZIYqeMEp8vLeRHSTB
 IqAiMe1GE1ADBwebgJHE91ZbkLCIgLHE/Jtz2UDqmQWaWCSmLPsMtk1YQE7i7sYLYDavgK7E
 74aHLBBD5zBJHHi5kh0iIShxcuYTsM3MAmYS8zY/ZAZZwAx00fJ/HCBhToFYic8P7oKViAoo
 SxzYdpxpAqPgLCTds5B0z0LoXsDIvIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhW
 tDR3MG5f9UHvECMTB+MhRgkOZiUR3h292QlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwX
 EkhPLEnNTk0tSC2CyTJxcEo1MOnE3X+dZPFo0rSflklnd+jm7/PjbevQmuvcMOXgLMaoBZd7
 bLbvW/y6b+lrNu6TYV0WLU/+ZQV43XPKdjVSW//B41nDjA3K1WdnCPydGJIfbRFWvMBNOGJL
 lPgCCzuT7aeu/D5pxPNTeuEcNdt9VXI7nSbc2yu4lNukpku31zj7/qrcqlSjV5y9eX3OZ06/
 Tf0XxCfAdGxSpcca2XJhzYlrGM00eFcfDDN4FNa68VenlVTDtjk6K7q+GyW/crKO1dZ6ujBe
 4Hx9taP5rW35PAIX41cqHRG9sa7wzKn1bzdEscnMfGdUnRqjV+gpoOE97Z64fawn985Pf5b/
 22kz+9q/K8LPerMu9jLrzf+8X4mlOCPRUIu5qDgRANADsI0EAwAA
X-CMS-MailID: 20210408074906epcas5p32380c971a9d8962f3c97542772399128
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----sQk.JUgeLCAux_OxNbCX-PiPTCRjBv-2ij2_ckcXYOqtMc.x=_5eaac_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210407123854epcas5p48217db953741a57d651a8a8bf240ee23
References: <20210312161824.GA3953@redsun51.ssa.fujisawa.hgst.com>
 <CGME20210407123854epcas5p48217db953741a57d651a8a8bf240ee23@epcas5p4.samsung.com>
 <20210407123806.23253-1-p.kalghatgi@samsung.com>
 <BYAPR04MB4965314610B9338D1D6D32E986759@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_085213_248234_C869C2E6 
X-CRM114-Status: UNSURE (   8.51  )
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

------sQk.JUgeLCAux_OxNbCX-PiPTCRjBv-2ij2_ckcXYOqtMc.x=_5eaac_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Apr 07, 2021 at 11:16:02PM +0000, Chaitanya Kulkarni wrote:
>On 4/7/21 05:46, Padmakar Kalghatgi wrote:
>> Along with this, we planned to implement the sideband MI command handling in QEMU.
>
>why ?
>
>
>
Add MI command emulation and avoid HW dependency for development and
testing.

------sQk.JUgeLCAux_OxNbCX-PiPTCRjBv-2ij2_ckcXYOqtMc.x=_5eaac_
Content-Type: text/plain; charset="utf-8"


------sQk.JUgeLCAux_OxNbCX-PiPTCRjBv-2ij2_ckcXYOqtMc.x=_5eaac_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

------sQk.JUgeLCAux_OxNbCX-PiPTCRjBv-2ij2_ckcXYOqtMc.x=_5eaac_--

