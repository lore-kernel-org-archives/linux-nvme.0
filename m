Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52FEC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 07:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M6ZAZK530XlPFb2VQnucp6E+OpT+7KlI8BMp52kl1FU=; b=43XZh/RpoYjMnONvsa5miZ6F7U
	yJHRt7gz0uREyRtRMV1t2SLjAhYZnrV9Qb5LAt7nZv0CTvDQt9QN9pYGh37+tJZKI6sVjMiyWYuid
	Gk8V/OY3WdhebRcbFZkTu38vKmTLwqf9QCR3S8KEzHGrwlmBHSVKwhc2JHiQTu/Agne7rn/ZbFz7E
	+MCwUxax1576o4lOuPIgeqFhLxXZX27iC/gssyQHZBbhZ+t8enRAR4PkrWNZWjk0vjKKRrAqWjnKb
	xtsnwhfQQCZZFEyUtueMe01kMoROoDQkkQ+oo4PISWg4hQlkbo0OG+uKkyPUA7E7Awpzf/6sR5D+M
	u+cEXaEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noK8M-000JxF-91; Tue, 10 May 2022 07:18:14 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noK8I-000Jud-EI
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 07:18:12 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20220510071803epoutp031021f6486de1b76a7f58bea880c0cc12~trTWNMoKX0109701097epoutp03i
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 07:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20220510071803epoutp031021f6486de1b76a7f58bea880c0cc12~trTWNMoKX0109701097epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652167083;
 bh=M6ZAZK530XlPFb2VQnucp6E+OpT+7KlI8BMp52kl1FU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Bq0GruLjS+S5QNdp24xC5PTiZIYI52Qgck5TOPlrlx+8+DV4/NdjuhZZ0yBbWrcDh
 9UZwwoxPeaWon90Hgg+dL++jEYNp0Zonz+uyd2dSZXSeWH1qXHSnpcSG/kq0wvQ5h0
 AbI5A+RGemEauiiRml3zeTlf0wXRNgj0EaETPpQY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20220510071803epcas5p21328fada51d349dd7470c5410e01ec91~trTVxzxNx0368203682epcas5p2a;
 Tue, 10 May 2022 07:18:03 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4Ky8Wr2VDNz4x9Px; Tue, 10 May
 2022 07:18:00 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 CA.32.09827.4A11A726; Tue, 10 May 2022 16:17:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20220509174253epcas5p32b0db87bb4d35c82c08b33d073a171c2~tgLmo-Mrn3206132061epcas5p3Z;
 Mon,  9 May 2022 17:42:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220509174253epsmtrp2321f6de039cec80bd00cdfd209eee0d0~tgLmoJ5UP2312623126epsmtrp2D;
 Mon,  9 May 2022 17:42:53 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-9d-627a11a42249
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 02.5F.11276.D9259726; Tue, 10 May 2022 02:42:53 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20220509174251epsmtip19527a909eb073ff4b304e52257cd1717~tgLlXokS82469024690epsmtip1M;
 Mon,  9 May 2022 17:42:51 +0000 (GMT)
Date: Mon, 9 May 2022 23:07:41 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Anuj Gupta
 <anuj20.g@samsung.com>, linux-nvme@lists.infradead.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvme: uninitialized return in nvme_ns_head_chr_uring_cmd()
