Return-Path: <SRS0=3Qb0=PQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641F2C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 12:45:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 195E26023F
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 12:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 195E26023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H9FQtC1q+HxfKOLia4OpxXV3vfJufYNd/ApQrDO0nig=; b=drN+Myud3aBfh3QU+CQK353Chj
	M/axIyF5Y11OtVqH7SjaHeHy5+hIuSErq9TcE2/Dg9tJIrXOjJjQWbS9EmVZ5tkfQTzocU+tvSDhk
	JJYouBvxWpecQzumL79GtvK0O8QSBT+9KaZXiEPavzoqBil9kewPohe6IkuFrLKPJM/76hJk5ACUd
	+RQStshCz97PxV5n8B0UHwSMTypPoa6oVnrq2E3FAyAhDr7iIOeumUKFGZPt9Eiq6JlVLX6mxYla0
	g7uhrWIAPrQXYiR0TTOv1REvwsm+veT0z0PKhPL4kFWKpFQW1teWEt6nfJbA1jgXh7jJtnH79AbAi
	Ong7tAOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mg4mY-007oIE-2q; Thu, 28 Oct 2021 12:45:22 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mg4mT-007oHL-PO
 for linux-nvme@lists.infradead.org; Thu, 28 Oct 2021 12:45:20 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="253966092"
X-IronPort-AV: E=Sophos;i="5.87,189,1631602800"; d="scan'208";a="253966092"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2021 05:45:15 -0700
X-IronPort-AV: E=Sophos;i="5.87,189,1631602800"; d="scan'208";a="498383874"
Received: from lmaniak-dev.igk.intel.com ([10.55.248.48])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2021 05:45:10 -0700
Date: Thu, 28 Oct 2021 14:43:59 +0200
From: Lukasz Maniak <lukasz.maniak@linux.intel.com>
To: Naveen Nagar <naveen.n1@samsung.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, kwolf@redhat.com,
 anuj.singh@samsung.com, p.kalghatgi@samsung.com,
 qemu-block@nongnu.org, k.jensen@samsung.com,
 anaidu.gollu@samsung.com, d.palani@samsung.com,
 linux-nvme@lists.infradead.org, mreitz@redhat.com,
 its@irrelevant.dk, stefanha@redhat.com, kbusch@kernel.org,
 prakash.v@samsung.com, raphel.david@samsung.com, jg123.choi@samsung.com,
 =?utf-8?Q?=C5=81ukasz?= Gieryk <lukasz.gieryk@linux.intel.com>
Subject: Re: [RFC PATCH v2] hw/nvme:Adding Support for namespace management
Message-ID: <20211028124359.GA2275590@lmaniak-dev.igk.intel.com>
References: <CGME20210819135248epcas5p1fcc9f399f16a5336e6af004170a0eea4@epcas5p1.samsung.com>
 <1629378597-30480-1-git-send-email-naveen.n1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629378597-30480-1-git-send-email-naveen.n1@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211028_054517_940698_9CC5665D 
X-CRM114-Status: GOOD (  34.45  )
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

