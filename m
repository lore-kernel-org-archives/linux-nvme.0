Return-Path: <SRS0=ZTQI=NK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606D1C4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 14:09:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F348161100
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 14:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F348161100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=hRkIPNpTMgm/gKSrSYMeF1UNXtmTD8LJ6bMZ91wiNAc=; b=kAykKPCpj/66Nd
	r4T+bzgruP5cjxqAlg17yGABeevtMC5UYF+TyuyWqyJzYMAPD2kq1bJd/E8Kw1QAUH5/L/CjgexhI
	JpA4ZFY6X5PQ4DC4mlNkdtRXC3t0tVElu2Ol96q9lDB4R2ybnNrdawVK139ogRwTYT9W254hEuF7t
	4DuG5ZgDHDJR+CChzPkS6wFgn9r7M1a32UKsW4rodp1y9Q5I8zLzWxsYV13vsGiC0TVo4zNdYrvV0
	oGNcKGxCWviYrjPc0kr6lMFuPemMBHYbEdRn+Vb4x//OLWiHUiMHEH+zN4eollM5TPkM4ECO+ZKm6
	dWRhR6WvBGgyGckzn7Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGiim-008ZkA-Ir; Thu, 19 Aug 2021 14:08:40 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGigc-008YdU-4J
 for linux-nvme@lists.infradead.org; Thu, 19 Aug 2021 14:06:30 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20210819140620epoutp01e95dea208467f99ef55796a57b71ea3e~cukc1yzo51727017270epoutp01p
 for <linux-nvme@lists.infradead.org>; Thu, 19 Aug 2021 14:06:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20210819140620epoutp01e95dea208467f99ef55796a57b71ea3e~cukc1yzo51727017270epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1629381980;
 bh=w/Yl9BE+N06IquYHF1Bsc0L35HQsV0eIUuRcSc0QbVk=;
 h=From:To:Cc:Subject:Date:References:From;
 b=B+LPc+uniT1RsHYWRE7/PICPjtYO8sILFk33oLcUoUqJpwpkGueqUiAGEW9aQeNvz
 YSpNoAdV70KVCznwLbHGKFCTxDHPoH0hnHz7NTfrsryK0f8woDRPKGj3jlVHxbZ5IK
 hH1Chc0NopsQzqyqNvvOMaP9+5wg8yp0M5/SYzrc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20210819140619epcas5p11f33ea190bfda197598f477ca6917c20~cukbwIHX81389313893epcas5p1E;
 Thu, 19 Aug 2021 14:06:19 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4Gr64g1Fx3z4x9Pv; Thu, 19 Aug
 2021 14:06:11 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 1D.87.09595.3556E116; Thu, 19 Aug 2021 23:06:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20210819135248epcas5p1fcc9f399f16a5336e6af004170a0eea4~cuYpOY8tG2371923719epcas5p1E;
 Thu, 19 Aug 2021 13:52:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210819135248epsmtrp197b3ace4dadfd6b09aa9353e9d7856c6~cuYpMoSyl1382913829epsmtrp1T;
 Thu, 19 Aug 2021 13:52:48 +0000 (GMT)
X-AuditID: b6c32a4a-eebff7000000257b-8a-611e65535404
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 B7.41.32548.0326E116; Thu, 19 Aug 2021 22:52:48 +0900 (KST)
Received: from test.sa.corp.samsungelectronics.net (unknown [107.108.56.58])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210819135245epsmtip1375a3dc8c7ef9a2f6126769f1d0a1999~cuYmJAw7o0955609556epsmtip1f;
 Thu, 19 Aug 2021 13:52:45 +0000 (GMT)
From: Naveen Nagar <naveen.n1@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, stefanha@redhat.com,
 fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 linux-nvme@lists.infradead.org, k.jensen@samsung.com,
 p.kalghatgi@samsung.com, raphel.david@samsung.com, d.palani@samsung.com,
 prakash.v@samsung.com, jg123.choi@samsung.com, anuj.singh@samsung.com,
 anaidu.gollu@samsung.com, Naveen <naveen.n1@samsung.com>
