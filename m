Return-Path: <SRS0=sV58=NE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807B0C4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Aug 2021 11:15:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23AA86104F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Aug 2021 11:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 23AA86104F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Byt7psWU6P96gj9VhEdOFxQ/onb1MfuK0BUTZ9K7Ko0=; b=ReqKYmTyKUm0Rr
	XSoJuh0BiG4QSAmlmyluIzgjCD4EPbt+/D36FhobAqlZtxRD1XCNohDyPkSwiYwFf+SeB2AlZUNz7
	pTWJsf7oF3fQwd8OvIBGkIkE9Yqy1xXZl13QyGmfUlUIoR7s19p4bOHXmxW/unND9G3KsoXTRIRpT
	XdynZT89jcLmBbz+wXSRg+0oSQFYPhNA+1rNMchESQ5SjWySbcWJdhyLFxm06rOpx3iDY3tYeufpr
	1ngQMtkxChc5uS5N1isTHiUlXIcxqg8nf//e/iYyro3EFS2QaITOnzWT3M4Sw49uLitooZU9W0gVf
	IaDwIAmEsTiLzdBXvWAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mEV97-00CVum-Qx; Fri, 13 Aug 2021 11:14:41 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEV91-00CVt4-9G
 for linux-nvme@lists.infradead.org; Fri, 13 Aug 2021 11:14:39 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20210813111432epoutp0317da4b9b25338060733a7fcbfca1befa~a2WvJa3bD2930329303epoutp03Q
 for <linux-nvme@lists.infradead.org>; Fri, 13 Aug 2021 11:14:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20210813111432epoutp0317da4b9b25338060733a7fcbfca1befa~a2WvJa3bD2930329303epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1628853272;
 bh=5TvCTJkq+K+NvMZ1O+L8URFjZ65DiKdCe/NNBPOfrkk=;
 h=From:To:Cc:Subject:Date:References:From;
 b=hZziypMDgFRMUo2/XB+V+fdt3wi466sVtR+UplhXBncvp0ANoFiAVpwId+Dh/2QpF
 Za099DYU74VuosJ4pbjeLN/AofQ1PVgwNxeT2d2wFSnjlRM8Om5SF1I+ydx2xgwTnA
 rPT8Wo31LqJ4y6LmdMaYMe5JoFvHnq2MJnNGuYzw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20210813111431epcas5p179819f40d10542f8eeca8626d490e6c8~a2WuHusTY2952529525epcas5p1o;
 Fri, 13 Aug 2021 11:14:31 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4GmLYB4DV7z4x9Pv; Fri, 13 Aug
 2021 11:14:22 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 3E.C5.09595.E0456116; Fri, 13 Aug 2021 20:14:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20210813101459epcas5p19cf9edbb414726886b9d3a5a140fc706~a1iv85FCh1559815598epcas5p14;
 Fri, 13 Aug 2021 10:14:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210813101459epsmtrp13867b51586e3e40f9563c52621175783~a1iv74HBh0616806168epsmtrp1d;
 Fri, 13 Aug 2021 10:14:59 +0000 (GMT)
X-AuditID: b6c32a4a-ed5ff7000000257b-bc-6116540eedc6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 28.28.08394.32646116; Fri, 13 Aug 2021 19:14:59 +0900 (KST)
Received: from test.sa.corp.samsungelectronics.net (unknown [107.108.56.58])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210813101456epsmtip1efb374a8e9a6c7c9a42f3fe1133daa44~a1itaaONI0696606966epsmtip1W;
 Fri, 13 Aug 2021 10:14:56 +0000 (GMT)
From: Naveen <naveen.n1@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, stefanha@redhat.com,
 fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 linux-nvme@lists.infradead.org, k.jensen@samsung.com, d.palani@samsung.com,
 prakash.v@samsung.com, jg123.choi@samsung.com, anuj.singh@samsung.com,
 raphel.david@samsung.com, p.kalghatgi@samsung.com, anaidu.gollu@samsung.com,
 Naveen <naveen.n1@samsung.com>
