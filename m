Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D10C49361
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 20:34:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1BE613B6
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 20:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1BE613B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y2LKTlWCSoA4iXsxbdlA6BZDEY4SMayfJSn1ewn/4v4=; b=FaOad1kzG9xYlc
	UYdoiJHPnW8l9Gs0/oKEEC9MN4OtemnfjSLKlON38YNsr2AUDgqiApEhjwXKXglFfDz5/+kLXGGZu
	M+fNHys1/m7O+xkRrOnnCr/2belqtx3BIHiWrl6TtIzhgYuult5tJptxoiefqwi+FYZHyNUNJx/RS
	6cwhFFpdHuX9cAOEsBG1k9JxEdb9rtZ+5cbu3eXvZBkhURvzZeb4tejKxa1atNb0tBuWIlit6ZPZs
	Y5jaCIzg59oWiLxBYGWGvnTqQkyFU14fozx3JxJO7H1kajM6gZUi8KZqiNHFrOnKY2PoimG6bexZi
	DTK9zVw8yJvqe4qq7DcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltFll-002pWZ-6q; Tue, 15 Jun 2021 20:34:45 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltBu4-001Lay-Rc
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 16:27:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 11C2967373; Tue, 15 Jun 2021 18:27:02 +0200 (CEST)
Date: Tue, 15 Jun 2021 18:27:01 +0200
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>
Subject: Re: [PATCH V6] nvme-core: use xarray for ctrl ns tracking
Message-ID: <20210615162701.GB1089@lst.de>
References: <20210608024247.35286-1-chaitanya.kulkarni@wdc.com>
 <dbab5916-a6de-5cd0-4bb5-b06d0349df0b@grimberg.me>
 <BYAPR04MB49657620DF9C7EA9158DB60686369@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49657620DF9C7EA9158DB60686369@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_092705_103182_F77E1085 
X-CRM114-Status: GOOD (  11.76  )
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

On Wed, Jun 09, 2021 at 08:48:10PM +0000, Chaitanya Kulkarni wrote:
> 
> This is to void the another call to the synchronize_rcu(),
> 
> I'll add a second call to synchronize_rcu() and keep the original
> position.

Or document why this is changed in the commit log, that is what it is
for.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
