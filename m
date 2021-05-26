Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D6BC2B9F7
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 11:01:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6822E610CB
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 11:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6822E610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jmTSs6SQ/RxhkVg/TUUkExEYJ7sCWRCJnWNav8OIUVY=; b=wxjXnwMSXJJ2L94+9wplu7V463
	PNTiPSXYo3wNoxEJJI5Na4c2vyYCwkvuvJVgIdDQusuT11/4Baj6IIXFfC2gkzqwInwgjrHlQZWLR
	C2halixAW7owonojd5jJX3/spaWzz6u3/RkmH9F8LFIjx2w7CfG5AmRdJfXOoWkPNayaE0VTCV8LD
	upqWGQuzgVqT0l+LxTZZl4xrDot8zW5rv1/HaF1NaPdcaRiYbfeyI1PlDCRWWNjGyY5tDESm23X4a
	eb5jUMoJ5SkSbMFCMP01x3mgWEm5stSnx0ax5GCmUJVlRdnW+7Omw69dtxxu1/yekbSw9rngJci79
	ipK6ITow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llrHr-00DOAO-CM; Wed, 26 May 2021 11:01:19 +0000
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llpaF-00Clgw-VA
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 09:12:13 +0000
Received: by mail-pg1-f169.google.com with SMTP id e22so406363pgv.10
 for <linux-nvme@lists.infradead.org>; Wed, 26 May 2021 02:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+Vxhxk+IJy7H1Y/NpicvN3xW1/S+o+bAwFuSsIrTggw=;
 b=Q+/1boca9KOFqoOk9F0X1CTco9V6xaXGX/T59qn3UqRwYJ8qnxbRBCdCS2tE3X2eYY
 IRRvlpJtLjTXHkbhymu9wYyO9ip1jbzfFJD2YLymQXhJMQAOALHHDcZqszaVBGlrhCI8
 xBWJkzvjjApdPHu3wwSo96Mo27219+ZQ0QvdVVWr7eDEKo6ZyhT2oJ1NHJHVbyio6yN7
 y+ijSbYaF8gbH6MFXmfR/+dscSbg7AGbEr5BO9GgiRoz883/d2JZnv9zBD8PE3GDB3J6
 XjeA/U0gpoqOkMgQVuCtRAnB8E7X4VDXtm1LRtl7gt+Cbo0s6FQR0Xsqlm3bjKpyhvr2
 GGnA==
X-Gm-Message-State: AOAM531Q4mD7pQko4L1jRzZJ2i2StwD/LJsCfZOVFcQQh/NMC7rstWpm
 u2ez56tD2H7EBW6oD/uJ3NKGMQ0Gex0=
X-Google-Smtp-Source: ABdhPJy7uoSHwA1rNS3RjQKRWJZ/c/eLldmJ89nh+J8yO06Qsbf+CNbeoVEK8wUk3al7j0dkMN2Hlw==
X-Received: by 2002:a63:2dc4:: with SMTP id t187mr24362122pgt.80.1622020330512; 
 Wed, 26 May 2021 02:12:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3726:dadd:2909:e6bb?
 ([2601:647:4802:9070:3726:dadd:2909:e6bb])
 by smtp.gmail.com with ESMTPSA id c16sm15292676pfd.206.2021.05.26.02.12.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 02:12:09 -0700 (PDT)
Subject: Re: [bug report] nvme sends invalid command capsule over rdma
 transport for 5KiB write when target supports MSDBD > 1
To: "Walker, Benjamin" <benjamin.walker@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR11MB2824E1B94D81B837E474A7A6EF269@BYAPR11MB2824.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dc96c3cf-e895-77c0-3d1a-1bc7e96cfd40@grimberg.me>
Date: Wed, 26 May 2021 02:12:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB2824E1B94D81B837E474A7A6EF269@BYAPR11MB2824.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_021212_084906_6E93AD22 
X-CRM114-Status: GOOD (  21.33  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> This bug was found using the iozone tool.
> 
> - Linux kernel initiator, SPDK target, RDMA (RoCEv2) transport
> - iozone is performing a 5KiB write to a 512 byte block size nvme device
> - The SPDK target has reported that it supports 4KiB of in-capsule data, MSDBD of 16 (number of SGL descriptors), and ICDOFF of 0.
> - The Linux kernel sends an NVMe-oF capsule with a command that claims to have 5KiB of data in the command, but actually only has a single SGL element describing 4KiB of data in-capsule.
> - The SPDK target correctly fails this I/O
> 
> This fails on at least 5.11 but worked prior to 5.4. A git bisect shows that this commit is responsible: 38e1800275d3af607e4df92ff49dc2cf442586a4
> 
> I believe the key is the use of MSDBD > 1 and in-capsule data support. This seems to trick the initiator into thinking it can do 5KiB in one command with two SGL elements, but then the initiator goes down the in-capsule data path and can only describe 4KiB that way.

I think it may be a wrong iteration on the scatterlist (which means
that iozone generated a scatterlist with more than 2 entries, causing
the sg_table to be chained).

Does this make the issue go away?
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8d107b201f16..44cfcaeb5f2e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1319,22 +1319,22 @@ static int nvme_rdma_map_sg_inline(struct 
nvme_rdma_queue *queue,
                 struct nvme_rdma_request *req, struct nvme_command *c,
                 int count)
  {
-       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
-       struct scatterlist *sgl = req->data_sgl.sg_table.sgl;
+       struct nvme_sgl_desc *sgl = &c->common.dptr.sgl;
+       struct scatterlist *sg, *scat = req->data_sgl.sg_table.sgl;
         struct ib_sge *sge = &req->sge[1];
         u32 len = 0;
         int i;

-       for (i = 0; i < count; i++, sgl++, sge++) {
-               sge->addr = sg_dma_address(sgl);
-               sge->length = sg_dma_len(sgl);
+       for_each_sg(scat, sg, count, i) {
+               sge->addr = sg_dma_address(sg);
+               sge->length = sg_dma_len(sg);
                 sge->lkey = queue->device->pd->local_dma_lkey;
                 len += sge->length;
         }

-       sg->addr = cpu_to_le64(queue->ctrl->ctrl.icdoff);
-       sg->length = cpu_to_le32(len);
-       sg->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;
+       sgl->addr = cpu_to_le64(queue->ctrl->ctrl.icdoff);
+       sgl->length = cpu_to_le32(len);
+       sgl->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;

         req->num_sge += count;
         return 0;
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
