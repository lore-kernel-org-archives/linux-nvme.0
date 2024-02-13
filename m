Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1607C48260
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 06:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ji03yx9DEGArKA7IwxF84g55gpa4iklo/tgRCMC4Esg=; b=3skZYC0nb5By2YhTOENzfUrfVh
	uHN97qgdhfvUbFyFrq9xKXLmkTHJMSi6QxQbKJ5Dc80o5Wcd19c8PUC6XP5Lt6Su7jbQGs8TeMLqu
	jI31DYG44aHw2r/8Oxg4V1i487Ju3krsvuXMw5OH9+491N2iBCtrCj2peKmVSgP2bOPl6c7JcAyva
	BnzAdNaISZMtsFTNQBHjp5n7MY3dw7BdFsZKDOvaluiaR60em6Ll7u7/oXuQM8SR8D+Ckag44qPRE
	EvpK7HI6eYvPt9+qCID+WNmYuspV1jPC2tdwsNCfrYo0dfX3rJ627YmrBxKAdkyihfNEfZZ61qpYF
	oN7kgu2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZmFR-000000088B6-2O9k;
	Tue, 13 Feb 2024 06:26:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZmFN-00000008898-0uHH
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 06:26:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 44B4D227A87; Tue, 13 Feb 2024 07:26:21 +0100 (CET)
Date: Tue, 13 Feb 2024 07:26:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v3 07/15] block: Limit atomic write IO size according
 to atomic_write_max_sectors
Message-ID: <20240213062620.GD23128@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-8-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-8-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_222625_450880_0ABFE253 
X-CRM114-Status: GOOD (  13.51  )
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

On Wed, Jan 24, 2024 at 11:38:33AM +0000, John Garry wrote:
> Currently an IO size is limited to the request_queue limits max_sectors.
> Limit the size for an atomic write to queue limit atomic_write_max_sectors
> value.

Same here.  Please have one patch that actually adds useful atomic write
support to the block layer.  That doesn't include fs stuff like
IOCB_ATOMIC or the block file operation support, but to have a reviewable
chunk I'd really like to see the full block-layer support for the limits,
enforcing them, the merge prevention in a single commit with an extensive
commit log explaining the semantics.  That allows a useful review without
looking at the full tree, and also will help with people reading history
in the future.

