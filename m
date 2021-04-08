Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1853C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 07:52:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3761661155
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 07:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3761661155
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5l/Vdk40tIQI8GKr16K+KwB9tIm4BHIBhsrEZ2K5Wm8=; b=aDFLkkQecbdcebHJktkChvlk5
	+Rry/Y0NMVhTkDVvAXvsevckjJ+Z28OTkmNO5Qm7CV9CNQUn139U6FNOian9tWAQS0XQxYNbwBa8G
	wBtlVBPZ/LGjDt4P8w2fx0NEo197ORNq5SpFHjFe4ocSNRo4XAsoxy9lDZ3baxy7FMakW/wHg/C73
	QPKxWH5ztXUX1pmXd1EUAcpWlKWiDRgoG8i0sZpn0gHnMi0DK+PK499qr28pjEIIKqbgFLgY+6niX
	YB9qPKOGDbWpPoYvNPMxioH3d1llJTzpM9A4ZaAwGfnPcVeG7cHv05w7cfkwjTLbGzHyLPvaoj59z
	FNJextu+g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUPSt-007HBS-3F; Thu, 08 Apr 2021 07:52:35 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUPSg-007H9V-HV
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 07:52:25 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20210408075216epoutp0484675b2b7d0a681acc39f63f2b95634b~z0q4W3NFZ2385723857epoutp04J
 for <linux-nvme@lists.infradead.org>; Thu,  8 Apr 2021 07:52:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20210408075216epoutp0484675b2b7d0a681acc39f63f2b95634b~z0q4W3NFZ2385723857epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1617868336;
 bh=RyN4zR8BW6u0GC/x1HxNsFGgNAUY+ltoT4Uqyhma/eg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ne4mt+vUsyU6BqssoJtuTL3/dh385D4XhbArEiDvUfnsMcuZIGw5ZD/XqqCFFIjCw
 652acygrqPpK6lRmke9CVac+tSWlU99G9Q0/Zz0roqLWnwj/py9acjUkjuRlhL746R
 //f0k4qE0He9HUvvUG3l0vLbKIDKw+Ys7vacyt6k=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20210408075215epcas5p39027c7b7342e0c2214974694c47e4125~z0q3wGuWz0809108091epcas5p37;
 Thu,  8 Apr 2021 07:52:15 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 F7.D6.39068.F26BE606; Thu,  8 Apr 2021 16:52:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20210408075114epcas5p1cadb93c00d135a7970d86e406d52f908~z0p-MGXX11570415704epcas5p1B;
 Thu,  8 Apr 2021 07:51:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210408075114epsmtrp2e4d64949f034029f66f6e887621e2904~z0p-LDFiJ0817808178epsmtrp2l;
 Thu,  8 Apr 2021 07:51:14 +0000 (GMT)
X-AuditID: b6c32a4a-625ff7000000989c-0a-606eb62f69d1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 E6.01.08745.2F5BE606; Thu,  8 Apr 2021 16:51:14 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20210408075113epsmtip2d901e54161aa033fe2808fe53a4667ed~z0p9kRhjJ2366323663epsmtip2T;
 Thu,  8 Apr 2021 07:51:13 +0000 (GMT)
