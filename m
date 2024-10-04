Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B435BCFA745
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 05:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hz0ntpKgG89EFhqhYxchf66oZMPTCVvnmK3pUHOKnfU=; b=hoW12Bu48NRNUzg/EthLX4ij30
	j++uP1WFKy5gRIGx+hb+gRYaeXsNWybtH+5nz/mCDVzb/M9A+CE5lRsMhTj1BLWpfEmHEJae740M0
	eS9hXfwUcIHpcnCpdEKRHUS0sAzPBKlcRlm/ijstc04cb23ZbFFgls+tesV9y+Ey6Iu9Xw7qfi0cK
	VrKF61+Ck6q0aeVLZttZwMTm5dEVVt3X8ZOxfb6ENtUIycV7D1e7cyDONkShAQalxcs8RZr75Hccw
	g+quOP5D+Y0Vc/tHjVAn8JcmOTWGXHijajm+Pw7HFfJK5bvagpSzQbcSnSQNLkejiVeIM7BTz8buZ
	QWQMyqHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swb4G-0000000B52A-0Bz1;
	Fri, 04 Oct 2024 05:41:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swb4C-0000000B51a-2GSR
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 05:41:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D56DB227A87; Fri,  4 Oct 2024 07:41:23 +0200 (CEST)
Date: Fri, 4 Oct 2024 07:41:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg Joyce <gjoyce@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me, hare@suse.de,
	dwagner@suse.de, msuchanek@suse.de, jonathan.derrick@linux.dev,
	okozina@redhat.com, nilay@linux.ibm.com
Subject: Re: [PATCH 1/1] nvme: retry security commands if media not ready
Message-ID: <20241004054123.GA14423@lst.de>
References: <20240930164845.8406-1-gjoyce@linux.ibm.com> <20240930164845.8406-2-gjoyce@linux.ibm.com> <20241002081633.GA22436@lst.de> <dbfd87e4900bea3a28ac46f5abcfb39ef2c13fc1.camel@linux.ibm.com> <20241003124345.GA16754@lst.de> <3876a795bbaa8cef46ed0cb84f8eeccc5462f075.camel@linux.ibm.com> <20241003144106.GA24422@lst.de> <fd5ebec0dc273afd5d748a26c999254d3ed28f01.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd5ebec0dc273afd5d748a26c999254d3ed28f01.camel@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_224128_750682_66C9D2EB 
X-CRM114-Status: GOOD (  20.21  )
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

On Thu, Oct 03, 2024 at 06:35:30PM -0500, Greg Joyce wrote:
> I agree, I wonder about the value/wisdom of the CC.CRIME capability
> especially since there is no way to read status that indicates that the
> media is ready for the Figure 103 commands. But it is a defined feature
> and setting it does cause CSTS.RDY to be asserted before the media is
> ready.
> 
> The Kioxia CM7 drive does set both CRWMS and CRIMS (CRMS=11b). And
> these lines in the NVMe driver thus set CC.CRIME:
> 
>         if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap &            
> NVME_CAP_CRMS_CRIMS)
>                 ctrl->ctrl_config |= NVME_CC_CRIME;
> 
> After reading more of the spec and driver code and discussions here, I
> suggest that those two lines be removed. This has the effect of
> returning to the NVMe version 1.4 behavior and CSTS.RDY will not be
> asserted until the media is ready for commands.

Well, it is a useful feature unless random admin commands return
not ready.  Which got weaseld into the spec, but really should not
happen to make the feature useful.  So I think we'll need to put the
workaround in instead of messing up the proper implementations of
the feature that aren't this silly.  And make sure the big companies
put that into their purchase specs.


