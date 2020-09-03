Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85474C433E2
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 16:20:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD5820829
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 16:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q4NVxXG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD5820829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e0oPswe5EEBACQf33OKKVnEkdAnRWqOSza09m7Kv0XE=; b=q4NVxXG6wbzqYImQrhesx4Mw2
	oSAQPxovJOX+hZ1WvEIS+Czv/xxZagJe/QZPD4JudtelYA7a1h3x27k8tSxZQa2HLa1Byua7aS7sR
	HsoQ488KtEG6i6UqQV1Kmo+teqC8mcNp3QiA5DsvzPJhXoHMxY+Dt6YZDucqKrfZ5DisKLT8DEMS0
	TZvqws4G1kx6e2u5BBqtgiHQrJpctwDPSfg7Vf4uCGfUkHY3QEULJUASSzOqYW+G+kiJ/TLPwhl5b
	g32fhNyhzQATy2i2X6w5UDef2dqiLGePKQuUXo+apUGqw0YLmuwfIoA67VAsshrk4Q6GsrPPjLyiz
	D05gVSQ7A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDryZ-0006SQ-Mu; Thu, 03 Sep 2020 16:20:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDryX-0006Ro-0X
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 16:20:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6F91467357; Thu,  3 Sep 2020 18:20:35 +0200 (CEST)
Date: Thu, 3 Sep 2020 18:20:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 05/12] nvmet: use unlikely for uncommon commands
Message-ID: <20200903162035.GD25423@lst.de>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-6-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200831222707.35611-6-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_122037_162993_DF5F600D 
X-CRM114-Status: GOOD (  11.14  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 31, 2020 at 03:27:00PM -0700, Chaitanya Kulkarni wrote:
> I/O commands (nvme_cmd_read, nvme_cmd_write) are most common commands
> when accessing passthru controller, most controllers should not
> have set the effects for r/w I/O commnds (atleast I don't know at this
> moment). Also, check for req->p.use_workqueue is true in two admin
> commands only which are low frequency commands.
> 
> Annotate use_workqueue and command effects check with unlikely in the
> fast path.

What difference does this make?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
