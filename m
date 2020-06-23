Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8726C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 22:10:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C12020724
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 22:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vFQl8AXI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1i5VqjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C12020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fn7vCeHPDG9lIxExqBpOhNUiTQEKXpfBlJMx+aFNik4=; b=vFQl8AXIdDJgUI0zbrV8fTU+e
	14YbetTUT46JRrPW5J9KCnWQ1GS3uDF8B5e/sUkaf4dpFpwjB1NbQY+F1+2p8aExr0lshUKgHU9NY
	73SC18fetHDc+e1noyELsO/kJ5qvry1AtkhFe4smKDaiYu3kjuw3TouzXF1qEmuEr6XW8f8HtpYrq
	lmwrOMr4HeoUPDeSV76qeO4TS8WUoeh1enOO5u5qKeGIehEQJ+zvALlQ4s28lBfE2a9/E6LQfhu+k
	T08c5J2Vp3RpUGgU91ObR4K5lHa9TlYLrDrj0IX9Td9bsJOPgTWcGQdDSOVkvQc1YQX8bpTG8OmIx
	tGNUw9Ybw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnr7l-0007lY-Qk; Tue, 23 Jun 2020 22:10:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnr7P-0007lH-WA
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 22:10:16 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8DE1420724;
 Tue, 23 Jun 2020 22:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592950215;
 bh=zmKL1sjxL6w9xqVyEnstEuOeJaEEQeG/0MzpssNKxKI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d1i5VqjUObKdWggQ5UPbobcahz/U8OwwaX9IA3aUeoax52//HJpaFGaqB6azcQQiq
 qjjpG3IEhFMjUIyaDXjPa8qkA2W/7V55h7ED3kPN3Zm3NYey6QTy8iFHF654Tf16gE
 C/ecVNccfzh2VYPuF0I+cRSXgGAR46T4Veraza8Y=
Date: Tue, 23 Jun 2020 15:10:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set support
Message-ID: <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200623112551.GB117742@localhost.localdomain>
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 11:25:53AM +0000, Niklas Cassel wrote:
> On Tue, Jun 23, 2020 at 01:53:47AM -0700, Sagi Grimberg wrote:
> > On 6/22/20 9:25 AM, Keith Busch wrote:
> > > -		len = nvme_process_ns_desc(ctrl, ids, cur);
> > > +		len = nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
> > >   		if (len < 0)
> > >   			goto free_data;
> > >   		len += sizeof(*cur);
> > >   	}
> > >   free_data:
> > > +	if (!status && nvme_multi_css(ctrl) && !csi_seen) {
> > 
> > We will clear the status if we detect a path error, that is to
> > avoid needlessly removing the ns for path failures, so you should
> > check at the goto site.
> 
> The problem is that this check has to be done after checking all the ns descs,
> so this check to be done as the final thing, at least after processing all the
> ns descs. No matter if nvme_process_ns_desc() returned an error, or if
> simply NVME_NIDT_CSI wasn't part of the ns desc list, so the loop reached the
> end without error.
> 
> Even if the nvme command failed and the status was cleared:
> 
>                 if (status > 0 && !(status & NVME_SC_DNR))
>                         status = 0;

This check is so weird. What has DNR got to do with whether or not we
want to continue with this namespace? The commit that adds this says
it's to check for a host failed IO, but a controller can just as validly
set DNR in its error status, in which case we'd still want clear the
status.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
