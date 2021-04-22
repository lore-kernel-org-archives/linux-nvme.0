Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C757C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 12:06:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752BB6140F
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 12:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752BB6140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9QVy/vmRxb+J+pFODCO+OXjsxyq9FrmL9iVGJ6vhxHA=; b=Gj1F3F/XowqAs9KFrzubV7/V2
	VcaiAe0XtJ1KHijupozGfBZmFzaR8kfGKSuIQ3jIEcFDuCjpYRNuPUOgK+GFrSl5l+BJ++EjFxtsk
	JHxn880sa3QQSEbS0s6/p3XW/lIr5MwRA1Wb2KNvmv/byX61IqA6rQxGEN4ihimm1u9FMHmr4mfKQ
	hzJmWNjVkAIo78kJ5zLaC5S62PtPo/T0bvVICfWv+OO1RQefiLzQRzEP7lARjaJRymtz6abuW2ZuP
	xaR0hFtG5wJjR2r09h2RrNkDmV/Yf4iPvTXo3x7LSY0CQU0orkv9dgG7lDCyRKuU5aaP0764zG+oe
	AU8HxQpkg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZY5u-00GeZ7-Ia; Thu, 22 Apr 2021 12:06:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZY5s-00GeYk-1S
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 12:06:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:Content-Type:
 Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
 :To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=FyTr1yMxDNEZAOhdG6vckVf6jLRuxSZrJfwM43d7o2A=; b=TI85j0uW+yZMbt9yY26Fo9/CaW
 r4qJCAQCW8u1ym9UayzeXCJWYA8vZ3u1rsPpZWjKQ4+XsSQRVOudF3c18hqONptcDZDgWsqPAaXrz
 Bji1ToPr/1P+K9nmX/J5qd0PHsjvebmxlL5xGK1E1uQZGj7zJum40tblCQ/fImuX7SS8oOeDoeZEo
 GxtQtdr1hAVXaepdQ1r00Ozl6Lb1rIknelHZ7v1em7hBVDWwCmWdNW5D78Nh0pYHSJ1fWWlfRTQ+6
 QescAYqxufQ31PMNm8FCvItFRo9i3tGQRK4r8JAkvquPOTlIZjxxl+3/KPZIj4s1EeJmXRPUyXVWM
 JLtOSs/g==;
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZY5o-00DeQf-W4
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 12:06:02 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20210422120556epoutp03bc0e7abd4dafa9dd8bfab5acbefc86b0~4LKXKZyJo1702317023epoutp031
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 12:05:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20210422120556epoutp03bc0e7abd4dafa9dd8bfab5acbefc86b0~4LKXKZyJo1702317023epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1619093156;
 bh=FyTr1yMxDNEZAOhdG6vckVf6jLRuxSZrJfwM43d7o2A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qXuzjCpazwmx2QJECAJA0+G2pIsY9s9DImjMgc9MfpXEVCKr2/SVhiZ/QomZOwXVD
 ni1gptHg4EIIJWAJfHEysDiK83KDKfakQ/X6SZus9t99kLRSCsx9WWn8XbrgoD4fF1
 i081x2AfALJxlyU7YM6ddHcXxW6ZKz8ttJfeQOUk=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20210422120556epcas5p2821c0236cdbb172beb30cab4e816c891~4LKWxevQp2514025140epcas5p2a;
 Thu, 22 Apr 2021 12:05:56 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C0.46.09697.4A661806; Thu, 22 Apr 2021 21:05:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20210422115544epcas5p28181653112f3a66df5f5396ab746ed37~4LBdjNHBw1567215672epcas5p2h;
 Thu, 22 Apr 2021 11:55:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210422115544epsmtrp17362ea9736d7afc79bb3d90e5bc88f3d~4LBdiYsuB0261402614epsmtrp1U;
 Thu, 22 Apr 2021 11:55:44 +0000 (GMT)
X-AuditID: b6c32a4a-64fff700000025e1-d0-608166a41dcc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 F1.E8.08637.04461806; Thu, 22 Apr 2021 20:55:44 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210422115543epsmtip219988a58660876909103cba28fc63bca~4LBcB4Fba2877828778epsmtip2I;
 Thu, 22 Apr 2021 11:55:43 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 1/2] nvme: add nvme_get_ns helper
