Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3602C3ABCB
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 05:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VunMRhCK2m+fv31Ffzeb8uG1SqmRNZC6M/WixwbJqHA=; b=KOZd56fU27FeA1k5gxIFy9MuNR
	dzNNuueL8qItkpYAGhF00hP0RzCJ62pk+98rZ+sZLn8JmKpOcaTClE50qGz5CqH/jt3v/GMWeJn3j
	dEpeCRNs6Qex2NX8vwJHpNSbWbq4thYyL/Li71D2o0KCbs5o92kS4AFEfdDFMAJzjasMXBk0GObbV
	HzkYE9CZv4qw37cS9D6O+k9zYY/m8txrRp3nV/mlvhTq0UnUFYtPQ2VcKVpde/VPOl3lpuQ6kVYQS
	VF/kNL0zz/mP1ZcGByGUtGj/J3YHUh7TvMgtlBWVRmlSTgT8KdipFE1+0wngEz85m2Hiu0t6phV8v
	uJBOrNUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF4uq-0000000E6Ix-2mZK;
	Wed, 14 May 2025 05:44:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF4sz-0000000E68R-2Kdd
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 05:42:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F1FBC68AA6; Wed, 14 May 2025 07:42:28 +0200 (CEST)
Date: Wed, 14 May 2025 07:42:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
	kbusch@kernel.org, sagi@grimberg.me, jmeneghi@redhat.com,
	axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
Subject: Re: [RFC PATCHv4 2/3] nvme: introduce multipath_always_on module
 param
Message-ID: <20250514054228.GB24939@lst.de>
References: <20250509175158.2753396-1-nilay@linux.ibm.com> <20250509175158.2753396-3-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250509175158.2753396-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_224233_731996_2C46F64B 
X-CRM114-Status: UNSURE (   9.92  )
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

I just applied this locally, but ran into somethig that I think is
not addressed here.  NVMe allows private namespaces to have non-unіque
nsids if certain features (like ANA) are not enabled.  I don't think
we handle this here, and in fact we can't really support that with
the multipath node.  But we'll at least need to reject that case
gracefully somehow and document it.

