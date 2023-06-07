Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24135C7EE29
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 08:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6oneRNDFxLa7WDXz/+SfEg4zm9Y6cftcn14KiJvPhY=; b=KqS470YbIIOsl8XcqPazvtHNW4
	dOLWwuyKaVsPpeafNGdS/dUd6ylSBXZR7C9ZEtPTcIjQXWwlcM1Vt2hpEnUuKP+B9PzOSA0lLnHbe
	54YLfLRbML+DLLEjFAi1BaAm08NpfuNXeIxIGLqrk/JI70hi7SfWkqDd90Bbz63k4lKzCLBGp9OZ8
	jooY/2RMYHkSgIZxVMUxiz4C9suODSa83JlfH8Ediq/z4zifyNQ2tnL1rNR+bLScFew5JwUP9c6zy
	xWSR30Ql0Twizeukvbx4vdiwOkUaOXvwB0eq7UPGdn9WqqsvF4/BZEq2IPJF5TAAIVdZtxqCW/043
	5IG+dgUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oOc-004vmg-05;
	Wed, 07 Jun 2023 08:19:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oOW-004vlE-2U;
	Wed, 07 Jun 2023 08:19:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0DC4660F7D;
	Wed,  7 Jun 2023 08:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADE5C433EF;
	Wed,  7 Jun 2023 08:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686125990;
	bh=bhPEUNqU+a2RwajMYr10YcQod7uo6bRu9m8nbjZC/X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2/u0lK/T6IWNZ+74l+9xHgTu/SF71BRHS/uLEpwZBctcy5g8KGrH6gP/Ho0QQKln
	 5qkVKhsk7HlZgAqdQwLM1MIiEl6T/QfH4Ibv/L9h2nM3uwvE54+8KmZ0oLxbsO91QN
	 hJRwkk/SieajEKOPcGTHaPk2IFlWpwOa2o2z8DAbcDtcM0cAx07db21Whr6OXZ5ZV2
	 j/A0q/XxqVSyk/ZxvJ6AiO8N7bjJJoxe6noi88aFL+OI6FYAwAx3O4cBH7LUNE3N9k
	 tD6Zf/uIvK8Pey+p3eQ9mrIlH9DqCvuU78zpoxTca2sOrNt1KvG2oPvhygH2k33jwn
	 T5lWAZbVwKRIQ==
Date: Wed, 7 Jun 2023 10:19:42 +0200
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
Subject: Re: [PATCH 05/31] cdrom: track if a cdrom_device_info was opened for
 data
Message-ID: <20230607-partner-reglos-2f455e85a92d@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-6-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_011952_846378_59DF73DA 
X-CRM114-Status: GOOD (  12.61  )
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

On Tue, Jun 06, 2023 at 09:39:24AM +0200, Christoph Hellwig wrote:
> Set a flag when a cdrom_device_info is opened for writing, instead of
> trying to figure out this at release time.  This will allow to eventually
> remove the mode argument to the ->release block_device_operation as
> nothing but the CDROM drivers uses that argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

