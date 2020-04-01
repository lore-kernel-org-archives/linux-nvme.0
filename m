Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0828C43331
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 20:43:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929EC20784
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 20:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VR7nj9hh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d06gCX/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929EC20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Oinhx1D+Bxo+LTTNiG7j+/SJEpVP9uSLxCFE1Acar0k=; b=VR7nj9hhLxEoAv
	mq/9zwtxSpUqrU1henJ8KUz1pG30W8KyGpGq8MI+eVCFEwo/CLlQbCKXrWV6pho0Hv3/2gKNV0fZx
	p64qsJHVCHp8RofuXnuZYoYhwRnvUFUGdVRqUoIyrYYIpMeHvb7UuwrWdoOpf01sdF3IlJeQq+2Fs
	A4wKLpU3QiSQSffuL1HLxdT9NpecpVlNlNf1QKyxg9lg0P84FI5+mopQ/J4tXovMbJNoOo+AhUq7J
	TrUuOKdtQbhupWFTsxrnFeU4wdwCQULOYfqSJKdZXt++bxryitsVg2pIiaM4kYGA+oaz/hr3VMgZ8
	44HNJ6WwRLc/gmGT70Kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJkDB-0006gV-MT; Wed, 01 Apr 2020 20:43:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJkD9-0006gC-HZ
 for linux-nvme@lists.infradead.org; Wed, 01 Apr 2020 20:43:44 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B4E6A20784;
 Wed,  1 Apr 2020 20:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585773823;
 bh=+x6ISKCPt3l2GHxP2YUa+4FUFuEaRZZZe42OGiQSjvc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d06gCX/PLbakmPtdqgeY/i+g/bT15qDiWenn3BLVJO6Ac2OTWApIRDqyG+5soHQUP
 T03kp9GfnQphB37lq2bVCnco2MUbhxyXVim5VJ6Z04L9G+pSovD3KV7z9hu/vZ7dNd
 0953nPuAfApicfFo06P/5lZlTEI1tTXQO4jSIczU=
Date: Thu, 2 Apr 2020 05:43:36 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH rfc 2/2] fabrics: allow user to pass hostname instead of
 traddr
Message-ID: <20200401204336.GA16884@redsun51.ssa.fujisawa.hgst.com>
References: <20200324090324.24459-1-sagi@grimberg.me>
 <20200324090324.24459-3-sagi@grimberg.me>
 <20200401193908.GB1144965@dhcp-10-100-145-180.wdl.wdc.com>
 <66d26b09-7a9f-cd2c-c2c4-e7e311271f5d@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <66d26b09-7a9f-cd2c-c2c4-e7e311271f5d@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_134343_606545_97CD8115 
X-CRM114-Status: GOOD (  20.44  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 01, 2020 at 01:33:40PM -0700, Sagi Grimberg wrote:
> 
> > > Some users would like to use well known hostnames instead
> > > of remembering ip addresses. So, allow users to pass --hostname
> > > and we will attempt to resolve against the DNS.
> > > 
> > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > ---
> > >   fabrics.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 75 insertions(+)
> > > 
> > > diff --git a/fabrics.c b/fabrics.c
> > > index a7d628b1f0c9..7bd95c4b0d10 100644
> > > --- a/fabrics.c
> > > +++ b/fabrics.c
> > > @@ -33,6 +33,10 @@
> > >   #include <sys/stat.h>
> > >   #include <stddef.h>
> > > +#include <sys/types.h>
> > > +#include <arpa/inet.h>
> > > +#include <netdb.h>
> > > +
> > >   #include "util/parser.h"
> > >   #include "nvme-ioctl.h"
> > >   #include "nvme-status.h"
> > > @@ -60,6 +64,7 @@ static struct config {
> > >   	char *nqn;
> > >   	char *transport;
> > >   	char *traddr;
> > > +	char *hostname;
> > >   	char *trsvcid;
> > >   	char *host_traddr;
> > >   	char *hostnqn;
> > > @@ -857,6 +862,54 @@ static int build_options(char *argstr, int max_len, bool discover)
> > >   	return 0;
> > >   }
> > 
> > The code looks fine.
> > 
> > I realize 'hostname' in this context is referring to the remote host and
> > resolves the target's transport address, but it just sounds potentially
> > confusing given we have "host_traddr". I'm not sure of a better name,
> > though, so if this is normal convention, then okay.
> 
> We could do it like ssh that can accept either IP or hostname (we check
> if string is IP and if not, resort to name resolution)
> 
> Is that preferable?

Yah, that option sounds more appealing to me.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
