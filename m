Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8D0606A339
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 01:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eMr8XNAb;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cYlnIhAU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=lOHE7yjEQ8BUcx54cPwGBEchDNr9/DzrkHiQKDP6Nz0=; b=eMr8XNAbBwBUN3
	0qtU2avgCNIM9NvczdTcS8FfAJXIP4rDoTDwHU5ljoJW+ZaJP8akdj4S5UtQm0teovpW3vL1eH1rg
	ouQDtX8kJLOiBmB9jvi9MRzOe+Dj9O+nSCYPcLCZ6b43wLo4C+h2ezeY56DFnuFRC26r6AE4zvRBJ
	ez4dL1yao1hCajLFgh3bsrmHeSDX7s3xf459i/gnlDyCHwOgKM2lqp4vwE/bGN0s1i2hlxvIcXhFf
	UFzjIZ1H3bYLicv8O4kZOMtVV6NqTgaBbSP7kNFCVDfB/X+O2WMkTXRum21WfA9dExY5JatSdqvJ/
	wOjoXKUCdtPxxHlM4BPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO3BI-00000000nLx-0Hf0;
	Tue, 03 Nov 2026 01:19:20 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO3BF-00000000nLa-2nNk
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 01:19:18 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2KERhk4074915;
	Tue, 3 Nov 2026 01:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lOHE7y
	jEQ8BUcx54cPwGBEchDNr9/DzrkHiQKDP6Nz0=; b=cYlnIhAU/Ky2+lfI0odWD4
	95Dwwq/YGsojVU0OvSGYTcU+B9x6St68R8lp3VGy9NhnRhwVb5VJk8lLCgR//ZC1
	8KmKK6IfYVf8pDTbRCqw9ae/S+SN+O+fY8kE44hHUAa41QoLLBIBnR3hrekRdx3B
	LdF/ul4Z81Easr2MeT3Q/8jzgpDRj+BQO0U8TG0jmAbS2u+jZRhN956GYEDYhmoD
	1kpX+/ceoBAPOgvLOiV2JFoW6J7iB5ZQIHKZp+23zMoVdTUbhvqLZOn2m/hmzRkO
	pL3tC/9veGyqtnb+JQARmtDJBJK2g9DLS8Y33XLS34FqBEyda82MPvvDsn0dJjjA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3bd8u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 01:19:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2K8rVU1440328;
	Tue, 3 Nov 2026 01:19:08 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hntnq0h5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 01:19:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A31IIvI25625202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 01:18:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4878258061;
	Tue,  3 Nov 2026 01:19:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E11AB58057;
	Tue,  3 Nov 2026 01:19:04 +0000 (GMT)
Received: from [9.61.129.51] (unknown [9.61.129.51])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 01:19:04 +0000 (GMT)
Message-ID: <98022e84-32f6-430e-899b-1f5cd9777183@linux.ibm.com>
Date: Tue, 3 Nov 2026 06:49:03 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvmet: fix use-after-free in passthru I/O hotpath
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, gjoyce@linux.ibm.com, chaitanyak@nvidia.com
References: <20260929112751.2985483-1-nilay@linux.ibm.com>
 <20260929112751.2985483-3-nilay@linux.ibm.com> <auhpmq499RVE9YpC@shinmob>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <auhpmq499RVE9YpC@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6ae9368d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=dgmAIkXw6Z9FE3075acA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4JMd1BjGcMMB7sK42cSihuXyW_X1TOL-
