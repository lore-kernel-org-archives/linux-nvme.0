Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00DAC47088
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 14:55:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4840761355
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 14:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4840761355
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9m75Z/PmNBt3abrSrIe8llFmI7dkb3BKXuWkWPgZr3o=; b=jbrfO+5zOsIJxC
	kyFZJhvxs/qCeu5tfTg7wVJWZ+J1jcz4piFH7CKrBW++YNO453Q946qmyW595AMOQK8r0OinXbFgB
	/Cf9pHx32cgI5+67O0EG1ug++NUYebb/0aW9QMvYTywcYSxd8z0+OmXS6O7mFrpB2+aGUyhqn0Img
	8bIhKT7qoVXviYIUyr81rMA2i0Wr3ea+MzEkIojSlMQw/c5PsKhSXgmU1Wt0Pj7b+FnC1hSGz9bgs
	aAHWAZ6CnQUfAmZjmWPC1FtiA3a546NQ6I3b/Ff0yAUklW4BiOW33b5PhMiHBOkkH5IEYKU9liNnB
	1pQ6TiRVAJuNgRzKneIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lluvy-00F6hQ-Hq; Wed, 26 May 2021 14:54:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lltAt-00EFJl-Ui
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 13:02:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1CD1267373; Wed, 26 May 2021 15:02:13 +0200 (CEST)
Date: Wed, 26 May 2021 15:02:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Christoph Hellwig <hch@lst.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Liang, Prike" <Prike.Liang@amd.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage device
 to D3 for s2idle
Message-ID: <20210526130212.GB25080@lst.de>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
 <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
 <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <20210525141631.GA12576@lst.de>
 <BYAPR12MB26939EE6323113FA9C43E875E2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <8eb98344-cee8-df6b-8e72-1771b16702b6@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8eb98344-cee8-df6b-8e72-1771b16702b6@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_060216_186314_DB84D9D7 
X-CRM114-Status: GOOD (  17.08  )
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

On Wed, May 26, 2021 at 10:52:35AM +0200, Hans de Goede wrote:
> I see that the discussion has already continued without my thoughts (good),
> reading the further discussion I see that pm_suspend_via_firmware() and
> pm_suspend_no_platform() have already been mentioned. Using these (or
> introducing something similar for this use-case) was also my first
> thought on this (after the previous options were shot down).
> 
> So I think that looking at those is going in the right direction. I notice
> that Rafael Wysocki is missing from the Cc (I've added him now) I believe
> that this is something which is right up his alley and he might have some
> ideas on this.

I think providing some information to the driver that the platform
expects to power off the PCIe slots after ->suspend is called would
be extremely useful.  We already had to disable the intelligent suspend
support for all devices with a HMB because of it, which then caused another
regression because some platform/device combination get hickups when
put into D3cold.  I wish PM wasn't such a mess..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