Date: Thu, 22 Apr 2021 17:24:26 +0530
Message-Id: <20210422115427.63636-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210422115427.63636-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7bCmpu6StMYEg1/HWC2aJvxltlh9t5/N
 YuXqo0wWR/+/ZbOYdOgao8X8ZU/ZLbb9ns9scWXKImaLda/fs1i8/nGSzYHL4/y9jSwel8+W
 emxa1cnmsXlJvcfumw1sHn1bVjEGsEVx2aSk5mSWpRbp2yVwZfza9pex4AtXxYSz9Q2MrZxd
 jJwcEgImEm3bvrB1MXJxCAnsZpSYdHk3C4TziVFizoTVTBDON0aJOzPamLsYOcBajnxLgIjv
 ZZS4eOUrVPtnRomZLyaygxSxCWhKXJhcCrJCRMBFouHfG0YQm1nAXeL2kx4mEFsYaM7E42fZ
 QGwWAVWJmx0vWUFsXgELiacv37JDnCcvMfPSdzCbU8BSYvOKl4wQNYISJ2c+YYGYKS/RvHU2
 M8gNEgKNHBIdXw6wQBzqItH/lRVijrDEq+NboGZKSbzsb4OyiyV+3TkK1dvBKHG9YSYLRMJe
 4uKev0wgc5iBflm/Sx8iLCsx9dQ6Joi9fBK9v58wQcR5JXbMg7EVJe5Negq1V1zi4YwlULaH
 xK4n19khYdXDKPFt1h22CYwKs5D8MwvJP7MQVi9gZF7FKJlaUJybnlpsWmCUl1quV5yYW1ya
 l66XnJ+7iRGclLS8djA+fPBB7xAjEwfjIUYJDmYlEd61xQ0JQrwpiZVVqUX58UWlOanFhxil
 OViUxHkFnasThATSE0tSs1NTC1KLYLJMHJxSDUzbz77nUjumFlb+U2T/u8LAJ6afJ07hncVR
 /8+nxXufEy9n4BIRAbfi298ir/E2ptqJvlq14YNz/9MbyyP9W24y5XXpP2nYdN7lByt7euCd
 Gdn8W+Q7Gh7uqCw/t/Gg4q3lGy5pLeKc9ohZZr0f+081Y0sxl116a07k/Lyhc9bqhbHz9Yer
 7ix49pL35hkJTfUVufYsKhEHN+y8eKo2o5Mv5nlD2fe3J2e7Pv9VJdp+X7PRJKes1vjsj4+G
 Zz88PFrO+SZIf1eZ4f+v1iXtp3paz2yMy8pmTuvh3iSxonLT/MnNNz9dZbt0z5ovQ9xd58GV
 K3n7/55aNfcOa8XSj17bjvyx92Ipe3DwZ/X6rJadSizFGYmGWsxFxYkAw1NvnLkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSvK5DSmOCwe11RhZNE/4yW6y+289m
 sXL1USaLo//fsllMOnSN0WL+sqfsFtt+z2e2uDJlEbPFutfvWSxe/zjJ5sDlcf7eRhaPy2dL
 PTat6mTz2Lyk3mP3zQY2j74tqxgD2KK4bFJSczLLUov07RK4Mn5t+8tY8IWrYsLZ+gbGVs4u
 Rg4OCQETiSPfEroYuTiEBHYzSizccZqli5ETKC4u0XztBzuELSyx8t9zdoiij4wSvde2M4I0
 swloSlyYXApSIyLgJTFv9gIWkDCzgKfE+onyIGFhoPETj59lA7FZBFQlbna8ZAWxeQUsJJ6+
 fAs1Xl5i5qXvYDangKXE5hUvGUFsIaCaR7M/skDUC0qcnPkEzGYGqm/eOpt5AqPALCSpWUhS
 CxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBAe9luYOxu2rPugdYmTiYDzEKMHB
 rCTCu7a4IUGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkG
 piOfikrVz888qOP6MctTOiu3dHeHuoSFNsuzN7qd93x6Fnzxfm8h9CGOV/bMlA6XA/ZtKrNl
 yn6lHDda/vnhzLilxfnx85avbHUJ2G797t+x7Aafz4cCH0z4JLvio2OUnPQZAedF57kran9n
 hb5l+vlLYNLhTzUZYrL5RQZbdu1N++tbNW+t3WHzVkerBbvOLJfn2Gb2glPmAdcsIdmJ1muU
 HSq85h1etsKJId46Tfbg/yD+yDvSG/W3BBWpc7XVhjnb/Fb9euxXvr1ii/GVrimb/ZnXmM85
 yRs4T/1T1ElzlecePQ0sOqweS+tZTx7+Y3V+3dQlvJvX3z+m3PJVvywnV3n2mYyPzqI1nyT5
 lViKMxINtZiLihMBan9vGOkCAAA=
X-CMS-MailID: 20210422115544epcas5p28181653112f3a66df5f5396ab746ed37
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210422115544epcas5p28181653112f3a66df5f5396ab746ed37
References: <20210422115427.63636-1-joshi.k@samsung.com>
 <CGME20210422115544epcas5p28181653112f3a66df5f5396ab746ed37@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_050601_394075_77D7E103 
X-CRM114-Status: GOOD (  14.08  )
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

Add a helper to avoid opencoding ns->kref increment.
Decrement is already done via nvme_put_ns helper.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2f45e8fcdd7c..f6d7c397f2ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -576,6 +576,11 @@ static void nvme_free_ns(struct kref *kref)
 	kfree(ns);
 }
 
+static inline bool nvme_get_ns(struct nvme_ns *ns)
+{
+	return kref_get_unless_zero(&ns->kref);
+}
+
 void nvme_put_ns(struct nvme_ns *ns)
 {
 	kref_put(&ns->kref, nvme_free_ns);
@@ -1504,7 +1509,7 @@ static int nvme_ns_open(struct nvme_ns *ns)
 	/* should never be called due to GENHD_FL_HIDDEN */
 	if (WARN_ON_ONCE(nvme_ns_head_multipath(ns->head)))
 		goto fail;
-	if (!kref_get_unless_zero(&ns->kref))
+	if (!nvme_get_ns(ns))
 		goto fail;
 	if (!try_module_get(ns->ctrl->ops->module))
 		goto fail_put_ns;
@@ -3613,7 +3618,7 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		if (ns->head->ns_id == nsid) {
-			if (!kref_get_unless_zero(&ns->kref))
+			if (!nvme_get_ns(ns))
 				continue;
 			ret = ns;
 			break;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