Subject: [RFC PATCH v1] Adding Support for namespace management
Date: Fri, 13 Aug 2021 15:02:22 +0530
Message-Id: <1628847142-24943-1-git-send-email-naveen.n1@samsung.com>
X-Mailer: git-send-email 1.8.3.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmhi5fiFiiQfssGYvXO48zW3z8e5bR
 4u3XB2wWV/afZ7TYf/Abq8XS+foWJxv3sFpMOnSN0WLJxVSL+cueslvMu6Vs0fhkN7vF9Z+P
 2C2uTFnEbDHrXTubxfHeHSwWe75sZLV4Pek/q4OQx49z7Wwe53acZ/fYtKqTzWPzknqPJ9c2
 M3m833eVzaNvyyrGAPaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxU
 WyUXnwBdt8wcoCeUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnp
 enmpJVaGBgZGpkCFCdkZczofshd8r6s4emYqWwPj7pguRk4OCQETiemHr7F0MXJxCAnsZpSY
 1fWVHcL5xCjx/toqVgjnG6PExV+zmWFaFtzYwwiR2MsocXX6W6j+RiaJ9rctbCBVbAIqEtP3
 ngCzRQQkJX53nWYGKWIWmMws8Xf6AaAODg5hAXuJy22SICaLgKpE/x+wcl4BV4kHWx4xQixT
 kJjy8D1Yq4RAJ4dE9+rX7BAJF4kFm5ewQNjCEq+Ob4GKS0m87G+DsoslLvT2s0A0NzBKPPq2
 AarBXuLinr9MIIuZBTQl1u/ShwjLSkw9tY4JxGYW4JPo/f2ECSLOK7Fj3hOwcgkBZYnzq7kh
 TEmJc9OTISo8JGav/A12spBArMSdW8tZJzDKzkKYv4CRcRWjZGpBcW56arFpgVFeajk8npLz
 czcxgpOmltcOxocPPugdYmTiYDzEKMHBrCTCWywslijEm5JYWZValB9fVJqTWnyI0RQYYhOZ
 pUST84FpO68k3tDE0sDEzMzMxNLYzFBJnJc9/muCkEB6YklqdmpqQWoRTB8TB6dUA1PXpjRr
 PzW/5/tsYrPc50fYb/Jse8j0tO48w3Wm6An2z54e54+eduzXaieF0t/N8WVHnnYK/VN+4qCn
 oMmg6HO1oXG59I6llzb/LjOb8ddrr59V4tc4L2fZJeUb9Ke1+nxMS37mc9LWPa5VbM6MH3LB
 cXHT3z37vk/r2o79T8/0fteuFfuzc1/nTA5/uc2PpS7YiXotSjuWta9n7Wvv/Xq7NT+wLoq8
 rqXK/nYnd4SAtWFP6fH2GuaMpwYr9l40b9zY1HOxenXwvXtpd5Yem6uW3KlUkrhdu9SwdVfz
 SjmjC7Fyb8+8U7R5ceaOjvXmw7+vvSgJrnml9YjT7tPc0rIPZ64e9E6r+7mxIto6eKISS3FG
 oqEWc1FxIgBwDyTzIwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSnK6ym1iiweZfMhavdx5ntvj49yyj
 xduvD9gsruw/z2ix/+A3Voul8/UtTjbuYbWYdOgao8WSi6kW85c9ZbeYd0vZovHJbnaL6z8f
 sVtcmbKI2WLWu3Y2i+O9O1gs9nzZyGrxetJ/Vgchjx/n2tk8zu04z+6xaVUnm8fmJfUeT65t
 ZvJ4v+8qm0ffllWMAexRXDYpqTmZZalF+nYJXBlzOh+yF3yvqzh6ZipbA+PumC5GTg4JAROJ
 BTf2MHYxcnEICexmlFj8qZkNIiEpseHvViYIW1hi5b/n7BBF/xklJn4AcTg52ARUJKbvPQHW
 IALU8LvrNDNIEbPASmaJtte9QGM5OIQF7CUut0mCmCwCqhL9f8DKeQVcJR5secQIMV9BYsrD
 98wTGHkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDmAtzR2M21d90DvEyMTB
 eIhRgoNZSYS3WFgsUYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZ
 Jg5OqQamau2ZqaJvl4n97dgrL9Kb8XLDQ8kJG4yzRI/kf33ewmDr8bvk4l2r1oslPzI9qsrW
 OqeHdKc9XObj88VMsV9X029BnbsD992L4uKespLX85QzfDXOH7mwRzP2XXWZJbNEd8n2W7dT
 E1UEnzjFL1Nv6nyb29l5xOPi2xUFl5pvX14v2TDjpONLNb+Pi9Pvygb9MrjGYGsnyH/kv87U
 PQoKpy06u6IfHe88dCC6a/nGG6/SGw5dtb51e/dBuYI5c6zW2csdLV605B57hctX9Udd/1fs
 Nmt9spC117nglnztW9cVei3q0tyXOdP4Q7ft4VrDdLht76KjSwyfTvdh4O5xCXyWk35PcFHH
 +xkVU/4psRRnJBpqMRcVJwIAm6ytL88CAAA=
X-CMS-MailID: 20210813101459epcas5p19cf9edbb414726886b9d3a5a140fc706
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210813101459epcas5p19cf9edbb414726886b9d3a5a140fc706
References: <CGME20210813101459epcas5p19cf9edbb414726886b9d3a5a140fc706@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210813_041435_888624_4F59728D 
X-CRM114-Status: GOOD (  24.43  )
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

