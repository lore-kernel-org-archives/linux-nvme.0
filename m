Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DA8C83F04
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 10:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FeJ9o3pAbPhVrTcYe7UddUwgRdaPYR5sm7vooA+Rii4=; b=cmSeHxto8ZzE51zJaXQtYeHihT
	Ja0J6f3rhLEK5P0HUt063UhpWgS6yM16axkXqn3L3Rc19tWOnq0cqmKTtaDXjNVKWpKJtXuHV/Wox
	8ffvXGXnSa5AcDZgxaF2d2usnl/z0Jg+jLpZC/S6WtjQyXVbJvK7+ilVb386FWaWIDfseRFX11vio
	Q1j1xej/AGmLsZz29GbEzt3ZqxrgakSK7G3eZeJ6JFiQgdseQLOLUv940Sg/6F8fC1wnTrfBOREFU
	SK4mUL0tH2aJ36SKNJ/UIxWZ9vGbDsCILnEYedB/rgMZL+Holi/id0KTQi2bUW+CovUvRjp2WvDre
	9huZqN5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXGpl-0000000AvwU-0rjE;
	Thu, 03 Jul 2025 10:06:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXFtI-0000000Am2t-3HS4
	for linux-nvme@bombadil.infradead.org;
	Thu, 03 Jul 2025 09:06:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FeJ9o3pAbPhVrTcYe7UddUwgRdaPYR5sm7vooA+Rii4=; b=OWi5EyyRkpjefj0nuWnDywaoTr
	t8QpqWHThRf0X52ISJVwAff1mavUQWxlfggRAav4s5rv6nRTB11v1L03BI+NuL7rzq/kASVc+yHqr
	dAsmerVPMfDz6r9dGFvKSU6OEwFNDmHzCljwDUczLykbBJrualiu+NkA/+696jJG7DLvtllsxHLLB
	T02ng+6CKRX0Y8hyAsGr+uQ5Hn2VNLVvIGC48Yv1DNiGUASwPqs57E4at9hu32rGBPhhDv4ZCGtA3
	51EMEHzPhNozAxfa+igqYCYEMyufYgEEv3vzIMjGoKmCkrcRUY+/KO1MySoBXysCveXQOkTvDT6mX
	D6f96jEw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXFtF-00000007ehd-45K2
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 09:05:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 374F268B05; Thu,  3 Jul 2025 11:05:55 +0200 (CEST)
Date: Thu, 3 Jul 2025 11:05:54 +0200
From: hch <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, hch <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>
Subject: Re: [PATCH v2 3/3] nvme: prevent ioq creation for discovery
 controllers
Message-ID: <20250703090554.GD4757@lst.de>
References: <20250702005830.889217-1-kamaljit.singh1@wdc.com> <20250702005830.889217-4-kamaljit.singh1@wdc.com> <c168acff-66ff-4692-b21e-093c0aa592a1@kernel.org> <MN2PR04MB68626BDAC087B4CC8CC1A1A9BC40A@MN2PR04MB6862.namprd04.prod.outlook.com> <63310a08-e01f-464d-9f46-54bb817f2121@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63310a08-e01f-464d-9f46-54bb817f2121@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_100558_260219_19F74BAA 
X-CRM114-Status: UNSURE (   9.95  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 03, 2025 at 08:59:47AM +0900, Damien Le Moal wrote:
> Why would the controller vendor or its fabric matter ?
> If the controller type is admin or discovery, you want queue_count set to 1. So
> I do not think there is any problem.

Exactly.


