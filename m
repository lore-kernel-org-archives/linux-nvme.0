Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCF9C3DA7F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jul 2024 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=ifQ+ZsEgPRbNlTxojnAd36k9hhy/SERZTzKl7+gMkyc=; b=0LwU5NP2cnbkXAQvJm3VNHmCqq
	fhHtVFHrrK1u7KMBdfTFlWoFjkMN7tJOt64fbQvuy6BIfhBD1u8GPChwdNvHzHLj14+9EjwqIohtp
	eSjg/Vy3gqft1W0t1fvcHsnpjCmsOB3jCqmH1VSmEu21pQ6AhuWK7y7e392TdBs3J8tFJxMrC17uh
	Ss01sl69O8I0KLTuH5JvlKu8B/1skcJ8p21Ujpxfek1l7sZFt9Q9Jl2NgOCA3aajzkMT0VzDWf856
	5/hWJ+Uofr1RBjX3+zM41Vv/JHJluinoynTKonxdOcz+C0cIk/9JezszgvTnifTG3lkf2E3ZlGONM
	ap5qJEAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYkGw-0000000ElZ0-0XB4;
	Tue, 30 Jul 2024 10:40:02 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYkGs-0000000ElXb-19Ae
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jul 2024 10:40:00 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240730103945epoutp0451724472804adf4a9c670857ad7e76a3~m93P_7iqy1468714687epoutp04z
	for <linux-nvme@lists.infradead.org>; Tue, 30 Jul 2024 10:39:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240730103945epoutp0451724472804adf4a9c670857ad7e76a3~m93P_7iqy1468714687epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722335985;
	bh=ifQ+ZsEgPRbNlTxojnAd36k9hhy/SERZTzKl7+gMkyc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=efoG2iRv/1z1NdzCxr8vMbprQ9KosrsG7cKK9S8C9/cGcTHfUndtc3r057lpuYaM8
	 vpHhiY/HfBaTet8M49ZWPgpB6O7H8may2J3N23DBoVG5JqNO22oMEzcpPyxE/2Pus8
	 Vvbuy/6z3Pr+ZvOMqBdY4O2YF4ZgkgmLqSRWOHG4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240730103944epcas5p1679be4d9e6298f4402c25abfc377403f~m93Ph_X5s2012520125epcas5p11;
	Tue, 30 Jul 2024 10:39:44 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WYBYq2xDBz4x9Px; Tue, 30 Jul
	2024 10:39:43 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0B.22.09743.EE2C8A66; Tue, 30 Jul 2024 19:39:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240730103941epcas5p37930edd18b9649d4df2083151ed21022~m93NAs-qV3199631996epcas5p3O;
	Tue, 30 Jul 2024 10:39:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240730103941epsmtrp24b81942356f1a5e79aec12e2d8a3db7a~m93NAIs070348103481epsmtrp2g;
	Tue, 30 Jul 2024 10:39:41 +0000 (GMT)
X-AuditID: b6c32a4a-3b1fa7000000260f-38-66a8c2ee9f23
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D6.F8.08964.DE2C8A66; Tue, 30 Jul 2024 19:39:41 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240730103940epsmtip1eb7b21098d8d8107babc38b17064bb56~m93MKXO1w1683516835epsmtip1m;
	Tue, 30 Jul 2024 10:39:40 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 0/3] nvme_ns_head cleanup
