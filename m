Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AECBC3271E
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jul 2024 05:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NA8kU+K9F2oh4S5xjK/4oC/evsEspSQKY/xJMAfemNQ=; b=zPQcru4ePlQCj+kCKnha+YYqNB
	76jsbTnDophH3mbEzAVYo5pOPF9xDjx8kvQntaJjadWhAbDQhr8kXHz41NFCe6utlA2XF86cGH8cG
	4g233SMZqiwQL/FzhVZz2F8wMJzNKPgpl3nJJsalVS4HWyBl+acFGNU04v9QiDAgGBVENJwmZhZZx
	lktzf8KyQsmFC/yHcizFiLwMqhsy5iqqusEWocG45u0zjwcxk8FYC5bvtL2zpsKwwVGwOnYES8Y5S
	4ndYrF5fkuFio8gSSMkMRnEO3op+FW04nOUv40MbDaKjpiiDKOs8ap2kfZB8wRjlQaM/Kq/UmPasP
	Kmz6EMpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRmZd-0000000CoB5-3wWl;
	Thu, 11 Jul 2024 05:42:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRmZb-0000000CoAX-18AK
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jul 2024 05:42:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1A8CA68AA6; Thu, 11 Jul 2024 07:42:25 +0200 (CEST)
Date: Thu, 11 Jul 2024 07:42:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: fine-grained PI control
Message-ID: <20240711054224.GA4331@lst.de>
References: <20240705083205.2111277-1-hch@lst.de> <yq1ttgz5l6d.fsf@ca-mkp.ca.oracle.com> <20240709071604.GB18993@lst.de> <yq1h6cy3r3f.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1h6cy3r3f.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240710_224231_473124_729CE52C 
X-CRM114-Status: GOOD (  22.97  )
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

On Tue, Jul 09, 2024 at 11:47:58PM -0400, Martin K. Petersen wrote:
> For the user API I think it would be most sensible to have CHECK_GUARD,
> CHECK_APP, CHECK_REF to cover the common DIX/NVMe case.
> 
> And then we could have NO_CHECK_DISK and IP_CHECKSUM_CONVERSION to
> handle the peculiar SCSI corner cases and document that these are
> experimental flags to be used for test purposes only. Not particularly
> elegant but I don't have a better idea. Especially since things are
> inherently asymmetric with controller-to-target communication being
> protected even if you don't attach PI to the bio.
> 
> I.e. I think the CHECK_{GUARD,APP,REF} flags should describe how a
> DIX or NVMe controller should check the attached bip payload. And
> nothing else.

I really hate an API that is basically exposes a completely
different set of flags for SCSI vs NVMe.

I am also really not sold on IP_CHECKSUM_CONVERSION and the separate
no check for disk vs controller things.  I can see why someone would
want to do that for testing, but as a general API at the syscall
level it just is not a useful abstraction and highly confusing.

Can we figure out a way to do these as error injection points in
scsi or something similar so that we don't have to overload the
user interface with it?

> I'll try to connect my NVMe test box tomorrow. It's been offline after a
> rack move. Would like to understand what's going on. Are we not setting
> ILBRT/EILBRT appropriately?

I think NVMe just had a real mess with deallocation and Write Zeroes
in the past, and my test driver might be old enough to have implemented
the ECNs that fixes this eventually, assuming it actually got fixed
everywhere.


