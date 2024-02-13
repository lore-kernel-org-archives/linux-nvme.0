Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C0FC48BC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 06:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yzRf3zSMtMKlamKnucudV7BBOqyL2MYCKd1TAXnUS68=; b=ektOLizKYtaOirXV4JR+crNvXS
	l4bfSeI0doSo3leHc7KO1FQFQU5NSY0bBQJm4y1D1UMSa3DQIFVakmPaoZ8HUmWxMXNLHLCYZ6sRT
	KarmYoF6WwPr9QFvsM/8/ZL9rzG6r9M8Dl6pQFnqac4ebOaoyNJGsnIbHCgcMFCIcel82R84Dv8n7
	gie0yIq4aKBBcxAitCezEeRF4rUc8aTCdIaZb6D3ThUiBHSrbk1hn87lR1/UNzI3LbnrEkG5js/JP
	wZrQQVxf7Q3nDJcVuoJYxuYkzI7ojK/cc+iVuxPcMS+qGPJT3AVN6VjLNOuIu/J9mG2/pJtK4kuyN
	u3SiFFJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZmVE-00000008ATe-1JE6;
	Tue, 13 Feb 2024 06:42:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZmVB-00000008ASK-05Ds
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 06:42:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3643D227A87; Tue, 13 Feb 2024 07:42:42 +0100 (CET)
Date: Tue, 13 Feb 2024 07:42:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v3 15/15] nvme: Ensure atomic writes will be executed
 atomically
Message-ID: <20240213064241.GC23305@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-16-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-16-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_224245_223826_7AB87D04 
X-CRM114-Status: GOOD (  12.96  )
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

If we don't end up doing the checks in the block layer:

> +	/*
> +	 * Ensure that nothing has been sent which cannot be executed
> +	 * atomically.
> +	 */
> +	if (req->cmd_flags & REQ_ATOMIC) {
> +		struct nvme_ns_head *head = ns->head;
> +		u32 boundary_bytes = head->atomic_boundary;

... please split the checks into a helper.  And merge them into the
previous patch.


