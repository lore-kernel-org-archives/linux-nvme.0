Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEC1C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 15:13:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716D160F6E
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 15:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 716D160F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IwMCsZv21MZd+NYcgO9EKkAHWUNyZ99KW4H/UauSz7w=; b=ra+XpSCljp+xiLyCOa+KyIX+Q3
	pMTGiopIjiUDEo4PZmHMmZGKo0rwb2iahJ4kX1lbIsRFTKBzPCMAxYAK80d4Dt6tZJd3LpsKxbdi9
	EBdNsFzAyXfEUq0l+So3QYIw07/s7cEqnc3rDDkmoF4NPUMIDqYuhiW1nJ5j5Gnm9/xN3ED3Vxmdv
	7N/w8dLwouBQEvGGK6k4Osmc8JcY534U6aYGnpQKTwj6IB033HodvDF7QJqMW28VU5JbvzYTxk1Fk
	+SfwxiZ8hCRrrVtvRXmnXg/hgxbRk3e//KiVfoNcnF6GdHvz4vQuQWS4CCiZ51od/eNGVb1OjZObL
	cvvwlCRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNGJF-001Cdg-4C; Mon, 06 Sep 2021 15:13:21 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNGJC-001Ccs-9e
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 15:13:20 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20210906151311epoutp0260a63e34fb98e67c65ae0897f5fe86f3~iRF9xRYSY1833618336epoutp02c
 for <linux-nvme@lists.infradead.org>; Mon,  6 Sep 2021 15:13:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20210906151311epoutp0260a63e34fb98e67c65ae0897f5fe86f3~iRF9xRYSY1833618336epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1630941191;
 bh=L/Dk2aecmW1XBEG797niwF/HDZT9ptt+wA3hKdLdDBA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dDPCxkD/jiwwOdIMApQLVM1D6j3MBQ6T9T9BGtR7/TF+x1QKtM0t4bmQn5b734xXg
 Vkyq/2KiTo72hjztHRsu9li7TSpmBDIwUmPzx3aKgtA1XdBKw3csid1oFUNzf3NwWY
 nyTX2IRl51ZCw2bsSoY+P5wugiw8GrZcd0QxuCkI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20210906151310epcas5p21a0e6d6a6edc1a2838839ab2794916e5~iRF80Dfa90586205862epcas5p2D;
 Mon,  6 Sep 2021 15:13:10 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4H3BjX0hKJz4x9Pr; Mon,  6 Sep
 2021 15:13:04 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 F9.83.38346.00036316; Tue,  7 Sep 2021 00:13:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20210906151053epcas5p184a694196a6e1816061872b50682e3f0~iRD9Jxlm73253532535epcas5p1K;
 Mon,  6 Sep 2021 15:10:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210906151053epsmtrp2e838d6e8e896d464aeb27726b5e05cc3~iRD8yJH3j1102111021epsmtrp2l;
 Mon,  6 Sep 2021 15:10:53 +0000 (GMT)
X-AuditID: b6c32a4b-23bff700000095ca-2b-61363000a03e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 5F.3A.08750.D7F26316; Tue,  7 Sep 2021 00:10:53 +0900 (KST)
Received: from test.sa.corp.samsungelectronics.net (unknown [107.108.56.58])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210906151051epsmtip12d91ccfda35df8836435cb203cf04801~iRD6wlBFw0309703097epsmtip1G;
 Mon,  6 Sep 2021 15:10:50 +0000 (GMT)
Date: Mon, 6 Sep 2021 19:48:54 +0530
From: Mohit Kapoor <mohit.kap@samsung.com>
To: kbusch@kernel.org, fam@euphon.net, its@irrelevant.dk, kwolf@redhat.com,
 linux-nvme@lists.infradead.org, mreitz@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, stefanha@redhat.com
Cc: arun.kka@samsung.com, d.palani@samsung.com, p.kalghatgi@samsung.com,
 javier.gonz@samsung.com, k.jensen@samsung.com, prakash.v@samsung.com,
 u.kishore@samsung.com
