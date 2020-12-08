Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE49C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 19:04:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA8523B28
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 19:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA8523B28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=r6qCEu8HEVY5ShgOqfTJisoMsMP67n1JdFtmeodTyTQ=; b=E+pFM0tX1vM9aX9x3E26AASEv
	YK8AWpUNjrnKf0t9fYolx1NA9eXS9NO7q6V/CCVYpUNqwduJKdzFNlKdAAk4GPO+isDX8LXp+cRXR
	PtWFaAf9aZbS2RQmC0bVP5px80QwF1f5dPXDBlpmBMVAqtoQ9kWk9bUmB+uUjzAJV3YGJXG0YP65A
	BXEut7XFzD2EXrabg+Ld/GTau/PC953WZt8+9xPbVzrGczR0nVoIzUVHwGaE2CtfHKfknvxnyvD+U
	b2XKSgK8srMlUh3kH0T+lUqWMLDkdRiZ5I3+JcE9aqGZOvpm1SxnftZsIkr2I/LpWz10GEfvF4ySN
	ttfKjyh3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmiH2-0004ly-Vz; Tue, 08 Dec 2020 19:03:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmiH0-0004lZ-H5
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 19:03:43 +0000
Date: Wed, 9 Dec 2020 04:03:35 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607454221;
 bh=L8FM559sr2mI1V2XQXd6cRw/SUcIbxs3FHy79RWrxTE=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=mqPFzsO3ZAtKrz8wPFVBeXJWaALpK+sQlNZl72bJMa9iLYWRjbuzLOfizW2hm2/SJ
 /GxpttTauDDzrD+AsLik6KleNnr4jHdL9tPX5msR2OWc6XMSz3/NP56qHaD7GBI96A
 f7ZTH1H81h67nKMNI8eXpaGX7UtkNXSPhk+rpcz4N8n+Sv5Ud02zxROSs4q3vtcDkX
 LOhDMtuumT61HLjeHsUrsGbQPVAx20DMxFieilInWQZdsVJHs94zWkNkOMlVemX8k7
 mn1MduOAHj+/kNYum19CYda/IFmia3A8Dv6qqGTG5NYpWlWchuPffh67rbl6DbwlIW
 uG+7uEPkZ0vBA==
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2] nvme: enable char device per namespace
Message-ID: <20201208190335.GC27155@redsun51.ssa.fujisawa.hgst.com>
References: <20201208132934.625-1-javier.gonz@samsung.com>
 <20201208142151.GA4108@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201208142151.GA4108@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_140342_650699_F532D056 
X-CRM114-Status: GOOD (  11.40  )
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
Cc: javier@javigon.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, minwoo.im.dev@gmail.com,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 08, 2020 at 03:21:51PM +0100, Christoph Hellwig wrote:
> > +	sprintf(cdisk_name, "nvme%dn%dc", ctrl->instance, ns->head->instance);
> 
> And the most important naming decision is this.  I have two issues with
> naming still:
> 
>  - we aready use the c for controller in the hidden disk naming.  Although
>    that is in a different position, but I think this not super intuitive.
>  - this is missing multipath support entirely, so once we want to add
>    multipath support we'll run into issues.  So maybe use something
>    based off the hidden node naming?  E.g.:
> 
> 	sprintf(disk_name, "nvme-generic-%dc%dn%d", ctrl->subsys->instance,
> 		ctrl->instance, ns->head->instance);

+1 for this naming suggestion.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
