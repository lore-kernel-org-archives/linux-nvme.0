Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF222C38142
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 10:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N4KCGCA+RPj/dU8Cncl1EuBzFNh937fpqhs7LsAC/zI=; b=LSJi4XkXeDUy0NFS4bP2n667HH
	7chEyyYLE5kTkNGvn3mRbPXak4gkrkdcogVoRVs6h11QAwRnqaQvrQ1f8GeD6gd1QppLwM/6pv6M/
	2EkCkKUYQaMc+Z9HzWtJAKpRw9XNwMOh9sVgM0fEJjQEzUhyTxNeXRLT2V/gAfnx+lwghq2X1/fvd
	t2U4arUkvSuAjBm1A4lXCU+qxIRyXRSh59LnQnu1Cr9CaaidFF8Vxymtgl02VsQgkLx1JpEyLGcUD
	ENAkjCWi14FXvROW5nU67H3yOA180BEtnetgLd62jxKrji1sI3QWRsbSBBuWb8vkEzyrDTL8y2IIj
	6kDai+cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMnXl-007GE8-0S; Tue, 31 Jan 2023 10:07:13 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMn9X-0075VI-UW
	for linux-nvme@lists.infradead.org; Tue, 31 Jan 2023 09:42:14 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230131094204epoutp033c548162b1a9a06c269cb5ce77ac9746~-W3BOJhVU2512025120epoutp03M
	for <linux-nvme@lists.infradead.org>; Tue, 31 Jan 2023 09:42:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230131094204epoutp033c548162b1a9a06c269cb5ce77ac9746~-W3BOJhVU2512025120epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1675158124;
	bh=N4KCGCA+RPj/dU8Cncl1EuBzFNh937fpqhs7LsAC/zI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GfZFcsd1yqdBhOy3zJQ3w4t8M8KW/FoK0ygz4K3FeGd4e6BGt6Y1QdIy4ENNe+cwV
	 TimcejVpLUwSFzFBelvEbynIWZvI3QMkVsuuV2ROKuOSlzwZggLbYXd2ODEwMhBod7
	 savPIQYSF1/GqvJWBJUum7MGU7sTcHEH3yxHvZI8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20230131094203epcas5p45681fa83fdaa6f8bac50b483b36cfa26~-W3Ann8xU0112401124epcas5p4I;
	Tue, 31 Jan 2023 09:42:03 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4P5g7G1KvRz4x9QF; Tue, 31 Jan
	2023 09:42:02 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	20.2C.55678.A62E8D36; Tue, 31 Jan 2023 18:42:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20230131094201epcas5p3934f2c5859d8cb3a67bcefb31e455332~-W2_nI8lA2230722307epcas5p3M;
	Tue, 31 Jan 2023 09:42:01 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230131094201epsmtrp2c0ff6bf0137297b021ed39f14a3f8231~-W2_mfPUY3119731197epsmtrp2m;
	Tue, 31 Jan 2023 09:42:01 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-86-63d8e26a63f4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	EE.78.17995.962E8D36; Tue, 31 Jan 2023 18:42:01 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230131094200epsmtip1c626301ecdb91efdc875bf2f75253410~-W29wA87W2740527405epsmtip1E;
	Tue, 31 Jan 2023 09:42:00 +0000 (GMT)
Date: Tue, 31 Jan 2023 15:11:34 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, Keith
	Busch <kbusch@kernel.org>
Subject: Re: [RESEND PATCHv3 1/2] nvme: always initialize known command
 effects
