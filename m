Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A61CD6E4A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 10:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hRPt7mzyqdyREPEGW6G3M5xYMjEjmy1kiu/DcmwtyEE=; b=aXEcqmtRV8ClN/gxEXeJ1AJnf6
	zJS+ugDJHufy7ypdgpIRt0Ww+ZZw4xkAo+qpMFMYhBPPzssouxIegOll3hRSNvyRsnM1CBUEJifEM
	Nl1GbHSb0wTrXgg8/jMuSL6QjkTuTG5Tb3VOjrzryJxtqHaa6H5Nbkg0/ip02jAwgSP1sgNzF0FGa
	lml+V0wkSp378TSgxum6Rkrgqoc14pNeaW8aC6T3uLrMnNxG/fnE2fRFEExuMgUxZFQmno/QBGyK1
	Z54ltprbhFDJ2iuxRYjxzrWcOMLhQg12zCTb4LRaSt2h4DM177DuGtetNnLT35PgsqyjtVTcDhIUu
	M3hggf9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUMJh-0000000Cm6Y-2wtt;
	Tue, 02 Jun 2026 10:25:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUMJe-0000000Cm5T-3BMk
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 10:25:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 67DDF40B36;
	Tue,  2 Jun 2026 10:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA991F00893;
	Tue,  2 Jun 2026 10:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395946;
	bh=hRPt7mzyqdyREPEGW6G3M5xYMjEjmy1kiu/DcmwtyEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oxWDg3VOdhrLnk6CH2HPjPsf4D3LfI8/QGRytvqpUurWfddEKoudjtAIIurph+Lyt
	 CkCbTJx/5PAMWghvlYTdRXpAeAEjXacWhKmw2A79V8KrN1jnkwZ2j76AwzZh+WnqvU
	 1A0vBqEysMcZyxSG/F11XvW+V96Zn4fRIgKoKgpSuRHK89uZcbnKeR8Uifeeyzrwpd
	 IRN2/TGDVAspJijA97goGwFF/AQFYeRMqHoWnd7gQ3vYUHc5xD1NIC44LJsxRFY9Rn
	 dll83oXxQeNxZ9OV+uQbwqqUBynI01Hp2/DEsjl2DxaoBGpmQRlGi2fQwJfOzvRMQ0
	 bqNjtg5Opxo0Q==
Date: Tue, 2 Jun 2026 11:25:40 +0100
From: Keith Busch <kbusch@kernel.org>
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Message-ID: <ah6vpFq3P4KnIc-j@kbusch-mbp>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_032546_816462_1399AD42 
X-CRM114-Status: UNSURE (   8.20  )
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

On Thu, May 28, 2026 at 03:24:27PM +0000, Achkinazi, Igor wrote:
> When nvme_ns_head_submit_bio() remaps a bio from the multipath head to
> a per-path namespace, bio_set_dev() clears BIO_REMAPPED.  The remapped
> bio is then resubmitted through submit_bio_noacct() which calls
> bio_check_eod() because BIO_REMAPPED is not set.

Thanks, applied to nvme-7.2. I had to manually fix up the whitespace
damage, but not a big deal.

