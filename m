Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C34C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 07:56:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8342D64E90
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 07:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8342D64E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Subject:References:In-Reply-To:
	Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oxp76yLxCoG4fmXaSi7L8T5HxuU7XOlIrChE5LN1VJs=; b=VeRwVLuGQEr1ai8Sk1ufHwwCT
	qnG2T3/Pu39AphkY8eM+1XKk4yDVY+Z1ZrOB3VUjgAB9ycgMsyAHtdcUL2t1r0/ILuIOP2UcN2kaf
	zB5baRXs8/5BRJ8ED+p6t68C7xwKi2ClX7/XV1P2QybL67A4H8jMzD7OSBp+TjELXWwjH3FcvGHP7
	LR34P25ke0pKDpM4KS2vBMdBkmvkLsvohGpv6KL+yzdNBQsyqOYQXF8raNXZ9pAcrVhKvckXxzjf5
	FI+I0K2/Ze+x9W0xwLSz53LPnQwY5+rXI73K+z4hx/kcG6K2k/TkB5bhtuQWNPrEku6Fwlri+1WXK
	SSVqa6bUg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFBVW-0006YX-Fb; Thu, 25 Feb 2021 07:56:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFBVQ-0006XP-Iz
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 07:56:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614239775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RImeT2ZQe2S/PdjknPovDHAWTW3Xv540+GVPBoqoxQ4=;
 b=b4XcHoiBEdcauSQO5b8Hnt3uzpbLBuGzaujpq+TIGIaQL6o98RzhWsNsjxR6Sti88l6jSV
 Z2JmX5UDUK0GdLJY8I6gyvEFlnXV1txrR/EI3uiq91oU1iNkyRgQOTGPpo4Zq13vGAF064
 RVS8Rfswp10sYIUkg/b9BdSvG9WCTTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-ZwfRl3C7PLSJoF2fAQDLJg-1; Thu, 25 Feb 2021 02:56:13 -0500
X-MC-Unique: ZwfRl3C7PLSJoF2fAQDLJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEDF1107ACE6;
 Thu, 25 Feb 2021 07:56:11 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB1D62BFE2;
 Thu, 25 Feb 2021 07:56:11 +0000 (UTC)
Received: from zmail20.collab.prod.int.phx2.redhat.com
 (zmail20.collab.prod.int.phx2.redhat.com [10.5.83.23])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9D83E18095C7;
 Thu, 25 Feb 2021 07:56:11 +0000 (UTC)
Date: Thu, 25 Feb 2021 02:56:11 -0500 (EST)
From: Gopal Tiwari <gtiwari@redhat.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Message-ID: <763823888.32269629.1614239771387.JavaMail.zimbra@redhat.com>
In-Reply-To: <BYAPR04MB496509F7429C820F6A8DF37F869E9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210209045902.72345-1-gtiwari@redhat.com>
 <211078952.30654328.1612955843198.JavaMail.zimbra@redhat.com>
 <20210210131557.GB29904@lst.de>
 <BYAPR04MB49650A271CD1C1B3EFA72F3D868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210211070748.GA13852@lst.de>
 <BYAPR04MB4965C95C3F826D7222EB3176868C9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210224091326.GA5159@lst.de>
 <BYAPR04MB496509F7429C820F6A8DF37F869E9@BYAPR04MB4965.namprd04.prod.outlook.com>
Subject: Re: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write
 Zeroes command
MIME-Version: 1.0
X-Originating-IP: [10.64.242.103, 10.4.195.7]
Thread-Topic: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write
 Zeroes command
