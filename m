Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646E5C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 06:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=9mVJDiSkjk40m3CNmjuTvvwn83NnZG1c76sTHJRzlKI=; b=eFpehn/y5mnBmDodWm/9M9BJSW
	e0yBN7u9GVYAEiJjn/7YxIPhqRfJ+sjHgcqrvK66XGN7gc7wUd+cvy1UOtWJWBgX2Sp0f+i76T1rF
	dmhw2K5t6NVaS19YlfEETj+0/gVGzFN1cg8zgoRd4mNEU0p0K4iHFB9kS78qbs0XiO++NgfzI189L
	pOLuiyX9uf/k67Ylh0A+qt2cDGg/tYCHvaE2iohDN5OJl8ZiIaiQ1Pn03jUOiL29SWdpK35SB6lJ/
	o91sp3wdLGkeOKK7Q1cVQ9OPXN9pqjwOarcDykZuZ3agPrMKRvuNiv4EpgcuKOCQERst3Hq/HoAH6
	Vvi/kK7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqr1T-00Bsto-PH; Tue, 17 May 2022 06:49:35 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqr0W-00BsKA-9g
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 06:48:38 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20220517064825epoutp04d423bba1c7e670b877e46b9a4373becd~v0adrq9zm1140411404epoutp04R
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 06:48:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20220517064825epoutp04d423bba1c7e670b877e46b9a4373becd~v0adrq9zm1140411404epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652770105;
 bh=9mVJDiSkjk40m3CNmjuTvvwn83NnZG1c76sTHJRzlKI=;
 h=From:To:Cc:Subject:Date:References:From;
 b=eRGCwnWZjQHjLWefCmmKvpVzJf1Ww9LcKg6UhISGGy5yGzShoJyMJAVANd3HuYDsN
 JC5dQcuRlni+Di0TKnfzWXMwqH8AUpsnpsLLVZB0GpIz+rofKlBe68lACAAVYpUxTF
 Ae9E6Tw9GEopBsKrHlksASE5rl7LmevnvMYtMY/I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20220517064824epcas5p38e486f1d61c4915b47392a629772cbf9~v0adY33fM1159211592epcas5p3L;
 Tue, 17 May 2022 06:48:24 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4L2RXP0p6Gz4x9Q9; Tue, 17 May
 2022 06:48:21 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C7.16.09827.33543826; Tue, 17 May 2022 15:48:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20220517053710epcas5p374ddc759e51f3adb243a5e98f5038699~vzcQCYJLZ1102511025epcas5p3r;
 Tue, 17 May 2022 05:37:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220517053709epsmtrp1e3af8855d73e8221a89faa7ffeb94373~vzcQBb-aW0103601036epsmtrp1h;
 Tue, 17 May 2022 05:37:09 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-6f-62834533d93e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 C2.1D.08924.58433826; Tue, 17 May 2022 14:37:09 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220517053708epsmtip1db54b14e1b0c6aa49163ba36086a63b5~vzcPEkeb71464814648epsmtip1c;
 Tue, 17 May 2022 05:37:08 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