This patch supports namespace management : create and delete operations.
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
Reviewed-by: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
Reviewed-by: Gollu Appalanaidu <anaidu.gollu@samsung.com>
Reviewed-by: Jaegyu Choi <jg123.choi@samsung.com>

---
 hw/nvme/ctrl.c       | 250 +++++++++++++++++++++++++++++++++++++++++--
 hw/nvme/ns.c         |  14 ++-
 hw/nvme/nvme.h       |   6 +-
 hw/nvme/subsys.c     |   3 +
 include/block/nvme.h |  18 +++-
 5 files changed, 272 insertions(+), 19 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 6baf9e0420..4be23a3092 100644
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
@@ -4445,6 +4446,30 @@ static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
     return nvme_c2h(n, id, sizeof(id), req);
 }
 
+static uint16_t nvme_identify_ns_common(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeIdNs id_ns = {};
+
+    id_ns.nsfeat |= (0x4 | 0x10);
+    id_ns.dpc = 0x1f;
+
+    NvmeLBAF lbaf[16] = {
+        [0] = {.ds = 9},
+        [1] = {.ds = 9, .ms = 8},
+        [2] = {.ds = 9, .ms = 16},
+        [3] = {.ds = 9, .ms = 64},
+        [4] = {.ds = 12},
+        [5] = {.ds = 12, .ms = 8},
+        [6] = {.ds = 12, .ms = 16},
+        [7] = {.ds = 12, .ms = 64},
+    };
+
+    memcpy(&id_ns.lbaf, &lbaf, sizeof(lbaf));
+    id_ns.nlbaf = 7;
+
+    return nvme_c2h(n, (uint8_t *)&id_ns, sizeof(NvmeIdNs), req);
+}
+
 static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req, bool active)
 {
     NvmeNamespace *ns;
@@ -4453,8 +4478,10 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req, bool active)
 
     trace_pci_nvme_identify_ns(nsid);
 
-    if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
+    if (!nvme_nsid_valid(n, nsid)) {
         return NVME_INVALID_NSID | NVME_DNR;
+    } else if (nsid == NVME_NSID_BROADCAST) {
+        return nvme_identify_ns_common(n, req);
     }
 
     ns = nvme_ns(n, nsid);
@@ -5184,6 +5211,195 @@ static void nvme_select_iocs_ns(NvmeCtrl *n, NvmeNamespace *ns)
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
+   uint32_t ret;
+   NvmeIdNs id_ns_host;
+   NvmeSubsystem *subsys = n->subsys;
+   Error *err = NULL;
+   uint8_t flbas_host;
+   uint64_t ns_size;
+   int lba_index;
+   NvmeNamespace *ns;
+   NvmeCtrl *ctrl;
+   NvmeIdNs *id_ns;
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
+   uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
+   uint8_t sel = dw10 & 0x7;
+   uint32_t nsid = le32_to_cpu(req->cmd.nsid);
+   NvmeNamespace *ns;
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
+        return nvme_namespace_create(n, req);
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
+}
+
 static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
@@ -5239,22 +5455,14 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
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
@@ -5487,6 +5695,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
         return nvme_get_feature(n, req);
     case NVME_ADM_CMD_ASYNC_EV_REQ:
         return nvme_aer(n, req);
+    case NVME_ADM_CMD_NS_MANAGEMENT:
+        return nvme_ns_management(n, req);
     case NVME_ADM_CMD_NS_ATTACHMENT:
         return nvme_ns_attachment(n, req);
     case NVME_ADM_CMD_FORMAT_NVM:
@@ -6471,6 +6681,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 
     if (n->subsys) {
         id->cmic |= NVME_CMIC_MULTI_CTRL;
+        id->tnvmcap = n->subsys->params.tnvmcap * GiB;
+        id->unvmcap = n->subsys->params.tnvmcap * GiB;
     }
 
     NVME_CAP_SET_MQES(cap, 0x7ff);
@@ -6518,6 +6730,22 @@ void nvme_attach_ns(NvmeCtrl *n, NvmeNamespace *ns)
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
index b7cf1494e7..c2b8c82024 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -402,10 +402,6 @@ int nvme_ns_setup(NvmeNamespace *ns, Error **errp)
         return -1;
     }
 
-    if (nvme_ns_init_blk(ns, errp)) {
-        return -1;
-    }
-
     if (nvme_ns_init(ns, errp)) {
         return -1;
     }
@@ -481,6 +477,15 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
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
@@ -519,6 +524,7 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 
                 if (ctrl) {
                     nvme_attach_ns(ctrl, ns);
+                    ctrl->id_ctrl.unvmcap -= le64_to_cpu(ns->size);
                 }
             }
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 83ffabade4..e1e4ab8a01 100644
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
@@ -495,6 +497,8 @@ static inline uint16_t nvme_cid(NvmeRequest *req)
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
