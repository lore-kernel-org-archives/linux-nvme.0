Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E36EC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 17:25:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F01320836
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 17:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tn3h2fYP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrmwJ7Do"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F01320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1Rn/hYMrZcIgRh9PL6rrCKf0egrIwSZURkbH/81/YJE=; b=Tn3h2fYP13b0eNmTvFutDOcbg
	TXU9+H0aAXNfD7zk9NxuOPcAdZP47OXkc6WNccwn2G9vbVyzn2NlVWK+sWD+SrnY1mOx6vsrLk967
	SFhUobAs/wEc4ZIAq+z+UfpprCHlf+Sa6KlN/igHuYwMXr4Iz1agSKKW7K6J2fTVA5yCU+Bj53Cvz
	Xl3uMYtWFk/Vm+f40XvuFbt0b986c0icfMv5InCf22AXYpm7+5Atnd6YaZQr9gNiBnGOKfqRPb2YZ
	w4LTr7aEHH+pYbkbValONUuPv+0MBEvVsXGu5dzJj1tRAUHxnbe6LfZyoHkrBHPR6uaJXceqLKkFg
	hwQWDoxcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo99A-0000LE-SL; Wed, 24 Jun 2020 17:25:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo997-0000Jv-6g
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 17:25:14 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C69022078D;
 Wed, 24 Jun 2020 17:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593019512;
 bh=HhO/sOQOOLLB8Ih6Q75GWOsi4UoMPxjoZ4C46ch4QRA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JrmwJ7Do1aY4hFozWLENjwf9W6i8yfDP71mPxKRPaI6w0QMYl8CRQTFXCuIfLoaeJ
 B3TPbMDgwnc+ANYi3ihXau8KiLP7UKojw6Y+RXUr+ik/+4mGFy7M/WIlnYAQw+Ci2V
 5zVSqMb9Lzj3snQaVFfRU2LI9GdaBtrbc+EvhE0M=
Date: Wed, 24 Jun 2020 10:25:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set support
Message-ID: <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 04:17:30PM -0700, Sagi Grimberg wrote:
> 
> > > > > -		len = nvme_process_ns_desc(ctrl, ids, cur);
> > > > > +		len = nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
> > > > >    		if (len < 0)
> > > > >    			goto free_data;
> > > > >    		len += sizeof(*cur);
> > > > >    	}
> > > > >    free_data:
> > > > > +	if (!status && nvme_multi_css(ctrl) && !csi_seen) {
> > > > 
> > > > We will clear the status if we detect a path error, that is to
> > > > avoid needlessly removing the ns for path failures, so you should
> > > > check at the goto site.
> > > 
> > > The problem is that this check has to be done after checking all the ns descs,
> > > so this check to be done as the final thing, at least after processing all the
> > > ns descs. No matter if nvme_process_ns_desc() returned an error, or if
> > > simply NVME_NIDT_CSI wasn't part of the ns desc list, so the loop reached the
> > > end without error.
> > > 
> > > Even if the nvme command failed and the status was cleared:
> > > 
> > >                  if (status > 0 && !(status & NVME_SC_DNR))
> > >                          status = 0;
> > 
> > This check is so weird. What has DNR got to do with whether or not we
> > want to continue with this namespace? The commit that adds this says
> > it's to check for a host failed IO, but a controller can just as validly
> > set DNR in its error status, in which case we'd still want clear the
> > status.
> 
> The reason is that if this error is not a DNR error, it means that we
> should retry and succeed, we don't want to remove the namespace.

And what if it is a DNR error? For example, the controller simply
doesn't support this CNS value. While the controller should support it,
we definitely don't need it for NVM command set namespaces.
 
> The problem that this solves is the fact that we have various error
> recovery conditions (interconnect issues, failures, resets) and the
> async works are designed to continue to run, issue I/O and fail. The
> scan work, will revalidate namespaces and remove them if it fails to
> do so, which is inherently wrong if these are simply inaccessible by
> the host at this time.

Relying on a specific bit in the status code seems a bit indirect for
this kind of condition.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
