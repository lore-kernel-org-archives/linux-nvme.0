Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A60C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 07:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q+VzSZjrSbem0gdn+rH6aoiwcXleso9/Sn9flXWccpo=; b=dfzlp55PgkcZoF4HUqxwjijZnU
	Coc+qKIWTOyk+KA8zX/B5KT/9VPe1t6dLEpG2K+OPNMMAEw1QxMOGBxUocGgllDaGw1RK8yscLdh2
	S0OCV4CHA8fMEf8Q/ATVMY7IArWhnU1HbF8BfK/lJzl30QZx3sEPrX0jKauVor2YmF05Da3MmhTGa
	Fcmiqx9TwWKrJSWEEGOzKWvIJvm9pyjW1tCbO8E2LyAZsFqElWD9nu3uGkSe97BNujlBW857BOMZp
	rE9ro99bOpNgwuH7mCWk4eWNJjj4XP559LXyKp181D44MWUTeWJNntXYTUjq4FP+cGxJxlmSGaPsG
	Bmb/qZZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0cmZ-003A3U-1h;
	Wed, 08 Nov 2023 07:15:23 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0cmY-003A30-1F;
	Wed, 08 Nov 2023 07:15:22 +0000
Date: Tue, 7 Nov 2023 23:15:22 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Wen Xiong <wenxiong@linux.ibm.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	linux-nvme@lists.infradead.org, Wenxiong <wenxiong@us.ibm.com>
Subject: Re: Saw I/O errors while delete/create/attach a namespace on nvme
 device.
Message-ID: <ZUs1iu2/qRkNPWH/@infradead.org>
References: <ee222a8c6574d754d7e6355591e1a06a@linux.ibm.com>
 <ZUn70pL+YV0adqd0@infradead.org>
 <299987e5-ffb8-461c-9228-cad7e17cc542@nvidia.com>
 <dd07dbc043e38a7a4dcaee0b6d2835ec@linux.ibm.com>
 <ZUpVOYvgmFzXEK0y@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUpVOYvgmFzXEK0y@kbusch-mbp.dhcp.thefacebook.com>
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

On Tue, Nov 07, 2023 at 08:18:17AM -0700, Keith Busch wrote:
> Are you running these commands in quick succession? There should be a
> "rescanning namespaces" message right after the 'detach-ns' command, and
> before subsequent 'attach-ns' command. It looks here that the rescan
> didn't run until after the 'attach-ns' occured. Instead of tearing down
> the original, the driver just sees the namespace it previously knew
> about has changed unexpectedly; the processing for the namespace removal
> didn't happen prior to the attach-ns command.

Yep.

> 
> > [  149.578714] nguid mismatch
> > [  149.578719] nvme nvme0: identifiers changed for nsid 1
> > [  149.582291] block nvme0n1: no usable path - requeuing I/O
> > [  149.722140] block nvme0n1: no available path - failing I/O
> > [  149.722157] block nvme0n1: no available path - failing I/O
> 
> If you drop all open references to /dev/nvme0n1, then the handle should
> get deleted, and a manual rescan after that should get your new
> namespace visible.

I fear we still need to handle this somehow.  For actual per-spec
namespce management we'll just need to snoop the namespace management
commands and update the ns_head membership.  For out of band management
there's not much we can do as-is.  A good addition to the spec would
be to add the concept of a namespace generation that is incremented
every time the nsid is reused.


