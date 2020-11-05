Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42513C00A89
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 07:29:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE0520780
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 07:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G7PINwJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE0520780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lUrambStYyDUwiTjQbc4qIMTFqaYdPiymSNB3NSo1PU=; b=G7PINwJ78yYmzh2TR3UTeVRNY
	LJ2x3LlQon1Wv7/zLw5nuEefmYCjAT7ClunI3av6IkKCE1tUIvt4I87qYcjywKwpM2G3ZC599+GCJ
	3/n7Upyr7OPJlLAs6tX4g7QTOm6NoUziqC25Q4Sc58jUsoJxv542RSSDY/O279NGQRreeM06pOXMR
	kuSqKuX4GLlY5aY1JMtZTHDUOF6wzMeJestadxiHWDdsYqSF+zQzFAEpaayLKSXHhpRgMPE3H6s3C
	ZMOcN/hsa7tGctPfCJFWf8FJ7yuc37soBzDO6cqq1AxPGCQVr3XCHaEuGsO1ptExj0doLQXHUQRJD
	rhpiIjwog==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaZhh-0003ET-Fb; Thu, 05 Nov 2020 07:29:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaZhf-0003D6-7B
 for linux-nvme@lists.infradead.org; Thu, 05 Nov 2020 07:29:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B9DD568B05; Thu,  5 Nov 2020 08:28:56 +0100 (CET)
Date: Thu, 5 Nov 2020 08:28:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V6 5/5] nvme: centralize setting req end_io_data
Message-ID: <20201105072856.GA4540@lst.de>
References: <20201104203736.62745-1-chaitanya.kulkarni@wdc.com>
 <20201104203736.62745-6-chaitanya.kulkarni@wdc.com>
 <66b805e8-9efe-8f47-b10a-1a8dd6505720@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <66b805e8-9efe-8f47-b10a-1a8dd6505720@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201105_022903_398201_6BD91344 
X-CRM114-Status: GOOD (  13.49  )
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
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 04, 2020 at 02:17:05PM -0800, Sagi Grimberg wrote:
>> The host side code allocates the request in several places using
>> nvme_alloc_request() and initialises the allocated request->end_io_data,
>> which repeats the code and will have duplicate code in the future.
>>
>> Add an end_io_data request parameter which initializes the block
>> layer request in nvme_alloc_request(), update the respective callers
>> and remove the duplicate code.
>
> There are less callers that actually put something there so not sure
> if this is an improvement.. The alloc signature is getting kinda bloated
> now...

Yes, I don't really see the point - the request is available to the
caller, so they can trivially assign it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
