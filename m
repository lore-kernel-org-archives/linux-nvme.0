Return-Path: <SRS0=38m3=E5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62348C63697
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 17:36:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6602075A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 17:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rL03izmo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0DUiSz9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6602075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IXN44XWoiuY+lPUTRves4sF5TZh17OgPNmyW3gUyL6M=; b=rL03izmo6mTjwJ6r3FZ+iQ0BU
	nrAS8hGlYNp0hiv6VaDbjYI8dSChyrSIgYt4m1/2inBh3QkEqJpEC7VUNlv8Zt0wVUCGuNdbWi2cK
	ag92I06wa6MeR5ezYOhsmB+kSKkV6se4m+rvROg6EdDSt1kes4BcPKI6sD5+SfHyv8Ti8ve6Q9sn9
	WAmMj4YDT0MHOO2B8YX9riAfHVn52J/rDE2IJWkJytuE0ppe0n5O6pPDUeyFbqL20Xfl/bT+Faeup
	Y+b9Lyx3JnB+tEr2gYEM6JJRZ/hRaUzDEK8k7xnin+KO9JsUPQBA8UI84qRbl9Tuuy6dY/LwTBLBV
	2i9kDYo1A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khFlD-0003IX-7k; Mon, 23 Nov 2020 17:36:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khFl9-0003Hi-VG
 for linux-nvme@lists.infradead.org; Mon, 23 Nov 2020 17:36:16 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 83E042072C;
 Mon, 23 Nov 2020 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606152974;
 bh=D3jpepm4TK3h+c/piftZB/nqdqo6hP6hhir7hGISvr0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0DUiSz9NBR+hON4L6iFr7TkFqsjTD+zuenbL2CVfi9wlmGk4SsbqZtgc+d2jM58ra
 deLmZIawEX2OfxOYeebwR+jr605qxwRJ5uhG+g2aGrUhuh51vGdiPqxWmUCG0EHvz3
 lcTRQ87on3F8N47bxkXZ7guOhZ0DL+0wpRZs2WA0=
Date: Mon, 23 Nov 2020 09:36:11 -0800
From: Keith Busch <kbusch@kernel.org>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201123173611.GB2865091@dhcp-10-100-145-180.wdc.com>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
 <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201120094432.GA25846@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_123616_088085_6CAE224C 
X-CRM114-Status: GOOD (  22.95  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 20, 2020 at 10:44:32AM +0100, hch@lst.de wrote:
> On Wed, Nov 18, 2020 at 08:09:43PM +0000, George, Martin wrote:
> > > How can the namespace reference an ANA group that we haven't been
> > > notified about using the NVME_AEN_CFG_ANA_CHANGE AEN before?
> > 
> > Well, I think that could be possible for a newly created namespace,
> > which happens to belong to a new ANA group. To quote the 1.4 spec in
> > context of Asymmetric Namespace Access Change under the Asynchronous
> > Event Information - Notice (Figure 147):
> > 
> > "A controller shall not send this event if:
> > a) the change is due to the creation of a namespace (refer to section
> > 5.20); or
> > b) the change is due to the deletion of a namespace (refer to section
> > 5.20),
> > as the Namespace Attribute Changed event is sent for these changes."
> > 
> > So it looks the NVME_AEN_CFG_ANA_CHANGE AEN is not required here for
> > such cases, but instead the NVME_AEN_CFG_NS_ATTR AEN would do.
> 
> For the newly created namespace to beong to a newly created ANA group
> the controller first needs to send NVME_AEN_CFG_ANA_CHANGE to announce
> the ANA group, it then send NVME_AEN_CFG_NS_ATTR to announce the
> new namespaces.  But the new namespace can't reference an ANA group
> that didn't exist, that is a separate event.

That sequence would have a group with no namespaces, which I is okay,
but we can tolerant targets that don't use that sequence without much
difficulty. This ought to do it:

---
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 74896be40c17..300cff8c616d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -667,6 +667,8 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 		if (desc.state) {
 			/* found the group desc: update */
 			nvme_update_ns_ana_state(&desc, ns);
+		} else {
+			nvme_read_ana_log(ctrl);
 		}
 	} else {
 		ns->ana_state = NVME_ANA_OPTIMIZED; 
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
