Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F92FA375C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i/6rWqKA+a8ka+54yXYYYno/mALIhuLTW81fpAzCJL4=; b=E0JjmfS3rNy/tOaRyXwfhNOdl4
	6xykzF5l9UuM+xNR5ZpqLb8mqQcu5ipE+cirZ0XFqGJJiB5GTptIs8xI9NE93XUFU62VJYkMIFmp2
	09VRifSMdFAX1IlgW0cc7o1pxSWlK4kAZGQ5L7AaFkGHwHG2ueBbtZ/3i4RZp2hV+PZXabt4fysTz
	ickR4gv9rvouZKOYz4nCjbn5xfxx7GUIxolpIBPsUYshEXYJo5W3hDuOl0Aw8MAagiX8Y2zFsYqEE
	aWwCP4FY9HPsKlloQIkVmHtqbGd0pq4Nw3VQI6VU9ncK+zONH1VWGMfaxcu1waES2zUWHql/YbZ5A
	7LpQjlmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp82s-0000000GKOn-0K8w;
	Fri, 13 Sep 2024 15:17:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp82p-0000000GKO5-1Q9L
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 15:17:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 407B45C559F;
	Fri, 13 Sep 2024 15:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283D4C4CEC0;
	Fri, 13 Sep 2024 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726240630;
	bh=i/6rWqKA+a8ka+54yXYYYno/mALIhuLTW81fpAzCJL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EfaOvAGFeKHKkbLbtGXOyeqF1DN1G7vqzVm6U7uXxgLtWTsVqf2XqiiFtfuDd3/hf
	 W+ZUGAVltVVPW22jghgxb8LnRKMI976lcbJqneqLyxzq0I76tjnOExaL0cmcFIhL9c
	 G/3F/7LyhjoK54dJiHRVlOXtBXtNl1PejdTjmcqOlRQCJ5QaftfczIc45sL26dh2SB
	 dchgmowpHTUO6TB4iLD4PBuxg8H2ZyM5Bf5BkYjwYnlyt/nOgXlQLUCWH55GbYdFHa
	 9393r4IKEK3S3rza7Zu6KFbyUSTs7HwcubHSZbnarjJkKHBdKSsWN2UoAMy12B1WqN
	 M91Qy/sV6Wj0A==
Date: Fri, 13 Sep 2024 09:17:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: David Jeffery <djeffery@redhat.com>
Cc: ens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: use per device timeout waits over depending on
 global default value
Message-ID: <ZuRXc8uj7J2CBDE-@kbusch-mbp>
References: <20240913134430.5416-1-djeffery@redhat.com>
 <20240913134430.5416-5-djeffery@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913134430.5416-5-djeffery@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_081711_438113_0D8CE88F 
X-CRM114-Status: GOOD (  11.44  )
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

On Fri, Sep 13, 2024 at 09:44:30AM -0400, David Jeffery wrote:
> Instead of passing NVME_IO_TIMEOUT as a parameter with every call to
> nvme_wait_freeze_timeout, use the largest timeout value from all the
> namespaces for the nvme controller. This will match the wait to the
> configuration of the devices instead of assuming a single value can
> fulfill the needs of all devices on the system.

The module parameter is obviously too coarse, but does IO timeout really
need to be per-namespace? I'd think setting the preferred timeout at the
controller level is sufficient.