Subject: [RFC PATCH v2] hw/nvme:Adding Support for namespace management
Date: Thu, 19 Aug 2021 18:39:57 +0530
Message-Id: <1629378597-30480-1-git-send-email-naveen.n1@samsung.com>
X-Mailer: git-send-email 1.8.3.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmlm5wqlyiwcofLBavdx5ntvj49yyj
 xduvD9gsruw/z2ix/+A3Voul8/UtTjbuYbWYdOgao8WSi6kW85c9ZbeYd0vZovHJbnaL6z8f
 sVtcmbKI2WLWu3Y2i+O9O1gs9nzZyGrxetJ/Vgchjx/n2tk8zu04z+6xaVUnm8fmJfUeT65t
 ZvJ4v+8qm0ffllWMAexR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmp
 tkouPgG6bpk5QE8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS
 9fJSS6wMDQyMTIEKE7Iznm3axVawYSJjxbO3v5gbGD9mdDFyckgImEgcfXKJuYuRi0NIYDej
 xNzdZ9ggnE+MEvOe/4fKfGaU+Pl6IxNMy46VMFW7GCUmvL7PCOE0Mkns6XnPAlLFJqAl8f3q
 NGYQW0RAUuJ312mwUcwCk5klpv3cBJYQFnCXmPT1IjuIzSKgKvHszVOgsRwcvAKuEn8n5EBs
 U5CY8vA9WK+EQC+HRMf3iYwQCReJjnezmSFsYYlXx7ewQ9hSEi/726DsYokLvf0sEM0NjBKP
 vm1ggUjYS1zc85cJZBmzgKbE+l36EGFZiamn1oG9ySzAJ9H7+wnUy7wSO+Y9ASuXEFCWOL+a
 G8KUlDg3PRmiwkPi8rn9rCC2kECsxPYN0xknMMrOQpi/gJFxFaNkakFxbnpqsWmBUV5qOTym
 kvNzNzGCE6eW1w7Ghw8+6B1iZOJgPMQowcGsJMJ77I9sohBvSmJlVWpRfnxRaU5q8SFGU2CI
 TWSWEk3OB6buvJJ4QxNLAxMzMzMTS2MzQyVxXt1XMolCAumJJanZqakFqUUwfUwcnFINTK7v
 X5xgNWH7us2yYvp1t5cnvecmJy/TPjnFd3tY0ePXM4uPtPWtSUrdH5krWfPyJtePqTY+zuIn
 J7X8VQuNcFum1RRtEqJjrXbjkdUrz2ux0r0V8ztPzHz3QEjoT8L63X8vCCmWPklRvF///F3E
 LoF5xc8PJcTuFlRZcUR+dif7syMb6pK6Zi4Q8Jyz5vO9F4cnWq6S1j0zd9rv5W+vNhQmKkvt
 fpPXtNnCZH7Wqi+7WoJKbFuuhd0xl5q+hitLq4Sj/LSjaPSL9PD5xrMm8p0ymfRalEF0X4VN
 4h7LJ3Wrwi5GfZ/qLzrl/p5DuQJ+HWa+K49cKTtxsdql9INwR6jqulOewmz7PGVStkQEMyix
 FGckGmoxFxUnAgD1oUAlJQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSnK5BklyiweuVOhavdx5ntvj49yyj
 xduvD9gsruw/z2ix/+A3Voul8/UtTjbuYbWYdOgao8WSi6kW85c9ZbeYd0vZovHJbnaL6z8f
 sVtcmbKI2WLWu3Y2i+O9O1gs9nzZyGrxetJ/Vgchjx/n2tk8zu04z+6xaVUnm8fmJfUeT65t
 ZvJ4v+8qm0ffllWMAexRXDYpqTmZZalF+nYJXBnPNu1iK9gwkbHi2dtfzA2MHzO6GDk5JARM
 JHasPMPWxcjFISSwg1Hi6uzLzBAJSYkNf7cyQdjCEiv/PWeHKPrPKPGkYz8bSIJNQEvi+9Vp
 YA0iQA2/u04zgxQxC6xklpi95hBYkbCAu8SkrxfZQWwWAVWJZ2+eAsU5OHgFXCX+TsiBWKAg
 MeXhe+YJjDwLGBlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEB7GW1g7GPas+6B1i
 ZOJgPMQowcGsJMJ77I9sohBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtS
 i2CyTBycUg1M/KlZr7oTDu75dF6//+f8hzynP+738bpZPNVweYNGW7lAUmG0yfnUbzO133cs
 NXgrd5ldw/rj7PC/HK+KFlZ8Wrag65b3hU+nckNO/S23W2Qcp7S7V5O3IsFg3rLfp6Unhd39
 om69p57/3OHeHyGCM8y2uf3mZUw5MfuF3ZfYzJNTSpeeX1AasbpGTv2zfpbRca12wb7pfnHL
 vRzaZkRIm8+V/ia5f/qd1tUSLhf+xjUr3+5SKvVt7VZeKtRZVDhJ9f+hFWq50f+d7ffNCZZd
 8sEm9Z796U7pufZHJBZ4+qp+jyjefnyrjtQrtXM3L0XaG2zTqll1eeaHL7bXdgt/EBAIiN18
 LS2nJe3gvm3RSizFGYmGWsxFxYkAhCuJydECAAA=
