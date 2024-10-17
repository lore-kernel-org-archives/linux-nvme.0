Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6195D2F7FF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 08:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pDLpjy6R8XNUqzYH2uFDSvoyNM+DND0gn5dbMA66X0s=; b=AqWcCaCZNwWsGVRdWW034JRCT/
	nFNe4PqlSfhnHOMzjwTBQkhheqVpL5jahOKdEJR4ssRKj/ASv6nvoG9M4xZaKF7IWl1PwTbAZ8pq5
	Awi+ovWAyAmidEx/TqilXZb/IxfDsQpE/gtEnGfzxArNdwlh0jKbh+l4QFb5NfZX/bpN2Ftat3lOV
	XA+K+xGVnrDMPYUtM/e1pXaN841hPsBExfgb10B2Tgc7Xr1tIl3eoWVQhLf9BQu2gR+l/fZrCjmQe
	2qyZ0DRY9cpipVLjv4f4U7bi+e4ubSXRzvHawY1/8phWSbL2TtQvOK3V4MvLl30BhkJxu6TdQlc5f
	Tq4z1YXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Lfl-0000000E89h-2p2R;
	Thu, 17 Oct 2024 08:15:53 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Le6-0000000E7Tt-1Nv5
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 08:14:14 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241017081400epoutp025083bfd282b6ee7aba13726637b8bab5~-L1jd4b5P2967429674epoutp02Z
	for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 08:14:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241017081400epoutp025083bfd282b6ee7aba13726637b8bab5~-L1jd4b5P2967429674epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729152840;
	bh=pDLpjy6R8XNUqzYH2uFDSvoyNM+DND0gn5dbMA66X0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YdhFbzJ2PBVMDLDvxrXB2iQnqQMetM8y0yHtU7Y4Q9xf/sZ28gi/fh9/vJm2wYmLq
	 XPzmV3XmbRazplPaownqa1q3G3SWgAH76W59xADj5k4M+0OnL9VIwO9k/34cGDaF97
	 GG8DBPWEUk+k99kadXEpzp14msoorN+pxAax0yJQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241017081400epcas5p46e38c0d524781a09f82842562c374225~-L1jR6JUg2577525775epcas5p4z;
	Thu, 17 Oct 2024 08:14:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XTgbB4CC5z4x9QH; Thu, 17 Oct
	2024 08:13:58 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	64.DB.09800.447C0176; Thu, 17 Oct 2024 17:13:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241017060905epcas5p35f250dd9dd49791b4e58c143dc5fbc00~-KIfJ3qM32739527395epcas5p3U;
	Thu, 17 Oct 2024 06:09:05 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241017060905epsmtrp251d909dd228d003131b265f0cc82ee47~-KIfEyuUP1835918359epsmtrp2r;
	Thu, 17 Oct 2024 06:09:05 +0000 (GMT)
X-AuditID: b6c32a4b-23fff70000002648-fd-6710c744a439
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F9.C7.18937.10AA0176; Thu, 17 Oct 2024 15:09:05 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241017060904epsmtip2c8dae186b8b4c86dcef2a7fe1faeb490~-KIeApd6C1460314603epsmtip2f;
	Thu, 17 Oct 2024 06:09:04 +0000 (GMT)
