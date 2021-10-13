Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CADEC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 05:11:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F1E60E8B
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 05:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 56F1E60E8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UDEX+II4o0qqmBEMzpsBewXxKTOcAVsyJhs6rFKbZNQ=; b=4vLlcABd3s7XMI
	Ft2EMivLVtIUZ4CRNQHrRxLglefb34k+3/qLrPc7MfDuZFQyt+/dsXle1Tkeco8S8mhKTKlAIv7Rf
	0gJHXVabB2ZDyDAKzFAqoa/Fz1OJWyPwoglLlVNpu8Gw22zF6Is1AfXu0uhOAV+70bWlyWl5IlBDk
	sd0r6qbu6Iu8NzcU58yfNDmH5d1xU10dpMwhtk+x2rIuSv/TBqOcxU59NXE25LXgRNZ83WuOuOsI3
	ciozetAB+Ri7KGKZmI9BDjMgMSWATHlgNyDpRqCaqNIPDPgkYtcjq9V2nv9WfMTZu85KE3dlqam2q
	goSQk1MDeu31sYT6eBqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maWY5-00EslW-2o; Wed, 13 Oct 2021 05:11:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWXv-00Esk5-Bq
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 05:11:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A5E8167373; Wed, 13 Oct 2021 07:11:15 +0200 (CEST)
Date: Wed, 13 Oct 2021 07:11:15 +0200
From: "hch@lst.de" <hch@lst.de>
To: Saurav Kashyap <skashyap@marvell.com>
Cc: "hch@lst.de" <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nilesh Javali <njavali@marvell.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [EXT] Re: [PATCH 0/2] qla2xxx - add nvme map_queues support
Message-ID: <20211013051115.GA25113@lst.de>
References: <20210823125649.16061-1-njavali@marvell.com>
 <c72c7669-8818-77f1-2e5d-98bb24308f08@grimberg.me>
 <DM6PR18MB30340DC93DCC82CFFAAE3ACCD2C59@DM6PR18MB3034.namprd18.prod.outlook.com>
 <YSRrmOmrwm5olk0D@T590>
 <DM6PR18MB30341F714429F8552EB4E126D2C69@DM6PR18MB3034.namprd18.prod.outlook.com>
 <DM6PR18MB30345F9B2131600CDFEA91AFD2D39@DM6PR18MB3034.namprd18.prod.outlook.com>
 <DM6PR18MB3034746DCB33C51D8CA4EEFED2DA9@DM6PR18MB3034.namprd18.prod.outlook.com>
 <20210914083249.GA5341@lst.de>
 <DM6PR18MB30342CF2C3CB23EE3B947841D2B79@DM6PR18MB3034.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM6PR18MB30342CF2C3CB23EE3B947841D2B79@DM6PR18MB3034.namprd18.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_221119_587423_73EB1EFC 
X-CRM114-Status: GOOD (  12.13  )
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

On Wed, Oct 13, 2021 at 05:09:04AM +0000, Saurav Kashyap wrote:
> Hi Christoph,
> 
> > > Hi Sagi/Christoph,
> > >
> > > I haven't heard anything on this and there are no review comments on this
> > patch set, kindly include this in nvme tree.
> > >
> > 
> > I'll queue this up once the 5.16 tree opens unless James voices any
> > objections.
> 
> Any updates on this one?

http://git.infradead.org/nvme.git/commitdiff/062b5291ef352d6198c6c8414c71ae2debd06cf7

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
