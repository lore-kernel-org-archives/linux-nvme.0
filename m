Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42874CFA773
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 12:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ron5xdTYnNHl4RWIBm9n3x4kPLGk96+YnDOo5KSBJuo=; b=IcJYYzkDbtzBE6s94P8JcmeAFa
	hyxB0oV80uSzpVBozMlugKuz88HwrFqF/8dzH9cmkqs/i/zsbU19cJ81+D5igAJ4Kg6xNMy0BKypr
	YGSs+anvQheSnaLaLfbfIQUSdkEHc+l7DGC3gf9AlkSwAmh/Pt0DZ8vHgNF9GcQBHDIr8chbSeuN1
	AHqcG1OrfhLJUmePo0qihZtluIpG/hSjYMF+diZuCwsNOIo6tBgpoKK/VCzC1Q+Ee4gHOoP9MvThx
	EDsolE3dHKBkQJE4ktU1W/j184R5JiO6oEeRP6nmSZlxDDff6ND03pZzlF8GYdgScwL0U9ZOrlbAh
	vYOyQDQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swhLz-0000000CI8H-1jCC;
	Fri, 04 Oct 2024 12:24:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swhLw-0000000CI6t-034T
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 12:24:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E946D227A87; Fri,  4 Oct 2024 14:24:06 +0200 (CEST)
Date: Fri, 4 Oct 2024 14:24:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Greg Joyce <gjoyce@linux.ibm.com>,
	linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
	sagi@grimberg.me, hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
	jonathan.derrick@linux.dev, okozina@redhat.com
Subject: Re: [PATCH 1/1] nvme: retry security commands if media not ready
Message-ID: <20241004122406.GA19130@lst.de>
References: <20240930164845.8406-1-gjoyce@linux.ibm.com> <20240930164845.8406-2-gjoyce@linux.ibm.com> <20241002081633.GA22436@lst.de> <dbfd87e4900bea3a28ac46f5abcfb39ef2c13fc1.camel@linux.ibm.com> <20241003124345.GA16754@lst.de> <3876a795bbaa8cef46ed0cb84f8eeccc5462f075.camel@linux.ibm.com> <20241003144106.GA24422@lst.de> <fd5ebec0dc273afd5d748a26c999254d3ed28f01.camel@linux.ibm.com> <20241004054123.GA14423@lst.de> <884b5503-5aba-46b2-b926-6dec4993881b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <884b5503-5aba-46b2-b926-6dec4993881b@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241004_052412_214934_678E09B0 
X-CRM114-Status: GOOD (  11.97  )
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

On Fri, Oct 04, 2024 at 12:52:50PM +0530, Nilay Shroff wrote:
> How about retrying the command, from nvme_retry_req(), if the return status
> of the security (or for that matter any admin) command suggests to retry 
> the request (i.e. DNR bit in the status is cleared to 0 and return status of 
> the command is NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY)?

It doesn't sound too horrible, but I'd have to see the result to
judge it.

