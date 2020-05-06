Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32519C28CBC
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 13:24:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F9D206DB
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 13:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KJ3u1Ow4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUJWXEM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F9D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mN6WAw75G4f5Wod++lT512qXy4kGiPkFTU+nP6mMdOk=; b=KJ3u1Ow4p7g5RR
	AmP0pLZ7qQMVFaMI4pxEElmLvKu1eYmWBwixF0awVVeCdax5ICzjrjdmwrqC009B0dSjhTNVj0spF
	Q/CmSU6wc7O/Hv9bjVZkHsJtRinayLS627U0IhnmvKy4hp0MYENFqg4gxAdZPEUuRnx4dwTpWXTjY
	gkbIlAtUfQn9tlJkuPrdfohjMowDn4PIBB0phZzj6Eo0zFSju6xfefOKEH9K1y4uY4g6ZPHJD7WDV
	FtBh6tVq2pCf1RQN0ohtLv0A+tO/naQjqOa49mae0wKnG7qtNPR2sZIrZZ9t51PVm1okMWEM9MZjf
	BV4tlitElyW5vnv4Yw5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWK2O-00053W-Tq; Wed, 06 May 2020 13:24:36 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWK2M-000534-6X
 for linux-nvme@lists.infradead.org; Wed, 06 May 2020 13:24:35 +0000
Received: by mail-wm1-x343.google.com with SMTP id u16so2633029wmc.5
 for <linux-nvme@lists.infradead.org>; Wed, 06 May 2020 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=HZSIDWP+eK9MR6666kojX7mQWszHDo6TYyqVsv9mPAc=;
 b=MUJWXEM6juGcApvRlQBlw7Px8gqIKeHAs+aApwwhp87TMPObagvDIVWDNcey7PYNjQ
 cid7UIeEvt0Jh6/1MATVGk+Kd5i3NDcYeEv/ljaFGJ3BRRJGTevoZZH5ZbiRtwWPg6AA
 70rf8nYkXCs4O7b695oeLLFNYncvtpr3bxCqQHhrbESNOs95Hgmno9AcudkiaP4/8Hml
 mwfCaLT2ZImg6S4xVrpUD4HhpQm11VnHcXW0Zarv+miropyHRlK03bHuyAVQDUqEwQS+
 J3LkbjUVHzTa+90RaR1U2Wtmy/k8qK+ORmzd5pgZY5laDPZbCtzhayB0rl9O75tvE1B4
 +wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HZSIDWP+eK9MR6666kojX7mQWszHDo6TYyqVsv9mPAc=;
 b=Dj5E2rZXUmIRxb5l11l6+k4w3eBdlJVittwFkhVLNEyJN2yvBlHRXtzxuEmYlxoNZh
 RrpIslkDRyA6Mwyr3VzFHqOOVT7PfmAcX9JyoDDcQmOLjo4giHupDPGtRy4QuHE73fOl
 G0s5ZX3bv4hAMRJRTtaItkv6yxMEuoXkryLjMh4SW4fVDg2nlItE95O041HRtuClmXBS
 JJkRYWwH/2S3A2dId89uya8afFJ0R32ZDlT80uvusSNklVbiW7Eo7n1OMlsVz+tYzlDx
 LtQoRtAcJOsfvGo1Fr1eTJFlCgKFbre2V7sO0fIYocAWJPJqscRbBkRo3ZSVypvaiTQC
 MFbQ==
X-Gm-Message-State: AGi0Pua7zoueWFKDLAX3+dJTA4vkvirb7egQd6wCO3NkOoTY3VVCJOyS
 FywdonXO2/cd1s6ftThiOpVyKBY=
X-Google-Smtp-Source: APiQypIeNB1UfBLwGxDvzCkjtxjh7XdwjeZosMuHYQ7Ebk0bpzvA1Bj3Aow+l6jtEm7zWN2qM6gUYw==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr4464573wmc.142.1588771472123; 
 Wed, 06 May 2020 06:24:32 -0700 (PDT)
Received: from avx2 ([46.53.250.199])
 by smtp.gmail.com with ESMTPSA id k6sm3067615wma.19.2020.05.06.06.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 06:24:31 -0700 (PDT)
Date: Wed, 6 May 2020 16:24:29 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
Message-ID: <20200506132429.GA21451@avx2>
References: <20200228184519.GA2281@avx2>
 <20200229055351.GA542920@dhcp-10-100-145-180.wdl.wdc.com>
 <defb25c5-5ae5-5ff9-66db-efb129bd7743@huawei.com>
 <20200506124701.GA54933@C02WT3WMHTD6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200506124701.GA54933@C02WT3WMHTD6>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200506_062434_264727_4982B345 
X-CRM114-Status: GOOD (  17.67  )
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
Cc: axboe@fb.com, John Garry <john.garry@huawei.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 06, 2020 at 06:47:01AM -0600, Keith Busch wrote:
> On Wed, May 06, 2020 at 12:03:35PM +0100, John Garry wrote:
> > On 29/02/2020 05:53, Keith Busch wrote:
> > > On Fri, Feb 28, 2020 at 09:45:19PM +0300, Alexey Dobriyan wrote:
> > > >   static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
> > > >   {
> > > > -	if (nvmeq->cq_head == nvmeq->q_depth - 1) {
> > > > +	if (++nvmeq->cq_head == nvmeq->q_depth) {
> > 
> > I figure momentarily nvmeq->cq_head may transition to equal nvmeq->q_depth
> > and then to 0, which causes an out-of-bounds access here:
> > 
> > static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
> > {
> > 	return (le16_to_cpu(nvmeq->cqes[nvmeq->cq_head].status) & 1) ==
> > 			nvmeq->cq_phase;
> > }
> 
> Thanks for the notice, your analysis sounds correct to me.
> 
> Ideally we wouldn't let the irq check happen while the threaded
> handler is running, but that is a bit risky to introduce at this
> point. I'm okay with reverting to fix this issue.

Pre-increment is still beneficial, should be done in register.
Please, test.


Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/nvme/host/pci.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -973,9 +973,16 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 {
-	if (++nvmeq->cq_head == nvmeq->q_depth) {
+	/*
+	 * Can't pre-increment ->cq_head directly.
+	 * It must be in [0, ->q_depth) range at all times.
+	 */
+	u16 tmp = READ_ONCE(nvmeq->cq_head);
+	if (++tmp == nvmeq->q_depth) {
 		nvmeq->cq_head = 0;
 		nvmeq->cq_phase ^= 1;
+	} else {
+		nvmeq->cq_head = tmp;
 	}
 }
 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
