Return-Path: <SRS0=sV58=NE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F65C432BE
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Aug 2021 16:46:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC2B610A4
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Aug 2021 16:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DBC2B610A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UXO7RajnoJJWdwHHkFaOBKnnW1ii4t4oz5/lCy7EDYA=; b=fsBAJQtrTsaicx
	vg7WwFW/Y0WMSFhXASzWjWr8aszx2kPu14a21Cnv0pWNx5MSjmDrChCAO7d2JsLjQcC0BrUyQgzfN
	x+4RGbARxdx2idbQngJEBs2hUEH8wi5nZjUN9oTBQKSf+g5FRvKgZxyCiYKteoXljMhIXfbCUTtwz
	K2sWl8Y0BgzRhyXlwQYWQgWjm/iNXKZ/xVPVVuki5uIaGcwCgbgfrFHWyXx4uI0kYNAYtURQkn+yb
	2rBiBIyBhuWTZ7NNTuxiE9u4OK9xfVttGEc6qAZiyzL1xc77S8MpTOIRJ3Zs/8BPGrdSjiQheaMnt
	8l1igdiEosAT+Suz+aig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mEaJw-00D9FA-1M; Fri, 13 Aug 2021 16:46:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEaJd-00D9Ep-SG
 for linux-nvme@lists.infradead.org; Fri, 13 Aug 2021 16:45:55 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7CA5610A4;
 Fri, 13 Aug 2021 16:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628873152;
 bh=z8zsNkYA2AJX76w4oA0E7Lb62DHf0hifmBag+OVPBlY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KhSWxIQAdSsoP3W2SWxihajKkoUO1Ag4eupbbze/aaMo2TY0cMkujpVlfCx5GLRkt
 MbOsWtnARMXkdS3fLnN4q4e2H/zBtnlTXe9Bram9haFGhK9ii4INshwLgLmGfj47wg
 zAS3E61pXz39Gz15TWr98JWZl1SnxN4VywFmi2T655pC77wpYPqRGG34WafXbLiU4y
 ZsUkx/DsOXrcg6+oGTzFQO+F3Krt1a037AXEt7Pd8s8FFE3xL0viC2au1NfobgH9qL
 abxvjXs5IPVpLLd4R8gnySjmhZM7idrRrVk0AJxRXFLsOV5oLOWxvmE7KNRHWPV+7N
 3weUZKMyvdrlg==
Date: Fri, 13 Aug 2021 09:45:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Naveen <naveen.n1@samsung.com>
Cc: qemu-devel@nongnu.org, its@irrelevant.dk, stefanha@redhat.com,
 fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, linux-nvme@lists.infradead.org,
 k.jensen@samsung.com, d.palani@samsung.com, prakash.v@samsung.com,
 jg123.choi@samsung.com, anuj.singh@samsung.com,
 raphel.david@samsung.com, p.kalghatgi@samsung.com, anaidu.gollu@samsung.com
Subject: Re: [RFC PATCH v1] Adding Support for namespace management
Message-ID: <20210813164547.GB3138953@dhcp-10-100-145-180.wdc.com>
References: <CGME20210813101459epcas5p19cf9edbb414726886b9d3a5a140fc706@epcas5p1.samsung.com>
 <1628847142-24943-1-git-send-email-naveen.n1@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1628847142-24943-1-git-send-email-naveen.n1@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210813_094553_997897_8228F74E 
X-CRM114-Status: GOOD (  16.82  )
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