X-CMS-MailID: 20210819135248epcas5p1fcc9f399f16a5336e6af004170a0eea4
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210819135248epcas5p1fcc9f399f16a5336e6af004170a0eea4
References: <CGME20210819135248epcas5p1fcc9f399f16a5336e6af004170a0eea4@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210819_070626_650305_AA52C232 
X-CRM114-Status: GOOD (  28.32  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Naveen <naveen.n1@samsung.com>

This patch supports namespace management : create and delete operations.

Since v1:
- Modified and moved nvme_ns_identify_common in ns.c file 
- Added check for CSI field in NS management
- Indentation fix in namespace create

This patch has been tested with the following command and size of image
file for unallocated namespaces is taken as 0GB. ns_create will look into
the list of unallocated namespaces and it will initialize the same and 
return the nsid of the same. A new mandatory field has been added called
tnvmcap and we have ensured that the total capacity of namespace created
does not exceed tnvmcap

-device nvme-subsys,id=subsys0,tnvmcap=8
-device nvme,serial=foo,id=nvme0,subsys=subsys0
-device nvme,serial=bar,id=nvme1,subsys=subsys0
-drive id=ns1,file=ns1.img,if=none
-device nvme-ns,drive=ns1,bus=nvme0,nsid=1,zoned=false,shared=true
-drive id=ns2,file=ns2.img,if=none
-device nvme-ns,drive=ns2,bus=nvme0,nsid=2,zoned=false,shared=true
-drive id=ns3,file=ns3.img,if=none
-device nvme-ns,drive=ns3,bus=nvme0,nsid=3,zoned=false,shared=true
-drive id=ns4,file=ns4.img,if=none
-device nvme-ns,drive=ns4,bus=nvme0,nsid=4,zoned=false,shared=true

Please review and suggest if any changes are required.

Signed-off-by: Naveen Nagar <naveen.n1@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
  
---
 hw/nvme/ctrl.c       | 237 +++++++++++++++++++++++++++++++++++++++++--
 hw/nvme/ns.c         |  61 ++++++-----
 hw/nvme/nvme.h       |   7 +-
 hw/nvme/subsys.c     |   3 +
 include/block/nvme.h |  18 +++-
 5 files changed, 285 insertions(+), 41 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 6baf9e0420..992aaa7d02 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -219,6 +219,7 @@ static const uint32_t nvme_cse_acs[256] = {
     [NVME_ADM_CMD_SET_FEATURES]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_GET_FEATURES]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_ASYNC_EV_REQ]     = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_NS_MANAGEMENT]    = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_NIC,
     [NVME_ADM_CMD_NS_ATTACHMENT]    = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_NIC,
     [NVME_ADM_CMD_FORMAT_NVM]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
 };