Message-ID: <20230131094134.GA17740@green5>
MIME-Version: 1.0
In-Reply-To: <20230127165620.3487918-2-kbusch@meta.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTQzfr0Y1kg/f72S1Wrj7KZDHp0DVG
	izNXF7JYzF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8zl2sCGCNyrbJSE1MSS1S
	SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqtpFCWmFMKFApILC5W
	0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOePlnO3PBPtaK
	rlevmBoYn7B0MXJySAiYSOy+uY+1i5GLQ0hgN6PExo29bBDOJ0aJngX/mCCcz4wST378ZIVp
	+fy9Fyqxi1Fi7rK97BDOE0aJk592MoJUsQioSrQePA1kc3CwCWhKXJhcChIWEVCUOA8MARCb
	WSBZ4uvpI+wgtrBAoMS0XZvBFvAKaEu8ev2AEcIWlDg5E+RWDg5OAXOJha18IGFRAWWJA9uO
	g90gIfCSXeLz6ydQx7lI/H53gxnCFpZ4dXwLO4QtJfH53V42CDtZ4tLMc0wQdonE4z0HoWx7
	idZT/cwQt2VIbPiwjh3C5pPo/f2ECeQGCQFeiY42IYhyRYl7k55CrRWXeDhjCZTtIXHp0QOw
	VUIC2xklttyKnsAoNwvJN7OQbICwrSQ6PzSxzgLawCwgLbH8HweEqSmxfpf+AkbWVYySqQXF
	uempxaYFRnmp5fAoTs7P3cQIToxaXjsYHz74oHeIkYmD8RCjBAezkgiv3bYbyUK8KYmVValF
	+fFFpTmpxYcYTYGRM5FZSjQ5H5ia80riDU0sDUzMzMxMLI3NDJXEedVtTyYLCaQnlqRmp6YW
	pBbB9DFxcEo1MIW2HnwQvzzegvOd+7Typw8na4muzTOtmGTD8MTIRuTNzbdz/nEalsuqNxyp
	ZFjrxx70e6PNMZ1LR5ZqCjReud4i8InLs+kkU5M5Q07mr+Yor89L439dkHQrDZXV/7nYaY/e
	g+I2Qx2vPaqXfNY8zFvW9ftkkAOfxVPO1zt+fNlZKLzdbM3mTYe/+lu+PWl20W9Wte4Rld9+
	Kftdsh5MEIhIb9U7tucLq8vk8Ot1rcJXUpfk7fafL8ZmbWoinrX0yQJ30Trjvrln3zT9tF5x
	Q/nz1x2+ewsnb3+y5UvWhL3p5/JdShZOOBc7273Tu9ot3KDxceSM6GURu+Tid+TO0rp87K2b
	b6RBwBlfrv0vhJRYijMSDbWYi4oTAYooliMVBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSnG7moxvJBue7JS1Wrj7KZDHp0DVG
	izNXF7JYzF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8zl2sCGCN4rJJSc3JLEst
	0rdL4MrYdE264ANTxY5jF5gbGDcwdTFyckgImEh8/t4LZHNxCAnsYJRYcOscVEJcovnaD3YI
	W1hi5b/n7BBFjxglHk+4A5ZgEVCVaD14mrGLkYODTUBT4sLkUpCwiICixHmgI0BsZoFkid/N
	rawgtrBAoMS0XZvBbF4BbYlXrx8wQszcziix488aqISgxMmZT1ggms0k5m1+yAwyn1lAWmL5
	Pw4Qk1PAXGJhKx9IhaiAssSBbceZJjAKzkLSPAtJ8yyE5gWMzKsYJVMLinPTc4sNC4zyUsv1
	ihNzi0vz0vWS83M3MYIDXUtrB+OeVR/0DjEycTAeYpTgYFYS4bXbdiNZiDclsbIqtSg/vqg0
	J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBiajNdbsqpNsPbfubTbisb6xTOud
	0k59rxdPn13coPSMPX7Ni+JvZu9+RafNZhPXa7bVLN0q6FiiHGVh03guS0g4wKrgwYMrMyoX
	zWFJfy2itObX3xsMytNci5uktrLe/hp76FXz0cNi55xl1/7Yd9Mmqrpnp+LhR2/U2I86iv3I
	qpW+eXPho/vG7Zd+sXhW1R2ripQ2N6vcOWmxtErKq4kOH549katLlWiWMlnxInLPym0v0uW9
	5ttN7dxb2DNN9IK7wKszp+8c/qqeWGO3eqnMj0KhOm5z7trIsmNzd8w8+f/7ixtrqsXmN6/U
	qVik3u2c1avw9tQbpsbQo09yrlmrcnDK2gYvnLHQ7K3TM30lluKMREMt5qLiRABtzjbE4wIA
	AA==
X-CMS-MailID: 20230131094201epcas5p3934f2c5859d8cb3a67bcefb31e455332
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_276e4_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230127170101epcas5p2772d8d56d8e46ca66f572edb747869b4
References: <20230127165620.3487918-1-kbusch@meta.com>
	<CGME20230127170101epcas5p2772d8d56d8e46ca66f572edb747869b4@epcas5p2.samsung.com>
	<20230127165620.3487918-2-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_014212_340583_78156FBF 
X-CRM114-Status: GOOD (  10.09  )
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

------20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_276e4_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Jan 27, 2023 at 08:56:19AM -0800, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>Instead of appending command effects flags per IO, set the known effects
>flags the driver needs to react to just once during initial setup.
>
>Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good.
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>


------20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_276e4_
Content-Type: text/plain; charset="utf-8"


------20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_276e4_--

