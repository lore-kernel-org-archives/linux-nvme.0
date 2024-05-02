Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A2DC25B10
	for <linux-nvme@archiver.kernel.org>; Thu,  2 May 2024 06:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=AjVpp42/tezEYnxm4zITp0yF+UFmW1SEWNp58iTf3y8=; b=nyJLjgKtpad9OolNf6JV2x+CXg
	ll8b/pzHgzz/rHbRyGqRRa1jUGKD4FOlZS1jSic0bKG4fUpd9+qVmPSh2/IMqqmlr+3mW925dSX04
	zWec3WhhFzHnt0ahQNBu2SzzfRUnA3esya/88S3kUvPtsmfz7W8gcVjh8vC8w7J6xV65xNpAXOIuk
	bX5zl3Y4VCwQKPd06ibYBsxCn6F09q+/Opt+vcwt8cvt1lYcQbdCn9mnlCQDuvH0COiBDMitvVfdY
	VBUs5og8Fu41b5723gAceaF5rOi3GEBoik0ST0t+x4UWJOqKAChlEvCcja2br05xXAchVrDYId1lF
	t8f8sriw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2Q98-0000000BgHZ-1Bd2;
	Thu, 02 May 2024 06:42:22 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2Q93-0000000BgEV-0b1L
	for linux-nvme@lists.infradead.org;
	Thu, 02 May 2024 06:42:19 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240502064151epoutp0392b497698899e1e0da0f22f0161cb402~LmNItFsTL1854318543epoutp03B
	for <linux-nvme@lists.infradead.org>; Thu,  2 May 2024 06:41:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240502064151epoutp0392b497698899e1e0da0f22f0161cb402~LmNItFsTL1854318543epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714632111;
	bh=AjVpp42/tezEYnxm4zITp0yF+UFmW1SEWNp58iTf3y8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Bdme4o8zTuy5cbHXpI7AG7XFG3pv3+8/np0W8f+UgXk78ZkQ5Ps7ET7vOGoSTUCl3
	 57IQwHNUgfTTvdiRdOQcmWaJF0lDh2iLUmgEAxlZQReL/BeIvXeXBq9kiQ1iPjb5lc
	 iG/wpXo1L8MRqsoLVYWoPPL3tw4QYZZL039Y+lCw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240502064151epcas5p458a76c7ee6cde704db97587b92e624b4~LmNIaN3h80725007250epcas5p4f;
	Thu,  2 May 2024 06:41:51 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VVPVP6HWMz4x9Pv; Thu,  2 May
	2024 06:41:49 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DA.65.09665.DA533366; Thu,  2 May 2024 15:41:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240502064149epcas5p4be127b8e22874b76bb41ce25c29263f9~LmNGj6HhX0725007250epcas5p4b;
	Thu,  2 May 2024 06:41:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240502064149epsmtrp19b848d44d1a6c31bed1864d0ae2da8a5~LmNGjVAi01137711377epsmtrp1h;
	Thu,  2 May 2024 06:41:49 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-54-663335adb16a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CD.06.08924.DA533366; Thu,  2 May 2024 15:41:49 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240502064148epsmtip1a2669e2b0fdc97a404b97222ed24a168~LmNFmBEuG2095420954epsmtip1B;
	Thu,  2 May 2024 06:41:48 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 0/2] cleanup
