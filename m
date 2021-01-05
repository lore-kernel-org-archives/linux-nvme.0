Return-Path: <SRS0=mRFX=GI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDBBC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 09:46:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98FD22257
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 09:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98FD22257
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jxtgeo9BpaevfPxPkRD0B/6+H+st5DAZ32pR2cWv2Hs=; b=KWMcO23mugd164pvnk852TTDq
	p9LNEAx64dz1XZJKFnP3hHs89lk6mzWoU5S/GsdZ4QNrqOD3nJZ8FV8UeykFDiA2yuZxiWmMnxoQ5
	6w+/lbtlNAqrwp4u/+76xXEZgpFhQ259mSZNUlL/vqj1jTSmONy51s/iBtM3fHr/uWMsJv0wWbxvX
	bpf3ONIxX0Ms8Z5/gDCZo5FAT8Kv7rqai7OZGeCRiUXztOIbRiXFYMNlUjrG0EDSd2Vb/LSvjKYJA
	+4T3L/GFCTYXXd1Cw6442+4L8fY2dZNZs5lOifbc2wt0tTiTKsMwRKGQSbg7lgbfZ7izAOr0g6Kd8
	0IW/3aUNA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwiuW-0002Xr-C4; Tue, 05 Jan 2021 09:45:52 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwiuS-0002Wh-LH
 for linux-nvme@lists.infradead.org; Tue, 05 Jan 2021 09:45:49 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 56758AD29;
 Tue,  5 Jan 2021 09:45:46 +0000 (UTC)
Date: Tue, 5 Jan 2021 10:45:45 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
Message-ID: <20210105094545.3tq7c6ev5yn3bhyi@beryllium.lan>
References: <20201209213228.5044-1-ematsumiya@suse.de>
 <4ebb1b8c-4bb0-6ebf-3417-d4aee1bdd3a8@suse.de>
 <20201230143805.2v4izgkzbnisssvr@beryllium.lan>
 <20201230151653.ozlqlwef7f2tarwz@beryllium.lan>
 <20201230153138.4f2jd2yd2vkqndby@beryllium.lan>
 <20210104210610.hliiupywksawgei3@hyori>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210104210610.hliiupywksawgei3@hyori>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_044548_820875_D9D30389 
X-CRM114-Status: GOOD (  13.62  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 04, 2021 at 06:06:10PM -0300, Enzo Matsumiya wrote:
> @Daniel maybe try tweaking your tests to use a smaller controller
> loss timeout (-l option)? I do this on my tests because the default
> value kicks in about 30min after hot-removal -- i.e. you
> have to actually wait for the timeout to expire to trigger the bug.

As far I can tell, the blktests test I am using will trigger the same
bug. The problem is that the lifetime of hwmon sysfs entry should be
aligned to the lifetime of the nvme sysfs entry. Currently, hwmon's
lifetime is bound to the lifetime of the ctl sysfs entry. When the nvme
entry goes away (and obviously also the underlying device), the hwmon
sysfs entry still references it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