@@ -4450,11 +4451,19 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req, bool active)
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     uint32_t nsid = le32_to_cpu(c->nsid);
+    NvmeIdNs *id_ns = NULL;
+    uint16_t ret;
 
     trace_pci_nvme_identify_ns(nsid);
 
-    if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
+    if (!nvme_nsid_valid(n, nsid)) {
         return NVME_INVALID_NSID | NVME_DNR;
+    } else if (nsid == NVME_NSID_BROADCAST) {
+        id_ns = g_new0(NvmeIdNs, 1);
+        nvme_ns_identify_common(id_ns);
+        ret = nvme_c2h(n, (uint8_t *)id_ns, sizeof(NvmeIdNs), req);
+        g_free(id_ns);
+        return ret;
     }
 
     ns = nvme_ns(n, nsid);
@@ -5184,6 +5193,200 @@ static void nvme_select_iocs_ns(NvmeCtrl *n, NvmeNamespace *ns)
     }
 }
 
+static int nvme_blk_truncate(BlockBackend *blk, size_t len, Error **errp)
+{
+    int ret;
+    uint64_t perm, shared_perm;
+
+    blk_get_perm(blk, &perm, &shared_perm);
+
+    ret = blk_set_perm(blk, perm | BLK_PERM_RESIZE, shared_perm, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = blk_truncate(blk, len, false, PREALLOC_MODE_OFF, 0, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = blk_set_perm(blk, perm, shared_perm, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
+static uint32_t nvme_allocate_nsid(NvmeCtrl *n)
+{
+    uint32_t nsid = 0;
+    for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+        if (nvme_ns(n, i) || nvme_subsys_ns(n->subsys, i)) {
+            continue;
+        }
+
+        nsid = i;
+        return nsid;
+    }
+    return nsid;
+}
+
+static uint16_t nvme_namespace_create(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint32_t ret;
+    NvmeIdNs id_ns_host;
+    NvmeSubsystem *subsys = n->subsys;
+    Error *err = NULL;
+    uint8_t flbas_host;
+    uint64_t ns_size;
+    int lba_index;
+    NvmeNamespace *ns;
+    NvmeCtrl *ctrl;
+    NvmeIdNs *id_ns;
+
+    ret = nvme_h2c(n, (uint8_t *)&id_ns_host, sizeof(id_ns_host), req);
+    if (ret) {
+        return ret;
+    }
+
+    if (id_ns_host.ncap < id_ns_host.nsze) {
+        return NVME_THIN_PROVISION_NO_SUPP | NVME_DNR;
+    } else if (id_ns_host.ncap > id_ns_host.nsze) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    if (!id_ns_host.nsze) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    if (QSLIST_EMPTY(&subsys->unallocated_namespaces)) {
+        return NVME_NS_ID_UNAVAILABLE;
+    }
+
+    ns = QSLIST_FIRST(&subsys->unallocated_namespaces);
+    id_ns = &ns->id_ns;
+    flbas_host = (id_ns_host.flbas) & (0xF);
+
+    if (flbas_host > id_ns->nlbaf) {
+        return NVME_INVALID_FORMAT | NVME_DNR;
+    }
+
+    ret = nvme_ns_setup(ns, &err);
+    if (ret) {
+        return ret;
+    }
+
+    id_ns->flbas = id_ns_host.flbas;
+    id_ns->dps = id_ns_host.dps;
+    id_ns->nmic = id_ns_host.nmic;
+
+    lba_index = NVME_ID_NS_FLBAS_INDEX(id_ns->flbas);
+    ns_size = id_ns_host.nsze * ((1 << id_ns->lbaf[lba_index].ds) +
+                (id_ns->lbaf[lba_index].ms));
+    id_ns->nvmcap = ns_size;
+
+    if (ns_size > n->id_ctrl.unvmcap) {
+        return NVME_NS_INSUFF_CAP;
+    }
+
+    ret = nvme_blk_truncate(ns->blkconf.blk, id_ns->nvmcap, &err);
+    if (ret) {
+        return ret;
+    }
+
+    ns->size = blk_getlength(ns->blkconf.blk);
+    nvme_ns_init_format(ns);
+
+    ns->params.nsid = nvme_allocate_nsid(n);
+    if (!ns->params.nsid) {
+        return NVME_NS_ID_UNAVAILABLE;
+    }
+    subsys->namespaces[ns->params.nsid] = ns;
+
+    for (int cntlid = 0; cntlid < ARRAY_SIZE(n->subsys->ctrls); cntlid++) {
+        ctrl = nvme_subsys_ctrl(n->subsys, cntlid);
+        if (ctrl) {
+            ctrl->id_ctrl.unvmcap -= le64_to_cpu(ns->size);
+        }
+    }
+
+    stl_le_p(&req->cqe.result, ns->params.nsid);
+    QSLIST_REMOVE_HEAD(&subsys->unallocated_namespaces, entry);
+    return NVME_SUCCESS;
+}
+
+static void nvme_namespace_delete(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid)
+{
+    NvmeCtrl *ctrl;
+    NvmeSubsystem *subsys = n->subsys;
+
+    subsys->namespaces[nsid] = NULL;
+    QSLIST_INSERT_HEAD(&subsys->unallocated_namespaces, ns, entry);
+
+    for (int cntlid = 0; cntlid < ARRAY_SIZE(n->subsys->ctrls); cntlid++) {
+        ctrl = nvme_subsys_ctrl(n->subsys, cntlid);
+        if (ctrl) {
+            ctrl->id_ctrl.unvmcap += le64_to_cpu(ns->size);
+            if (nvme_ns(ctrl, nsid)) {
+                nvme_detach_ns(ctrl, ns, nsid);
+            }
+            nvme_ns_attr_changed_aer(ctrl, nsid);
+        }
+    }
+}
+
+static uint16_t nvme_ns_management(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
+    uint8_t sel = dw10 & 0x7;
+    uint32_t nsid = le32_to_cpu(req->cmd.nsid);
+    uint8_t  csi = le32_to_cpu(req->cmd.cdw11) >> 24;
+    NvmeNamespace *ns;
+
+    if (!n->subsys) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    switch (sel) {
+    case NVME_NS_MANAGEMENT_CREATE:
+        if (nsid) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+        if (csi == NVME_CSI_NVM) {
+            return nvme_namespace_create(n, req);
+        }
+        break;
+    case NVME_NS_MANAGEMENT_DELETE:
+        if (nsid != NVME_NSID_BROADCAST && !nvme_nsid_valid(n, nsid)) {
+            return NVME_INVALID_NSID | NVME_DNR;
+        }
+        if (nsid == NVME_NSID_BROADCAST) {
+            uint32_t i;
+
+            for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+                ns = nvme_subsys_ns(n->subsys, i);
+                if (!ns) {
+                    continue;
+                }
+                nvme_namespace_delete(n, ns, i);
+            }
+            return NVME_SUCCESS;
+        } else {
+            ns = nvme_subsys_ns(n->subsys, nsid);
+            if (!ns) {
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
+            nvme_namespace_delete(n, ns, nsid);
+            return NVME_SUCCESS;
+        }
+
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
 static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
@@ -5239,22 +5442,14 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
             if (!nvme_ns(ctrl, nsid)) {
                 return NVME_NS_NOT_ATTACHED | NVME_DNR;
             }
-
-            ctrl->namespaces[nsid] = NULL;
-            ns->attached--;
-
-            nvme_update_dmrsl(ctrl);
+            nvme_detach_ns(ctrl, ns, nsid);
         }
 
         /*
          * Add namespace id to the changed namespace id list for event clearing
          * via Get Log Page command.
          */
-        if (!test_and_set_bit(nsid, ctrl->changed_nsids)) {
-            nvme_enqueue_event(ctrl, NVME_AER_TYPE_NOTICE,
-                               NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
-                               NVME_LOG_CHANGED_NSLIST);
-        }
+        nvme_ns_attr_changed_aer(ctrl, nsid);
     }
 
     return NVME_SUCCESS;
@@ -5487,6 +5682,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
         return nvme_get_feature(n, req);
     case NVME_ADM_CMD_ASYNC_EV_REQ:
         return nvme_aer(n, req);
+    case NVME_ADM_CMD_NS_MANAGEMENT:
+        return nvme_ns_management(n, req);
     case NVME_ADM_CMD_NS_ATTACHMENT:
         return nvme_ns_attachment(n, req);
     case NVME_ADM_CMD_FORMAT_NVM:
@@ -6471,6 +6668,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 
     if (n->subsys) {
         id->cmic |= NVME_CMIC_MULTI_CTRL;
+        id->tnvmcap = n->subsys->params.tnvmcap * GiB;
+        id->unvmcap = n->subsys->params.tnvmcap * GiB;
     }
 
     NVME_CAP_SET_MQES(cap, 0x7ff);
@@ -6518,6 +6717,22 @@ void nvme_attach_ns(NvmeCtrl *n, NvmeNamespace *ns)
                             BDRV_REQUEST_MAX_BYTES / nvme_l2b(ns, 1));
 }
 
+void nvme_detach_ns(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid)
+{
+    n->namespaces[nsid] = NULL;
+    ns->attached--;
+    nvme_update_dmrsl(n);
+}
+
+void nvme_ns_attr_changed_aer(NvmeCtrl *n, uint32_t nsid)
+{
+    if (!test_and_set_bit(nsid, n->changed_nsids)) {
+        nvme_enqueue_event(n, NVME_AER_TYPE_NOTICE,
+                           NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
+                           NVME_LOG_CHANGED_NSLIST);
+    }
+}
+
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n = NVME(pci_dev);
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index b7cf1494e7..f62a695132 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -54,6 +54,30 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     id_ns->npda = id_ns->npdg = npdg - 1;
 }
 
