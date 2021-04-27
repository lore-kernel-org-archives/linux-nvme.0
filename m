Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B95CC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 07:09:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20165601FC
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 07:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20165601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gTIAsToIPmDSI6nC03+ioB6H9cbWbPpXkWmDGjmuv4Q=; b=nJ1OVr92jKrG8Q7ZewKrwmBQ2
	5LFf9gVU/aOdWgDsLORwmK34OfVTxxdxlxd01s54jmSQ2NnwGYb2G/EIvORd00H2T3slzr6XPBHjG
	wFCWeWRxlZ6gSCfmvyYX0A4yN+Phxw8HKoAwO86ffkksacusuBBdrj6zbdCgs7wbOhaVfF+x6AoNc
	1HqwPVQz+pmlISTSAxgs8L1z0P2gChtJwlxLwFd8Mltsb/2RXF5UJclU0e8zKXRd/vvLJ3T9UTRzR
	Bq/C8y21qrb6btTPTAmKaKkqdRdAKJtGbTT78I8zLcL+H4TT/iB5P4FjyQdxYejIr8bwmQR7jzFQ5
	U5GJawyJQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbHqY-000vSN-Fn; Tue, 27 Apr 2021 07:09:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbHqU-000vR7-OR
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 07:09:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=hwVIZoduimXHkDCkhRjQA6XbeyIrDjQ6GoK5RVw5XLQ=; b=O5TYGQ/+nl9ReZAMfW07IaBUn5
 lo3b6lLU1shyLUf8vwElXtQwdKPISA+e6LW9/8h/mkETyCunA2rChloKFLv19c3Yr2J9sfZJI70jo
 fhEZyBinm+QF+TXm2xeIxOVAL4gHKaXLxNgKIrNXqHM5Q3DXGmYuwcPhiIeC/ReINNgBPWdlgv9vu
 L4XDnR9vob8dZgpW4ZjV4daP3nOF8lnG+WTHSmdDY3lAhEl5acbf/1SboXl0fv0iTQCc9zhUbRyeg
 RUl296+lJSbU2IlSjyy8sm9EUujjj4oqQ5KR4rrisg36MLORBbUu1ftULdtnVzcsiCNjBw3ohxfnk
 aw3Bwy0g==;
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbHqM-00GUeY-JV
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 07:09:21 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20210427070901epoutp034b2f582c8ef06f4cf77065e04dd565cc~5pVjUzP6W3238132381epoutp03-
 for <linux-nvme@lists.infradead.org>; Tue, 27 Apr 2021 07:09:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20210427070901epoutp034b2f582c8ef06f4cf77065e04dd565cc~5pVjUzP6W3238132381epoutp03-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1619507342;
 bh=hwVIZoduimXHkDCkhRjQA6XbeyIrDjQ6GoK5RVw5XLQ=;
 h=From:To:Cc:Subject:Date:References:From;
 b=V7I8Ua3DN+tjgvF1yr6zYQfNgNaxtoaFB5FGKPzz7imM6ScIidSVele22n75km4Cw
 CD3RuG4ytYDc8sH5o/IbnRfe+gidITT+v68mJh/aw3smc6xeotRMmQCJ8lw9Xe1osh
 Ic+wDgi0VlJKJ1pes+3jzR8IeZGSduEGlo8pl0Fw=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20210427070901epcas5p211fa8450b7e27594afbd192a32a86d68~5pViu6xlb0948209482epcas5p2J;
 Tue, 27 Apr 2021 07:09:01 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 CD.27.09606.D88B7806; Tue, 27 Apr 2021 16:09:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20210427064849epcas5p424de8d9686fc422ecb80540d57d040f1~5pD6Rd33J2186521865epcas5p4Q;
 Tue, 27 Apr 2021 06:48:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210427064849epsmtrp2556ee3f8162d1c2d2e36c76f5616120f~5pD6QpigF2752727527epsmtrp2N;
 Tue, 27 Apr 2021 06:48:49 +0000 (GMT)
X-AuditID: b6c32a49-bdbff70000002586-57-6087b88d0d60
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 B7.7E.08163.1D3B7806; Tue, 27 Apr 2021 15:48:49 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210427064848epsmtip1835c8c330306e7f0445f0806d22b6f54~5pD4yEedY2288022880epsmtip1Y;
 Tue, 27 Apr 2021 06:48:47 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, chaitanya.kulkarni@wdc.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v3 0/2] kref and passthrough cleanup