Subject: Re: [RFC PATCH : v3 2/2] Implementation of nvme-mi plugin in nvme-cli
Message-ID: <20210906141854.GD22632@test.sa.corp.samsungelectronics.net>
MIME-Version: 1.0
In-Reply-To: <1627981486-3369-1-git-send-email-mohit.kap@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbVRj33NveXnB3uZTizhC0KVsmmNJ2a+tlvEzGWBNQwRkXmRm7gWth
 Lb1NW3DOMWEYJ0RIx0vW8doDZFAZg0lwbhCKkTEDjPAwyAIIJermVkaVyECx7fX13+/7fb/f
 +b7vfOfgqPBbLBjPNlgYk4HWSzB/XvdA+AvSp+RqWj5b+DRVO0dRD3+bx6iJvlFA9fWv8qnF
 e24BNVR4k0+VO6YAdXmMoRqalwRU/fdh1HdrCwJqovIiStkencGowdIeHvWgfJNPTRctYS+T
 mt9HzmCakZ5RgaaztRjTdF3+QOOc6kI0rt5JTFN2vRWkCNJ0MVkMncmYxIwhg83MNmhjJUkH
 0/elq9RyhVQRRb0kERvoHCZWkpCcIk3M1ntal4jzaH2uh0qhzWaJLC7GxOZaGHEWa7bEShhj
 pt6oNEaa6RxzrkEbaWAsexVy+W6VR3hUl1XwSTHfOM0/XuS6hxSAVV4JwHFIKmHnpqgE+OFC
 8isAz8+zJcDfg1cArB5pQ7jADeDi6X7Uq/IarBf6UC5xA8Aa+xLGBYUIbCmrBV4Vj9wBL87N
 +DBGRkDbwKbPLSK/BrBuMM1rQMkWAMuvVvO8iUAyBRZVuHw9EaQGNsyd8tIEGQCHzjl9tB+5
 H64PE146yHN85VC3ry4k7+LwXNEXgOsuAVrnm/gcDoT3B68LOBwM3Y9uYdzI70NbO8F5Pwaw
 sWwY4zTxcOzmH4hXg5JZ0F5j4uhQWHWnHfFilNwKS9edCMcTsKfeiXBHhsHmX/UcvR2udFT8
 3YEG/tzSJuCuZxLAisFxvhU8b/vfZLb/qtl8FfbC4uXTfI5+Fn72J87BcHj1hqwR8FvBdsZo
 ztEyZpVxj4F5999lZ7A5ncD3qiOSesDC/HKkAyA4cACIoxIRcXjfblpIZNLvnWBMbLopV8+Y
 HUDlWdRZNDgog/V8C4MlXaGMkivVarUyao9aIdlGSO+H0EJSS1sYHcMYGdM/PgT3Cy5AYsC4
 zBaUmBdaG/1OiqwgPC403rW467yqQDwynC+Y1lkKX02dWE+8PaB8e6Omub/qw/G6ZEsjMvmj
 MGTiOefJlqbYLTPsldWoW2PPvKm+5HxjI/+nb1YOtlSJlprE+LXSmKp0Wjqkmq39MlBXF2Zt
 yAvLf1B9osOxmFw6E+dONWzkJUb0XoqP+3zW8tGpyt5o/7ekd65UV4CAjuMn3aa05Sf140mp
 9jWX5dMEELDNUdx9d+1wzoH+0aOvszzZQ3vnWZFVJaIPNV8LjsbYQ1uedB1BHmfaZa9IXwt5
 XCnv7Wp78ZeFBkpLsLfhMV2QM2PHD3n2qfYjkcTWncek+4d3aSU8cxatiEBNZvovIILWgF4E
 AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnG6tvlmiwckWZYs59y0s3n59wGZx
 Zf95Rov9B7+xWjy+85nd4mTjHlaLSYeuMVosuZhqMX/ZU3aLebeULa7/fMRucWXKImaLWe/a
 2SyO9+5gsXg96T+rxc3mp2wOAh4/zrWzeZzbcZ7dY9OqTjaPzUvqPZ5c28zk8X7fVTaPvi2r
 GAPYo7hsUlJzMstSi/TtErgynm2ex1zQzVzxYfdKxgbGQ0xdjJwcEgImEhMW7mfuYuTiEBLY
 wShx+eM8doiEpMT8nTOYIWxhiZX/nrNDFP1nlHh6Zz8jSIJFQEVi0f3bYDabgJbErMP/wSaJ
 CBxhlNi3ZB0LiMMssIJR4tTOO6wgVcICfhIfN+8Bsjk4eAU8JObfr4OYepVRYumLA2A1vAKC
 EidnPmEBsZkFzCTmbX7IDFLPLCAtsfwfB4jJKeAq8fssL0iFKNANU05uY5vAKDgLSfMsJM2z
 EJoXMDKvYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjjYtrR2Me1Z90DvEyMTBeIhR
 goNZSYQ32tkoUYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5O
 qQamxaFPpnOnXSoSny4mxLpL+NgUPasjZxYUOHR1aj1+Hv+5wuDpRo5J1x7sDpzqfI9Pzv0d
 01I+9WsTun13vZkmVP/V6uOc5qMByftU1eLC2MIu3Wx369jhfi/06YorP+M/vvY/9+lr2HFl
 z5WLGeJ36R43PnG+m99/ftA/R+0uW8ePPfcX+vAs27tH1S5duSg+p2ZBSe6i44qnLFfPC/N+
 KZB6m1/CaMr9PauOP/RT85k14+PR27UX27ddcU4179u7Qq9nb52tY0bIqsTf+1wbmmolvghv
 rp3Sf2mKpK9kgPrsX/7hrvnTOJcousV41O3jSHLRjTzO+Cu1v/hNXmz29PTKF1wnjU+ev2J1
 eYOYEktxRqKhFnNRcSIAfpTsqSUDAAA=