Date: Thu, 17 Oct 2024 11:31:23 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, martin.petersen@oracle.com, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
Message-ID: <20241017060123.GA8191@green245>
MIME-Version: 1.0
In-Reply-To: <20241016201309.1090320-1-kbusch@meta.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmhq7LcYF0gy3T+C1W3+1ns1i5+iiT
	xaRD1xgtzlxdyGKx95a2xfxlT9ktlh//x+TA7nH5bKnHplWdbB6bl9R77L7ZwOZx7mKFx8en
	t1g8Pm+SC2CPyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQ
	dcvMATpGSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJl
	aGBgZApUmJCd8fv0IfaCZWwVX9/0MTYw7mHtYuTkkBAwkbg84xF7FyMXh5DAbkaJb++XMUI4
	nxglDjZvZ4Nzrl/+xgjTsqhxB1TLTkaJ81vmgc0SEnjGKLGxwxXEZhFQlTjTeZMFxGYTUJc4
	8rwVrFlEQFHiPDAoQJqZBeYySvxc8BisSFjAXeLp2g42EJtXQEfi7IoeRghbUOLkzCdgNZwC
	5hLzV+5mB7FFBZQlDmw7zgQySELgL7tE344WJojzXCTuf3jIDmELS7w6vgXKlpL4/G4vG4Sd
	LvHj8lOo+gKJ5mP7oF6zl2g91c/cxcgBdF2GxKflahBhWYmpp9aBlTML8En0/n4C1corsWMe
	jK0k0b5yDpQtIbH3XAOU7SHxve0EKyS0uhglbi+cxzaBUX4Wkt9mIaybBbZCR2LB7k9sEGFp
	ieX/OCBMTYn1u/QXMLKuYpRMLSjOTU8tNi0wzksth0d4cn7uJkZwWtXy3sH46MEHvUOMTByM
	hxglOJiVRHgndfGmC/GmJFZWpRblxxeV5qQWH2I0BcbVRGYp0eR8YGLPK4k3NLE0MDEzMzOx
	NDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qBaeJeqaqFs7bysS9quna+k2nHCgOzm5Ja
	M2//WGPx+8DLeGeXF6dE9Cz8tuVX+e3w29TxdcdqLWYeacbE6FfBl+Sc8m9typJaZ3xd6pXr
	8sfnlPiNf65ZenS3cNVlBYGTaf+WxVx7obXxis0LletXJBb3CMZ9Pfg8Nvrl/SC+Y+s3X5WR
	nSF20+U05+7bdo3uyhGfOrh3yGx7kzPffK61bPmWL34H5rN8WaUzc3felLJUJ6vzmlyfoh0E
	Jy+rWcH0Pm/L4ucmBlMDeBJ0+phDQ/ZtbWtQTrhtc1lqf/iWufKn+3OudH2oSBDbkcJdmvSR
	S016O8evINFfqi42R+Lta7bsLG1s+fJyz/mL7tzem5RYijMSDbWYi4oTAcRpVEE0BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvC7jKoF0g8NdMhar7/azWaxcfZTJ
	YtKha4wWZ64uZLHYe0vbYv6yp+wWy4//Y3Jg97h8ttRj06pONo/NS+o9dt9sYPM4d7HC4+PT
	WywenzfJBbBHcdmkpOZklqUW6dslcGXcO+hY8Iy5YvOBk8wNjFOZuxg5OSQETCQWNe5g72Lk
	4hAS2M4o8X/aEzaIhITEqZfLGCFsYYmV/55DFT1hlNj18g47SIJFQFXiTOdNFhCbTUBd4sjz
	VrAGEQFFifNA54A0MAvMZZRYcWchE0hCWMBd4unaDrANvAI6EmdX9DBCTO1ilJhy8DMrREJQ
	4uTMJ2BTmQW0JG78ewnUzAFkS0ss/8cBEuYUMJeYv3I32BGiAsoSB7YdZ5rAKDgLSfcsJN2z
	ELoXMDKvYhRNLSjOTc9NLjDUK07MLS7NS9dLzs/dxAiOBK2gHYzL1v/VO8TIxMF4iFGCg1lJ
	hHdSF2+6EG9KYmVValF+fFFpTmrxIUZpDhYlcV7lnM4UIYH0xJLU7NTUgtQimCwTB6dUA5P/
	CokzhVdufrtuketd23K8WHaVscSPG9YdQv9/WU4VEvgpedpL6s6/6cf2HjrrUXK8z8I4TUeh
	UO0TM0PSNI83oV+3bvKt5mytnbnLfqtQjNduCb6vXt1fNjOzvq8tKuY+wlC4Z9e0vMbv3tEM
	yd/Ee+5PqPMSfjNvgu7H2y0nDkSoXrnY6TQjJJ93kogzW8GLpZ+b/y/uzFyw+9SJ/xze7nZz
	zNM1K5/t3dwl7xvWkHDT1zmT0aFM58LvFee5F6mtrc9f3POHV724jz+19fkK6Q+T1vN7b1Rp
	EumvOFzH5JmTz7c0tdHzfeuqbAOtw1LzFm7nr7g7b8o1sfeHvi9d1au66aaSa9KT3D4WLiWW
	4oxEQy3mouJEAO+aI6/zAgAA
X-CMS-MailID: 20241017060905epcas5p35f250dd9dd49791b4e58c143dc5fbc00
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_4e3a1_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241016201330epcas5p33226adcbff73f7df7cced504aea64a13
References: <CGME20241016201330epcas5p33226adcbff73f7df7cced504aea64a13@epcas5p3.samsung.com>
	<20241016201309.1090320-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_011410_949239_6DF60EEB 
X-CRM114-Status: GOOD (  13.25  )
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

------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_4e3a1_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Oct 16, 2024 at 01:13:09PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The seed is only used for kernel generation and verification. That
> doesn't happen for user buffers, so passing the seed around doesn't
> accomplish anything.
>

Not for nvme passthrough, but all this code is needed for io_uring
metadata series. Please see the need/justifcation [*].

[*] https://lore.kernel.org/linux-block/20241017054900.alfiqn3o37f4kkxb@green245/

------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_4e3a1_
Content-Type: text/plain; charset="utf-8"


------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_4e3a1_--

