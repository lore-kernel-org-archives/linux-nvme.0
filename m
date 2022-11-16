Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A3AC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 13:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5qWErvoyl4gjdQb7YlZURM9an1zWoLcZWBZ7wYoiHA8=; b=l3jAIme3jVRuqwZT0QpANfLPmc
	Mb4RD7hOF/tcHPgAsnCLBsd9WfrALjfvCOgVwCl926jBVokJX5ziZRow9xgX/WeT2gjzeOCZPzS5A
	+kyVwVOIXpfjbHfFLoHiaNrOduETvI4fU/SYM+mQERV1T6a9Qo6q1iN5661oMNXx1g74SbfpzYYSJ
	ZXBeZG70WshaYyeReaEtif9yyEMMqjsADf3CmT/UAvrvyFkpeKK/+F6T4nY5+FkY8TKRuZns4HG9E
	JhEsjoAReRfsvyOWoUMlHOVgRsb8aBMfaSwZq7+kUvq479Pn3R9wMVymMe4XdLS58ypgJ8PNJhgJC
	39MKZWTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovIak-0040ms-FW; Wed, 16 Nov 2022 13:36:38 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovIag-0040jZ-IM
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 13:36:37 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221116133627epoutp013f2843ddf91fc5cae13f9358af22ce7e~oFB92ZlSx0601306013epoutp01g
	for <linux-nvme@lists.infradead.org>; Wed, 16 Nov 2022 13:36:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221116133627epoutp013f2843ddf91fc5cae13f9358af22ce7e~oFB92ZlSx0601306013epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1668605787;
	bh=5qWErvoyl4gjdQb7YlZURM9an1zWoLcZWBZ7wYoiHA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h4jpJ5YAIYtCZjyszuKUiRHRSqkY6r0NwK2rT+Jr1Q6DU9gzsIWzmIiSHZKWPx0WJ
	 +zx5RdFKyYga4zJ4HK/eKByExfooGD+6tjyzCRqXBYw/MJ13o8gwPCUa/Sdp2uJdHG
	 6rXGoCtdGg+87AVAKAzNcCVtXOMKVTjuYkipRGkk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20221116133627epcas5p4d717c490e558ad47821fbcb416eeaa37~oFB9rBSq-2842428424epcas5p4e;
	Wed, 16 Nov 2022 13:36:27 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4NC3wn30GNz4x9Pr; Wed, 16 Nov
	2022 13:36:25 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	21.12.39477.757E4736; Wed, 16 Nov 2022 22:36:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20221116133622epcas5p1e3baaf4c86f2afb6071ee4669cfb8e7d~oFB5WfPYQ0058900589epcas5p1C;
	Wed, 16 Nov 2022 13:36:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221116133622epsmtrp1b3b6ea44f5c6063def05f9699780cb94~oFB5V12HK3226032260epsmtrp14;
	Wed, 16 Nov 2022 13:36:22 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-b2-6374e7578da9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0C.9A.14392.657E4736; Wed, 16 Nov 2022 22:36:22 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20221116133621epsmtip1d40b3ed14b048bb481cbbc9ba571ac2e~oFB4Y4MgI0602806028epsmtip1N;
	Wed, 16 Nov 2022 13:36:21 +0000 (GMT)
