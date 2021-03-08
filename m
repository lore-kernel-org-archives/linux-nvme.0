Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDBDC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 19:19:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3332965295
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 19:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3332965295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GEpmE5pVV+sRfX6XK6tC9gTxV5NlAxmoEL5ELJgfjiA=; b=kbnZO0yQ3+5OaFJ+xZh2/HZKT
	8wuQEOordS73anQo95A2jV+hW2BQb0DMEV/sKZHyuveKNFhXQ/RBAeppJEO8Rs1EU5mHxSKnxhHPe
	OqVuqeoFGQ+Sfia0Lg/d8KV4JkNyI5hurYtVmjrilJLi0h01F959pbTN1Ih0mqR+twvZwZYRuS0VR
	vtA34gBvgiF4EOshxQyeIALDf+KlDhsmvV+uKzKpAj2zDqpbt0aQipc+FcBv+4Y4IXTiaztV35YlA
	awO97S47CsMPPTVV3CXNKsX9UF/Vwnu5S2IBA66n7gw4ZPUvfUaBXf3hi6jFjZpewcOgONYTc1LTg
	GC4k5/wPA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJLP7-0022Pu-6p; Mon, 08 Mar 2021 19:18:57 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJLP2-0022NU-L0
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 19:18:55 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20210308191848epoutp03ddcf2efcb8dd0517c1763a5adf9174e6~qdCcv310E1211512115epoutp03n
 for <linux-nvme@lists.infradead.org>; Mon,  8 Mar 2021 19:18:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20210308191848epoutp03ddcf2efcb8dd0517c1763a5adf9174e6~qdCcv310E1211512115epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1615231128;
 bh=1jzVdLycVvS0ZpUpUp403FdXJiMPJf3ohzf0US6u2xU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GTk6SRTCciaoABOemNiS5c67AOyKZ8mN4fsu4f0baxaR6Ms2LNXdUq4ppue5QE4Dx
 yGB5MHbPpXqdcG09V53Nm0UivZUc6OdmJ10rnzXpdb3LmflYLcBgR0cbi9nDPX4hi3
 qhLodx3ocsbZxIe06V9pQXziL+KHcsyokf+dlBwU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20210308191847epcas5p322b374c962b5d4008764d2892f046a95~qdCcRgW_o1328913289epcas5p3o;
 Mon,  8 Mar 2021 19:18:47 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 15.06.15682.79876406; Tue,  9 Mar 2021 04:18:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20210308191846epcas5p38986c0cecce3eb3530cdbd4c66b9ed06~qdCa73xzF2991229912epcas5p31;
 Mon,  8 Mar 2021 19:18:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210308191846epsmtrp28d485109a3361ac8df26a16adffc8979~qdCa7M2DF1790917909epsmtrp23;
 Mon,  8 Mar 2021 19:18:46 +0000 (GMT)
X-AuditID: b6c32a49-8bfff70000013d42-3c-60467897cc17
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 09.A1.13470.59876406; Tue,  9 Mar 2021 04:18:45 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210308191844epsmtip257845c06ad5e9fa65143f6bbc906b8aa~qdCZ1ODSr0220002200epsmtip2z;
 Mon,  8 Mar 2021 19:18:44 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com, Kanchan
 Joshi <joshi.k@samsung.com>
