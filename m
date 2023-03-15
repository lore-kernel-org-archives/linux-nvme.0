Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDFEC61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8Nv+vC+2FlPq68coQ9TQlfK7bthVXXBTzQ4ZTOag7w=; b=lr6xQgwJgi1gt0QU4i0+pHnkBK
	RlGG5pQ/63/G8j9V6miBlMQctpSgmhmAkxsmP/BqHApOxfJFpqX89PCyWsb9CvJfw5L7YiLfkocI4
	EUYmSEm2oYzYUAXTjpQF/1yFmcAOJaH/FDeMj1z5fMd3N7l5gnTN/6myPRz+hAYQslR8Pwvje9HxL
	RtO1WBJXoO1+7ut+pX8UDAN7++gygiEvgsqagBii07HZltM+IaQaXZwqWQsL5VWDYo0Eif0RnuiGy
	36ISaMuku4w7/aLJhLh+5NPoWM08VotyJGdVF+eemG3ScHLxqm1ugbQwFWxKM+W8H1tpWcb59ZusH
	NCPIVQNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRDU-00DS40-09;
	Wed, 15 Mar 2023 13:30:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRDR-00DS2U-0S
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 13:30:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65B0768B05; Wed, 15 Mar 2023 14:30:40 +0100 (CET)
Date: Wed, 15 Mar 2023 14:30:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
	kbusch@kernel.org, target-devel@vger.kernel.org,
	Jan Hoeppner <hoeppner@linux.ibm.com>
Subject: Re: [PATCH v4 02/18] block: Rename BLK_STS_NEXUS to
 BLK_STS_RESV_CONFLICT
Message-ID: <20230315133039.GA24533@lst.de>
References: <20230224174502.321490-1-michael.christie@oracle.com> <20230224174502.321490-3-michael.christie@oracle.com> <20230314171119.GB6780@lst.de> <33ed9615-b570-03c7-9a7a-d07f020d3222@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33ed9615-b570-03c7-9a7a-d07f020d3222@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_063053_346321_3EB462B0 
X-CRM114-Status: GOOD (  13.61  )
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

On Wed, Mar 15, 2023 at 11:04:22AM +0100, Stefan Haberland wrote:
> This also fits for the DASD case. We use this error code for a
> reservation/locking conflict of the DASD device when the lock we
> previously held was stolen.

But that's not really a reservation conflict in the sense
of the reservation API.  Given that DASD doesn't support it it
might not matter.  Do you have applications that checks for
the translated errno value?  We'll probably at least want
a comment documenting this status code.

