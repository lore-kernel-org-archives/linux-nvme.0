Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083EAC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Oct 2022 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:MIME-Version:Content-Type:Message-ID:Date:Subject:
	CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=3+Cgrw/jozLMVTqnnJQlZNyE/gNCMcmbUCywMpV8GCs=; b=b8x3Xxy4UnJsDoq5nKtynApa8Z
	eyFH187GzJ/j69GyXPnHGIRwN4b+sFgi+m+PftJgQ3W56j/fe+hnr2KT0erereQ6z3x7Z2jxkpdix
	E2ggJUU+1Txw00kmfRNGOrr04hHtY6wyI3ropA8vGiIcQF2cxf/QiVgHYv4dcWQ3KQoGx+dy6znCb
	Wzx4I61dDMteN7sa6e8t3mFE1E6liu1HBJkgf8BujADdyRGQZPKViwx0A+0vq+5vH81+Sz/s9j1rv
	yhnXF99gVGZk4z25ExqxJJhUMg+qOn9D24kkT/Nyf2OGFczAU8iKrWIjCZabqgPgHaQo852wuhKN+
	fiZBfLHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ognNU-0095to-NP; Fri, 07 Oct 2022 13:27:00 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ognNK-0095r0-1v
	for linux-nvme@lists.infradead.org; Fri, 07 Oct 2022 13:26:53 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221007132637euoutp01a0e28d677645c7f034a711edcd266443~bzF9fHH0A1635716357euoutp013
	for <linux-nvme@lists.infradead.org>; Fri,  7 Oct 2022 13:26:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221007132637euoutp01a0e28d677645c7f034a711edcd266443~bzF9fHH0A1635716357euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1665149197;
	bh=3+Cgrw/jozLMVTqnnJQlZNyE/gNCMcmbUCywMpV8GCs=;
	h=From:To:CC:Subject:Date:References:From;
	b=cWgdPwVx3sHLRQY6X6dbydTi/sO6G5SPHHtD1wSgl9mtss9nEuv/yCWUw8vMeEVyf
	 8ivCsjkJTQcVHmeWMe4gIJ6gZwaap9oN1nS5DwYyjNoGrDCjThtqWxHJLUKqVP6kEP
	 CC4CY9Mx2lzq3bQFl2vkyPG7qDeMnvO/Jz3OTlko=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221007132636eucas1p1481a390aba0aa0faf48a1505ea2fd80f~bzF9LRPy40771007710eucas1p1G;
	Fri,  7 Oct 2022 13:26:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 70.99.07817.C0920436; Fri,  7
	Oct 2022 14:26:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221007132636eucas1p207b5f2e42f831bd7cb4c15f6e6ae4758~bzF86-CLQ0617506175eucas1p2A;
	Fri,  7 Oct 2022 13:26:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221007132636eusmtrp213fe0c7a498c39092b80cdb46d1c2e45~bzF859fGV2144721447eusmtrp23;
	Fri,  7 Oct 2022 13:26:36 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-d7-6340290cf82e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 90.57.07473.C0920436; Fri,  7
	Oct 2022 14:26:36 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221007132636eusmtip2a66ab77abea7e94a16966a5c0e4462b1~bzF8vqaLP1543015430eusmtip2C;
	Fri,  7 Oct 2022 13:26:36 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 7 Oct 2022 14:26:31 +0100
From: Joel Granados <j.granados@samsung.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, <javier.gonz@samsung.com>,
	<gost.dev@samsung.com>, <joshi.k@samsung.com>, Joel Granados
	<j.granados@samsung.com>