Date: Wed, 16 Nov 2022 18:55:02 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: block dangerous passthrough operation
Message-ID: <20221116132502.GA5094@test-zns>
MIME-Version: 1.0
In-Reply-To: <20221116130104.2186334-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmhm7485Jkg8/veS1Wrj7KZDHp0DVG
	i/nLnrJbrHv9nsWBxeP8vY0sHptWdbJ5bF5S77H7ZgNbAEtUtk1GamJKapFCal5yfkpmXrqt
	kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
	Rn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG6o//mAueslfsfficuYHxDFsX
	IyeHhICJxKn3J5m6GLk4hAR2M0r03f3HBJIQEvjEKPH2uy2E/Y1RYseZbJiG1mttjBANexmB
	uptYIJxnjBJ7ehaAdbMIqEqcPPIbaAUHB5uApsSFyaUgYREBJYmnr84ygtjMAukScxZ9Zwax
	hQWMJHac3Adm8wroSFzadgjKFpQ4OfMJC4jNCVQzt+MGO4gtKqAscWDbcbCrJQTusUtc33uA
	FeI6F4ntr6azQNjCEq+Ob2GHsKUkXva3QdnJEpdmnmOCsEskHu85CGXbS7Se6meGOC5D4vyJ
	s1A2n0Tv7ydMIL9ICPBKdLQJQZQrStyb9BRqrbjEwxlLoGwPiVNrDrBDwqSVUeLmnAusExjl
	ZiH5ZxaSFRC2lUTnhybWWUArmAWkJZb/44AwNSXW79JfwMi6ilEytaA4Nz212LTAKC+1HB7F
	yfm5mxjBaVDLawfjwwcf9A4xMnEwHmKU4GBWEuHNn1ySLMSbklhZlVqUH19UmpNafIjRFBg9
	E5mlRJPzgYk4ryTe0MTSwMTMzMzE0tjMUEmcd/EMrWQhgfTEktTs1NSC1CKYPiYOTqkGpqkH
	Fy2YypE6ZWHUjO5PFcX7WIJzlgZrfS8V3h7mIHFxU56AZHr/ajZTE9dwjRSHvUp9s5rci6fk
	fMvrzuw/mVog63zzF4Oz3J1LcwpKK77fP1zbbB3kI3Pl3z2t7jKz58b3S5QXV0xnXuC8XvFP
	044Kzay2N+6SZwTE3eNS0n1NqyP6xA+objkgNpf1+ZlkC/WSKZselOW+0TkcfvzajjgB1aKO
	nsw+iT8rNhyf2+gqeTHZnXXyKj+e2OCHbpomCSntwRvNBR9O1RZOOPs2c2JaUHzk6RZvq7t5
	TdwyUX/P7LC/PWEWk+2eqvs6jz5rvSuuuS6/5oHfY74uLde1i7coR4TernKeb9N1rUSJpTgj
	0VCLuag4EQBsK9yqDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSnG7Y85Jkg8X7JC1Wrj7KZDHp0DVG
	i/nLnrJbrHv9nsWBxeP8vY0sHptWdbJ5bF5S77H7ZgNbAEsUl01Kak5mWWqRvl0CV0ZDy2PW
	gumsFds3nmdrYJzB0sXIySEhYCLReq2NsYuRi0NIYDejxLEr7cwQCXGJ5ms/2CFsYYmV/56z
	QxQ9YZQ40b4PLMEioCpx8shvti5GDg42AU2JC5NLQcIiAkoST1+dZQSxmQXSJeYs+g42U1jA
	SGLHyX1gNq+AjsSlbYfAbCGBVkaJc/N1IOKCEidnPmGB6DWTmLf5ITPIeGYBaYnl/zhAwpxA
	Y+Z23AC7QFRAWeLAtuNMExgFZyHpnoWkexZC9wJG5lWMkqkFxbnpucWGBYZ5qeV6xYm5xaV5
	6XrJ+bmbGMGBraW5g3H7qg96hxiZOBgPMUpwMCuJ8OZPLkkW4k1JrKxKLcqPLyrNSS0+xCjN
	waIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgamJ2yt4uohHjqzENfXLX2InfJu5+wF//0Ph
	sNqLizWfdD+X2bKG4Wp68kmXxfx8921O/L/BIrvB2rjbpVBFZ/Ppf67/f75IkRQzc5TOCXLQ
	nF94tTqkJWl+tfPeMj+rAycyy11WisSWz5EyjFJ++XXjCz0Ljca5eYpSZ30evPr0Ze+lU4em
	Pz9bJ7v5N9+XZYzN618lmNe4uf2cOMnbqF7zr/O6o1OvMFsXXl76T5Wn12z/h8MLJ69niigS
	ihO5z1GyPv3js96HeTcTT/5MEbu3WvLKXO6rGqpMTW+eBeioz5+8NE3/8Npn6Uapfcv2VHiu
	quXSnRR6ofzmmwtz7PfXB0ja2OYoHQkUDcvd6qzEUpyRaKjFXFScCACVxgzl2wIAAA==
X-CMS-MailID: 20221116133622epcas5p1e3baaf4c86f2afb6071ee4669cfb8e7d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4aa00_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221116130636epcas5p39a586e15d27045752f18d022f4efd74a
References: <CGME20221116130636epcas5p39a586e15d27045752f18d022f4efd74a@epcas5p3.samsung.com>
	<20221116130104.2186334-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_053635_415123_404FD791 
X-CRM114-Status: GOOD (  16.58  )
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

------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4aa00_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Nov 16, 2022 at 02:01:00PM +0100, Christoph Hellwig wrote:
>Hi all,
>
>I recently had to debug some testing code that tried to send fabrics
>commands and caused a major havoc.  This series adds checks for various
>very low-level passthrough commands that have no business sent by anyone
>but the driver itself.  The list might now be complete, so discussion
>is welcome.

Sorry to hear about the trouble, but I am confused how did this
happen.
The old code also did not allow fabrics command and any other
admin command except id-ns variants. Yet this series had to
explicitly disallow admin cmds such create/delete sq/cq and
set-features.

------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4aa00_
Content-Type: text/plain; charset="utf-8"


------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4aa00_--

