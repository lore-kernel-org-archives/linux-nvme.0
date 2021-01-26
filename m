Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACADC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 19:07:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9EB622228
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 19:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EB622228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9o9yOjjVdp/b39H5FLxbu9wUTR8D6WPBxK3olTxhOaA=; b=vcznmMqITBm2m0oUUoDwiiqQv
	fuW/dW0l6BQLSZ3YDZWQPn+byW2IqacZEoXPS2SsbStc1invM/ScQUGDENG2cgd4ju01ylseDOV4z
	syyMluVUU63bcenmEA8mD4msVKwOzsCyG9OLFZ8l5qh3xpwj4ZHdHFOxOqqanKK5wsOgSAneasWda
	7VuVxg1H2vaqu3wFGvh3UvtnVrXkNT/TyfRMfziNWk4/uOsUnbc1mr/6cTKWmmUy7+suplCJW2lXW
	WHMUpN0nAlc2UbWTXRSAw/pBHk3/F8s+rry7+LqkCynyf2FxL8ycdvAVoJsWVS3BUom5wUu0OO5rm
	k9OCiJ83g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4Tg4-00027G-Fo; Tue, 26 Jan 2021 19:07:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4Tg2-00026Q-SE
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 19:06:59 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A389E22228;
 Tue, 26 Jan 2021 19:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611688017;
 bh=oHDwZKX4ZmCAR5GlNEJps+pQQ58Xo8ydvVXyuFUnXzU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S/yGmOEOoTz+RNKysTmUePMVDn7Mu60zcP4QV2d1YBvGoTuTFiXUsTlBoS9TFD78U
 cAEj6GmYWaIZZa7OKEeH2sIlEfPmTUTHh8bbel1S+wXo6SCJCC0Jlp+u/PIiMAZ0ky
 IiZGQ2OnuAUihyhdX4rARPuAgNetqW6A4GWhYhBviF8p7yzElP4+9GRS9Xv3IjbMb1
 Ud1mcV66sIyT50OmHfZ96z8Am4Xn/OO8PkKj10FM5evjHG/azeR92O2GfHRxIyk53c
 nMnHkEMDxXx36p0ZenqHXnqXVDXosMxEMWSb8DTBdjMMrCoEHbKf6N8nCD3ZeqFqQO
 cLuqzydqAWdYQ==
Date: Tue, 26 Jan 2021 11:06:54 -0800
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: do not ignore nvme status in nvme_set_queue_count()
Message-ID: <20210126190654.GB1742960@dhcp-10-100-145-180.wdc.com>
References: <20210121095021.22807-1-hare@suse.de>
 <20210121201459.GA1727271@dhcp-10-100-145-180.wdc.com>
 <f374b032-cd26-4552-b613-228449f4971d@suse.de>
 <20210122164454.GA4392@redsun51.ssa.fujisawa.hgst.com>
 <b27ba758-7635-4235-cb32-d485a01e59f5@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b27ba758-7635-4235-cb32-d485a01e59f5@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_140658_977360_152671EF 
X-CRM114-Status: GOOD (  26.31  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 26, 2021 at 04:25:11PM +0100, Hannes Reinecke wrote:
> On 1/22/21 5:44 PM, Keith Busch wrote:
> > On Fri, Jan 22, 2021 at 05:35:35PM +0100, Hannes Reinecke wrote:
> > > On 1/21/21 9:14 PM, Keith Busch wrote:
> > > > On Thu, Jan 21, 2021 at 10:50:21AM +0100, Hannes Reinecke wrote:
> > > > > If the call to nvme_set_queue_count() fails with a status we should
> > > > > not ignore it but rather pass it on to the caller.
> > > > > It's then up to the transport to decide whether to ignore it
> > > > > (like PCI does) or to reset the connection (as would be appropriate
> > > > > for fabrics).
> > > > 
> > > > Instead of checking the error, wouldn't checking the number of created
> > > > queues be sufficient? What handling difference do you expect to occur
> > > > between getting a success with 0 queues, vs getting an error?
> > > > 
> > > The difference is that an error will (re-)start recovery, 0 queues won't.
> > > But the problem here is that nvme_set_queue_count() is being called during
> > > reconnection, ie during the recovery process itself.
> > > And this command is returned with a timeout, which in any other case is
> > > being treated as a fatal error. Plus we have been sending this command on
> > > the admin queue, so a timeout on the admin queue pretty much _is_  a fatal
> > > error. So we should be terminating the current recovery and reconnect. None
> > > of that will happen if we return '0' queues.
> > 
> > You should already be getting an error return status if a timeout occurs
> > for nvme_set_queue_count(), specifically -EINTR. Are you getting success
> > for some reason?
> > 
> -EINTR (which translates to 'nvme_req(req)->flags & NVME_REQ_CANCELLED')
> will only ever be returned on pci; fabrics doesn't set this flag, so we're
> never getting an -EINTR.

Sounds like that's the problem that needs to be fixed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
