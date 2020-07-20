Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1B2C4727C
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 21:43:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F74207FC
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 21:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DxTjSab8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="hR02xQhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F74207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SYj0/fr2b1OL3FZm1mKjBw7z3i97YUDknrG0oX/5HYY=; b=DxTjSab8yPmnNWTBisvnIZ3GW
	tLLgF7JGz+mDHDAMwJuqTCAygUtwW6fbdmu47eBaljR54PRTXv75l1WfxbyCj4A7EzZb561v/nhBP
	s5YIYHerqmKQ04/zPSAfoq1XggjUJt1EX6dqRmGmZllNCqn/0RDaeb06+mByQbgQtPP+wydIkv9vv
	xRhASPrSF1q9dRrkZjqIQn6OoFRcMWk1rG6bT9rGJcoS/PCEBfSsPN5DchOvqdSzagUgxNGnrfdNL
	ME7ia6XTjTAw3aw96elvHBodUjBBm4nU2yaiMR4fniT/cOJebZBi1y+terMxdubZalisLVKSPvp7t
	iWgvVoRWw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxdZ3-0004os-MI; Mon, 20 Jul 2020 21:43:13 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxdXU-0003pr-A8
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 21:41:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EI4HV6io6QvxPNiiP4h3U+USCze8na4pN1lXIYxzsKE=; b=hR02xQhhHkzb0x75CmE926uQPi
 kl8Qui+dyXxqehG+rEIaDSxHS5IkQAoE+3VCIQZM+SJ6igXfHmxalPZozHDne+U6Wb9olrPFi/QTL
 w7nu84wzNw7+EzIxnYSIwatdu20/yhGJYD5R1DiN5L068fm8V1mvO3mbNcSGY76JTd/IC8YN3IC7A
 pu6YaSkr3LvhIORG9nK5gDlVAd6kt2Z/XBXIhiIO3tFsBtEveBTG4RQ4EFidyCm7iKocAsKTBEfnO
 wrWbv7OUVOImZ1Dx38WrbJ0MgJJcRukmDbnbLxlB3q7GYA177bJk5/cso0881QsVNzQOxnfMKrV6U
 AJxIQ3ZA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1jxdXL-0002HX-UZ; Mon, 20 Jul 2020 15:41:28 -0600
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com> <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
Date: Mon, 20 Jul 2020 15:41:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com,
 Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de,
 sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_174136_576587_49878815 
X-CRM114-Status: GOOD (  16.86  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks for the review Christoph. I think I should be able to make all
the requested changes in the next week or two.

On 2020-07-20 1:35 p.m., Sagi Grimberg wrote:
> 
>> I'm still not so happy about having to look up the namespace and still
>> wonder if we should generalize the connect_q to a passthrough_q.  But
>> I guess we can do that later and then reduce some of the exports here..
> 
> That is a neat idea! should be easy to do (and we can then lose the host
> xarray stuff). I don't mind having it on a later patch, but it should be
> easy enough to do even before...
> 

I sort of follow this. I can try to work something up but it will
probably take me a few iterations to get it to where you want it. So,
roughly, we'd create a passthrough_q in core with the controller's IO
tagset and then cleanup the fabrics hosts to use that instead of each
independently creating their connect_q?

Though, I don't understand how this relates to the host xarray stuff
that Sagi mentioned...

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
