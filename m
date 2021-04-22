Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D1FC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 12:06:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B72B61422
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 12:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B72B61422
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J8zMt4hwQUu+VT33oFon2/2gKEtpujqB58iA2UMIJrs=; b=ccX0R6f0MoVt71npQWdZdhfje
	5tSR2qpaz42AXoBcGAxcvFKQyZfZfPAtF5wAFbWlWpbT7Bor3pUNg327iUMkrADjesseFzVHfth1U
	9pwxSa2ROmrLzwcQAfg0dxWZySrRdypFyoSak58+v2y3VYdmaeboHv3XS4ulQ/bF3J6vngRBfK3QE
	loCx3d7wfrhlNKw4byL3HeSxWURfiGsTK/tOgzVhmfI479d2NKv7LfU6oFfoHGZw5wne0sMFPXxcW
	7WhL8LOGZSXHmehmBwo4jzyLwp4bWyv773UTpHHHUMH4Lmfhd/z7DSrgIxRjToAWczuViFD+wdngO
	uR7eN+STA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZY65-00Geas-ON; Thu, 22 Apr 2021 12:06:17 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZY63-00GeaS-Ev
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 12:06:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:Content-Type:
 Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
 :To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=76Wh/SSPNroo57zkdXpRREimvdHQ3BYbv9xQ65Wakgw=; b=t4imhGMauBxI95V4m3unA5eL3I
 A9Esn64DJ5vpchjqkU1hYXdT3Rr1uSik9YH96bP5sg+mWtMQQJOIJTIHkfllyF5Z4QFzeowur8PNR
 OSs2CVuUrkt9LVq3eh2BUdQ3KY2Ks6W96siGPpYZX0WrYZXAGQ91ofmymNCOkE5ou8RzIQgzRKBB/
 0GIuU1hXRnZ4lhi8iuf9u3h8fsWLqnxeyLkQDJenWpFWKs9TGCvpMt9CTj17EtGKaQkGU8Fhp85vO
 SvEQ4PV1nRQi7dS61VxS2iDYkv/ypEYuN2dG19cRBNQupXIka00gLUWCeK+aqCn4rmAw5UrECtocB
 +ZKZBybw==;
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZY60-00DeRM-Lh
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 12:06:14 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20210422120610epoutp039b4b558ca957b401defaec0bd88627ba~4LKkJiJlq1744517445epoutp03n
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 12:06:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20210422120610epoutp039b4b558ca957b401defaec0bd88627ba~4LKkJiJlq1744517445epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1619093170;
 bh=76Wh/SSPNroo57zkdXpRREimvdHQ3BYbv9xQ65Wakgw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RUONC+dCNRXNCA7nJyMZvJWukTZTeuMTN99aKzg2S2QjZXgTnFUKMc3wK5mGYFx+7
 uXSToE1M6WN/Cos21BR1aHwSGgOKjx9W9SaNvsjaFC85FSe/gqKZdssbZhx7UyMb1b
 lokQ1CJKUvyRiaAoYxnBZhwj/8Q/vLZQoKQiGrI8=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20210422120610epcas5p4652bf5a17a023f1f75a3f4552195cb6d~4LKjuu0b02624526245epcas5p49;
 Thu, 22 Apr 2021 12:06:10 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 F4.46.09697.1B661806; Thu, 22 Apr 2021 21:06:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20210422115548epcas5p319a909cbe43a627aa4a5ad5490fa810e~4LBgsbIrX2612126121epcas5p3O;
 Thu, 22 Apr 2021 11:55:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210422115548epsmtrp17c86083fb58976bf3a34691687a1fd9b~4LBgrqMvu0340503405epsmtrp1L;
 Thu, 22 Apr 2021 11:55:48 +0000 (GMT)
X-AuditID: b6c32a4a-639ff700000025e1-ef-608166b17618
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 1E.08.08163.44461806; Thu, 22 Apr 2021 20:55:48 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210422115546epsmtip248f365083fe1bee53437be7e39452e8d~4LBfGNO3S2887428874epsmtip2C;
 Thu, 22 Apr 2021 11:55:46 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 2/2] nvme: avoid memset for passthrough requests
