Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D122C3A5A8
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 17:29:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744442087E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 17:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IRolj9s9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744442087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KbMpJYMeNPpRJOMGsKBuf83qEv6NSm7ewbtjFQfiDkk=; b=IRolj9s96Ah8Rk
	d8LwLaHF76Iw+864XrF4belAHh8yzfXyDegTH7TH2SJhdIsBx52p5LGmFr1QGlYJSff1HAIWYzmWw
	JrNh9ey1IRZesZZyn2UEI8v7Kzsbh+Tce5ynZPZu9jyurfHOwKSlVY+wAST5DnBnVcsACeFpfcf7y
	ph4GByGTJFZXUDBz96H1hbHGO+WHEFEHdOyv7U/INbT6g7Tru6Gh+kR71xnIRC8r8+uSWRoaND48c
	3ANQnl0OWs7F6jWK/p/PUtZexYtsMNT0wg3JNJyx3TP8A50sUyaU859CUPZowAcbvwvXaAb8dpmGc
	hmg+oA0Xt43EwJDPfcrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5Z6A-00082Y-4d; Wed, 04 Sep 2019 17:29:38 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5Z67-00081e-BO
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 17:29:36 +0000
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
 helo=[192.168.11.155])
 by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <logang@deltatee.com>)
 id 1i5Z64-0008Ty-GK; Wed, 04 Sep 2019 11:29:33 -0600
To: Keith Busch <kbusch@kernel.org>
References: <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
 <20190903164620.GA20847@localhost.localdomain>
 <20190904060558.GA10849@lst.de>
 <20190904144426.GB21302@localhost.localdomain>
 <20190904154215.GA20422@lst.de>
 <20190904155445.GD21302@localhost.localdomain>
 <ef3bf93b-cb47-95c5-7d96-f81d9acfdb55@deltatee.com>
 <20190904163557.GF21302@localhost.localdomain>
 <f07e03f1-48f0-591e-fdf6-9499fa4dd9ab@deltatee.com>
 <20190904171445.GG21302@localhost.localdomain>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5a4cf3b0-daa2-30de-63b2-c5b28c5bb7b4@deltatee.com>
Date: Wed, 4 Sep 2019 11:29:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904171445.GG21302@localhost.localdomain>
Content-Language: en-US
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: keith.busch@intel.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, martin.petersen@oracle.com, sagi@grimberg.me,
 hare@suse.com, axboe@fb.com, hch@lst.de, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_102935_726714_5587AF20 
X-CRM114-Status: GOOD (  12.16  )
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
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2019-09-04 11:14 a.m., Keith Busch wrote:
> On Wed, Sep 04, 2019 at 11:01:22AM -0600, Logan Gunthorpe wrote:
>> Oh, yes that's simpler than the struct/kref method and looks like it
>> will accomplish the same thing. I did some brief testing with it and it
>> seems to work for me (though I don't have any subsystems with multiple
>> controllers). If you want to make a patch out of it you can add my
>>
>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Thanks! I'll make it a proper patch and send shortly.
> 
> For testing multi-controller subsystems, I haven't got proper hardware
> either, so I really like the nvme loop target. Here's a very simple json
> defining a two namespace subsystem backed by two real nvme devices:

Cool right, thanks for the tip, I should have thought of that. I just
did some more loop testing with your patch and it behaves roughly as we
expect. The controller and subsystem IDs never overlap unless they are
created at the same time and it doesn't look like any IDs are ever
leaked. With simple non-CMIC devices the ctrl and subsystem always have
the same instance number.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