Message-ID: <20220509173741.GA16832@test-zns>
MIME-Version: 1.0
In-Reply-To: <YnjZovrfnF0YYuvN@kili>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmhu4SwaokgxW3OSyaJvxltvi/5xib
 xet/01ksVq4+ymQx6dA1Routt6Qt5i97ym6x7vV7FgcOj4nN79g9zt/byOKxaVUnm8fmJfUe
 u282sHl8fHqLxaNvyypGj8+b5AI4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0t
 zJUU8hJzU22VXHwCdN0yc4AOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBTo
 FSfmFpfmpevlpZZYGRoYGJkCFSZkZ0xb+I2p4ClrxZrH35gaGCeydjFyckgImEi8alzG3sXI
 xSEksJtR4tKVi8wQzidGiWVPD0BlvjFKzJt6hBmmZe/plWwQib2MEve2/2GCcJ4xSjR0LGMB
 qWIRUJH4tnMRkM3BwSagKXFhcilIWERAR+Jy5w+wqcwCrxgl7u7aywSSEBYIlHh9pJcNxOYV
 0JU4vOgiK4QtKHFy5hOwOZxAM3fcrgYJiwooSxzYdpwJ4qCZHBI/r9pB2C4Sn/uWQMWFJV4d
 38IOYUtJfH63lw3CTpZo3X6ZHWSkhECJxJIF6hBhe4mLe/6CtTILZEjMbl8K9a+sxNRT66Di
 fBK9v59AjeeV2DEPxlaUuDfpKTRIxSUezlgCZXtIPJl+C2yOkEC5RPvEb+wTGOVnIXlsFpJ1
 ELaVROeHJtZZQNcxC0hLLP/HAWFqSqzfpb+AkXUVo2RqQXFuemqxaYFRXmo5PLqT83M3MYJT
 rZbXDsaHDz7oHWJk4mA8xCjBwawkwru/ryJJiDclsbIqtSg/vqg0J7X4EKMpMKImMkuJJucD
 k31eSbyhiaWBiZmZmYmlsZmhkjjv6fQNiUIC6YklqdmpqQWpRTB9TBycUg1MHYbXpB1Wn9yu
 wDFbVJ0rR6NBTtnh4ze2N78+XHldnmVdy6idm261LfVNpKKROI9U0EP9M4GHyqLd6hZpffwT
 cNww+a/ww7U23PpHj0zPYK5K0WdqP67xU3tVR8Wj1FkLZym+XvLlu+pLLsVajlcPBd3aGTc3
 R/yM22U55YSrIq97RmeLcmxUxXYBndLga8aqoZ7imdXTXf3+3bp7I8t3t3sha4rDj4nTmx7d
 e8J+mWerQprFUueH/JXJydZFEk81pzM/v8X0utn6vkWwxI+IO4kSrfXH9x4PfK1/YtbEPVyv
 Tu6ZdIH9NH9yuWKKn8XNa3Zhnz5Kc5kvlE2dFPI/Ia8lf5nV6pUSKRs16pRYijMSDbWYi4oT
 AX4Lvbg+BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSnO7coMokg1sTWCyaJvxltvi/5xib
 xet/01ksVq4+ymQx6dA1Routt6Qt5i97ym6x7vV7FgcOj4nN79g9zt/byOKxaVUnm8fmJfUe
 u282sHl8fHqLxaNvyypGj8+b5AI4orhsUlJzMstSi/TtErgyVrRPYyqYzlzxufcfUwPjXaYu
 Rk4OCQETib2nV7J1MXJxCAnsZpRYP+MlI0RCXKL52g92CFtYYuW/5+wQRU8YJR7sfcUKkmAR
 UJH4tnMRSxcjBwebgKbEhcmlIGERAR2Jy50/wOqZBV4xSvy/2gM2VFggUOL1kV42EJtXQFfi
 8KKLYHOEBMolWnfvYoSIC0qcnPmEBcRmFjCTmLf5ITPIfGYBaYnl/zhATE6gtTtuV4NUiAoo
 SxzYdpxpAqPgLCTNs5A0z0JoXsDIvIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhK
 tDR3MG5f9UHvECMTB+MhRgkOZiUR3v19FUlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwX
 EkhPLEnNTk0tSC2CyTJxcEo1MAVOuCFUOtFTreI6i8yddUdySwTMMyvFO6yY/16yND1ufc9g
 8emttYWt8xYcPzyNOSFbe4X4lx1np2S4eUpetp+banTN5eK07e9Uzsz2q7C8n9R79k2q9H2X
 VzN8vu7p262r8e6pPidXS/x7t4R7se/r3ZY+6r9e+WNiyupi0x3dk+JCyv//VPz5RfXSrFWf
 QvO7anV/Bn6a3T1V5dRzvmV1H7M/PuIN33XCX+Nbv0PVf1dj46e6P7dybZE85CRUGsL26Y31
 5lmKktxRnps/uj44/eLSj540b4e8R+++qXOxTWMJtM1dvWxqvq+Wa6KZqLWbrXP9qrDfa65z
 n/kc4uCv8vOk1U/T6bKlWh1+skosxRmJhlrMRcWJADH6c8oBAwAA
X-CMS-MailID: 20220509174253epcas5p32b0db87bb4d35c82c08b33d073a171c2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----KqMzgBRJR.Fsk82YJsMcER2lgAm37zzR_kphVf-KeEbAMdws=_5573f_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220509090735epcas5p372dacbf5a9615ebb97ac8156694866c2
References: <CGME20220509090735epcas5p372dacbf5a9615ebb97ac8156694866c2@epcas5p3.samsung.com>
 <YnjZovrfnF0YYuvN@kili>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_001811_037854_ED0F348E 
X-CRM114-Status: GOOD (  11.74  )
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

------KqMzgBRJR.Fsk82YJsMcER2lgAm37zzR_kphVf-KeEbAMdws=_5573f_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, May 09, 2022 at 12:06:42PM +0300, Dan Carpenter wrote:
>The "ret" value is not set if "ns" is zero.
>
>Fixes: 86116c2f6fee ("nvme: wire-up uring-cmd support for io-passthru on char-device.")
>Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

This change is already present in the branch.
Folded during -
https://lore.kernel.org/linux-nvme/20220506150357.2443040-1-nathan@kernel.org/

------KqMzgBRJR.Fsk82YJsMcER2lgAm37zzR_kphVf-KeEbAMdws=_5573f_
Content-Type: text/plain; charset="utf-8"


------KqMzgBRJR.Fsk82YJsMcER2lgAm37zzR_kphVf-KeEbAMdws=_5573f_--