Date: Thu, 22 Apr 2021 17:24:27 +0530
Message-Id: <20210422115427.63636-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210422115427.63636-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7bCmlu6mtMYEg95ZTBZNE/4yW6y+289m
 sXL1USaLo//fsllMOnSN0WL+sqfsFtt+z2e2uDJlEbPFutfvWSxe/zjJ5sDlcf7eRhaPy2dL
 PTat6mTz2Lyk3mP3zQY2j74tqxgD2KK4bFJSczLLUov07RK4MqYv/cJYsJKrYs+rhewNjNc5
 uhg5OSQETCT6e86xdzFycQgJ7GaUuLT8FhOE84lRomXhHDYI5zOjxLVLj5lgWpa/2csIkdjF
 KPH17l4muKrFK3YzdzFycLAJaEpcmFwK0iAi4CLR8O8NI4jNLOAucftJD9ggYQFnieMbroLZ
 LAKqEvNWTQar4RWwkJi0qA1qmbzEzEvf2UFsTgFLic0rXkLVCEqcnPmEBWKmvETz1tnMIDdI
 CDRySDTsnskC0ewi8Wj1U3YIW1ji1fEtULaUxMv+Nii7WOLXnaNQzR2MEtcbYJrtJS7u+csE
 8gwz0DPrd+lDhGUlpp5axwSxmE+i9/cTqEN5JXbMg7EVJe5NesoKYYtLPJyxBMr2kJh6tJ8V
 Elg9jBJ3ezcyT2BUmIXkoVlIHpqFsHoBI/MqRsnUguLc9NRi0wKjvNRyveLE3OLSvHS95Pzc
 TYzg1KTltYPx4YMPeocYmTgYDzFKcDArifCuLW5IEOJNSaysSi3Kjy8qzUktPsQozcGiJM4r
 6FydICSQnliSmp2aWpBaBJNl4uCUamAy7L39aHLeLVNG3qUGnxluP9FY4eumYznrl9+3JDbj
 Ku/84PLSlCbLoKvvZj+uSzzT1hc0YaJFwNpnefM+aNTq895UjWNvdHK/7f2Uy7Y3/9Cm/xVt
 XtI7XwcXh/qKfeGW2tu+8bPLU42CrIBPMnwna73zJCO3Cv7myLbz6FptGT21TUYo9f7SyzGv
 vB0Olj8PmF2leHqlq+bpJ08iZvU0G9TPzdiYfsrkQ/NONR6+joCOlA8L9nLfKOE/VR1d2zBV
 avq816Gej9pmTXy+qjjiZtcmowKnnQveXqiz/RCk1ylSeefA0Rb1pNY/R2TT6r987Z8h8vfg
 76hlm8ILuY91KHmLcvDHsAjn3ju1TImlOCPRUIu5qDgRAIknTf28AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSvK5LSmOCQWcjn0XThL/MFqvv9rNZ
 rFx9lMni6P+3bBaTDl1jtJi/7Cm7xbbf85ktrkxZxGyx7vV7FovXP06yOXB5nL+3kcXj8tlS
 j02rOtk8Ni+p99h9s4HNo2/LKsYAtigum5TUnMyy1CJ9uwSujOlLvzAWrOSq2PNqIXsD43WO
 LkZODgkBE4nlb/YygthCAjsYJfrWFUHExSWar/1gh7CFJVb+ew5kcwHVfGSUmNb4h62LkYOD
 TUBT4sLkUpAaEQEviXmzF7CAhJkFPCXWT5QHCQsLOEsc33CVCcRmEVCVmLdqMtgqXgELiUmL
 2pggxstLzLz0HWwVp4ClxOYVL6HOsZB4NPsjC0S9oMTJmU/AbGag+uats5knMArMQpKahSS1
 gJFpFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcNhrae1g3LPqg94hRiYOxkOMEhzM
 SiK8a4sbEoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg
 ihJs+KkfIHBnsdX7WUabLmQdvrlQsOXyn4pLBUsuRS3lt57BOOmP/YXS05sYNonfWa3+/pv1
 7+PK/Gwv7/O/z7h9XvrDjb+HVJc4GhVaH5ks0rd9un/Ylit7pC1Kv85JMA/+9CT9sLRq1iXL
 9zfUdvCk68fENWu3S7Ew22xy83q6vyzdamWM2XwT7/5JqYv5HjCVh2lZ+bCFBL6Us2HWNOjr
 eVESdKynomvBjdWXz124mbugUMPu0BunqnDWJ0Kxzz+4pcQ95Jqky1sw5ZD30xWXlq/hcM43
 K4jyiNxx9fTcGVvyL5pICR90uaksr+h4In/GKVW+vz/j7ur29YQcvjLpVcTlVze+7J7D8XHl
 DSWW4oxEQy3mouJEAIP+TZTqAgAA
X-CMS-MailID: 20210422115548epcas5p319a909cbe43a627aa4a5ad5490fa810e
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210422115548epcas5p319a909cbe43a627aa4a5ad5490fa810e
References: <20210422115427.63636-1-joshi.k@samsung.com>
 <CGME20210422115548epcas5p319a909cbe43a627aa4a5ad5490fa810e@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_050613_073800_EE20ECD4 
X-CRM114-Status: GOOD (  13.87  )
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

nvme_clear_nvme_request() clears the nvme_command, which is unncessary for
passthrough requests as nvme_command is overwritten immediately.
Move clearing part from this helper to the caller, so that double memset
for passthrough requests is avoided.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f6d7c397f2ee..a380eb3847d6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -589,9 +589,6 @@ EXPORT_SYMBOL_NS_GPL(nvme_put_ns, NVME_TARGET_PASSTHRU);
 
 static inline void nvme_clear_nvme_request(struct request *req)
 {
-	struct nvme_command *cmd = nvme_req(req)->cmd;
-
-	memset(cmd, 0, sizeof(*cmd));
 	nvme_req(req)->retries = 0;
 	nvme_req(req)->flags = 0;
 	req->rq_flags |= RQF_DONTPREP;
@@ -903,8 +900,10 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 	struct nvme_command *cmd = nvme_req(req)->cmd;
 	blk_status_t ret = BLK_STS_OK;
 
-	if (!(req->rq_flags & RQF_DONTPREP))
+	if (!(req->rq_flags & RQF_DONTPREP)) {
 		nvme_clear_nvme_request(req);
+		memset(cmd, 0, sizeof(struct nvme_command));
+	}
 
 	switch (req_op(req)) {
 	case REQ_OP_DRV_IN:
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