Date: Thu,  2 May 2024 12:04:36 +0530
Message-Id: <20240502063438.422046-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmuu5aU+M0gzNt+hYrVx9lsjj6/y2b
	xaRD1xgt5i97ym6x7vV7FgdWj/P3NrJ4bFrVyeaxeUm9x+6bDWwefVtWMQawRmXbZKQmpqQW
	KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
	K+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ2x76lKwi6ni
	4qYr7A2M3xi7GDk5JARMJHZ9W8DWxcjFISSwm1HiT+9+dpCEkMAnRokN5/0h7G+MEn2/fWAa
	zi1tY4Vo2Msoce18P1T3Z0aJx9eXM3cxcnCwCWhKXJhcCtIgImAs0bmygQXEZhZwl7j9pIcJ
	pERYQEbi/X2wI1gEVCVWNXaA7eUVsJT427qNBWKXvMTMS9+h4oISJ2c+gRojL9G8dTYzyFoJ
	gX3sEo9WLmOHaHCR2N/xnAnCFpZ4dXwLVFxK4mV/G5SdLHFp5jmomhKJx3sOQtn2Eq2n+sHO
	ZwY6f/0ufYhdfBK9v5+AnSwhwCvR0SYEUa0ocW/SU1YIW1zi4YwlULaHxM0p+1lByoUEYiV+
	nLadwCg3C8kDs5A8MAth1wJG5lWMkqkFxbnpqcWmBcZ5qeXwaEzOz93ECE5xWt47GB89+KB3
	iJGJg/EQowQHs5II75SF+mlCvCmJlVWpRfnxRaU5qcWHGE2BoTqRWUo0OR+YZPNK4g1NLA1M
	zMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamBiPNEqGX1Hqi9025qTO2sCXQp3
	rPD6VflaVjLDdbaDZGr+2StTC1SeFD81NM6xairj91uTHSdSYlLS4Lv/3NHoqAbjaWdsb83j
	ufrV2Cm5794szYcnTVTX2ebyrPa8nH+kLmWv/Dx9EUUW19RLbb1aUo9UUhL/6fTeaOCU721W
	+OB5+DKH3OfT76sf5Lmqn6/v8GMW+v6N5fxsiyKxP0pnF/L/TP48NeyNSVL6mcZteYLXZk2Z
	NOH7F1uOR+I/FbWZrseZLDi6miloWsFui89xOa+NWnft9L5TIpJifnVh8Qafrn7tB7ueFU5+
	wKbe7Z6xf+th4bVBKvf26Ry7f3da5BzfFbLLV03ImGmfuEiJpTgj0VCLuag4EQDK8SBV+gMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSnO5aU+M0g2MHuSxWrj7KZHH0/1s2
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8+rasYgxgjeKySUnNySxL
	LdK3S+DK2PbUpWAXU8XFTVfYGxi/MXYxcnJICJhInFvaxtrFyMUhJLCbUeLQ2nUsEAlxieZr
	P9ghbGGJlf+es0MUfWSUOLJyA1sXIwcHm4CmxIXJpSA1IgLmEvsuPGcFCTMLeEqsnygPYgoL
	yEi8vw+2ikVAVWJVYwfYRF4BS4m/rdugNslLzLz0HSouKHFy5hOwODNQvHnrbOYJjHyzkKRm
	IUktYGRaxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHIpamjsYt6/6oHeIkYmD8RCj
	BAezkgjvlIX6aUK8KYmVValF+fFFpTmpxYcYpTlYlMR5xV/0pggJpCeWpGanphakFsFkmTg4
	pRqYjC9Ial2NPP9s29av11j6Hy+z+6r1f/PkHPNzLx/uqGk51enfNmHv//raUIce1exvRSIl
	ZYx3XGuTOFYtaLGYc8Fg5QVejiLt/XUz4qLzH3ZvDQtPOyP1brH2vZvbNm3fs/FheKPa07KL
	Tm8v7XCbZ/017EliB+9euwOPTQuVihjaFnb1hVfqn5Bo/Mly5cEt5S+uMT9WWv4+FHzugL30
	kqffFti/OfBkad71b+6Hv/y02vrit9tZd99jG3j3dsd0VNbUMF0ymLXYU/Rr+o8d7NPexsyp
	FmiO3GDg8Vx0S3OxRFGxvPyBTU83BYksqTv8etdeMZc66RUGBRmqP95xc/rt3LNld/+SD8df
	ys4xvKXEUpyRaKjFXFScCABO/0patAIAAA==
X-CMS-MailID: 20240502064149epcas5p4be127b8e22874b76bb41ce25c29263f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240502064149epcas5p4be127b8e22874b76bb41ce25c29263f9
References: <CGME20240502064149epcas5p4be127b8e22874b76bb41ce25c29263f9@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240501_234218_078522_92358C95 
X-CRM114-Status: GOOD (  11.37  )
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

First patch removes two unused variables.
Second one reduces repeated checking.

Kanchan Joshi (2):
  nvme: remove sgs and sws
  nvme: reduce a repeated ZNS check

 drivers/nvme/host/core.c | 9 +++++----
 drivers/nvme/host/nvme.h | 2 --
 2 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.25.1


