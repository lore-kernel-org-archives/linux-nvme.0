Return-Path: <SRS0=MUCY=OP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E9EC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 20:39:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153FB60E76
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 20:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 153FB60E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K32dc6lBsuz066HYxnbS+YeouHx8LT5Mgf76sXrrcoY=; b=q0x/RAwgnAo1y+
	ZHJMexZu/Yzrzp/XufIo6aW28TX2bDjHjCkiDtjtjxrRxzY5cSbQcV9sUp6ziLHgjj3aLV0EUuHEP
	1gaNSwZLv454gHiCHucO2BK47nyoUYoQrL99vs7BOoy2fsmf1qUYUJXetAFF3SwtoPm7S1AVKn3qp
	nkFrN5AtsA8SfYsNKeOavY0DdDVJZYbED5E4gtj+ei/FxyOTZ5OGrejPqg/7RkBdFAayGffuGlOvQ
	QGWMDmy/bioQthoiKPirPDI9dzsPpripzu2oanXCAV2l2do1ecdxDdXjtD4V/NNwendYOBzF54q7i
	A6pUHWnzcsOTZkT9r6dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUERr-00HDJ0-LH; Sat, 25 Sep 2021 20:39:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUERo-00HDIN-IW
 for linux-nvme@lists.infradead.org; Sat, 25 Sep 2021 20:39:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E03560F4B;
 Sat, 25 Sep 2021 20:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632602340;
 bh=ldPHFYhy+RgAg2IGaXUZcTLr+nQ9ccV2OZg06CSTSmE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OjyMVsIk3A/oEI9NPBBezI+qeW1CYvmErbWkLb/+Wq6CnZVuxhJQBoxIbx5k0TgRT
 JQQhComOB1XCkrGV1sfu/nfjaZhOSJkRfrK0kDsfFbrJ2cezz88aRIkxmEJU6OkwLI
 qLsyU8PrtSYwyRt7eOK7aCQAbdRdMLTLomk3NpR3ZAP9ubjuh6Y/l17gvzdbE0IPk5
 2h72jPoHEYlxUnaYjN6gvwDB6Kha4aJWHLBhJl89ZJy3z68G2twuf/WEpNSEZDj/9Y
 NQsFDp5VC2K9cxAiF7PrF6RYQbxL4Sgdbd3hjHbVmowm7pEUA10C9d0A3xn6kuO6Mm
 /e7/IIhTS0Ihg==
Date: Sat, 25 Sep 2021 13:38:57 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Aditya Garg <gargaditya08@live.com>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.
Message-ID: <20210925203857.GC116968@dhcp-10-100-145-180.wdc.com>
References: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
 <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com>
 <4849f3d3-4abd-49b7-b053-d7965daa7138@www.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4849f3d3-4abd-49b7-b053-d7965daa7138@www.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_133900_667534_E0629ED4 
X-CRM114-Status: GOOD (  44.90  )
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

On Sat, Sep 25, 2021 at 10:08:53PM +0200, Sven Peter wrote:
> I actually ran into a similar issue while adding support for the NVMe
> controller found on the M1 and assumed it was only present there.
> 
> Some background why this happens: ANS2 is a co-processor that emulates
> an NVMe MMIO interface and uses the tag as an index to an internal data
> structure. 

Thanks for confirming the behavior. The patch should restore the
command_id values to when everything was working. I'll just need to
update the quirk description to better align with the actual limitation
if the patch is successful. 

> On the M1 we can directly talk to ANS2 and while we can submit
> commands with a higher index it'll just ignore the upper bits and only
> return the lowest eight IIRC in the completion queue.
> I guess whatever software is running on the T2 actually has an assert to
> ensure that the tag is within the limits before forwarding the command
> to ANS2.

Is the PCI Device ID for the M1 the same as reported for the T2? Either
0x2005 or 0x2003 should make this quirk apply.

Side note, I mistakenly added an entry for device ID 0x2006, but that
was from me misreading the report.

> Best,
> 
> Sven
> 
> 
> On Sat, Sep 25, 2021, at 21:54, Keith Busch wrote:
> > On Sat, Sep 25, 2021 at 11:47:08AM -0700, Linus Torvalds wrote:
> >> On Fri, Sep 24, 2021 at 9:02 PM Aditya Garg <gargaditya08@live.com> wrote:
> >> >
> >> > From: Aditya Garg <gargaditya08@live.com>
> >> > Date: Fri, 24 Sep 2021 15:36:45 +0530
> >> > Subject: [PATCH] Revert nvme to 5.14.5 to fix incompatibility arised in Apple SSDs.
> >> > Fixes: e7006de6c238 (nvme: code command_id with a genctr for use-after-free validation)
> >> 
> >> I think we need to hear more about the problem than just revert a
> >> commit like this randomly. That commit has already been picked up for
> >> -stable,
> >> 
> >> What are the exact symptoms, and which Apple SSD is this?
> >> 
> >> I do find this:
> >> 
> >>   https://lore.kernel.org/all/cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com/
> >> 
> >> which instead of a revert has an actual patch. Can you try that one?
> >> 
> >> Keith Busch replied to that one, saying that the Apple SSD might not
> >> be spec compliant, but hey, what else is new? If we start demanding
> >> that hardware comply with specs, we'd have to scrap the whole notion
> >> of working in the real world. Plus it would be very hypocritical of
> >> us, since we ignore all specs when we deem them too limiting (whether
> >> they be language specs, POSIX OS specs, or whatever).
> >
> > Right, we have a lot of quirks for the apple controllers, what's one
> > more? :)
> >
> > Could the following patch be tried? I'm basing this off the 'lspci' from
> > Orlando, but I'm assuming the previous model has the same limitation,
> > too.
> >
> > ---
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 7efb31b87f37..f0787233557f 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -979,6 +979,7 @@ EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
> >  blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
> >  {
> >  	struct nvme_command *cmd = nvme_req(req)->cmd;
> > +	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
> >  	blk_status_t ret = BLK_STS_OK;
> > 
> >  	if (!(req->rq_flags & RQF_DONTPREP)) {
> > @@ -1027,7 +1028,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, 
> > struct request *req)
> >  		return BLK_STS_IOERR;
> >  	}
> > 
> > -	nvme_req(req)->genctr++;
> > +	if (!(ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
> > +		nvme_req(req)->genctr++;
> >  	cmd->common.command_id = nvme_cid(req);
> >  	trace_nvme_setup_cmd(req, cmd);
> >  	return ret;
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index 9871c0c9374c..b49761d30df7 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -86,6 +86,12 @@ enum nvme_quirks {
> >  	 */
> >  	NVME_QUIRK_NO_DEEPEST_PS		= (1 << 5),
> > 
> > +	/*
> > +	 * The controller requires the command_id value be be limited to the
> > +	 * queue depth.
> > +	 */
> > +	NVME_QUIRK_SKIP_CID_GEN			= (1 << 6),
> > +
> >  	/*
> >  	 * Set MEDIUM priority on SQ creation
> >  	 */
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index b82492cd7503..d9f22ed68185 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -3369,7 +3369,10 @@ static const struct pci_device_id nvme_id_table[] = {
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
> >  		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
> >  				NVME_QUIRK_128_BYTES_SQES |
> > -				NVME_QUIRK_SHARED_TAGS },
> > +				NVME_QUIRK_SHARED_TAGS ,
> > +				NVME_QUIRK_SKIP_CID_GEN },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2006),
> > +		.driver_data = NVME_QUIRK_SKIP_CID_GEN },
> > 
> >  	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
> >  	{ 0, }
> > --
> 
> -- 
> Sven Peter

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
