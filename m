Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FF7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 08:33:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F06860F23
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 08:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F06860F23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1wq8+HecRGhTmOZsj94otZFsI042NcpRbUAPhhGLXD4=; b=XPLIcGO8IlxKRU
	gPnHdHiAtykYLVPafMIbwZgDfmH00iEswALXDzYmwRtHaXhCvTHH6y08/C5MMAqAJvOExunGOVDBV
	RDZ9hUlBXtqXRXKq4MaLSEWadkESTG42ZvFcW1QRXMVSidbnJSUDGqM5583/Bk60x0pcKI4cKouL0
	PgSJkh6GI3VZjfw1S7OJuxWCyy4iKaBWMljJdzYo7vQpoTM3xk279zPkSuCQtCB41wGuUqYTfcPv2
	3hr6VLHuFKJ41UbF9xLs9oUIa1DAIPzdIROqjMt0NoKXjdglx/84I9iDHkEcEr72zx1pE40ankfA1
	7HeIdkDto/vocsSU26vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ3se-004hri-4R; Tue, 14 Sep 2021 08:33:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ3s6-004hf1-6B
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 08:32:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A392A67373; Tue, 14 Sep 2021 10:32:49 +0200 (CEST)
Date: Tue, 14 Sep 2021 10:32:49 +0200
From: "hch@lst.de" <hch@lst.de>
To: Saurav Kashyap <skashyap@marvell.com>
Cc: Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, Nilesh Javali <njavali@marvell.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [EXT] Re: [PATCH 0/2] qla2xxx - add nvme map_queues support
Message-ID: <20210914083249.GA5341@lst.de>
References: <20210823125649.16061-1-njavali@marvell.com>
 <c72c7669-8818-77f1-2e5d-98bb24308f08@grimberg.me>
 <DM6PR18MB30340DC93DCC82CFFAAE3ACCD2C59@DM6PR18MB3034.namprd18.prod.outlook.com>
 <YSRrmOmrwm5olk0D@T590>
 <DM6PR18MB30341F714429F8552EB4E126D2C69@DM6PR18MB3034.namprd18.prod.outlook.com>
 <DM6PR18MB30345F9B2131600CDFEA91AFD2D39@DM6PR18MB3034.namprd18.prod.outlook.com>
 <DM6PR18MB3034746DCB33C51D8CA4EEFED2DA9@DM6PR18MB3034.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM6PR18MB3034746DCB33C51D8CA4EEFED2DA9@DM6PR18MB3034.namprd18.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_013254_435030_9378CCE5 
X-CRM114-Status: GOOD (  10.85  )
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

On Tue, Sep 14, 2021 at 08:07:02AM +0000, Saurav Kashyap wrote:
> Hi Sagi/Christoph,
> 
> I haven't heard anything on this and there are no review comments on this patch set, kindly include this in nvme tree.
> 

I'll queue this up once the 5.16 tree opens unless James voices any
objections.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
