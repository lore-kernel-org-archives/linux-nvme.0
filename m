Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D738C05027
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 14:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p6vHc4I84jVDBphTnSY/rGcA7w4hGX7PrbSUviiNJO0=; b=EVaW89VQwiolUdwmu7tD+36x38
	+cHupeCXWoI7sa3F5D293PSyfTtnk6Vig6pMcNxa+zRbiNtcEMdtFhf1RLAZDSqxMs+9BWUr/r0Wd
	9rOVIQBtUmvU8RsRJUHx/73Skl7k4EP5wyqI1lUUFkv7p3+PIoBUvQO1CBkdxnk44H6rlgSJlENnE
	Nrlvc3VOtopCFK83AkEHIRWWUqzH/VPcIlc7kZcwx68x578Z8OBzBY971iGWdSB7Ob3pnUpbsXewd
	R0rKjEv5wgHZQpRPxxX8V2asvBWdQ5QO5348hRFi2yUj28QOMDa4P0ZSsQ+wZ3XPDZeHcUUNj75Cl
	7v6bVjQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPl2g-00Fq7D-7C; Wed, 08 Feb 2023 14:03:22 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPl2c-00Fq5b-AL
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 14:03:21 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230208140303epoutp02011fb5ec87ffab66d8114b5cae036199~B3lLdiplJ2817428174epoutp02I
	for <linux-nvme@lists.infradead.org>; Wed,  8 Feb 2023 14:03:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230208140303epoutp02011fb5ec87ffab66d8114b5cae036199~B3lLdiplJ2817428174epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1675864983;
	bh=p6vHc4I84jVDBphTnSY/rGcA7w4hGX7PrbSUviiNJO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kM/NmhmPofVklSTQBT8b4DFLQrNl+LvacJm9ZkmJjjf/UbX6dtzEBYKJa/Wal8zwj
	 vGGlhBu1VM/cVGk9pi5mo5RhDh2t5VvQOV3tOAm9Qw8IpJXLUCT8Ile70y03R7zuMW
	 vJmr5amYCZfJqWyLijdDZuLTCYh2d53D+lTAoa6g=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230208140303epcas5p1aee4c560a08a98739e53f841af3364ff~B3lLNmTbi2940729407epcas5p1O;
	Wed,  8 Feb 2023 14:03:03 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4PBhXk2zNzz4x9Pt; Wed,  8 Feb
	2023 14:03:02 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	73.05.10528.69BA3E36; Wed,  8 Feb 2023 23:03:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20230208140302epcas5p3bb028eeba17e4c7c47a009967bd2456a~B3lJxsg5a1183311833epcas5p3t;
	Wed,  8 Feb 2023 14:03:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230208140302epsmtrp143d0bda43bb9cdee23ab73d646dda733~B3lJwJ39P0542005420epsmtrp15;
	Wed,  8 Feb 2023 14:03:02 +0000 (GMT)
X-AuditID: b6c32a49-c17ff70000012920-e2-63e3ab96814f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2F.B0.05839.59BA3E36; Wed,  8 Feb 2023 23:03:01 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20230208140301epsmtip20e63b291213081f84ebb4c7d70036e1e~B3lI3B6kd1844418444epsmtip2y;
	Wed,  8 Feb 2023 14:03:00 +0000 (GMT)
Date: Wed, 8 Feb 2023 19:32:33 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
	Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme: retry internal commands if DNR status bit is
 not set
