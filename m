Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB13AC27C53
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 16:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U7msnklgYBOIfbgcaCxKz002QCLA3EeUmLoFR0q1Nlk=; b=xuEKEX3WV51ovVm3zcgZ+/vgC6
	XtgJMAQKZmz8yCtI0/NAUxi5gqbWa4y+Qm6YAk6ol6KgwOJ3BMrYULyEtdruqnpwdomvL7mvf2vKv
	uvo79hvIi11TMtgviU6dZK7Q9ZjnwDt2E2f70OinMM+6gBy8iN8v1VxdxVFYXyf5JQ7EZKqG4TbaG
	f/FQrDzxR+rh9PbkOuMpoOcszh0907Ml12mz+DoMonRwLwFTYkJxbbOAMD793VgdJQjcEnVD/dPf6
	nOJQK2yLVQmgZESiIj+XOPJBIGIRZK5s0DoJe0o+mC1KEbCdyfi4N7iZRIkmVpcy/H2KR9SHBD2ch
	GbkblTDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFcnY-0000000F023-34Fl;
	Fri, 07 Jun 2024 16:50:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFcnR-0000000F01e-2uSk
	for linux-nvme@lists.infradead.org;
	Fri, 07 Jun 2024 16:50:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717779030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7msnklgYBOIfbgcaCxKz002QCLA3EeUmLoFR0q1Nlk=;
	b=hVihkznZpiPE2cpA+rvX46v7UkURea7Dro0o3ExffQactqHhXe0mBUddJeVBpvOKFusHM5
	nQgMol6jmeuIZVv0UhFguJzft6AiH/0Cqztq7kigxGtA9uTnU6hxmba6soPOcPZ0mxmQW8
	FwFXG0rJAMMbJWNYnZGKZJt8plr7X8s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-mONfFz0OMcW4N61P6CokGA-1; Fri,
 07 Jun 2024 12:50:26 -0400
X-MC-Unique: mONfFz0OMcW4N61P6CokGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 788FB3806708;
	Fri,  7 Jun 2024 16:50:25 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 32EE43C23;
	Fri,  7 Jun 2024 16:50:24 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 0C00330C1C2E; Fri,  7 Jun 2024 16:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 08B043D91D;
	Fri,  7 Jun 2024 18:50:24 +0200 (CEST)
Date: Fri, 7 Jun 2024 18:50:23 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, 
    Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>, 
    Dan Williams <dan.j.williams@intel.com>, 
    Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
    Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>, 
    Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
    linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-raid@vger.kernel.org, nvdimm@lists.linux.dev, 
    linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: Re: move integrity settings to queue_limits v2
In-Reply-To: <ZmMqfj3T9Ft680j6@kernel.org>
Message-ID: <d686fec1-c883-b02a-f755-b63d2661df6f@redhat.com>
References: <20240607055912.3586772-1-hch@lst.de> <ZmMqfj3T9Ft680j6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_095033_918827_9831C46D 
X-CRM114-Status: GOOD (  23.11  )
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



On Fri, 7 Jun 2024, Mike Snitzer wrote:

> On Fri, Jun 07, 2024 at 07:58:54AM +0200, Christoph Hellwig wrote:
> > Hi Jens, hi Martin,
> > 
> > this series converts the blk-integrity settings to sit in the queue
> > limits and be updated through the atomic queue limits API.
> > 
> > I've mostly tested this with nvme, scsi is only covered by simple
> > scsi_debug based tests.
> > 
> > For MD I found an pre-existing error handling bug when combining PI
> > capable devices with not PI capable devices.  The fix was posted here
> > (and is included in the git branch below):
> > 
> >    https://lore.kernel.org/linux-raid/20240604172607.3185916-1-hch@lst.de/
> > 
> > For dm-integrity my testing showed that even the baseline fails to create
> > the luks-based dm-crypto with dm-integrity backing for the authentication
> > data.  As the failure is non-fatal I've not addressed it here.
> 
> Setup is complicated. Did you test in terms of cryptsetup's testsuite?
> Or something else?
> 
> Would really like to see these changes verified to work, with no
> cryptsetup regressions, before they go in.
>  
> > Note that the support for native metadata in dm-crypt by Mikulas will
> > need a rebase on top of this, but as it already requires another
> > block layer patch and the changes in this series will simplify it a bit
> > I hope that is ok.
> 
> Should be fine, Mikulas can you verify this series to pass
> cryptsetup's testsuite before you rebase?

Yes - it passes the cryptsetup testsuite.

Mikulas

> Thanks,
> Mike
> 


