Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6625C48BEB
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Feb 2024 08:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SlDfSacAmvkYg4YRJ0SSR9Djg0KENVzB2R7+zG5tZ4I=; b=kAcmhJHZ3LUPoucZgDhjBKtL8h
	YGjFrHZg8a55Vb/Wh5xaoHJUWkSTBKEN9utD2s84pjlEONxSk4daGPRnwzKb28tAFeoAgKdkPLWoE
	fHOBluKmhwMugc8OP9EMN+tgaCOTJtrPHR9hu8ebpcc0pNdbuWkUN9AyvfiszkwDq04KvXgXW7d2O
	Ti/F13BfYBQ6lUpiqWtZec2Bx8BrSWFt7kUYBzHaTtfqg2FGoqk+6SAwMwxiUKesEa5P0M0J3g4TP
	7wAm8QZJxUNB7NnuQ2dJg85mrADoELiZDVQFobnd8Iw01YJNi49fA67qMu7dhwZ6ZK/AxNEAAah69
	QiPgdGrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raAC5-0000000C629-0scv;
	Wed, 14 Feb 2024 08:00:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raAC1-0000000C61N-3cIn
	for linux-nvme@lists.infradead.org;
	Wed, 14 Feb 2024 08:00:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0DD4C227AAD; Wed, 14 Feb 2024 09:00:25 +0100 (CET)
Date: Wed, 14 Feb 2024 09:00:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v3 14/15] nvme: Support atomic writes
Message-ID: <20240214080024.GA10357@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-15-john.g.garry@oracle.com> <20240213064204.GB23305@lst.de> <0323ba69-dff9-4465-817e-2c349141b753@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0323ba69-dff9-4465-817e-2c349141b753@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_000034_060831_380772DF 
X-CRM114-Status: GOOD (  14.33  )
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

On Tue, Feb 13, 2024 at 02:21:25PM +0000, John Garry wrote:
>> Please also read through TP4098(a) and look at the MAM field.
>
> It's not public, AFAIK.

Oracle is a member, so you can take a look at it easily.  If we need
it for Linux I can also work with the NVMe Board to release it.

> And I don't think a feature which allows us to straddle boundaries is too 
> interesting really.

Without MAM=1 NVMe can't support atomic writes larger than
AWUPF/NAWUPF, which is typically set to the indirection table
size.  You're leaving a lot of potential unused with that.