Message-ID: <20230208140233.GA13408@green5>
MIME-Version: 1.0
In-Reply-To: <20230208084939.145257-3-hare@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTXXfa6sfJBqfnCVrsWTSJyWLl6qNM
	FpMOXWO0mL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNgAZp6sDWKOybTJSE1NSixRS
	85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAdisplCXmlAKFAhKLi5X0
	7WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjMan15iLPjOVrFt
	6knmBsZvrF2MnBwSAiYSew/OZ+xi5OIQEtjNKHHwZQ8zSEJI4BOjxMWDaRCJb4wST3rmscF0
	fD3YDNWxl1Hi9t0ONoiOJ4wSZ5+ogtgsAioS8+Y8BFrBwcEmoClxYXIpSFhEQEniY/shdpBe
	ZoF2RomZz88wgdQIC4RKnHgdD1LDK6Atcf3pJCYIW1Di5MwnLCA2p4CxxO93bewgtqiAssSB
	bceZQOZICHxkl1i4aBbUcS4SZz4eYIGwhSVeHd/CDmFLSbzsb4OykyUuzTzHBGGXSDzecxDK
	tpdoPdUP9j2zQIbE6WkrWSBsPone30/A7pQQ4JXoaBOCKFeUuDfpKTQUxSUezlgCZXtI7P37
	mB0SPusZJXZ//8c0gVFuFpJ/ZiFZAWFbSXR+aGKdBbSCWUBaYvk/DghTU2L9Lv0FjKyrGCVT
	C4pz01OLTQsM81LL4VGcnJ+7iRGcGLU8dzDeffBB7xAjEwfjIUYJDmYlEd7vEx8nC/GmJFZW
	pRblxxeV5qQWH2I0BUbPRGYp0eR8YGrOK4k3NLE0MDEzMzOxNDYzVBLnVbc9mSwkkJ5Ykpqd
	mlqQWgTTx8TBKdXAtGXPsqrqix0BZiyxvmWHHs1349B8aH5Rzu+gSLVkT+6c9G2/5+sXqN15
	P0UwYEK+ZNhjAb1QGTZuq8hbaWe3T9Pfdrh+wzvd1D2Wd1jer5pgecKI+bHUxevMKp+6g4Sb
	NvV931N+Yd7BZ1vmeSWu9LotcTp5wzXua69Fb95fULuSzXZJq7neG/WpL45dPiSx7Oi1+wdZ
	Lx+45nShaofbAk3egCOTWlc9ESzYOGPd9AzzFFVLifilry65dS1ec+oHm5+BR2aWV0OAmtaS
	32G/p3DeCE8KlJneXH78sPhHy8gyp91ztNyeTv75z81h+cug9yf5z9mVM575MvNw9EffoKBY
	s6bW9UIHnr+9fHFKdLUSS3FGoqEWc1FxIgDPQ15fFQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvO7U1Y+TDaYuMLPYs2gSk8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbAAyTlcHsEZx2aSk5mSWpRbp
	2yVwZXTcbGAqWMlSMenMfrYGxkPMXYycHBICJhJfDzYzdjFycQgJ7GaU+Ph7OhNEQlyi+doP
	dghbWGLlv+fsEEWPGCX+f33LCJJgEVCRmDfnIWsXIwcHm4CmxIXJpSBhEQEliY/th8DqmQXa
	GSW+rt/KAlIjLBAqceJ1PEgNr4C2xPWnk5ggZq5nlDg58xULREIQyH4CZjMLmEnM2/yQGaSX
	WUBaYvk/DpAwp4CxxO93bWC3iQooSxzYdpxpAqPgLCTds5B0z0LoXsDIvIpRMrWgODc9t9iw
	wDAvtVyvODG3uDQvXS85P3cTIzjYtTR3MG5f9UHvECMTB+MhRgkOZiUR3u8THycL8aYkVlal
	FuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwNTffjn79wyG7V86WFxX
	3VfgS2VYZtJWdaxr4+HH5lcZ1gS+OvLrfqzxgkNJWznF02L/7mM3WL1n37+ee2tLzI8/3C53
	nJslbempH8IfOz1FPz0QfnxGe9luE1up9jaPXp1pT9VCZ6Q0cao7PCx7zripZ3Jm+JOqDzMj
	DKcV3ajfOGGF+NoN55bYpopqds99/cpguUbkyklP74gUmZ4t9yw7+2jpN94fHp1VQfd/6z89
	MCtpxSPLZ9cn1sbc0FRIjmHWLPvv/fiD5yvuvlOCj8Neema3fVoiZNmeoT4rpkIoxnxbt43Y
	9cV/JAJzeZl/T9gm/94u5FXx7JBH4VPkOLxVf3ekyL0UEzq8PDcxf6oSS3FGoqEWc1FxIgDR
	80aU5QIAAA==
X-CMS-MailID: 20230208140302epcas5p3bb028eeba17e4c7c47a009967bd2456a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_4a449_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230208085444epcas5p38a75bedb706daaf7828b6c98e38aa2da
References: <20230208084939.145257-1-hare@suse.de>
	<CGME20230208085444epcas5p38a75bedb706daaf7828b6c98e38aa2da@epcas5p3.samsung.com>
	<20230208084939.145257-3-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_060319_034157_997A96AA 
X-CRM114-Status: GOOD (  14.53  )
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

------KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_4a449_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Feb 08, 2023 at 09:49:38AM +0100, Hannes Reinecke wrote:
>Add a 'retry' argument to __nvme_alloc_rq() to instruct
>the function to not set the FAILFAST_DRIVER bit for the command,
>causing it to be retried in nvme_decide_disposition() if the DNR
>bit is not set in the command result.
>And modify the authentication code to allow for retries.


This new argument is sent as true only at one place.
Will it be better to have that case handled in that place itself?
By clearing REQ_FAILFAST_DRIVER bit from req->cmd_flags in auth code.

------KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_4a449_
Content-Type: text/plain; charset="utf-8"


------KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_4a449_--