Subject: [PATCH 1/2] nvme: use NVME_CTRL_CMIC_ANA macro
Date: Tue,  9 Mar 2021 00:48:03 +0530
Message-Id: <20210308191804.8582-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308191804.8582-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZdlhTU3d6hVuCweV9Ehb/9xxjs1i5+iiT
 xdH/b9ksJh26xmgxf9lTdosrUxYxW6x7/Z7Fgd1jYvM7do/z9zayeGxa1cnmsXlJvcfumw1s
 Hn1bVjEGsEVx2aSk5mSWpRbp2yVwZXT09bMW/GStePWvj7mBsZG1i5GTQ0LAROJk8ySWLkYu
 DiGB3YwSi07/YIdwPjFKbPm4Asr5xigx7ekLZpiWm2tfM0Ek9jJKdO5ohur/zChx+c12xi5G
 Dg42AU2JC5NLQRpEBJQk/q5vYgEJMwtkSDw6owsSFhYwl7gw/x07iM0ioCqx49VTsPm8QPHH
 CzugzpOXmHnpO1gNp4CFxOndi1ghagQlTs58wgJiMwPVNG+dzQxygoTAW3aJvhVTGSGaXSTm
 3pwAdbSwxKvjW9ghbCmJz+/2skHYxRK/7hyFau5glLjeMJMFImEvcXHPXyaIozUl1u/Sh1jG
 J9H7+wlYWEKAV6KjTQiiWlHi3qSnUDeLSzycsYQVosRDYu85J0jodDNKvOmfzjqBUX4Wkhdm
 IXlhFsKyBYzMqxglUwuKc9NTi00LDPNSy/WKE3OLS/PS9ZLzczcxghOMlucOxrsPPugdYmTi
 YDzEKMHBrCTC29vjnCDEm5JYWZValB9fVJqTWnyIUZqDRUmcd4fBg3ghgfTEktTs1NSC1CKY
 LBMHp1QDk/si7ejzE+pSNnXtUDt2Md7z9Lzl61reKUbfm39p/5ol1ho+bq49c6/Pu9vQ82GT
 nyqD/hfP36Vqwc1Vhvu71Ptr/MREp03u6lyoF32qoCawgXHbffHFU7pu2H9QnGv45sj80j8r
 VNhvb93mKWp96ThXt4+0Uly80ZSgXe37wzwl959scP5aYDh3PavY4Y99P3/PvnjENnf+3tNm
 Xyvell0pcPQUkVNoee/TcDLdvanl+nMz116/vQE1B++E5015xmux4tM/G+fEL8bdx58ztD9X
 7eYrfnp6wUzNoHlv3k/snXVnasDMlOcVvbUL7JVPur4sy838YPC9iy/48ePKZOt7837ZmU3b
 rJy855vNeSWW4oxEQy3mouJEAEDeZnafAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvO7UCrcEg89brCz+7znGZrFy9VEm
 i6P/37JZTDp0jdFi/rKn7BZXpixitlj3+j2LA7vHxOZ37B7n721k8di0qpPNY/OSeo/dNxvY
 PPq2rGIMYIvisklJzcksSy3St0vgyujo62ct+Mla8epfH3MDYyNrFyMnh4SAicTNta+Zuhi5
 OIQEdjNKPN7ZwwaREJdovvaDHcIWllj57zk7RNFHRoktTzYxdzFycLAJaEpcmFwKUiMioCTx
 d30TC4jNLJAnsb25A2yOsIC5xIX578DmsAioSux49ZQZxOYFij9e2AF1hLzEzEvfwWo4BSwk
 Tu9eBBYXAqqZ8/kmVL2gxMmZT6Dmy0s0b53NPIFRYBaS1CwkqQWMTKsYJVMLinPTc4sNCwzz
 Usv1ihNzi0vz0vWS83M3MYLDW0tzB+P2VR/0DjEycTAeYpTgYFYS4e3tcU4Q4k1JrKxKLcqP
 LyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqganP9Ynpsa/KmSanN7xn44+5
 1LxU3tp5j+m75Veri52Pvk057mmRwR+qy1PwfcNjPdVb8yuP/LZ+qnTTVX3BefezJ8NszdX2
 rbb0uTqzT/xGVratvOO5xxcOSZXXr+0KW7tg+scZW04FycuorH4VW6bBYFf0Snzz/LeVcZua
 L61jd7+nrT9VJmK7j9O8Cfulzi1mnhFafvD0PEvGCWF267rFMzf+9btbOa09+cK0L7VXyhby
 MLp2vZ7nGvrV9KxzhP7jrhMdneekg95FrTpXfjP36fHoUBGres6/4Sns5/K4xffWy390v/pb
 /51v1KJcTnYXpdzLPM92CxpcDH0/SfVOJc8uZ5bka+sZXCZkKCmxFGckGmoxFxUnAgCCDSBu
 3gIAAA==
X-CMS-MailID: 20210308191846epcas5p38986c0cecce3eb3530cdbd4c66b9ed06
X-Msg-Generator: CA
CMS-TYPE: 105P
X-CMS-RootMailID: 20210308191846epcas5p38986c0cecce3eb3530cdbd4c66b9ed06
References: <20210308191804.8582-1-joshi.k@samsung.com>
 <CGME20210308191846epcas5p38986c0cecce3eb3530cdbd4c66b9ed06@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_191853_246994_97614FC7 
X-CRM114-Status: GOOD (  14.98  )
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

use the macro instead of hard-coded value.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..e82407d1ec23 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -745,7 +745,7 @@ static inline void nvme_trace_bio_complete(struct request *req)
 static inline int nvme_mpath_init(struct nvme_ctrl *ctrl,
 		struct nvme_id_ctrl *id)
 {
-	if (ctrl->subsys->cmic & (1 << 3))
+	if (ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA)
 		dev_warn(ctrl->device,
 "Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.\n");
 	return 0;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
