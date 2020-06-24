Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4793C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 18:07:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9533B206C0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 18:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q1PRPbRn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlAbWsBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9533B206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5scqf4dDHsAgwvaSrolurCwhr7pP0D1HBrnQc6x/d5s=; b=q1PRPbRnnR5gHh4lcoPBVJHef
	r7D4oGhBh7h+J7ynp8YJifJWNFZm4xWd8b6PE4IdEUxgndIiLSl8w5Kj18RfslV+Oy1oinvuYbBB1
	LwC6kHyO45KJLRv0y+0Ju8aQqGbd4B80XzMNbwN3gscVl+6+3+iWQC86wm7HF3e7anF5tPIZoZ0Rs
	DkouvIevPw7hW2HM4CJDQ+SI4KYYgQ+Aj2nkjHPkjq9y6zbMZ0A6cXep+FsnDTDfOmqiUTft0RDNO
	eJ5ZKU9FJIL6bb8qzJONNm4aK3K4dNevFrsCEzuVpg6AO5hxCWjCKTHMKrWIYhlOQJ+wSUN0yZyv0
	34FCcampg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo9nk-0003qQ-2Z; Wed, 24 Jun 2020 18:07:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo9kA-0001vj-UC
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 18:03:35 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 72EBA206EB;
 Wed, 24 Jun 2020 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593021806;
 bh=AZTKZ6KSw+bbD8axJCFHiGmvOaj3nYdk5ra1ah7MLRk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hlAbWsBuT4Qp5F94aXzp7trcbqtBjsvmO5qnC7sa3dp6aFwxRFeEv1yVhFMjuKzGd
 FNKdrTgSuCV9/uiGmB/sFdzpJrDWFFkU7DRn2OxAaYM1HlUkKpQ24u+6xhC4Ua3N3v
 u1ddVcATWGHsy4DeKuHPW5dDjcsy5y3L6nAc14Ho=
Date: Wed, 24 Jun 2020 11:03:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set support
Message-ID: <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
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

On Wed, Jun 24, 2020 at 10:46:03AM -0700, Sagi Grimberg wrote:
> On 6/24/20 10:25 AM, Keith Busch wrote:
> > On Tue, Jun 23, 2020 at 04:17:30PM -0700, Sagi Grimberg wrote:
> > And what if it is a DNR error? For example, the controller simply
> > doesn't support this CNS value. While the controller should support it,
> > we definitely don't need it for NVM command set namespaces.
> 
> Maybe I mis-undersatnd the comment, but if you see a DNR error, it means
> that the controller replied an error and its final, so then you can have
> extra checks.

If the controller does not support the CNS value, it may return Invalid
Field with DNR set. That error currently gets propogated back to
nvme_init_ns_head(), which then abandons the namespace. Just as the code
coments say, we had been historically been clearing such errors because
we have other ways to identify the namespace, but now we're not clearing
that error.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