Subject: [RFC 0/2] nvme : Add whitelist for admin commands in passthru
Date: Fri, 7 Oct 2022 15:22:54 +0200
Message-ID: <20221007132256.2543136-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsWy7djPc7o8mg7JBrPuGVusXH2UyWLSoWuM
	FvOXPWW3WPf6PYsDi8f5extZPDat6mTz2Lyk3mP3zQa2AJYoLpuU1JzMstQifbsErozFLxvY
	Cw6JVew784GxgXGCUBcjJ4eEgInEl3Vd7F2MXBxCAisYJebPPgblfGGUuDb7IhuE85lR4sSV
	JWwwLZPvPGSGSCxnlHi5dBUTSAKsaudFS4jEJkaJU9vnsYIk2AR0JM6/ucMMYosIWEocvnKZ
	CaSIWWAW0MKDE8ESwgJuEqeW7wCzWQRUJLb3tTCC2LwCthITet+xQKyWl2i7Ph0ozgHUrCmx
	fpc+RImgxMmZT8BKmIFKmrfOZoYoV5TYMuc7K4RdK/HgTQ/Y1RICOzgkVh3dxQoyR0LARaK/
	LRyiRlji1fEt7BC2jMT/nfOZIOxsiZ1TdkHNLJCYdXIqG0SrtUTfmRyIsKPE7Fuf2SHCfBI3
	3gpCXMMnMWnbdGaIMK9ERxs01NUkdjRtZZzAqDwL4ZVZSF6ZheSVBYzMqxjFU0uLc9NTi43y
	Usv1ihNzi0vz0vWS83M3MQITyOl/x7/sYFz+6qPeIUYmDsZDjBIczEoivDt32iUL8aYkVlal
	FuXHF5XmpBYfYpTmYFES52WboZUsJJCeWJKanZpakFoEk2Xi4JRqYMo7dG7ud4vmqU8LYx2n
	/za7xj5PXvUOw6lrpyQ0l0y0SjLa7/Yuwin/df37G9zdbGdFmrn2e/K7/Shs0/mR1NkeYPx4
	MvPevZsMY3da7SliXT5vmePzjO6oi4kLuR5Ovndn8gVWuWlKHFsD2qJ9yiyS226xsWe2LpyS
	0PJKZ9KLFUbB8aGLVYWSVhlM+jLhzK3O1m0FZwN/cfbPE2av1K+e+nIBc7gGZ38op10ug2aP
	ZPrl1/f1FBS0P3zYxDnz8MtQBiVV9oSjnPa90rMvywo17WpskDjWJ7atqdk379i209MeMsmc
	vLjhWK2vdsSk2ONVk1kajq7XWr1X4lMZd0bDnszVgi6xXpy5bUqWSizFGYmGWsxFxYkAaKaq
	PI8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t/xe7o8mg7JBp//KVmsXH2UyWLSoWuM
	FvOXPWW3WPf6PYsDi8f5extZPDat6mTz2Lyk3mP3zQa2AJYoPZui/NKSVIWM/OISW6VoQwsj
	PUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzFLxvYCw6JVew784GxgXGCUBcjJ4eE
	gInE5DsPmbsYuTiEBJYySszZN40VIiEj8enKR3YIW1jiz7UuNoiij4wSU1tuQTmbGCWWXH3M
	DFLFJqAjcf7NHTBbRMBS4vCVy0wgRcwCsxgl5h+cCJYQFnCTOLV8B5jNIqAisb2vhRHE5hWw
	lZjQ+44FYp28RNv16UBxDqBmTYn1u/QhSgQlTs58AlbCDFTSvHU2M0S5osSWOd+hrq6V2PR6
	PdMERqFZCN2zkHTPQtK9gJF5FaNIamlxbnpusaFecWJucWleul5yfu4mRmDUbDv2c/MOxnmv
	PuodYmTiYDzEKMHBrCTCu3OnXbIQb0piZVVqUX58UWlOavEhRlOgbyYyS4km5wPjNq8k3tDM
	wNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgSmhsXXHynl8R29NuasTv07u
	quGrmMXnsj4b/pGzvjWL/6v42umHPk+P3ne5utE1YN7/o1kbO++c3Ol5Vmv7/Yu9b2YccGsW
	nXbIavZSOSvR6U5/Doh4BbYJfWB61LzlFvPkjNltD/hMeWbeulV57te1nA2cO9cvzUnin/WA
	vyv5YJG0gEHhlh/7FGoOn8ld8nqDndnNfYcP6BReUrGvFC3M/nNG5JvIhBXi/67u4JIIlS4s
	/xSnaui0T8F+T4xrZPWVe0HJrI8ONEftzTw4T/pEwMEPXu/cTJvEZuZsM6recEX3cE48x46g
	Z/4GobHqAiEvFVtuvnDPYHYwvnbtU9Xd+UvSsme8zbn06Fzu0mU3lViKMxINtZiLihMBkxZ6
	uSMDAAA=