Date: Tue, 27 Apr 2021 12:17:45 +0530
Message-Id: <20210427064747.5988-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7bCmlm7vjvYEgwdr+CyaJvxltph1+zWL
 xcrVR5ksjv5/y2Yx6dA1Rov5y56yW2z7PZ/Z4sqURcwW616/Z7F4/eMkmwOXx/l7G1k8Nq3q
 ZPPYvKTeY/fNBjaPvi2rGD3aD3QzBbBFcdmkpOZklqUW6dslcGXM/LuQqaCRpWLdhSb2BsbZ
 zF2MnBwSAiYS614uYeti5OIQEtjNKPFzyWNWkISQwCdGiR0L0iASnxkl9i14C9TBAdbxfpY6
 RHwXo8SX9huMcEVPNs5iAiliE9CUuDC5FMQUEQiUOPVYGmQms4C7xO0nPUwgtjDQmKVP37OB
 2CwCqhJzXv1jBLF5BcwlXi15yAhxnLzEzEvf2SHighInZz5hgZgjL9G8FeQBLqCat+wSE3cf
 gWpwkbj8aDk7hC0s8er4FihbSuLzu71sEHaxxK87R6GaOxglrjfMZIFI2Etc3PMX7H5moPvX
 79KHCMtKTD21jgliMZ9E7+8nTBBxXokd82BsRYl7k56yQtjiEg9nLIGyPSSWrOpjgwRorMT2
 CyuYJjDKz0Lyzywk/8xC2LyAkXkVo2RqQXFuemqxaYFhXmq5XnFibnFpXrpecn7uJkZw8tHy
 3MF498EHvUOMTByMhxglOJiVRHjZdrUmCPGmJFZWpRblxxeV5qQWH2KU5mBREucVdK5OEBJI
 TyxJzU5NLUgtgskycXBKNTCVHN6Up73ixN2Dd7/cPO92K7lJpeqh59lIO82XE3b/Wp0zT5dt
 574nbN06Z1oPymhZ6mR77pBfXzSr8GbuSr2LhS9lLYIvSE6cyLWy/9+rmyZlzw031iUrn8jc
 VtB4JvG6qdG0LbmT9GwXh+7+F+Tc87Vx5aezNSwW88OM8zXEzwZrh9x+llKmpM785tCBB2dW
 dFzc9kYrZ+nLp7m6p/7oT7RsePPwT7z7o1+mLjMZnl2NfPzkOvsD0YNJ3oVL5COdtr4xWLXp
 xengCXOCX3TVf0pqEYiNMw0seH7BxuDIfe+wQlXO37xvdU5r/gpXKA/Su7l90532v9PenNuk
 phl85LFstYdw6oyzc6Z/Z/SXVWIpzkg01GIuKk4EAORonJStAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSnO7Fze0JBvufy1s0TfjLbDHr9msW
 i5WrjzJZHP3/ls1i0qFrjBbzlz1lt9j2ez6zxZUpi5gt1r1+z2Lx+sdJNgcuj/P3NrJ4bFrV
 yeaxeUm9x+6bDWwefVtWMXq0H+hmCmCL4rJJSc3JLEst0rdL4MqY+XchU0EjS8W6C03sDYyz
 mbsYOTgkBEwk3s9S72Lk4hAS2MEocWb1NaYuRk6guLhE87Uf7BC2sMTKf8/ZIYo+Mkp87F7P
 BtLMJqApcWFyKUiNiECoxPK301hAwswCnhLrJ8qDhIWBxi99+p4NxGYRUJWY8+ofI4jNK2Au
 8WrJQ0aI8fISMy99Z4eIC0qcnPmEBcRmBoo3b53NPIGRbxaS1CwkqQWMTKsYJVMLinPTc4sN
 C4zyUsv1ihNzi0vz0vWS83M3MYIDWUtrB+OeVR/0DjEycTAeYpTgYFYS4WXb1ZogxJuSWFmV
 WpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9OqSof27OMLawQbMnrq
 PmsEX/F5EmmQ5L7ieNDCzksW2nPqp3WFH0059k9LWerWu/2Hvp7b1RLDvb/zSrPtXbOpiR0C
 S5+9MZAyDljK+cZdwigvxV+82e9o/L9/bjXzNd/9mB2r36Z23LzFYruO7NsZG5O7HWfns1lf
 T/fP13Kwu6dd6hFuM0tZ+eSkf192VZbcCr9sLOetmJkQEq80KdggcEbcpCv/EmpWPJy+nUPw
 vzG7oJUYf+K3HQdf8qilPTxW1alz8UMKt+aLJOef2dm1SUZR1XXP965gsaw9/2PB44cnNzkF
 pZ/5uufq97JNW2wkNu6/fGSJ+tkFr5IeNz/Me5Gy5b+54JZVm5Xs/JVYijMSDbWYi4oTAb2/
 SODTAgAA
X-CMS-MailID: 20210427064849epcas5p424de8d9686fc422ecb80540d57d040f1
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210427064849epcas5p424de8d9686fc422ecb80540d57d040f1
References: <CGME20210427064849epcas5p424de8d9686fc422ecb80540d57d040f1@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_000916_016592_6D01B0F0 
X-CRM114-Status: UNSURE (   9.81  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

first patch is to avoid opencoding ns->kref, while second one to remove
double memset in passthough io path.

since v2:
- [patch 2] applied Chaitanya's feedback
- [patch 1] collected "reviewed-by"

since v1:
- [patch 2] move clearing-cmd part to nvme_setup_cmd (Christoph's feedback)

Kanchan Joshi (2):
  nvme: add nvme_get_ns helper
  nvme: avoid memset for passthrough requests

 drivers/nvme/host/core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