Date: Thu, 8 Apr 2021 13:20:35 +0530
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
Message-ID: <20210408075035.GB12847@test-zns>
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965B31055E6805C185C26AA86759@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7bCmhq7+trwEg/5OZYtZt1+zWLz9+oDN
 4vGdz+wWJxv3sFpMOnSN0WLhxmVMFvOXPWW3WPNC2eLKlEXMFhfv3WS3mPfnI7sDt8emVZ1s
 HpuX1Hu833eVzaNvyypGj/YD3UwBrFFcNimpOZllqUX6dglcGa/+8Rd0cFScO/6evYHxAVsX
 IyeHhICJxMbfF5m6GLk4hAR2M0q8PTyVDcL5xCjxa8JOKOczo8Sft1/gWm5vOg2V2MUoceff
 V2YI5xmjxJ5LZ1lBqlgEVCSezH8CVMXBwSZgJPG91RYkLCJgLDH/5lywZmaBf8wSO6b/BasX
 FpCTuLvxAiOIzSugK3Fly1MWCFtQ4uTMJ2A2p0CsxISrE5hBbFEBZYkD246DHS4hMJdDYtGN
 YywQ57lIrPjczAhhC0u8Or6FHcKWkvj8bi8bREMzo8S+L1dYIJwJjBJT5r9jgqiyl7i45y+Y
 zSyQIfHkTxtUt6zE1FProOJ8Er2/n0DV80rsmAdjq0o8vnAQGkjSErNXfoKKe0hsbv0MDbA5
 TBIHnvxkmsAoPwvJe7OQ7IOwrSQ6PzSxzgIGHzPQrOX/OCBMTYn1u/QXMLKuYpRMLSjOTU8t
 Ni0wykst1ytOzC0uzUvXS87P3cQITlpaXjsYHz74oHeIkYmD8RCjBAezkgjvjt7sBCHelMTK
 qtSi/Pii0pzU4kOM0hwsSuK8OwwexAsJpCeWpGanphakFsFkmTg4pRqYDoRZxq07lPlJeOry
 ac3Cn+fd7vR6LcC0/7nEfMnIkizZym0pRv7Gx7lO/4652f7+ntEztQfX77ltP61e/nD+tLNK
 k06/YGOLXbw3jiWF97OqxPygaNmMPaFK/1LzSv6on2lqTzLcvSat8//krhPtrS/8izIljH7q
 nH8qZzcj67+u3Clpu7Vt18UTjPqZvSUnnIy/nOxYPvkZe9Kq29bBRdGRLolfxXeKbpz29d3j
 eyvumAoWzYo8m3WO6d31yYe9bsg/NXnz27ir7My6TbcvKKxKX7jTu+WcYH3411Vx1euO6Whd
 DMk/GuLh+/mQUNXCFY1Tal/9SZxSkSOn45Dzy/wh47GGj2YPl6UqzFl5QomlOCPRUIu5qDgR
 ANvESFbJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvO6nrXkJBp3z9S1m3X7NYvH26wM2
 i8d3PrNbnGzcw2ox6dA1RouFG5cxWcxf9pTdYs0LZYsrUxYxW1y8d5PdYt6fj+wO3B6bVnWy
 eWxeUu/xft9VNo++LasYPdoPdDMFsEZx2aSk5mSWpRbp2yVwZax7vo29YBdrxeVWmQbGNSxd
 jJwcEgImErc3nWYDsYUEdjBK3OuUhIhLS+x7eB2qRlhi5b/n7F2MXEA1Txgl/n36wASSYBFQ
 kXgy/wlQMwcHm4CRxPdWW5CwiICxxPybc9lA6pkFmlgkpiz7zAiSEBaQk7i78QKYzSugK3Fl
 y1MWiKFzmCQWz5vGDJEQlDg58wnYZmYBM4l5mx8ygyxgBrpo+T8OkDCnQKzEhKsTwMpFBZQl
 Dmw7zjSBUXAWku5ZSLpnIXQvYGRexSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHCda
 WjsY96z6oHeIkYmD8RCjBAezkgjvjt7sBCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJ
 pCeWpGanphakFsFkmTg4pRqY2G/6iZV8kzx6r+PIZq4JqTudHu25PvlxS8zmd5PaVf11Nn/Y
 UvZBdlrT8nTGGc+Nn4rE/nbatzY54tWPGccOvWRXXn1bNCUqM3+mbBWL4mSlPbXT+s7eeHhN
 0P/eG0GWfQv7W9fX7DCbx/53lv7DWdObOwq7RP0/ffN8vYpHIzO0etbp66tWWpZr3/t6z+rE
 nP3sVwvFj03LWeKvfGPHUS0usbmF2/6wvDkde3tiD4tdYeR0pceOlVr91u+iayusVKevnX9B
 JnKZQp721k+hVVGuB2f95W9bvGgG868sQf0zQTXnWJhDhbczPH9Y9VGGc+G7mQpTTi9Sc2Fj
 0lGZF7XkG18XF8e9/hU3w6N//1FiKc5INNRiLipOBAASSpgFAgMAAA==
X-CMS-MailID: 20210408075114epcas5p1cadb93c00d135a7970d86e406d52f908
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----Q-msIrZUiOdgFIXW25bFqaDApMD6FguveSXWgTQzG2RiKNeM=_5e69f_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210407123854epcas5p48217db953741a57d651a8a8bf240ee23
References: <20210312161824.GA3953@redsun51.ssa.fujisawa.hgst.com>
 <CGME20210407123854epcas5p48217db953741a57d651a8a8bf240ee23@epcas5p4.samsung.com>
 <20210407123806.23253-1-p.kalghatgi@samsung.com>
 <BYAPR04MB4965B31055E6805C185C26AA86759@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_085223_283946_D5134C36 
X-CRM114-Status: GOOD (  10.78  )
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

------Q-msIrZUiOdgFIXW25bFqaDApMD6FguveSXWgTQzG2RiKNeM=_5e69f_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Apr 07, 2021 at 11:19:57PM +0000, Chaitanya Kulkarni wrote:
>On 4/7/21 05:46, Padmakar Kalghatgi wrote:
>>
>> Please share your thougths whether to have this feature as a plugin or as a standalone tool, also provide feedback on our plan to have the sideband MI functionality.
>
>If you want it all in one place you should implement it as plugin,
>it will make your life easier.
>
>I think Keith has already NAVKED SMBus, you need to provide a really good
>justification if you want that to be a part of nvme-cli.
>
>
>
There are many SSD Vendors (Eg., as listed earlier) and OEMs using side
band to validate MI. Hence we believe this plugin will be useful to the
community.

------Q-msIrZUiOdgFIXW25bFqaDApMD6FguveSXWgTQzG2RiKNeM=_5e69f_
Content-Type: text/plain; charset="utf-8"


------Q-msIrZUiOdgFIXW25bFqaDApMD6FguveSXWgTQzG2RiKNeM=_5e69f_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

------Q-msIrZUiOdgFIXW25bFqaDApMD6FguveSXWgTQzG2RiKNeM=_5e69f_--