X-CMS-MailID: 20221007132636eucas1p207b5f2e42f831bd7cb4c15f6e6ae4758
X-Msg-Generator: CA
X-RootMTR: 20221007132636eucas1p207b5f2e42f831bd7cb4c15f6e6ae4758
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221007132636eucas1p207b5f2e42f831bd7cb4c15f6e6ae4758
References: <CGME20221007132636eucas1p207b5f2e42f831bd7cb4c15f6e6ae4758@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_062650_529536_4B07002E 
X-CRM114-Status: GOOD (  21.80  )
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

What?
In this patch set we implement a dynamic whitelist for admin opcodes that
will allow the privileged user to define what opcodes can be used by the
unprivileged user in the passthru path. Applications will not only be
restricted by the whitelist, but will also need write permissions for the
device.

There are questions at the end of the cover letter for people to chime in.
I'll take these comments and hopefully send a V1 soon after.

Why?
Applications with write permissions should not need to be privileged to
write to the device. With Kanchan's latest patch
(https://lore.kernel.org/linux-nvme/20220927183620.12583-1-joshi.k@samsung.com/)
the nvme IO commands in passthru now follow device permissions however
privileged execution is still needed for admin commands like identify that
usually come before the actual write.  This patchset removes this requirement.

We can't foresee what subset of the existing admin commands will be used
nor what new ones will be added to future versions of the nvme
specification. Therefore we go with a dynamic whitelist instead of a
hardcoded one.

How?
We added an ioctl (NVME_IOCTL_PTHRU_WLIST) that controls adding, removing
and testing admin opcode to the whitelist for the passthru path. It can
only be used by privileged users (CAP_SYS_ADMIN).  Given that the nvme
identify opcode is usually needed to generate IO, we add it to the
whitelist by default.

I have rebased this on top of Kanchans "nvme: fine-granular CAP_SYS_ADMIN
for nvme io commands"
(https://lore.kernel.org/linux-nvme/20220927183620.12583-1-joshi.k@samsung.com/)
because this only makes sense if we can also do IO as unprivileged.

Questions:
1. I initialize the whitelist at the end of nvme_core_init. I put it there
   as I saw that that is where the module specific stuff what being
   initialized. Is there another function that is better?

2. Scope of the whitelist is the driver. There is only one whitelist for
   all the nvme devices. You can further control which devices use the
   whitelist with device file permissions. All devices with WRITE
   permissions are able to execute all whitelisted opcods. Any comments?

3. I went with the ioctl name of NVME_IOCTL_PTRHU_WLIST. Are there
   alternatives?

4. I have left the nvme_admin_identify cmd active by default as it is the
   one that I think would be used for simple most IO commands. Comments?

Joel Granados (2):
  nvme : Add dynamic whitelisting for passthru
  nvme : Add ioctls for passthru admin whitelisting

 drivers/nvme/host/core.c        | 10 ++++++++
 drivers/nvme/host/ioctl.c       | 43 +++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h        |  1 +
 include/linux/nvme.h            |  1 +
 include/uapi/linux/nvme_ioctl.h | 14 +++++++++++
 5 files changed, 67 insertions(+), 2 deletions(-)

-- 
2.30.2


