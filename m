Return-Path: <SRS0=AClc=25=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A511C00523
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 04:22:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DCE20705
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 04:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RbXftPvx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Nwow75Cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DCE20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IQThcboxcbC1qoKaULUqLjFtdcnHh5wm9EAtFptkDBo=; b=RbXftPvxXHHthv
	lmRuSlW1cMkXi29kCahAXF4Z2de9loItD0Rgm8PtXOqUA4fI1ue2FNxpmSYrsAutNIpM51HOXP1wD
	4Q/Nk7tCcyMwj3vZcKDTapVOa1B82DJqfJbZ9WEJ/6qv1dZrkDq3jWT6R/ju3aPVTzi8Y71EhNKQC
	u/1JCvzIggFvag7a1iST1o28ZohpHXA39Xiq3LYC5ikpvFxSObP86W2OKRSrVpt2dN01XUgQu4MvX
	yf19xfMJaCfp4pnnmHGVvblSVPApu/k0BNaAvVVC6obpFvzu46OOWdHYC7EhQ7kcsxiKhWwaUJRNu
	K8QoM8ua6nsTpnWmNsIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ip2r8-0001Ln-Ea; Wed, 08 Jan 2020 04:22:06 +0000
Received: from smtp-fw-9101.amazon.com ([207.171.184.25])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ip2q6-0000LM-Pj
 for linux-nvme@lists.infradead.org; Wed, 08 Jan 2020 04:21:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1578457263; x=1609993263;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1OsGcmReV23Ns6GEgxqF7Tm8toBm55M9+IgR0xNKyJU=;
 b=Nwow75CpOR5TgRS1RePs9TonGGhoZz9kakTdBykX6l1rSCk4w5imjjZU
 kkee3xIKuUUKP+zoK3V/N9SOkNHYJ2ovne0sZWz6LBFjKiHi0q0d4mZfd
 f6T5FiT0QAOQxSQCbVsQ7Ukd/421mM1eaB1/hJmA5TtX0fMI91YX38ZTy 0=;
IronPort-SDR: O9+rmpiBNrQLSNLXnnHli6sgP7fkp9EhZwkgMxdTlPKlb++pPwaEIpuS+xjUwJfxdKThtdQNJT
 iDWqxIE4i9pw==
X-IronPort-AV: E=Sophos;i="5.69,408,1571702400"; 
   d="scan'208";a="8967941"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP;
 08 Jan 2020 04:20:49 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
 by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS
 id 86B8DA243D; Wed,  8 Jan 2020 04:20:48 +0000 (UTC)
Received: from EX13D11UWB004.ant.amazon.com (10.43.161.90) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 8 Jan 2020 04:20:48 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB004.ant.amazon.com (10.43.161.90) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 8 Jan 2020 04:20:48 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Wed, 8 Jan 2020 04:20:47 +0000
From: "Singh, Balbir" <sblbir@amazon.com>
To: "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
Thread-Topic: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
Thread-Index: AQHVxdHPlvRRrRbcTUG70jpk0aWGbqfgKlyA
Date: Wed, 8 Jan 2020 04:20:47 +0000
Message-ID: <e88e18fcd77243f7af39081b3b15aed3d2a1e674.camel@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-6-sblbir@amazon.com>	<yq1blrg2agh.fsf@oracle.com>
 <bc0575f1bb565f3955a411032f97163b2a5bd832.camel@amazon.com>
 <yq1blre1vwr.fsf@oracle.com>
In-Reply-To: <yq1blre1vwr.fsf@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.119]
Content-ID: <EFF6FE334C78AC4F8FA46091ED182175@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200107_202102_908391_154950CB 
X-CRM114-Status: GOOD (  12.58  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "mst@redhat.com" <mst@redhat.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Sangaraju, 
 Someswarudu" <ssomesh@amazon.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, 2020-01-07 at 22:15 -0500, Martin K. Petersen wrote:
> Balbir,
> 
> > > We already emit an SDEV_EVT_CAPACITY_CHANGE_REPORTED event if device
> > > capacity changes. However, this event does not automatically cause
> > > revalidation.
> > 
> > The proposed idea is to not reinforce revalidation, unless explictly
> > specified (in the thread before Bob Liu had suggestions). The goal is
> > to notify user space of changes via RESIZE. SCSI sd can opt out of
> > this IOW, I can remove this if you feel
> > SDEV_EVT_CAPACITY_CHANGE_REPORTED is sufficient for current use cases.
> 
> I have no particular objection to the code change. I was just observing
> that in the context of sd.c, RESIZE=1 is more of a "your request to
> resize was successful" notification due to the requirement of an
> explicit userland action in case a device reports a capacity change.
> 

That is true, yes I agree with your observation.

Balbir Singh.
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
