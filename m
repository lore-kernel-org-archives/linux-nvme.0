Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20864C6FA8E
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Feb 2023 01:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r8FQTgVg957SHeiJxvxIeR8IzBx6zDIJDsv9pYv0umE=; b=oXnSnFNoeRP281T8GmyCN8uvrI
	bmdlULkVd9Ns9yIC4I87VHqISsKFjmZX4DB1va5/DlY/V6/8RXwPqAMxfXJSRZwOi3hB9T5dtQX4u
	gWcR4lojJAvHHPCmnvy3gFS4dIMY0oZ9wTpKILmUoWUU9QzLa+bQu/8y/rKf/iWkLZhE42trKp+S+
	PQK9b9MS1hIMw2JoGVP1FUjMfKAPMvvuI1cQXOgK+FmEgS86m46T4eilsivggNnpd93QHmu5fJS3b
	ZSRgXwWjSuLDWW62clrWkS9dTvmzMqcdkN/tlURJ4Yj0rCS4JS5GX9XM/4rVNiNySGDjA1lGKz9TP
	Y6xfxPaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVjil-004a5f-KC; Sat, 25 Feb 2023 01:51:31 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVjij-004a53-1w
	for linux-nvme@lists.infradead.org; Sat, 25 Feb 2023 01:51:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 50530B81D78;
	Sat, 25 Feb 2023 01:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394C7C433D2;
	Sat, 25 Feb 2023 01:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677289886;
	bh=r8FQTgVg957SHeiJxvxIeR8IzBx6zDIJDsv9pYv0umE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZECbBE6NJHRYzKMdMRT8ENRE64p/7PiRwkocof87FTlj3ouvrxUxsEpUD6PnQ2ujl
	 sbPilKHUSGWAU0vYvzBc8NufmdFra44qwA5xBGIh+kXbNA9rnEHrvP+/PaoQOpOXB6
	 zg0yJloVKHlDcjcAhl4/EneDHitKOs8Pt3+l0/WGQmA0JzYtcJOteduCbhhL8wOAg5
	 wfThyH4t+AEVcK9pU3e2nCtAJiOUQEaHP8Z3ZoGDELMWBzyNcIa6MpQyqHXy+PdfWy
	 oBTret3S8wE79g8EVbI9unZ+E07rzhMq64Eanr5ao+E/SVpzP0Y7o7ixG8aFodSNTH
	 vclDtbjSijX9g==
Date: Fri, 24 Feb 2023 18:51:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	"dgilbert@interlog.com" <dgilbert@interlog.com>,
	Hannes Reinecke <hare@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"lsf-pc@lists.linuxfoundation.org" <lsf-pc@lists.linuxfoundation.org>
Subject: Re: [LSF/MM/BPF BOF] Userspace command abouts
Message-ID: <Y/lpmrwuehnsWmmR@kbusch-mbp.dhcp.thefacebook.com>
References: <3d3369f1-7ebe-b3b8-804c-ff2b97ec679d@suse.de>
 <Y+5cjPBE6h/IW9VH@kbusch-mbp>
 <ad837a26-948a-c690-cd9e-4dfffb5f990d@grimberg.me>
 <57d8dff9-2fdb-8198-6cdc-7265797a704a@interlog.com>
 <23526cf9-d912-59a7-4742-6003d6ccfd45@grimberg.me>
 <Y/Yscr82hqdKl1Hw@kbusch-mbp.dhcp.thefacebook.com>
 <561afa67-04d0-c675-6bbb-048313da152b@grimberg.me>
 <73b4dd39-9ce8-9b55-8a1d-06865f3bde32@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b4dd39-9ce8-9b55-8a1d-06865f3bde32@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230224_175129_261804_BC037F23 
X-CRM114-Status: GOOD (  10.07  )
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

On Fri, Feb 24, 2023 at 11:54:39PM +0000, Chaitanya Kulkarni wrote:
> I do think that we should work on CDL for NVMe as it will solve some of
> the timeout related problems effectively than using aborts or any other
> mechanism.

That proposal exists in NVMe TWG, but doesn't appear to have recent activity.
The last I heard, one point of contention was where the duration limit property
exists: within the command, or the queue. From my perspective, if it's not at
the queue level, the limit becomes meaningless, but hey, it's not up to me.

