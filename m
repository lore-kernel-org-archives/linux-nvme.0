Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D644C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 12:06:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68B26140F
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 12:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68B26140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=lgLzqsJ8OA5svMYFO8kXuOVubXzp4NPSCGe0YI+/M28=; b=UpRs5jMn8/v68+7GPoYx6kY5v
	xSRUIJD5yBWCbPlDHDB1auUZbRhQw2WKiawcpmqXpmaKoVkIijEkn1Oi0/5Ln2glDOGjJpOa/CY7f
	8j1D5qkgRf2krlPRkKbrTwIh/9yPZbsz8b7avcTLG5ekRKbVCZZDycGoDSJE41IGvOjCj22u70ITw
	1rt5jqyJLL2K5lTuVw/2wk7W/9RGGlpjZ3pJXyqxBOM0fBj6bOdlufBBtyonweoXa3KTKdvmWXOvr
	KRyrBL0igrhJ7iX4R0/8vJ9otFLh2i+v96oArklTL6p80n5+4fNs5KqN7DOGoFC0xiIc8S8GiHsKO
	GKAMQuSzQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZY5e-00GeX9-Ie; Thu, 22 Apr 2021 12:05:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZY5a-00GeWP-Sr
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 12:05:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=Ey5tA1Fcws3WQWMzjR1/H2OHlvI4p65kRGulsnxJl3w=; b=fiAcNnZNKslL7ZDnsCE3F37mtE
 ZrjUms7kMeV1oMbi4EdHKC4yp8h44rhplx3JumKJSXQxkJbArOURrSI6v22zAnR2S4ZLWoIKSZXz+
 PnIVZU/5+EurY/BrWHdH0dFUMwmH2MxO9sG8LUK+juqlyJk0VABO45BjRs9Ve9o2gdWGlGNthCqKw
 oPhNAkg4R9jKCJcV12d8UwneS2BFdR3hpAFoQppMp9OR37s9gPUht77w0bMMZDntWh8/MdV2aJXRP
 C6G4EooNyCrmunw7cqr4wGIRxnjMGmPiFnG4l9U5Z8U+s7QtX9g28wVxsR60fVUdrhDnm5zhSlQ+z
 Y6OH0Ctw==;
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZY5V-00DePl-K4
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 12:05:45 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20210422120535epoutp01a4de8442135e28160aeca52f0bfce711~4LKD86CTw2251922519epoutp01g
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 12:05:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20210422120535epoutp01a4de8442135e28160aeca52f0bfce711~4LKD86CTw2251922519epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1619093136;
 bh=Ey5tA1Fcws3WQWMzjR1/H2OHlvI4p65kRGulsnxJl3w=;
 h=From:To:Cc:Subject:Date:References:From;
 b=SbDFNRuBErTjrpvKMTbsq6xeTUJ3zi6nSHzMBmd38A6tnExYrC6n0M3tYCX0vROaX
 qTu8DjXN3vGUW0pmCAml1dahNQQ/bOh2nMiulKU5+yr30uxqXeWReb/U8QjjUw7EBI
 QunXGbLC1Mfn996gznG/WBzW82U4J8gBT2m8C/Ro=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20210422120535epcas5p44db5e1a2156e40450d08eb6b846a557c~4LKDdNJbV0064700647epcas5p4C;
 Thu, 22 Apr 2021 12:05:35 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 97.E1.09835.F8661806; Thu, 22 Apr 2021 21:05:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20210422115540epcas5p24913e1f452b1f0637f863c25327f31a4~4LBZm8gRI1178011780epcas5p2X;
 Thu, 22 Apr 2021 11:55:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210422115540epsmtrp2589d9073644861eefe956843c20a2e22~4LBZmD-al3114931149epsmtrp2E;
 Thu, 22 Apr 2021 11:55:40 +0000 (GMT)
X-AuditID: b6c32a4b-7dfff7000000266b-85-6081668ff5bb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A0.E8.08637.C3461806; Thu, 22 Apr 2021 20:55:40 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210422115539epsmtip2d7ad782950ecc772ac3d134447b72307~4LBYJxuyh2877828778epsmtip2E;
 Thu, 22 Apr 2021 11:55:39 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 0/2] kref and passthrough cleanup
