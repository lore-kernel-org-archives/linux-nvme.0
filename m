Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D458C7EE2D
	for <linux-nvme@archiver.kernel.org>; Fri, 12 May 2023 13:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lT15HdgyHoQ0AUjKfDdOb7KL320sqJIhvVE0mfCw3mM=; b=pVLhmxv+xbamvt1HrbaL8xMuWU
	AvkqaQUIdtJMuRGNryM8T0tPq+IgwTJVcsU8hA0UG2YHWW/IY4+3jlKcxLjGUO/XaeXK8tRpMeM1e
	xzrPyhOW7qaRhNlqqOGfm1FFsNOZPB8i9x17H/QD9NWWeZiD1eiXOI6hdVt2LhpfUxicWQJdAAS4s
	XgtAMhmBKa6pf8uamphrMnW/O0Xf9O9WZMjbFAOqJB76xJ7Gw9GPQlAGOfLR3b8PFHzimuUCco6u5
	DlpKJjKbw00+st7MZQxM+2fmWo/HDGZOsGjW3zQ+rPbhoh0LH/JtaBJfLAqB/l2/lLGFsliY2Eesu
	4FexaTEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxSOL-00ByRK-32;
	Fri, 12 May 2023 13:01:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxSOF-00ByQ1-2r
	for linux-nvme@lists.infradead.org;
	Fri, 12 May 2023 13:00:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4B6AC68B05; Fri, 12 May 2023 15:00:43 +0200 (CEST)
Date: Fri, 12 May 2023 15:00:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	axboe@kernel.dk, colyli@suse.de, kent.overstreet@gmail.com,
	agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
	song@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com
Subject: Re: [RFC PATCH] block: add meaningful macro for flush op flags
Message-ID: <20230512130042.GA29078@lst.de>
References: <20230512080757.387523-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512080757.387523-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_060056_091946_727CA3B2 
X-CRM114-Status: UNSURE (   7.88  )
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

Hell no.  This is just obsfucation.  We can look into actually exposing
REQ_OP_FLUSH at the bio level, but not something like this.