Date: Tue, 30 Jul 2024 16:01:35 +0530
Message-Id: <20240730103138.66714-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmlu67QyvSDHob+CxWrj7KZHH0/1s2
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8+rasYgxgjcq2yUhNTEkt
	UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
	VtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIznh5trbgDVPF
	zmf/2RoYVzB1MXJySAiYSOxo+svexcjFISSwm1Hi2ZULrBDOJ0aJaY93sEA43xglvv88xQ7T
	MuXJG0aIxF5Gife/f0A5nxklTndPZO5i5OBgE9CUuDC5FKRBRMBYonNlAwuIzSzgLnH7SQ/Y
	bmGgkq6+rWA2i4CqxJd7zxhBbF4BC4lf17uhlslLzLz0nR0iLihxcuYTqDnyEs1bZzOD7JUQ
	2Mcu8e7VNTaIBheJm/P2QzULS7w6vgXKlpL4/G4vVE22xINHD1gg7BqJHZv7WCFse4mGPzdY
	Qe5nBjpu/S59iF18Er2/nzCBhCUEeCU62oQgqhUl7k16CtUpLvFwxhIo20Pi++6rYNOFBGIl
	7l34wjKBUW4Wkg9mIflgFsKyBYzMqxglUwuKc9NTi00LjPJSy+FRmZyfu4kRnOq0vHYwPnzw
	Qe8QIxMH4yFGCQ5mJRHe+CtL04R4UxIrq1KL8uOLSnNSiw8xmgKDdSKzlGhyPjDZ5pXEG5pY
	GpiYmZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE08fEwSnVwFQz1ffAJ6ndkk/F9i11kdiw
	xtDz1AfppUvm3goRsDK4uSUiN8HfV1HAw+COk9B+Xb1a6ahzl63OB+2yfZTfa5J+74up+tv7
	Cf99bubJvnHrlNmW9/an9b4wvmsPzW+fTxdfYMddfjEleW2K6q28C5/0JldLN8y7MPVAVWns
	BffnUet1D2k/dj/baT5D50l1rYzOmc+BfNEuCqEvhX2t/jJE5Tw5ovxb3bP0ZW9XiG9B6Zqc
	9ypMsxfe9xJaKXx05vMd9Sr7/K0ijxpNmq5nFWnnf1fyu7KyTf4Gu8pWRedTxfnFnBb2gRd2
	/qzfvuX/ivqn+xo0b8enPZ5fdfFBSALL7NCMY+GcppuWzbwxQ4mlOCPRUIu5qDgRAL7kt+/+
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSnO7bQyvSDHYfMLJYufook8XR/2/Z
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6NuyijGANYrLJiU1J7Ms
	tUjfLoEr4+XZ2oI3TBU7n/1na2BcwdTFyMkhIWAiMeXJG8YuRi4OIYHdjBKf2lqYIRLiEs3X
	frBD2MISK/89Z4co+sgosWbXCyCHg4NNQFPiwuRSkBoRAXOJfRees4KEmQU8JdZPlAcJCwNV
	dPVtBdvFIqAq8eXeM0YQm1fAQuLX9W6o8fISMy99Z4eIC0qcnPmEBcRmBoo3b53NPIGRbxaS
	1CwkqQWMTKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYKDUUtzB+P2VR/0DjEycTAe
	YpTgYFYS4Y2/sjRNiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/4i94UIYH0xJLU7NTUgtQimCwT
	B6dUA1NH+Y13exiub63Ve8nN9up8YaDo6tOGHBs72rI43AXXevWxP+Ng9tm4pm/au5lS+5JM
	M3XU1r4NunnR4+vMdY6/L4kt0p637XNJfcKltcHpTr2WwZJ9DzYq6v7eJp757/PFyQEvXQUe
	H0sK7/T6c+a+7fnDjbrH/sbqbDhfFrDpu1bH6atuLe3aHM/t2gXr/FMbymqZcrKc/0mpx38q
	nr/N6Ke/OMuC7Sf4BH5NETO5dmXyfMFOV94bmzqNjpllB9+/rrb7rJpegP96p74jnwKf6M9j
	TWXbzvLGY7Znz6HUvffOc7N9WLPUbMW2uNdXf/QbpjwwUK3Y+rrml22ZmZTB485fpeYCsVlP
	XzuYBCixFGckGmoxFxUnAgBzPxaJtQIAAA==
X-CMS-MailID: 20240730103941epcas5p37930edd18b9649d4df2083151ed21022
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240730103941epcas5p37930edd18b9649d4df2083151ed21022
References: <CGME20240730103941epcas5p37930edd18b9649d4df2083151ed21022@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_033959_039071_194B09A3 
X-CRM114-Status: GOOD (  10.64  )
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

Remove/change/reorganize fields inside nvme_ns_head.

Kanchan Joshi (3):
  nvme: remove a field from nvme_ns_head
  nvme: change data type of lba_shift
  nvme: reorganize nvme_ns_head fields

 drivers/nvme/host/core.c | 16 ++++++++--------
 drivers/nvme/host/nvme.h | 13 ++++++-------
 2 files changed, 14 insertions(+), 15 deletions(-)

-- 
2.25.1