On Fri, Aug 13, 2021 at 03:02:22PM +0530, Naveen wrote:
> +static uint16_t nvme_identify_ns_common(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    NvmeIdNs id_ns = {};
> +
> +    id_ns.nsfeat |= (0x4 | 0x10);
> +    id_ns.dpc = 0x1f;
> +
> +    NvmeLBAF lbaf[16] = {
> +        [0] = {.ds = 9},
> +        [1] = {.ds = 9, .ms = 8},
> +        [2] = {.ds = 9, .ms = 16},
> +        [3] = {.ds = 9, .ms = 64},
> +        [4] = {.ds = 12},
> +        [5] = {.ds = 12, .ms = 8},
> +        [6] = {.ds = 12, .ms = 16},
> +        [7] = {.ds = 12, .ms = 64},
> +    };

Since the lbaf is a copy of what's defined in nvme_ns_init, so should be
defined for reuse.

> +
> +    memcpy(&id_ns.lbaf, &lbaf, sizeof(lbaf));
> +    id_ns.nlbaf = 7;

The identify structure should be what's in common with all namespaces,
and this doesn't look complete. Just off the top of my head, missing
fields include MC and DLFEAT.

> +
> +    return nvme_c2h(n, (uint8_t *)&id_ns, sizeof(NvmeIdNs), req);
> +}
> +
>  static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req, bool active)
>  {
>      NvmeNamespace *ns;
> @@ -4453,8 +4478,10 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req, bool active)
>  
>      trace_pci_nvme_identify_ns(nsid);
>  
> -    if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
> +    if (!nvme_nsid_valid(n, nsid)) {
>          return NVME_INVALID_NSID | NVME_DNR;
> +    } else if (nsid == NVME_NSID_BROADCAST) {
> +        return nvme_identify_ns_common(n, req);
>      }
>  
>      ns = nvme_ns(n, nsid);
> @@ -5184,6 +5211,195 @@ static void nvme_select_iocs_ns(NvmeCtrl *n, NvmeNamespace *ns)
>      }
>  }
>  
> +static int nvme_blk_truncate(BlockBackend *blk, size_t len, Error **errp)
> +{
> +    int ret;
> +    uint64_t perm, shared_perm;
> +
> +    blk_get_perm(blk, &perm, &shared_perm);
> +
> +    ret = blk_set_perm(blk, perm | BLK_PERM_RESIZE, shared_perm, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret = blk_truncate(blk, len, false, PREALLOC_MODE_OFF, 0, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret = blk_set_perm(blk, perm, shared_perm, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static uint32_t nvme_allocate_nsid(NvmeCtrl *n)
> +{
> +    uint32_t nsid = 0;
> +    for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
> +        if (nvme_ns(n, i) || nvme_subsys_ns(n->subsys, i)) {
> +            continue;
> +        }
> +
> +        nsid = i;
> +        return nsid;
> +    }
> +    return nsid;
> +}
> +
> +static uint16_t nvme_namespace_create(NvmeCtrl *n, NvmeRequest *req)
> +{
> +   uint32_t ret;
> +   NvmeIdNs id_ns_host;
> +   NvmeSubsystem *subsys = n->subsys;
> +   Error *err = NULL;
> +   uint8_t flbas_host;
> +   uint64_t ns_size;
> +   int lba_index;
> +   NvmeNamespace *ns;
> +   NvmeCtrl *ctrl;
> +   NvmeIdNs *id_ns;
> +
> +    ret = nvme_h2c(n, (uint8_t *)&id_ns_host, sizeof(id_ns_host), req);
> +    if (ret) {
> +        return ret;
> +    }

Some unusual indentation here.

> +
> +    if (id_ns_host.ncap < id_ns_host.nsze) {
> +        return NVME_THIN_PROVISION_NO_SUPP | NVME_DNR;
> +    } else if (id_ns_host.ncap > id_ns_host.nsze) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    if (!id_ns_host.nsze) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    if (QSLIST_EMPTY(&subsys->unallocated_namespaces)) {
> +        return NVME_NS_ID_UNAVAILABLE;
> +    }
> +
> +    ns = QSLIST_FIRST(&subsys->unallocated_namespaces);
> +    id_ns = &ns->id_ns;
> +    flbas_host = (id_ns_host.flbas) & (0xF);
> +
> +    if (flbas_host > id_ns->nlbaf) {
> +        return NVME_INVALID_FORMAT | NVME_DNR;
> +    }
> +
> +    ret = nvme_ns_setup(ns, &err);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    id_ns->flbas = id_ns_host.flbas;
> +    id_ns->dps = id_ns_host.dps;
> +    id_ns->nmic = id_ns_host.nmic;
> +
> +    lba_index = NVME_ID_NS_FLBAS_INDEX(id_ns->flbas);
> +    ns_size = id_ns_host.nsze * ((1 << id_ns->lbaf[lba_index].ds) +
> +                (id_ns->lbaf[lba_index].ms));
> +    id_ns->nvmcap = ns_size;
> +
> +    if (ns_size > n->id_ctrl.unvmcap) {
> +        return NVME_NS_INSUFF_CAP;
> +    }
> +
> +    ret = nvme_blk_truncate(ns->blkconf.blk, id_ns->nvmcap, &err);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ns->size = blk_getlength(ns->blkconf.blk);
> +    nvme_ns_init_format(ns);
> +
> +    ns->params.nsid = nvme_allocate_nsid(n);
> +    if (!ns->params.nsid) {
> +        return NVME_NS_ID_UNAVAILABLE;
> +    }
> +    subsys->namespaces[ns->params.nsid] = ns;
> +
> +    for (int cntlid = 0; cntlid < ARRAY_SIZE(n->subsys->ctrls); cntlid++) {
> +        ctrl = nvme_subsys_ctrl(n->subsys, cntlid);
> +        if (ctrl) {
> +            ctrl->id_ctrl.unvmcap -= le64_to_cpu(ns->size);
> +        }
> +    }
> +
> +    stl_le_p(&req->cqe.result, ns->params.nsid);
> +    QSLIST_REMOVE_HEAD(&subsys->unallocated_namespaces, entry);
> +    return NVME_SUCCESS;
> +}
> +
> +static void nvme_namespace_delete(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid)
> +{
> +    NvmeCtrl *ctrl;
> +    NvmeSubsystem *subsys = n->subsys;
> +
> +    subsys->namespaces[nsid] = NULL;
> +    QSLIST_INSERT_HEAD(&subsys->unallocated_namespaces, ns, entry);
> +
> +    for (int cntlid = 0; cntlid < ARRAY_SIZE(n->subsys->ctrls); cntlid++) {
> +        ctrl = nvme_subsys_ctrl(n->subsys, cntlid);
> +        if (ctrl) {
> +            ctrl->id_ctrl.unvmcap += le64_to_cpu(ns->size);
> +            if (nvme_ns(ctrl, nsid)) {
> +                nvme_detach_ns(ctrl, ns, nsid);
> +            }
> +            nvme_ns_attr_changed_aer(ctrl, nsid);
> +        }
> +    }
> +}
> +
> +static uint16_t nvme_ns_management(NvmeCtrl *n, NvmeRequest *req)
> +{
> +   uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
> +   uint8_t sel = dw10 & 0x7;
> +   uint32_t nsid = le32_to_cpu(req->cmd.nsid);
> +   NvmeNamespace *ns;

There's no check for CDW11's CSI field. Since we support NVM and ZNS
command sets, you have check this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