Date: Thu, 22 Apr 2021 17:24:25 +0530
Message-Id: <20210422115427.63636-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7bCmum5/WmOCwYTJ4hZNE/4yW6y+289m
 sXL1USaLo//fsllMOnSN0WL+sqfsFtt+z2e2uDJlEbPFutfvWSxe/zjJ5sDlcf7eRhaPy2dL
 PTat6mTz2Lyk3mP3zQY2j74tqxgD2KK4bFJSczLLUov07RK4Mt682MJYsIK54uaN24wNjJeZ
 uhg5OSQETCReTN4NZHNxCAnsZpQ4ufUQO4TziVFi/ucLbBDON0aJZweWMMO0XPyxhRUisZdR
 4nPXbXaQhJDAZ0aJ+6tquxg5ONgENCUuTC4FCYsIuEg0/HvDCGIzC7hL3H7SwwRSIgw0Z/bn
 QpAwi4CqxNxpj8DG8wpYSMx/eYkRYpW8xMxL39kh4oISJ2c+YYEYIy/RvHU2M8gJEgIv2SVm
 L3vABtHgIrF2w1GoO4UlXh3fwg5hS0l8frcXqqZY4tedo1DNHYwS1xtmskAk7CUu7vkLdhwz
 0P3rd+lDhGUlpp5axwSxmE+i9/cTaNDxSuyYB2MrStyb9JQVwhaXeDhjCZTtIdH7dDYrJHhi
 Jd6dvMw2gVF+FpJ/ZiH5ZxbC5gWMzKsYJVMLinPTU4tNC4zzUsv1ihNzi0vz0vWS83M3MYKT
 j5b3DsZHDz7oHWJk4mA8xCjBwawkwru2uCFBiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+gc3WC
 kEB6YklqdmpqQWoRTJaJg1OqgWnWRO/QXLEdNw89CGm02uGRwWFQ616p9vyCLvuSmkLrGJNs
 EbeTqlHMwQtXm0b4Hf77XXzCr++Vjise6y8IFPz5MH/GM7H6TWc2hZ9r/37uUKzCucDXKkyv
 xcUtbgg/jNy9sOuX9Zv0FJPGyeuW8k/703x8+ZlAvaWRzA597zt+Mp8IK1XuVrvgfaC7aubR
 rfJMlve98s90rJMOifVVPH9S3fniO/3jG9z03y96WPVEfPc+tgCtFfJ94cuVWa49y7sWlOe6
 7ch7+ea/O3ozN+Z+mK/088/pyW9LZHUFv/k6N4tMadrzIGAOx7Xli4RUTy4r3NyQ9n/aguRn
 jd+77/x5a1QTOfmuTIXuOotHPJuVWIozEg21mIuKEwFe1NALrQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSvK5NSmOCwYNDGhZNE/4yW6y+289m
 sXL1USaLo//fsllMOnSN0WL+sqfsFtt+z2e2uDJlEbPFutfvWSxe/zjJ5sDlcf7eRhaPy2dL
 PTat6mTz2Lyk3mP3zQY2j74tqxgD2KK4bFJSczLLUov07RK4Mt682MJYsIK54uaN24wNjJeZ
 uhg5OSQETCQu/tjC2sXIxSEksJtRYveKM+wQCXGJ5ms/oGxhiZX/nrNDFH1klNix5gRLFyMH
 B5uApsSFyaUgNSICXhLzZi8ACzMLeEqsnygPYgoDzZ/9uRCkgkVAVWLutEfMIDavgIXE/JeX
 GCGmy0vMvPSdHSIuKHFy5hMWEJsZKN68dTbzBEa+WUhSs5CkFjAyrWKUTC0ozk3PLTYsMMxL
 LdcrTswtLs1L10vOz93ECA5jLc0djNtXfdA7xMjEwXiIUYKDWUmEd21xQ4IQb0piZVVqUX58
 UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTMt4l7TMYT555IvV3q3qAS9s
 ni35zXekZvvEtGeGHq61pc9re1Zt4shOrmjN9P7647FbX93yJquSDmOHwgenLimWrFzoeT77
 lfVE+4fuajJvxOdax87y0TdOPall9WFF8vyXc9erLi1OubdQMoc/ti2l8pLZ2rDX+Q/OWuml
 L1grZXbKIeOWlt3ad8H2IuxaHpXSZ6s+bg93378wdFGM0twPGTN/TnytbFHnnt/uEN6j0qfs
 0tK80H1ORptfs9t5JqUl1x1YuI+oPeYIepq8JZkpYOmv35kOP9+EbuMO4b1l5taY8DJ8bVQc
 V7PCm5OsRxZ474t0/PDT/oXX1MUbTM6eelW0Oc1DydnmeVeWEktxRqKhFnNRcSIA0q1X0tIC
 AAA=
X-CMS-MailID: 20210422115540epcas5p24913e1f452b1f0637f863c25327f31a4
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210422115540epcas5p24913e1f452b1f0637f863c25327f31a4
References: <CGME20210422115540epcas5p24913e1f452b1f0637f863c25327f31a4@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_050542_253637_551C7707 
X-CRM114-Status: GOOD (  12.94  )
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

first patch is to avoid opencoding ns->kref, while second one is to remove
double memset in passthough io path.

since v1:
- (patch 2) move clearing-cmd part to nvme_setup_cmd (Christoph's feedback)

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
