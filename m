Return-Path: <SRS0=LrAE=X6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A25C47404
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2019 02:11:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0607F20830
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2019 02:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bRZS0KSZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="n7o+xfia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0607F20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7rpBQ9lQZAGdqbEvzjgvbOZrp7CIKVrxhQ87VWck6n8=; b=bRZS0KSZQGwJ+n
	VsWHSNOGzO/cqCrWYDGTk+WAUOWhwJZxzhmdLwR25wDUQ3EqyX89vhBNj/JN6OSnGFW8q00DUeORH
	FPaUOtVnkWovkrCZMBeBB1hh8P7eCb7pWQFjlksbY60WAtA8usRiCDUAza0yQGFZI2uimhegodnQM
	GzjUD3ocn7RqI4aD74SzebX4tgkMYoLXkrGD2JcraXTBi8Aj0627j3AFNIS3OIVMCyB5c4x8TEssx
	k961yvZ/DRl+ubO5mhIVB658VZrzPhZ2SUeH9NcPFe/r20XDeLs2a9SdxBxOA2mOV81EVAQXfnvEn
	B97vAidaJiLfbAVuWTIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iGZXF-0001Nb-Q9; Sat, 05 Oct 2019 02:11:05 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iGZXC-0001Mo-8O
 for linux-nvme@lists.infradead.org; Sat, 05 Oct 2019 02:11:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1570241462; x=1601777462;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=zrvR2JTZ+Ln78IRzoO+VVFXXk4+VB5nYEPpbM4aFRU8=;
 b=n7o+xfiaFmPNDioCId1UT7sSbSxNut1fq5/tvqkEv3DEsAaS9Artk1EN
 sPVmtCUzkFNB8CQfHqy4u6pk8E8fnC1CpwGxrvffDTZAfIjnDPHXShPmf
 vXwPfs8EN10Y9rc79YkQxQOeMPPoNDfkJGkWvSDhNvd2/qqXcuMtodf9k E=;
X-IronPort-AV: E=Sophos;i="5.67,258,1566864000"; d="scan'208";a="839393317"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO
 email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.22.34])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 05 Oct 2019 02:07:49 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS
 id 6AAB2A23B3; Sat,  5 Oct 2019 02:07:21 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sat, 5 Oct 2019 02:07:20 +0000
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sat, 5 Oct 2019 02:07:20 +0000
Received: from EX13D01UWB003.ant.amazon.com ([10.43.161.94]) by
 EX13d01UWB003.ant.amazon.com ([10.43.161.94]) with mapi id 15.00.1367.000;
 Sat, 5 Oct 2019 02:07:20 +0000
From: "Singh, Balbir" <sblbir@amazon.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "tyaramer@gmail.com" <tyaramer@gmail.com>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: Shutdown when removing dead controller
Thread-Topic: [PATCH] nvme-pci: Shutdown when removing dead controller
Thread-Index: AQHVeyGeGhwUwA6X9kWpqedn8pc+zg==
Date: Sat, 5 Oct 2019 02:07:19 +0000
Message-ID: <e0edf48eb84fe038c2912328b28e931900684de2.camel@amazon.com>
References: <20191003191354.GA4481@Serenity>
 <CAKcoMVC2LdcmUx6j5JzuT-TsFGz=mwQ0MsprrKR2qeXoTmQ-TQ@mail.gmail.com>
In-Reply-To: <CAKcoMVC2LdcmUx6j5JzuT-TsFGz=mwQ0MsprrKR2qeXoTmQ-TQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.228]
Content-ID: <B991183222A3AC43AEEFB59E60CD63E2@amazon.com>
MIME-Version: 1.0
Precedence: Bulk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191004_191102_368797_FA709305 
X-CRM114-Status: GOOD (  24.39  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

On Fri, 2019-10-04 at 11:36 -0400, Tyler Ramer wrote:
> Here's a failure we had which represents the issue the patch is
> intended to solve:
> 
> Aug 26 15:00:56 testhost kernel: nvme nvme4: async event result 00010300
> Aug 26 15:01:27 testhost kernel: nvme nvme4: controller is down; will
> reset: CSTS=0x3, PCI_STATUS=0x10
> Aug 26 15:02:10 testhost kernel: nvme nvme4: Device not ready; aborting
> reset
> Aug 26 15:02:10 testhost kernel: nvme nvme4: Removing after probe
> failure status: -19
> 
> The CSTS warnings comes from nvme_timeout, and is printed by
> nvme_warn_reset. A reset then occurs
> Controller state should be NVME_CTRL_RESETTING
> 
> Now, in nvme_reset_work, controller is never marked "CONNECTING"  at:
> 
>      if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING))
> 
> because several lines above, we can determine that
> nvme_pci_configure_admin_queues returns
> a bad result, which triggers a goto out_unlock and prints "removing
> after probe failure status: -19"
> 
> Because state is never changed to NVME_CTRL_CONNECTING or
> NVME_CTRL_DELETING, the
> logic added in 
> https://github.com/torvalds/linux/commit/2036f7263d70e67d70a67899a468588cb7356bc9
> should not apply. We can further validate that dev->ctrl.state ==
> NVME_CTRL_RESETTING thanks to
> the WARN_ON in nvme_reset_work.
> 
> 
> 
> 
> 
> 
> On Thu, Oct 3, 2019 at 3:13 PM Tyler Ramer <tyaramer@gmail.com> wrote:
> > 
> > Always shutdown the controller when nvme_remove_dead_controller is
> > reached.
> > 
> > It's possible for nvme_remove_dead_controller to be called as part of a
> > failed reset, when there is a bad NVME_CSTS. The controller won't
> > be comming back online, so we should shut it down rather than just
> > disabling.
> > 

What is the bad CSTS bit? CSTS.RDY? The entire reset/disable race is quite
tricky in general, it was made better with the shutdown_lock, but if the
timeout value is small, several of them can occur in the middle of a reset.

For this patch

Acked-by: Balbir Singh <sblbir@amzn.com>

> > Signed-off-by: Tyler Ramer <tyaramer@gmail.com>
> > ---
> >  drivers/nvme/host/pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index c0808f9eb8ab..c3f5ba22c625 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2509,7 +2509,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl
> > *ctrl)
> >  static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
> >  {
> >         nvme_get_ctrl(&dev->ctrl);
> > -       nvme_dev_disable(dev, false);
> > +       nvme_dev_disable(dev, true);




> >         nvme_kill_queues(&dev->ctrl);
> >         if (!queue_work(nvme_wq, &dev->remove_work))
> >                 nvme_put_ctrl(&dev->ctrl);
> > --
> > 2.23.0
> > 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