X-CMS-MailID: 20210906151053epcas5p184a694196a6e1816061872b50682e3f0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----U8CIXdF52oAoGeRkYVEVeH2qRGPDUYqN5.u0c97gxHEcYtzV=_57908_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210803094723epcas5p323efa7e40e3d843ff8b91507c48edd17
References: <1627975487-1640-1-git-send-email-p.kalghatgi@samsung.com>
 <CGME20210803094723epcas5p323efa7e40e3d843ff8b91507c48edd17@epcas5p3.samsung.com>
 <1627981486-3369-1-git-send-email-mohit.kap@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210906_081318_792470_AF34A93D 
X-CRM114-Status: UNSURE (   9.56  )
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

------U8CIXdF52oAoGeRkYVEVeH2qRGPDUYqN5.u0c97gxHEcYtzV=_57908_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Tue, Aug 03, 2021 at 02:34:46PM +0530, Mohit Kapoor wrote:
>From: mohit kapoor <mohit.kap@samsung.com>
>
>Subject: [RFC PATCH : v3 2/2] Implementation of nvme-mi plugin in nvme-cli

Hello All,
Request to kindly provide your valuable feedback for the patches shared
for nvme-mi over QEMU and nvme-cli.
Looking forward for any suggestions and improvements.

Regards,
Mohit Kapoor


------U8CIXdF52oAoGeRkYVEVeH2qRGPDUYqN5.u0c97gxHEcYtzV=_57908_
Content-Type: text/plain; charset="utf-8"


------U8CIXdF52oAoGeRkYVEVeH2qRGPDUYqN5.u0c97gxHEcYtzV=_57908_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

------U8CIXdF52oAoGeRkYVEVeH2qRGPDUYqN5.u0c97gxHEcYtzV=_57908_--

