Return-Path: <SRS0=4MGw=HV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D2DC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 09:13:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0174A64E86
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 09:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0174A64E86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OsTVyc3sphFVJI+FP/4M22JCnqxqKLrrX4gRbBxDY3g=; b=HQEyA8WefzpGQELeM2WbTU8Xm
	XWIQY+7ToC3jbndYKYVXg8PHuzfCOtIYamfglyjtvR7l1YAM54FLqJOnWCg3ZK0860pV3UjBhXykc
	19Cf5gcjrVeqXxRKqv6cL2MXIHnjuU6oEQiyllND9IvW/mzeXMaHV0KzFgZF3FGkinBdBWTr3X0zM
	oWan7lt/3Nfh9paO7sVDlL0l19hQelmkk2SnahiAEhVUE5jDFvz8OmMSkVBXNssW7TYifGgkyFG6F
	mAb/7ntDwuYgpH0WZVOSV5Q+SILw44OzJCqk8OcieFAsZCo6eG8zvfW3SkLcY1F9SLLjpfmBCSjL+
	OnrbgY6qQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lD1qB-00020S-5G; Fri, 19 Feb 2021 09:12:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lD1q8-0001zM-NN
 for linux-nvme@lists.infradead.org; Fri, 19 Feb 2021 09:12:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EA70E67373; Fri, 19 Feb 2021 10:12:37 +0100 (CET)
Date: Fri, 19 Feb 2021 10:12:37 +0100
From: "hch@lst.de" <hch@lst.de>
To: Shai Malin <smalin@marvell.com>
Subject: Re: [RFC PATCH v3 00/11] NVMeTCP Offload ULP and QEDN Device Driver
Message-ID: <20210219091237.GA4036@lst.de>
References: <20210207181324.11429-1-smalin@marvell.com>
 <PH0PR18MB3845E15A62826C9B5A520628CC859@PH0PR18MB3845.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PH0PR18MB3845E15A62826C9B5A520628CC859@PH0PR18MB3845.namprd18.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210219_041244_888393_AF686635 
X-CRM114-Status: UNSURE (   8.07  )
X-CRM114-Notice: Please train this message.
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
Cc: Ariel Elior <aelior@marvell.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Michal Kalderon <mkalderon@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "malin1024@gmail.com" <malin1024@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "axboe@fb.com" <axboe@fb.com>,
 Nikolay Assa <nassa@marvell.com>,
 "Douglas.Farley@dell.com" <Douglas.Farley@dell.com>,
 "Erik.Smith@dell.com" <Erik.Smith@dell.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 Prabhakar Kushwaha <pkushwaha@marvell.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 18, 2021 at 06:38:07PM +0000, Shai Malin wrote:
> So, as there are no more comments / questions, we understand the direction 
> is acceptable and will proceed to the full series.

I do not think we should support offloads at all, and certainly not onces
requiring extra drivers.  Those drivers have caused unbelivable pain for
iSCSI and we should not repeat that mistake.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
