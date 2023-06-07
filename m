Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F84C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 09:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gBuPfhJ4bMDaF0DaOTZiq+zlIvYXc8IG9p8nD3j7p7k=; b=lTjgY80eje7rMAel7z8Sdfd8dB
	eUX0rhGjucBcl/eN/X61uFqHSScdougU2zUOb7XJkNa5DA/L4rmQRyqx2DEnj8OTv4JUirTEugR4D
	xt0bABIR0ZKTQotBj9AHlv2k575TmtbMkhBkIqdatblIB/1hETTVKIZgZ8wG+mtYmnlTydw/OTgnO
	wjFe1mDFuz0TfNiAbkoO7cNfAW6cZPdoiQW2JZXxTN6X0yaZ7UccEHsOZPmojNY/In31EflEJex3E
	CzwxDHPlR6o7TzJ4sw0zL/B1AFDzuX/JPQcg3zev5dkHbaWaB7PCxLCmE9qnPgAzhjVM87cQXtz5t
	5qcOQf8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6p2v-0058D7-2F;
	Wed, 07 Jun 2023 09:01:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6p2r-0058BG-2P;
	Wed, 07 Jun 2023 09:01:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 443A563CA0;
	Wed,  7 Jun 2023 09:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FCDC4339E;
	Wed,  7 Jun 2023 09:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686128492;
	bh=g3r5rYOcZPuzhWXIH0bYKBRPgwc3E1p0pJA/TrUWYf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rP0+sQU05ytYS6k6BMHqTVzyKjsFFQ6Wnfz9kTwbzFygygaENxsZpLVLE+i0Qat/T
	 H9xyY75epM433AvDHOzMGZ5nCVlaptMhX5S2jj2AOMVumZAKr75qlxAmdCSJnS6NUd
	 7tqPBZriCMC3nI9evGotlI0qLb0BdyIVBS77Pfxw7PBbtd9IVfScHPRbniWMpCV7lR
	 55VKlh0TF/3SRbWeQbPAZTyUSElyLojLOoq4PjR4jgVaJ3PzHPr6hWQJhpR6zvmzyU
	 fgP8TlXGFzHd65cVjqzqqQynkH3SXjh0FCcoqjywuH9MLmxBXvOdpNSU1a7eORehO/
	 8mV+t8uVMgcTQ==
Date: Wed, 7 Jun 2023 11:01:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 24/31] rnbd-srv: replace sess->open_flags with a "bool
 readonly"
Message-ID: <20230607-getadelt-pfauenauge-75adb3f04015@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-25-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-25-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_020133_836793_6E956B65 
X-CRM114-Status: GOOD (  11.64  )
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

On Tue, Jun 06, 2023 at 09:39:43AM +0200, Christoph Hellwig wrote:
> Stop passing the fmode_t around and just use a simple bool to track if
> an export is read-only.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