Subject: [PATCH 0/3] uring-passthrough for admin commands
Date: Tue, 17 May 2022 11:01:44 +0530
Message-Id: <20220517053147.7925-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmuq6xa3OSwZ5pphar7/azWdw8sJPJ
 YuXqo0wW598eZrKYdOgao8X8ZU/ZHdg8ds66y+5x+Wypx6ZVnWwem5fUe+y+2cDm0bdlFWMA
 W1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
 ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE
 7Iyz23awFbxjr/i4qbqBcQVbFyMnh4SAicSGl9MYuxi5OIQEdjNKXJx7iB3C+cQosWP3fKjM
 Z0aJo59fssC0TJt8hAUisYtRYu/qNcwIVcfmAGU4ONgENCUuTC4FMUUEjCRuv40B6WUW8Je4
 sn4fO4gtLGApcW/RE7CZLAKqElu3/wGL8wqYS1zqaoM6T15i5qXvUHFBiZMzIeqZgeLNW2eD
 rZUQOMYuMWn6fFaQXRICLhIb7jJC9ApLvDq+hR3ClpJ42d8GZSdLtG6/zA5RXiKxZIE6RNhe
 4uKev0wgYWag49fv0ocIy0pMPbWOCWIrn0Tv7ydMEHFeiR3zYGxFiXuTnrJC2OISD2csgbI9
 JP41fgTbJCQQKzFtZ+IERvlZSH6ZheSXWQiLFzAyr2KUTC0ozk1PLTYtMMpLLYfHaXJ+7iZG
 cDrU8trB+PDBB71DjEwcjIcYJTiYlUR4DSoakoR4UxIrq1KL8uOLSnNSiw8xmgIDeCKzlGhy
 PjAh55XEG5pYGpiYmZmZWBqbGSqJ8wr8b0wSEkhPLEnNTk0tSC2C6WPi4JRqYFrBff+MQdG9
 vCxrrzK5H7e0+TtjTol9ZpirtUhdPlVHYKnrtmq+nbt4P1tz7fHYHax1p+BWTrfbTaP4BXqc
 j298OCZZMfHZxeTVa9rVjO9zz3/6zXdh7qV3kcc35NqqrI4J3yTHL1rjKXeqtP59eXuMz3XZ
 KV6VB1lbVaQa/HZu/tYaNun2vWaLOvd3+a83nWPSvnV2+SSLVX+mWBwst/L+1Rca2BPndfd5
 94N/06o7dh3fO2FGfd2/B4sUt3YvKGtkkSmNl626es2mfvfC22f/3zy1p3HmYrWAw/Yu33Om
 r1AOM7kcp9o6v71hsge7qNsdEZlLFQsSZuVn8Ea6/63oX7Xztt0h1x9bZh/o+qXEUpyRaKjF
 XFScCAC5YUfBEAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSnG6rSXOSwevDlhar7/azWdw8sJPJ
 YuXqo0wW598eZrKYdOgao8X8ZU/ZHdg8ds66y+5x+Wypx6ZVnWwem5fUe+y+2cDm0bdlFWMA
 WxSXTUpqTmZZapG+XQJXxtltO9gK3rFXfNxU3cC4gq2LkZNDQsBEYtrkIyxdjFwcQgI7GCUm
 fXrEBJEQl2i+9oMdwhaWWPnvOTtE0UdGiTkftwMVcXCwCWhKXJhcClIjImAmsWDBPBYQm1kg
 UKK75z6YLSxgKXFv0RMwm0VAVWLr9j9gM3kFzCUudbVBHSEvMfPSd6i4oMTJmU+g5shLNG+d
 zTyBkW8WktQsJKkFjEyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCA1RLawfjnlUf
 9A4xMnEwHmKU4GBWEuE1qGhIEuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZq
 akFqEUyWiYNTqoGJyyyo8mTTny1ParaeybFI3L0obXnsJLkJTFJmlgdPR3209Xnsk70yQEUo
 YN/+q5fVpyzOuX1k1g2v83Yzdt9Q1Ns3uZ75MeeZCznp5aXVSfstdx+SV1Jyj1inc/267Cvl
 XfN8duYFGC09o7fVdqOFucJeH/2mJJmoN8LSdremCot+jZ0yMzK9/Ok2/mmsHTeL3yZ/tCs7
 tn9uxp0ZOd8OWYQ1HXpuMrN18uZCw+3ePl/bX1rqRNwuTttQue2j+fd5b302zpphtt7z8vK5
 G9yN5q+e/kLycIqp+JQI9r9cK8WEm3rC7hs4rP7Xs1h64edXc2KjJGZ+dHl/Zy/XF78dOtM5
 qpe+ev9rZu/C7Q+rSpRYijMSDbWYi4oTAUR5jgO/AgAA
X-CMS-MailID: 20220517053710epcas5p374ddc759e51f3adb243a5e98f5038699
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517053710epcas5p374ddc759e51f3adb243a5e98f5038699
References: <CGME20220517053710epcas5p374ddc759e51f3adb243a5e98f5038699@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_234836_909330_85AD37F3 
X-CRM114-Status: GOOD (  12.21  )
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

During the review rounds and LSFMM, it emerged that uring-passthrough
for admin-commands will also be useful. So this series wires that up.

Prepared against for-next (linux-block) on top of
commit cef3f8e4ed04 (Merge branch 'for-5.19/block'...).

Patch 1 is prep.
Patch 2 adds new opcode for admin uring-passthrough, and enables it over
ns char device (/dev/ngXnY). It reuses the code of io-command
passthrough, with the only difference that commands are issued on admin
queue.

Patch 3 enables the same for controller char device (/dev/nvmeX).

Kanchan Joshi (3):
  nvme: helper for uring-passthrough checks
  nvme: enable uring-passthrough for admin commands
  nvme: admin command uring-passthrough on controller node

 drivers/nvme/host/core.c        |  1 +
 drivers/nvme/host/ioctl.c       | 83 +++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h        |  1 +
 include/uapi/linux/nvme_ioctl.h |  1 +
 4 files changed, 77 insertions(+), 9 deletions(-)

-- 
2.25.1


