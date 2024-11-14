Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EFBD68B32
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rcxm6s3WGREUhS2mxYJ7NGMy1RGZ9kzM0QjeT++PjUg=; b=MyjdjNrKIwRDTi9VXmV4fgUxny
	8ZyXiLjxhJc0JOpX6OR3kjt9QzW+O6FZ+YZRApmAMAPmrvWlfz0XEx29cQl5Qpgq3hU76nzFHzy+L
	pEmvEkQ7DJobFwk1JOwPioXvBV031WP4tQvLqNLP4uKnyZ7oOccU+n5LwN2ET4uF5kqlr80ZeWlbP
	lKFyppHJXwb1JOMDMngCBjFh6dzjRCLfnmQMO2rBESdCsWZ837j10Nn0U213B1MfwoA3qaKlItbR9
	pywgtqFnjIz7fROcFGEySn4ORvzpgAPHPcODfqZM1zcLUfIC6WrBLH4nZwM/7WmIE08aRIw1+5NlI
	3kvTPb0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBbul-000000003Cd-3h64;
	Thu, 14 Nov 2024 15:37:47 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBbuh-0000000039s-1qS7
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 15:37:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 43A2CA40C8E;
	Thu, 14 Nov 2024 15:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2FBC4CECD;
	Thu, 14 Nov 2024 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731598662;
	bh=/+R1ST0vftb5gy4I6bUzRs7WTpvRvyWN8cNyI/K6cm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rTgkXuvbyVMCvVdW511hCPklC5A06FO9rhh+0nZWgUDV7AODxu6cC76JzlzfcdJNG
	 5pB9tTfjEQ1F3Qd7opW9zM/omVnngXcISa/uUZDbBNrRC6IcjJpaU69ZvOm0zVYcpq
	 fCn0lyJEtDHShnaMqCaqPJYXT36cFGoVeeJNf6aN8eRBFxNQGn+uT0LUUotKE4qvOz
	 mmaNHpk70FxYvQu2hDokANeV6BQ88kBwRfHsdCuy37OtkO58gV0wvazGCbD2YjthXu
	 O/BpEso46ZXIXt+7lRIrTWyzkq+sgTqV+XDUYOlDSWedyhD7q5cPFXeuSdx2NLm/sP
	 /CN4huxe2Zd4A==
Date: Thu, 14 Nov 2024 08:37:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: =?iso-8859-1?Q?Pawel?= Anikiel <panikiel@google.com>,
	bob.beckett@collabora.com, axboe@kernel.dk, kernel@collabora.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <ZzYZQ7aW1KiK2tCp@kbusch-mbp>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com>
 <20241114121751.GA3971@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241114121751.GA3971@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_073743_572239_B225382C 
X-CRM114-Status: GOOD (  12.33  )
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

On Thu, Nov 14, 2024 at 01:17:51PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 14, 2024 at 11:38:03AM +0000, Pawel Anikiel wrote:
> > When doing a write of 264 sectors with PRP list offset of 0xf00,
> > the bridge treats data as a pointer, and writes incorrect data to
> > the drive. This might be why Robert is experiencing fs corruption.
> 
> Not having the hardware and just speculating, but this seems like
> a pretty likely failure mode.

I can totally believe that. I recall the driver had a similiar bug like
15 years ago. I think Nisheeth fixed it. Checks logs... Yep, commit
0d1bc9125890426b52c.

Anyway, even with the quirk, we can still have the last PRP just before
the page boundary from the "large" pool if the device supports MDTS 2MB
or more. What does this device report?