+void nvme_ns_identify_common(NvmeIdNs *id_ns)
+{
+    id_ns->dlfeat = 0x1;
+
+    /* support DULBE and I/O optimization fields */
+    id_ns->nsfeat |= (0x4 | 0x10);
+    id_ns->mc = NVME_ID_NS_MC_EXTENDED | NVME_ID_NS_MC_SEPARATE;
+    id_ns->dpc = 0x1f;
+
+    static const NvmeLBAF lbaf[16] = {
+        [0] = { .ds =  9           },
+        [1] = { .ds =  9, .ms =  8 },
+        [2] = { .ds =  9, .ms = 16 },
+        [3] = { .ds =  9, .ms = 64 },
+        [4] = { .ds = 12           },
+        [5] = { .ds = 12, .ms =  8 },
+        [6] = { .ds = 12, .ms = 16 },
+        [7] = { .ds = 12, .ms = 64 },
+    };
+
+    memcpy(&id_ns->lbaf, &lbaf, sizeof(lbaf));
+    id_ns->nlbaf = 7;
+}
+
 static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
 {
     static uint64_t ns_count;
@@ -65,11 +89,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
     ns->csi = NVME_CSI_NVM;
     ns->status = 0x0;
 
-    ns->id_ns.dlfeat = 0x1;
-
-    /* support DULBE and I/O optimization fields */
-    id_ns->nsfeat |= (0x4 | 0x10);
-
+    nvme_ns_identify_common(id_ns);
     if (ns->params.shared) {
         id_ns->nmic |= NVME_NMIC_NS_SHARED;
     }
@@ -89,32 +109,15 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
     ds = 31 - clz32(ns->blkconf.logical_block_size);
     ms = ns->params.ms;
 
-    id_ns->mc = NVME_ID_NS_MC_EXTENDED | NVME_ID_NS_MC_SEPARATE;
-
     if (ms && ns->params.mset) {
         id_ns->flbas |= NVME_ID_NS_FLBAS_EXTENDED;
     }
 
-    id_ns->dpc = 0x1f;
     id_ns->dps = ns->params.pi;
     if (ns->params.pi && ns->params.pil) {
         id_ns->dps |= NVME_ID_NS_DPS_FIRST_EIGHT;
     }
 
-    static const NvmeLBAF lbaf[16] = {
-        [0] = { .ds =  9           },
-        [1] = { .ds =  9, .ms =  8 },
-        [2] = { .ds =  9, .ms = 16 },
-        [3] = { .ds =  9, .ms = 64 },
-        [4] = { .ds = 12           },
-        [5] = { .ds = 12, .ms =  8 },
-        [6] = { .ds = 12, .ms = 16 },
-        [7] = { .ds = 12, .ms = 64 },
-    };
-
-    memcpy(&id_ns->lbaf, &lbaf, sizeof(lbaf));
-    id_ns->nlbaf = 7;
-
     for (i = 0; i <= id_ns->nlbaf; i++) {
         NvmeLBAF *lbaf = &id_ns->lbaf[i];
         if (lbaf->ds == ds) {
@@ -402,10 +405,6 @@ int nvme_ns_setup(NvmeNamespace *ns, Error **errp)
         return -1;
     }
 
-    if (nvme_ns_init_blk(ns, errp)) {
-        return -1;
-    }
-
     if (nvme_ns_init(ns, errp)) {
         return -1;
     }
@@ -481,6 +480,15 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    if (nvme_ns_init_blk(ns, errp)) {
+        return;
+    }
+
+    if (!ns->size) {
+        QSLIST_INSERT_HEAD(&subsys->unallocated_namespaces, ns, entry);
+        return;
+    }
+
     if (nvme_ns_setup(ns, errp)) {
         return;
     }
@@ -519,6 +527,7 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 
                 if (ctrl) {
                     nvme_attach_ns(ctrl, ns);
+                    ctrl->id_ctrl.unvmcap -= le64_to_cpu(ns->size);
                 }
             }
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 83ffabade4..142268f4e0 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -51,9 +51,11 @@ typedef struct NvmeSubsystem {
 
     NvmeCtrl      *ctrls[NVME_MAX_CONTROLLERS];
     NvmeNamespace *namespaces[NVME_MAX_NAMESPACES + 1];
+    QSLIST_HEAD(, NvmeNamespace) unallocated_namespaces;
 
     struct {
         char *nqn;
+        uint64_t tnvmcap;
     } params;
 } NvmeSubsystem;
 
@@ -130,7 +132,7 @@ typedef struct NvmeNamespace {
     uint16_t     status;
     int          attached;
 
-    QTAILQ_ENTRY(NvmeNamespace) entry;
+    QSLIST_ENTRY(NvmeNamespace) entry;
 
     NvmeIdNsZoned   *id_ns_zoned;
     NvmeZone        *zone_array;
@@ -259,6 +261,7 @@ int nvme_ns_setup(NvmeNamespace *ns, Error **errp);
 void nvme_ns_drain(NvmeNamespace *ns);
 void nvme_ns_shutdown(NvmeNamespace *ns);
 void nvme_ns_cleanup(NvmeNamespace *ns);
+void nvme_ns_identify_common(NvmeIdNs *id_ns);
 
 typedef struct NvmeAsyncEvent {
     QTAILQ_ENTRY(NvmeAsyncEvent) entry;
@@ -495,6 +498,8 @@ static inline uint16_t nvme_cid(NvmeRequest *req)
 }
 
 void nvme_attach_ns(NvmeCtrl *n, NvmeNamespace *ns);
+void nvme_detach_ns(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid);
+void nvme_ns_attr_changed_aer(NvmeCtrl *n, uint32_t nsid);
 uint16_t nvme_bounce_data(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
                           NvmeTxDirection dir, NvmeRequest *req);
 uint16_t nvme_bounce_mdata(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 93c35950d6..e30bfbca81 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -53,11 +53,14 @@ static void nvme_subsys_realize(DeviceState *dev, Error **errp)
     qbus_create_inplace(&subsys->bus, sizeof(NvmeBus), TYPE_NVME_BUS, dev,
                         dev->id);
 
+    QSLIST_INIT(&subsys->unallocated_namespaces);
+
     nvme_subsys_setup(subsys);
 }
 
 static Property nvme_subsystem_props[] = {
     DEFINE_PROP_STRING("nqn", NvmeSubsystem, params.nqn),
+    DEFINE_PROP_SIZE("tnvmcap", NvmeSubsystem, params.tnvmcap, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 77aae01174..8a8ca6753b 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -592,6 +592,7 @@ enum NvmeAdminCommands {
     NVME_ADM_CMD_SET_FEATURES   = 0x09,
     NVME_ADM_CMD_GET_FEATURES   = 0x0a,
     NVME_ADM_CMD_ASYNC_EV_REQ   = 0x0c,
+    NVME_ADM_CMD_NS_MANAGEMENT  = 0x0d,
     NVME_ADM_CMD_ACTIVATE_FW    = 0x10,
     NVME_ADM_CMD_DOWNLOAD_FW    = 0x11,
     NVME_ADM_CMD_NS_ATTACHMENT  = 0x15,
@@ -882,6 +883,9 @@ enum NvmeStatusCodes {
     NVME_FEAT_NOT_CHANGEABLE    = 0x010e,
     NVME_FEAT_NOT_NS_SPEC       = 0x010f,
     NVME_FW_REQ_SUSYSTEM_RESET  = 0x0110,
+    NVME_NS_INSUFF_CAP          = 0x0115,
+    NVME_THIN_PROVISION_NO_SUPP = 0x011b,
+    NVME_NS_ID_UNAVAILABLE      = 0x0116,
     NVME_NS_ALREADY_ATTACHED    = 0x0118,
     NVME_NS_PRIVATE             = 0x0119,
     NVME_NS_NOT_ATTACHED        = 0x011a,
@@ -1056,8 +1060,10 @@ typedef struct QEMU_PACKED NvmeIdCtrl {
     uint16_t    mtfa;
     uint32_t    hmpre;
     uint32_t    hmmin;
-    uint8_t     tnvmcap[16];
-    uint8_t     unvmcap[16];
+    uint64_t    tnvmcap;
+    uint64_t    tnvmcap_u;
+    uint64_t    unvmcap;
+    uint64_t    unvmcap_u;
     uint32_t    rpmbs;
     uint16_t    edstt;
     uint8_t     dsto;
@@ -1154,6 +1160,11 @@ enum NvmeIdCtrlCmic {
     NVME_CMIC_MULTI_CTRL    = 1 << 1,
 };
 
+enum NvmeNsManagementOperation {
+    NVME_NS_MANAGEMENT_CREATE = 0x0,
+    NVME_NS_MANAGEMENT_DELETE = 0x1,
+};
+
 #define NVME_CTRL_SQES_MIN(sqes) ((sqes) & 0xf)
 #define NVME_CTRL_SQES_MAX(sqes) (((sqes) >> 4) & 0xf)
 #define NVME_CTRL_CQES_MIN(cqes) ((cqes) & 0xf)
@@ -1285,7 +1296,8 @@ typedef struct QEMU_PACKED NvmeIdNs {
     uint16_t    nabo;
     uint16_t    nabspf;
     uint16_t    noiob;
-    uint8_t     nvmcap[16];
+    uint64_t    nvmcap;
+    uint64_t    nvmcap_u;
     uint16_t    npwg;
     uint16_t    npwa;
     uint16_t    npdg;
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