On Thu, Aug 19, 2021 at 06:39:57PM +0530, Naveen Nagar wrote:
> From: Naveen <naveen.n1@samsung.com>
> 
> This patch supports namespace management : create and delete operations.
> 
> Since v1:
> - Modified and moved nvme_ns_identify_common in ns.c file 
> - Added check for CSI field in NS management
> - Indentation fix in namespace create
> 
> This patch has been tested with the following command and size of image
> file for unallocated namespaces is taken as 0GB. ns_create will look into
> the list of unallocated namespaces and it will initialize the same and 
> return the nsid of the same. A new mandatory field has been added called
> tnvmcap and we have ensured that the total capacity of namespace created
> does not exceed tnvmcap
> 
> -device nvme-subsys,id=subsys0,tnvmcap=8
> -device nvme,serial=foo,id=nvme0,subsys=subsys0
> -device nvme,serial=bar,id=nvme1,subsys=subsys0
> -drive id=ns1,file=ns1.img,if=none
> -device nvme-ns,drive=ns1,bus=nvme0,nsid=1,zoned=false,shared=true
> -drive id=ns2,file=ns2.img,if=none
> -device nvme-ns,drive=ns2,bus=nvme0,nsid=2,zoned=false,shared=true
> -drive id=ns3,file=ns3.img,if=none
> -device nvme-ns,drive=ns3,bus=nvme0,nsid=3,zoned=false,shared=true
> -drive id=ns4,file=ns4.img,if=none
> -device nvme-ns,drive=ns4,bus=nvme0,nsid=4,zoned=false,shared=true
> 
> Please review and suggest if any changes are required.
> 
> Signed-off-by: Naveen Nagar <naveen.n1@samsung.com>
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
>   
> ---
>  hw/nvme/ctrl.c       | 237 +++++++++++++++++++++++++++++++++++++++++--
>  hw/nvme/ns.c         |  61 ++++++-----
>  hw/nvme/nvme.h       |   7 +-
>  hw/nvme/subsys.c     |   3 +
>  include/block/nvme.h |  18 +++-
>  5 files changed, 285 insertions(+), 41 deletions(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 6baf9e0420..992aaa7d02 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -219,6 +219,7 @@ static const uint32_t nvme_cse_acs[256] = {
>      [NVME_ADM_CMD_SET_FEATURES]     = NVME_CMD_EFF_CSUPP,
>      [NVME_ADM_CMD_GET_FEATURES]     = NVME_CMD_EFF_CSUPP,
>      [NVME_ADM_CMD_ASYNC_EV_REQ]     = NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_NS_MANAGEMENT]    = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_NIC,
>      [NVME_ADM_CMD_NS_ATTACHMENT]    = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_NIC,
>      [NVME_ADM_CMD_FORMAT_NVM]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
>  };
> @@ -4450,11 +4451,19 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req, bool active)
>      NvmeNamespace *ns;
>      NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
>      uint32_t nsid = le32_to_cpu(c->nsid);
> +    NvmeIdNs *id_ns = NULL;
> +    uint16_t ret;
>  
>      trace_pci_nvme_identify_ns(nsid);
>  
> -    if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
> +    if (!nvme_nsid_valid(n, nsid)) {
>          return NVME_INVALID_NSID | NVME_DNR;
> +    } else if (nsid == NVME_NSID_BROADCAST) {
> +        id_ns = g_new0(NvmeIdNs, 1);
> +        nvme_ns_identify_common(id_ns);
> +        ret = nvme_c2h(n, (uint8_t *)id_ns, sizeof(NvmeIdNs), req);
> +        g_free(id_ns);
> +        return ret;
>      }
>  
>      ns = nvme_ns(n, nsid);
> @@ -5184,6 +5193,200 @@ static void nvme_select_iocs_ns(NvmeCtrl *n, NvmeNamespace *ns)
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
> +    uint32_t ret;
> +    NvmeIdNs id_ns_host;
> +    NvmeSubsystem *subsys = n->subsys;
> +    Error *err = NULL;
> +    uint8_t flbas_host;
> +    uint64_t ns_size;
> +    int lba_index;
> +    NvmeNamespace *ns;
> +    NvmeCtrl *ctrl;
> +    NvmeIdNs *id_ns;
> +
> +    ret = nvme_h2c(n, (uint8_t *)&id_ns_host, sizeof(id_ns_host), req);
> +    if (ret) {
> +        return ret;
> +    }
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
> +    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
> +    uint8_t sel = dw10 & 0x7;
> +    uint32_t nsid = le32_to_cpu(req->cmd.nsid);
> +    uint8_t  csi = le32_to_cpu(req->cmd.cdw11) >> 24;
> +    NvmeNamespace *ns;
> +
> +    if (!n->subsys) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    switch (sel) {
> +    case NVME_NS_MANAGEMENT_CREATE:
> +        if (nsid) {
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +        if (csi == NVME_CSI_NVM) {
> +            return nvme_namespace_create(n, req);
> +        }
> +        break;
> +    case NVME_NS_MANAGEMENT_DELETE:
> +        if (nsid != NVME_NSID_BROADCAST && !nvme_nsid_valid(n, nsid)) {
> +            return NVME_INVALID_NSID | NVME_DNR;
> +        }
> +        if (nsid == NVME_NSID_BROADCAST) {
> +            uint32_t i;
> +
> +            for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
> +                ns = nvme_subsys_ns(n->subsys, i);
> +                if (!ns) {
> +                    continue;
> +                }
> +                nvme_namespace_delete(n, ns, i);
> +            }
> +            return NVME_SUCCESS;
> +        } else {
> +            ns = nvme_subsys_ns(n->subsys, nsid);
> +            if (!ns) {
> +                return NVME_INVALID_FIELD | NVME_DNR;
> +            }
> +            nvme_namespace_delete(n, ns, nsid);
> +            return NVME_SUCCESS;
> +        }
> +
> +    default:
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +    return NVME_INVALID_FIELD | NVME_DNR;
> +}
> +
>  static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeNamespace *ns;
> @@ -5239,22 +5442,14 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
>              if (!nvme_ns(ctrl, nsid)) {
>                  return NVME_NS_NOT_ATTACHED | NVME_DNR;
>              }
> -
> -            ctrl->namespaces[nsid] = NULL;
> -            ns->attached--;
> -
> -            nvme_update_dmrsl(ctrl);
> +            nvme_detach_ns(ctrl, ns, nsid);
>          }
>  
>          /*
>           * Add namespace id to the changed namespace id list for event clearing
>           * via Get Log Page command.
>           */
> -        if (!test_and_set_bit(nsid, ctrl->changed_nsids)) {
> -            nvme_enqueue_event(ctrl, NVME_AER_TYPE_NOTICE,
> -                               NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
> -                               NVME_LOG_CHANGED_NSLIST);
> -        }
> +        nvme_ns_attr_changed_aer(ctrl, nsid);
>      }
>  
>      return NVME_SUCCESS;
> @@ -5487,6 +5682,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
>          return nvme_get_feature(n, req);
>      case NVME_ADM_CMD_ASYNC_EV_REQ:
>          return nvme_aer(n, req);
> +    case NVME_ADM_CMD_NS_MANAGEMENT:
> +        return nvme_ns_management(n, req);
>      case NVME_ADM_CMD_NS_ATTACHMENT:
>          return nvme_ns_attachment(n, req);
>      case NVME_ADM_CMD_FORMAT_NVM:
> @@ -6471,6 +6668,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>  
>      if (n->subsys) {
>          id->cmic |= NVME_CMIC_MULTI_CTRL;
> +        id->tnvmcap = n->subsys->params.tnvmcap * GiB;
> +        id->unvmcap = n->subsys->params.tnvmcap * GiB;
>      }
>  
>      NVME_CAP_SET_MQES(cap, 0x7ff);
> @@ -6518,6 +6717,22 @@ void nvme_attach_ns(NvmeCtrl *n, NvmeNamespace *ns)
>                              BDRV_REQUEST_MAX_BYTES / nvme_l2b(ns, 1));
>  }
>  
> +void nvme_detach_ns(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid)
> +{
> +    n->namespaces[nsid] = NULL;
> +    ns->attached--;
> +    nvme_update_dmrsl(n);
> +}
> +
> +void nvme_ns_attr_changed_aer(NvmeCtrl *n, uint32_t nsid)
> +{
> +    if (!test_and_set_bit(nsid, n->changed_nsids)) {
> +        nvme_enqueue_event(n, NVME_AER_TYPE_NOTICE,
> +                           NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
> +                           NVME_LOG_CHANGED_NSLIST);
> +    }
> +}
> +
>  static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      NvmeCtrl *n = NVME(pci_dev);
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index b7cf1494e7..f62a695132 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -54,6 +54,30 @@ void nvme_ns_init_format(NvmeNamespace *ns)
>      id_ns->npda = id_ns->npdg = npdg - 1;
>  }
>  
> +void nvme_ns_identify_common(NvmeIdNs *id_ns)
> +{
> +    id_ns->dlfeat = 0x1;
> +
> +    /* support DULBE and I/O optimization fields */
> +    id_ns->nsfeat |= (0x4 | 0x10);
> +    id_ns->mc = NVME_ID_NS_MC_EXTENDED | NVME_ID_NS_MC_SEPARATE;
> +    id_ns->dpc = 0x1f;
> +
> +    static const NvmeLBAF lbaf[16] = {
> +        [0] = { .ds =  9           },
> +        [1] = { .ds =  9, .ms =  8 },
> +        [2] = { .ds =  9, .ms = 16 },
> +        [3] = { .ds =  9, .ms = 64 },
> +        [4] = { .ds = 12           },
> +        [5] = { .ds = 12, .ms =  8 },
> +        [6] = { .ds = 12, .ms = 16 },
> +        [7] = { .ds = 12, .ms = 64 },
> +    };
> +
> +    memcpy(&id_ns->lbaf, &lbaf, sizeof(lbaf));
> +    id_ns->nlbaf = 7;
> +}
> +
>  static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
>  {
>      static uint64_t ns_count;
> @@ -65,11 +89,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
>      ns->csi = NVME_CSI_NVM;
>      ns->status = 0x0;
>  
> -    ns->id_ns.dlfeat = 0x1;
> -
> -    /* support DULBE and I/O optimization fields */
> -    id_ns->nsfeat |= (0x4 | 0x10);
> -
> +    nvme_ns_identify_common(id_ns);
>      if (ns->params.shared) {
>          id_ns->nmic |= NVME_NMIC_NS_SHARED;
>      }
> @@ -89,32 +109,15 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
>      ds = 31 - clz32(ns->blkconf.logical_block_size);
>      ms = ns->params.ms;
>  
> -    id_ns->mc = NVME_ID_NS_MC_EXTENDED | NVME_ID_NS_MC_SEPARATE;
> -
>      if (ms && ns->params.mset) {
>          id_ns->flbas |= NVME_ID_NS_FLBAS_EXTENDED;
>      }
>  
> -    id_ns->dpc = 0x1f;
>      id_ns->dps = ns->params.pi;
>      if (ns->params.pi && ns->params.pil) {
>          id_ns->dps |= NVME_ID_NS_DPS_FIRST_EIGHT;
>      }
>  
> -    static const NvmeLBAF lbaf[16] = {
> -        [0] = { .ds =  9           },
> -        [1] = { .ds =  9, .ms =  8 },
> -        [2] = { .ds =  9, .ms = 16 },
> -        [3] = { .ds =  9, .ms = 64 },
> -        [4] = { .ds = 12           },
> -        [5] = { .ds = 12, .ms =  8 },
> -        [6] = { .ds = 12, .ms = 16 },
> -        [7] = { .ds = 12, .ms = 64 },
> -    };
> -
> -    memcpy(&id_ns->lbaf, &lbaf, sizeof(lbaf));
> -    id_ns->nlbaf = 7;
> -
>      for (i = 0; i <= id_ns->nlbaf; i++) {
>          NvmeLBAF *lbaf = &id_ns->lbaf[i];
>          if (lbaf->ds == ds) {
> @@ -402,10 +405,6 @@ int nvme_ns_setup(NvmeNamespace *ns, Error **errp)
>          return -1;
>      }
>  
> -    if (nvme_ns_init_blk(ns, errp)) {
> -        return -1;
> -    }
> -
>      if (nvme_ns_init(ns, errp)) {
>          return -1;
>      }
> @@ -481,6 +480,15 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
>          }
>      }
>  
> +    if (nvme_ns_init_blk(ns, errp)) {
> +        return;
> +    }
> +
> +    if (!ns->size) {
> +        QSLIST_INSERT_HEAD(&subsys->unallocated_namespaces, ns, entry);
> +        return;
> +    }
> +
>      if (nvme_ns_setup(ns, errp)) {
>          return;
>      }
> @@ -519,6 +527,7 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
>  
>                  if (ctrl) {
>                      nvme_attach_ns(ctrl, ns);
> +                    ctrl->id_ctrl.unvmcap -= le64_to_cpu(ns->size);
>                  }
>              }
>  
> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index 83ffabade4..142268f4e0 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -51,9 +51,11 @@ typedef struct NvmeSubsystem {
>  
>      NvmeCtrl      *ctrls[NVME_MAX_CONTROLLERS];
>      NvmeNamespace *namespaces[NVME_MAX_NAMESPACES + 1];
> +    QSLIST_HEAD(, NvmeNamespace) unallocated_namespaces;
>  
>      struct {
>          char *nqn;
> +        uint64_t tnvmcap;
>      } params;
>  } NvmeSubsystem;
>  
> @@ -130,7 +132,7 @@ typedef struct NvmeNamespace {
>      uint16_t     status;
>      int          attached;
>  
> -    QTAILQ_ENTRY(NvmeNamespace) entry;
> +    QSLIST_ENTRY(NvmeNamespace) entry;
>  
>      NvmeIdNsZoned   *id_ns_zoned;
>      NvmeZone        *zone_array;
> @@ -259,6 +261,7 @@ int nvme_ns_setup(NvmeNamespace *ns, Error **errp);
>  void nvme_ns_drain(NvmeNamespace *ns);
>  void nvme_ns_shutdown(NvmeNamespace *ns);
>  void nvme_ns_cleanup(NvmeNamespace *ns);
> +void nvme_ns_identify_common(NvmeIdNs *id_ns);
>  
>  typedef struct NvmeAsyncEvent {
>      QTAILQ_ENTRY(NvmeAsyncEvent) entry;
> @@ -495,6 +498,8 @@ static inline uint16_t nvme_cid(NvmeRequest *req)
>  }
>  
>  void nvme_attach_ns(NvmeCtrl *n, NvmeNamespace *ns);
> +void nvme_detach_ns(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid);
> +void nvme_ns_attr_changed_aer(NvmeCtrl *n, uint32_t nsid);
>  uint16_t nvme_bounce_data(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>                            NvmeTxDirection dir, NvmeRequest *req);
>  uint16_t nvme_bounce_mdata(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
> index 93c35950d6..e30bfbca81 100644
> --- a/hw/nvme/subsys.c
> +++ b/hw/nvme/subsys.c
> @@ -53,11 +53,14 @@ static void nvme_subsys_realize(DeviceState *dev, Error **errp)
>      qbus_create_inplace(&subsys->bus, sizeof(NvmeBus), TYPE_NVME_BUS, dev,
>                          dev->id);
>  
> +    QSLIST_INIT(&subsys->unallocated_namespaces);
> +
>      nvme_subsys_setup(subsys);
>  }
>  
>  static Property nvme_subsystem_props[] = {
>      DEFINE_PROP_STRING("nqn", NvmeSubsystem, params.nqn),
> +    DEFINE_PROP_SIZE("tnvmcap", NvmeSubsystem, params.tnvmcap, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 77aae01174..8a8ca6753b 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -592,6 +592,7 @@ enum NvmeAdminCommands {
>      NVME_ADM_CMD_SET_FEATURES   = 0x09,
>      NVME_ADM_CMD_GET_FEATURES   = 0x0a,
>      NVME_ADM_CMD_ASYNC_EV_REQ   = 0x0c,
> +    NVME_ADM_CMD_NS_MANAGEMENT  = 0x0d,
>      NVME_ADM_CMD_ACTIVATE_FW    = 0x10,
>      NVME_ADM_CMD_DOWNLOAD_FW    = 0x11,
>      NVME_ADM_CMD_NS_ATTACHMENT  = 0x15,
> @@ -882,6 +883,9 @@ enum NvmeStatusCodes {
>      NVME_FEAT_NOT_CHANGEABLE    = 0x010e,
>      NVME_FEAT_NOT_NS_SPEC       = 0x010f,
>      NVME_FW_REQ_SUSYSTEM_RESET  = 0x0110,
> +    NVME_NS_INSUFF_CAP          = 0x0115,
> +    NVME_THIN_PROVISION_NO_SUPP = 0x011b,
> +    NVME_NS_ID_UNAVAILABLE      = 0x0116,
>      NVME_NS_ALREADY_ATTACHED    = 0x0118,
>      NVME_NS_PRIVATE             = 0x0119,
>      NVME_NS_NOT_ATTACHED        = 0x011a,
> @@ -1056,8 +1060,10 @@ typedef struct QEMU_PACKED NvmeIdCtrl {
>      uint16_t    mtfa;
>      uint32_t    hmpre;
>      uint32_t    hmmin;
> -    uint8_t     tnvmcap[16];
> -    uint8_t     unvmcap[16];
> +    uint64_t    tnvmcap;
> +    uint64_t    tnvmcap_u;
> +    uint64_t    unvmcap;
> +    uint64_t    unvmcap_u;
>      uint32_t    rpmbs;
>      uint16_t    edstt;
>      uint8_t     dsto;
> @@ -1154,6 +1160,11 @@ enum NvmeIdCtrlCmic {
>      NVME_CMIC_MULTI_CTRL    = 1 << 1,
>  };
>  
> +enum NvmeNsManagementOperation {
> +    NVME_NS_MANAGEMENT_CREATE = 0x0,
> +    NVME_NS_MANAGEMENT_DELETE = 0x1,
> +};
> +
>  #define NVME_CTRL_SQES_MIN(sqes) ((sqes) & 0xf)
>  #define NVME_CTRL_SQES_MAX(sqes) (((sqes) >> 4) & 0xf)
>  #define NVME_CTRL_CQES_MIN(cqes) ((cqes) & 0xf)
> @@ -1285,7 +1296,8 @@ typedef struct QEMU_PACKED NvmeIdNs {
>      uint16_t    nabo;
>      uint16_t    nabspf;
>      uint16_t    noiob;
> -    uint8_t     nvmcap[16];
> +    uint64_t    nvmcap;
> +    uint64_t    nvmcap_u;
>      uint16_t    npwg;
>      uint16_t    npwa;
>      uint16_t    npdg;
> -- 
> 2.17.1
> 

Hi Naveen,

I found a bug, it is not possible to attach a created shared namespace
to more than one controller with current implementation.

Here is the fix.

---
 hw/nvme/ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 992aaa7d02..63ea2fcb14 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5390,6 +5390,7 @@ static uint16_t nvme_ns_management(NvmeCtrl *n, NvmeRequest *req)
 static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
+    NvmeIdNs *id_ns;
     NvmeCtrl *ctrl;
     uint16_t list[NVME_CONTROLLER_LIST_SIZE] = {};
     uint32_t nsid = le32_to_cpu(req->cmd.nsid);
@@ -5420,6 +5421,7 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
         return NVME_NS_CTRL_LIST_INVALID | NVME_DNR;
     }
 
+    id_ns = &ns->id_ns;
     *nr_ids = MIN(*nr_ids, NVME_CONTROLLER_LIST_SIZE - 1);
     for (i = 0; i < *nr_ids; i++) {
         ctrl = nvme_subsys_ctrl(n->subsys, ids[i]);
@@ -5432,7 +5434,7 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
                 return NVME_NS_ALREADY_ATTACHED | NVME_DNR;
             }
 
-            if (ns->attached && !ns->params.shared) {
+            if (ns->attached && !(id_ns->nmic & NVME_NMIC_NS_SHARED)) {
                 return NVME_NS_PRIVATE | NVME_DNR;
             }
 
-- 
2.25.1


