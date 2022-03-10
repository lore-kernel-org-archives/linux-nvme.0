Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EEAC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 08:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J26ESDZtXyA+SOuoGHTg3Bi1Wwr7V818jgAsqIx8ULI=; b=lzbMCx/OQXL9BMrQ4ik0V6minJ
	fmkxrKZc7HJBSomvOC4SysssoMvssyBuNvnAn7yQzjcqXedLAfa0XzqP+1aCQGEcIFqrtQa9pEF7G
	dU2Oz7VCKOFI0a4+nF8xKV1w5TEkaNOQYIPWr9oUzoZIaCwmCT94Z/JG/H1glfhJaX8rUSZM3ehUd
	QOo9hlLJsRF3Fe2rdy5P+DjuY9loxdT6UIOXXDop6pXNioXXAZRYOa/uyHucVlePDeIScGefhYXsU
	8vCNRcbFS0a1AH/jOhz3yXGffZA4rBksRlLO6ChG6OIQjfRlFRugH2nbQYCgpVBtHRrdNJKlqQtmG
	NMovL3kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSEK1-00BxEt-Kd; Thu, 10 Mar 2022 08:38:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSEJK-00Bwyt-My
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 08:38:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DEB3468AFE; Thu, 10 Mar 2022 09:38:11 +0100 (CET)
Date: Thu, 10 Mar 2022 09:38:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mingbao Sun <sunmingbao@tom.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 1/2] nvmet-tcp: support specifying the
 congestion-control
Message-ID: <20220310083811.GA26953@lst.de>
References: <20220309053711.2561-1-sunmingbao@tom.com>
 <20220309061541.GB31316@lst.de> <20220309175203.00006ee2@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220309175203.00006ee2@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_003814_938452_3C453B0F 
X-CRM114-Status: GOOD (  24.90  )
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

On Wed, Mar 09, 2022 at 05:52:03PM +0800, Mingbao Sun wrote:
> On Wed, 9 Mar 2022 07:15:41 +0100
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Wed, Mar 09, 2022 at 01:37:11PM +0800, Mingbao Sun wrote:
> > > +		if (port->nport->tcp_congestion) {
> > > +			icsk_new = inet_csk(newsock->sk);
> > > +			if (icsk_new->icsk_ca_ops != icsk->icsk_ca_ops) {
> > > +				pr_warn("congestion abnormal: expected %s, actual %s.\n",
> > > +					icsk->icsk_ca_ops->name,
> > > +					icsk_new->icsk_ca_ops->name);
> > > +			}
> > > +		}  
> > 
> > What is the point of having this code?
> 
> Well, this could happen in certain circumstances.
> Take the result from my test as an example:
> 
>     - The congestion of the listening socket of the target was set to
>       ‘dctcp’.
> 
>     - But the congestion of the socket of the host side was set to
>       ‘cubic’.
> 
>     - Then the congestion of the socket of the new connection at the
>       target side would automatically be altered to ‘dctcp-reno’.
> 
> In case tcp_congestion was explicitly set for the target, it can be
> supposed that the user attaches great importance to performance.
> So we’d better make the users aware that the system is not working
> in the way they expect. 

A warning message really seems very severe for a condition like this.
Maybe the better interface is a way to figure out which congestion
control algorithm is in use by reading a sysfs file.

