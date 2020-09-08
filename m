Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31DBC43461
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 08:57:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7D42166E
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 08:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0zTKGovD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7D42166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sp7kFCdFuR2/h2+sTV8p9YS9rgF/dePtdmlagrFEx6c=; b=0zTKGovDCdUwde8lxkTgWvSrb
	rdcsvXR3iN6smtRigYTTijuIxoqSQzKABNEe795a9NYiBiqrORe5l4djUvnU18TdBJm19Wr/XqL6Y
	6QvloEXv6LSPItGDNWLXy9FhIWRXp6jVyoITDTlDxzmbyulY1rjsIdBh1thPE3VLjCbVagbRU+ACS
	PUqvd4EIJft7I6CQu6fZ26RwnxcwKPNFGnk8ZZJwpqU9HPkIkiaRRuUKlw9A7ti86l2r5cV+r9Kb5
	6ROSCHSHyqu+bKScQcF+aP4PChlyr4qO8wemyvQLS/ovL0Z2EM3QsnxsQDaM5KZGZFTbptCL3E3QF
	TlOu/3Bag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFZRd-0003Wu-4r; Tue, 08 Sep 2020 08:57:41 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFZRY-0003VA-Ug
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 08:57:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A77A168AFE; Tue,  8 Sep 2020 10:57:34 +0200 (CEST)
Date: Tue, 8 Sep 2020 10:57:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V2 01/12] nvme-core: annotate nvme_alloc_request()
Message-ID: <20200908085734.GA17982@lst.de>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-2-chaitanya.kulkarni@wdc.com>
 <20200903161729.GA25423@lst.de>
 <BYAPR04MB49658D024946E9510B9C71FD862C0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49658D024946E9510B9C71FD862C0@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_045737_122824_6E6AC5CE 
X-CRM114-Status: GOOD (  17.06  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "logang@deltatee.com" <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 03, 2020 at 07:40:14PM +0000, Chaitanya Kulkarni wrote:
> On 9/3/20 09:17, Christoph Hellwig wrote:
> > Before we start micro-optimzing this stuff I suspect we might want
> > to just split the submit_cmd handlers so that we have a fast path
> > and the rest.  We've grown a few too many arguments by now..
> > 
> 
> Are you referring to any of this :-
> 
> 1. Split nvmet_passthru_execute_cmd() into
>     nvmet_passthru_execute_io_cmd() and
>     nvmet_passthru_execute_admin_cmd() handler just like as bdev-ns and
>     file-ns. (I don't think so that is what you mean).
> 
> OR
> 
> 2. Split the nvme_alloc_request() into nvme_alloc_request_qid_any() and
>     nvme_alloc_request_qid() then call nvme_alloc_request_qid_any() from
>     passthru fast path ? (or variation of the same).
> 
> OR
> 
> Can you please elaborate how you like to have a split ?

I'm not really sure yet, I just noticed that we created a convoluted
mess.  I'll see what I can do.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