Thread-Index: AQHW/qFWhMgmVmIHi0+62c2Fpd6hivR/Ze8/
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gtiwari@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_025616_842832_5F43C387 
X-CRM114-Status: GOOD (  21.94  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@infradead.org, kbusch@kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Chaitanya, 

No feedback on the patch yet. 

Thanks 
Gopal  

----- Original Message -----
From: "Chaitanya Kulkarni" <Chaitanya.Kulkarni@wdc.com>
To: "Christoph Hellwig" <hch@lst.de>
Cc: hch@infradead.org, kbusch@kernel.org, "Gopal Tiwari" <gtiwari@redhat.com>, linux-nvme@lists.infradead.org
Sent: Thursday, February 25, 2021 7:39:33 AM
Subject: Re: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write Zeroes command

On 2/24/21 01:13, Christoph Hellwig wrote:
> On Thu, Feb 11, 2021 at 06:11:19PM +0000, Chaitanya Kulkarni wrote:
>> On 2/10/21 11:07 PM, Christoph Hellwig wrote:
>>>>> I'd also love to retest most Write Zeroes quirks with that in place.
>>>> Do you prefer some variant of the following patch (totally untested)? OR
>>>> something else ?
>>> Somwhat.  As said I suspect defaulting to MDTS with a big fat comment
>>> might make most sense unless the new WZSL is set.
>>>
>> Okay, will send out patche(s) soon.
> Did you get to this?  Or did I just miss it?
>
I sent out WIP to Gopal on 02/13 due to lack of drive.

Not sure if makes sense to start the review where patch is
not tested on the real H/w, here it is :-

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e68a8c4ac5a6..62c928fb0ded 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1965,6 +1965,7 @@ static void nvme_config_discard(struct gendisk
*disk, struct nvme_ns *ns)
 
 static void nvme_config_write_zeroes(struct gendisk *disk, struct
nvme_ns *ns)
 {
+       bool use_mdts = ns->ctrl->quirks & NVME_QUIRK_USE_MDTS_WRITE_ZEROES;
        u64 max_blocks;
 
        if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
@@ -1980,7 +1981,9 @@ static void nvme_config_write_zeroes(struct
gendisk *disk, struct nvme_ns *ns)
         * configured based on the controller's MDTS field in the
         * nvme_init_identify() if available.
         */
-       if (ns->ctrl->max_hw_sectors == UINT_MAX)
+       if (use_mdts && ns->ctrl->max_mdts_hw_sectors)
+               max_blocks = ns->ctrl->max_mdts_hw_sectors + 1;
+       else if (ns->ctrl->max_hw_sectors == UINT_MAX)
                max_blocks = (u64)USHRT_MAX + 1;
        else
                max_blocks = ns->ctrl->max_hw_sectors + 1;
@@ -3136,10 +3139,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
        atomic_set(&ctrl->abort_limit, id->acl + 1);
        ctrl->vwc = id->vwc;
+       ctrl->max_mdts_hw_sectors = 0;
+       max_hw_sectors = UINT_MAX;
        if (id->mdts)
                max_hw_sectors = 1 << (id->mdts + page_shift - 9);
-       else
-               max_hw_sectors = UINT_MAX;
        ctrl->max_hw_sectors =
                min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..906b26b3d306 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -150,6 +150,12 @@ enum nvme_quirks {
         * 48 bits.
         */
        NVME_QUIRK_DMA_ADDRESS_BITS_48          = (1 << 16),
+
+       /*
+        * The controller doesn't allow the write zeores command of size
+        * more than reported by the MDTS
+        */
+       NVME_QUIRK_USE_MDTS_WRITE_ZEROES        = (1 << 17)
 };
 
 /*
@@ -274,6 +280,7 @@ struct nvme_ctrl {
 
        u64 cap;
        u32 max_hw_sectors;
+       u32 max_mdts_hw_sectors;
        u32 max_segments;
        u32 max_integrity_segments;
 #ifdef CONFIG_BLK_DEV_ZONED
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 207137a0ed8e..f9f36d26828b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3268,6 +3268,8 @@ static const struct pci_device_id nvme_id_table[] = {
                .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
        { PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
                .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+       { PCI_DEVICE(0x1c5c, 0x2839),  /* SK Hynix PE8000 U.3 NVMe
storage */
+               .driver_data = NVME_QUIRK_USE_MDTS_WRITE_ZEROES, },
        { PCI_DEVICE(0x2646, 0x2262),   /* KINGSTON SKC2000 NVMe SSD */
                .driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
        { PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index cb6f86572b24..38fffee6b85e 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -688,7 +688,8 @@ static struct nvmf_transport_ops nvme_loop_transport = {
        .name           = "loop",
        .module         = THIS_MODULE,
        .create_ctrl    = nvme_loop_create_ctrl,
-       .allowed_opts   = NVMF_OPT_TRADDR,
+       .allowed_opts   = NVMF_OPT_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
+
 };
 
 static int __init nvme_loop_init_module(void)


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
