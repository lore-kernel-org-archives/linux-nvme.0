Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDEAC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 16:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hxBgnsSFU5qxODZU3ulpgywsz/4bCTqg2flBEBiHAjI=; b=o3K6VLnRYbWWo0ov2n1OqVIl3T
	GUv0kyJmOuxp41PyxGbw09TzD+ZRTyHNHHE6Hm83Sa4zaXzlO0oBAVIvRJo9sB0e/P+gK9EiNu/6T
	i97ekpYuWhBK9NJYkOvXUae1J+dbRIzpPKQ3DVy2RKw+j6aK26Xf4q3KSfdCXq54wjzTg2lqq5uZk
	hysJOA8ix4vK5YxR/z/HgsZBTJ2MXUGv7Nhl9TylivEER/7OaJE8GsbOiUxdy6u3SLKC+2SPvkV+M
	TxluyFvIqs3eSt2X47XibXe8ZC6UtuNFkGg4wrCYPTS84V+LqEgxfgSvFfYkF+rmyvGrmI1MQ9PJW
	xiWt/r4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSLGs-00DS4K-Ri; Thu, 10 Mar 2022 16:04:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSLGq-00DS3u-GV
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 16:04:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AC47968B05; Thu, 10 Mar 2022 17:04:01 +0100 (CET)
Date: Thu, 10 Mar 2022 17:04:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Maurizio Lombardi <mlombard@redhat.com>,
 linux-nvme@lists.infradead.org, axboe@fb.com,
 Sagi Grimberg <sagi@grimberg.me>, Ming Lei <minlei@redhat.com>
Subject: Re: nvme-host: disk corruptions when issuing IDENTIFY commands via
 ioctl()
Message-ID: <20220310160359.GA3733@lst.de>
References: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
 <20220309062630.GA31508@lst.de>
 <20220309162303.GB3949054@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309162303.GB3949054@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_080408_718619_0357D7EE 
X-CRM114-Status: GOOD (  21.93  )
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

On Wed, Mar 09, 2022 at 08:23:03AM -0800, Keith Busch wrote:
> > Combination of a broken application (does what the spec explicitly
> > tells it not do) and broken hardware (does the most stupid thing when
> > fed invalid input), not much the driver can do here.
> 
> There's nothing the hardware can do either to know it was given invalid
> input here if PRP2 is page aligned. There's no way it can tell the
> difference between a PRP List vs PRP destination.

Well, it can know that there must be at most two PRP2 for Identify when
the MPS is set to 4k.  Yes, this is annoying especially with hardware
allerated frontends, but that's what you get for that stupid globally
harmful microptimization that PRPs are.

> > But we really should talk to the nvme working group to ECN the text
> > for the single PRP requirement to spell out the consequence in more
> > detail, and maybe also mandate how it is handled for the next spec
> > version.
> 
> It's not a "single PRP requirement". The spec just says the "data
> structure is 4096 bytes". This can validly span 2 PRPs if the first one
> has a non-zero offset.

Yes.  But even 2 PRPs are not a PRP list given that the data pointer has
two PRP fields.  (completly ingoring the issues with non-4k MPS).