X-Proofpoint-GUID: 4JMd1BjGcMMB7sK42cSihuXyW_X1TOL-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAwNCBTYWx0ZWRfX5Opb3j3+E1CZ
 2wSUh1fEzfYg7QXYXHDlDqDLMnH97i+RN5BGXrWiK8fRzjB7twY118eruPk4y30b3EtAIUD/BTB
 kwSi3L5JHtFohywuVoZ27//2K6exZcuSXLv32zOZw+fJ3tiSvjmkYbJonJQnbd4a98PXkovaIXj
 lhiR9rUsj3vH2qLO3pMoAE3EYk4CAa6pp0lmMgSttl+W6ThRkQgxGK4M9d49XyjrPPiyHLXcoP/
 hiI6Nev2R4kxCnWRjUzJMmT4ET0OEoPoyBIOY7a43JKohIQsr5dqcJmTmOJ3CNFVw0rCDegCCRc
 8De2+0KV764KyJExWKxIPtYE9vog2S+0mydlLZJQExTkVDhyuSLsl4T9V/f8nOdoSMnr1hHfkPO
 S27R+YP3y0cr+OQafhKQkHQP7Yfk2wB3LsOiRKWbfEpH3AfFgpQOVc0zuw1NZsOxNvkE3SOguu/
 LEH5XC2oUJYOEslbWFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAwNCBTYWx0ZWRfX9Ln/XR2XoHa6
 Tx2fgv58HpFiTFJLohkbozeU2MAxhABmDyuCWSZlrVbexzqy/P5GT0O+76NGF1J4W+x2EresAP6
 RwS2LXnfMhjTgqeDoKSojHPfdijs5fo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030004
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_171917_727107_CF02E327 
X-CRM114-Status: GOOD (  21.23  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Shin'ichiro,

On 11/2/26 4:19 PM, Shin'ichiro Kawasaki wrote:
> Hi, Nilay
> 
> I ran blktests with the kernel v7.4-rc1, and found the test case nvme/037 hangs
> when it runs for rdma transport and siw driver [1]. I bisected and found this
> patch as the commit 5e12d81874a1 is the trigger. If this han is a new issue, fix
> actions will be appreciated.

Thanks for report!

I tried recreating this issue on my system running nvme/037 multiple times but
I couldn't recreate it.

Looking through the code carefully, it seems that we release the passthru request
reference in __nvmet_req_complete() after ops->queue_repsonse() returns. However once
ops->queue_response() is called, the transport may complete and recycle the request
on another CPU. If the request is reused, its req->p.ref_held field may be reset
to false before __nvmet_req_complete() checks it in nvmet_put_passthru_ref().
Consequently, the passthru reference may not be released, leaving
wait_for_completion(&passthru->disable_done) in __nvmet_passthru_ctrl_disable()
blocked indefinitely.

Based on the above, I prepared a patch[1] to fix this issue. May I ask you to
validate this patch on your system? If this works for you then I'll send out a
formal patch.

[1]
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a8171b88035c..714ac8add4c8 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -804,6 +804,7 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
  {
  	struct nvmet_ns *ns = req->ns;
  	struct nvmet_pr_per_ctrl_ref *pc_ref = req->pc_ref;
+	struct nvmet_passthru *passthru = nvmet_passthru_ref_held(req);

  	if (!req->sq->sqhd_disabled)
  		nvmet_update_sq_head(req);
@@ -822,7 +823,8 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
  	if (ns)
  		nvmet_put_namespace(ns);

-	nvmet_put_passthru_ref(req);
+	if (passthru)
+		nvmet_put_passthru_ref(passthru);
  }

  void nvmet_req_complete(struct nvmet_req *req, u16 status)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d7804bf91aaa..f8205fbfee6e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -824,6 +824,15 @@ static inline struct nvmet_passthru *nvmet_subsys_passthru(
  	return subsys->passthru;
  }

+static inline struct nvmet_passthru *nvmet_passthru_ref_held(
+		struct nvmet_req *req)
+{
+	if (req->p.ref_held)
+		return nvmet_req_subsys(req)->passthru;
+
+	return NULL;
+}
+
  static inline bool nvmet_get_passthru_ref(struct nvmet_req *req)
  {
  	if (!percpu_ref_tryget_live(&nvmet_req_subsys(req)->passthru->ref))
@@ -833,13 +842,9 @@ static inline bool nvmet_get_passthru_ref(struct nvmet_req *req)
  	return true;
  }

-static inline void nvmet_put_passthru_ref(struct nvmet_req *req)
+static inline void nvmet_put_passthru_ref(struct nvmet_passthru *passthru)
  {
-	if (!req->p.ref_held)
-		return;
-
-	req->p.ref_held = false;
-	percpu_ref_put(&nvmet_req_subsys(req)->passthru->ref);
+	percpu_ref_put(&passthru->ref);
  }
  #else /* CONFIG_NVME_TARGET_PASSTHRU */
  static inline void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
@@ -865,11 +870,16 @@ static inline struct nvmet_passthru *nvmet_subsys_passthru(
  {
  	return NULL;
  }
+static inline struct nvmet_passthru *nvmet_passthru_ref_held(
+		struct nvmet_req *req)
+{
+	return NULL;
+}
  static inline bool nvmet_get_passthru_ref(struct nvmet_req *req)
  {
  	return false;
  }
-static inline void nvmet_put_passthru_ref(struct nvmet_req *req)
+static inline void nvmet_put_passthru_ref(struct nvmet_passthru *passthru)
  {
  }
  #endif /* CONFIG_NVME_TARGET_PASSTHRU */


