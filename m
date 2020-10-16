Return-Path: <SRS0=oO1v=DX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114FEC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 16:49:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 689B320848
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 16:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TFmfnFqy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="SXFP0mWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689B320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1yppyNHhtm99CH3byRu9fqgw7kyu6GV/nOm63u8MyWQ=; b=TFmfnFqyCqaZe/6ljaXuyFEgV
	RvoxvQvC+2kq87/RRaahsrk6I8btBMjTyKW36v90lrqHF2ALKBhhc4QP5WP/JHS/exCxvadZwa4WO
	DMQzIoJQ8YdfEqTrQMsdc24DJpjMTOew+TdTzIsU4/mRT9c2UsFeuBTcgvdol2BjoaxGx+U8TKw0S
	l/drzdiEBz8OwsICtYb3GkdaccpTgtouZvmgI0x9SaU+2ABmyWaqqm5b9M9FBbK2+/T7Y+Hw8IsVN
	SEqyWTn34YdlIgqiK/Uq/ZKIrx0GXXYVJucE7axA9nGscsSgDPG7Eahch17dMDc5zXo7oP0DTDgKc
	L7BWeBgiA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTSuq-00011u-0l; Fri, 16 Oct 2020 16:49:16 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTSun-00011J-7H
 for linux-nvme@lists.infradead.org; Fri, 16 Oct 2020 16:49:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XFzSkfvySXjVdpFoMLyY3vCrSenRd6CUS5ZEi6TqYCU=; b=SXFP0mWpoigqtv8OnpcDHU08+M
 PQWn2DyjNKUSnxg314rITG6d6L3vMxVjy40uepWqzBmCS40BF2IeZZ9phB0lfE9PgcyDjQ/hRHK+n
 K/bN14rfzlLAZnM0bWKPYiEXdoFPtWyWLJ6zDvbb2S9GE8HFRxLr0JyKXbdpRxgrGQFTwzZ8gCZuJ
 g4c4tt076yrdfrrxHhnKKRAuFms8IY/hkN5Gg5Jwm8EZponELWYpm9r87itbOh1EX20P6BDbONNk9
 qO1juGNesozj9F4gqhTmJmElo5S8tXdd7OdovsztJSg5CSzYfu5n1ihbj8QkqJuEKnWhZ7e6kFnYV
 EL4xQ8gQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kTSuh-0000Xj-Gw; Fri, 16 Oct 2020 10:49:08 -0600
To: Christoph Hellwig <hch@lst.de>
References: <20201009231816.1524-1-logang@deltatee.com>
 <20201015075640.GJ14082@lst.de>
 <bc51aadc-eee3-cf52-0623-b3f82e1958f4@deltatee.com>
 <20201015180148.GA23377@lst.de>
 <b798e7f6-0afc-551c-f6d9-f7900b400137@deltatee.com>
 <20201016135759.GA4685@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9cb1b799-63a4-a597-896a-72cd5589d99c@deltatee.com>
Date: Fri, 16 Oct 2020 10:49:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201016135759.GA4685@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: chaitanya.kulkarni@wdc.com, sagi@grimberg.me,
 dgilbert@interlog.com, linux-nvme@lists.infradead.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] nvmet-passthru: Cleanup nvmet_passthru_map_sg()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201016_124913_323545_BAE1895E 
X-CRM114-Status: GOOD (  13.29  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Douglas Gilbert <dgilbert@interlog.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-10-16 7:57 a.m., Christoph Hellwig wrote:
> On Thu, Oct 15, 2020 at 12:40:52PM -0600, Logan Gunthorpe wrote:
> blk_rq_map_sg maps the bio chain.  Take a look at the for_each_bio
> loop in __blk_bios_map_sg.

Ah, yes, ok... I originally had a loop that created a chain of bios but
used bio_add_page() instead of bio_add_pc_page(). This was combined with
a separate check for max_segments and max_hw_sectors. When I switched to
bio_add_pc_page() to drop the separate check, it no longer made sense to
do the chain because there was no way to tell if bio_add_pc_page()
failed because of bio_full() or because it exceeded
max_segments/hw_sectors. If the bio was full, we'd want to create the
chain, but if it exceeded the maximums we'd want to error out...

>> If you want me to send a patch to future proof the MDTS limit with
>> BIO_MAX_PAGES, I can do that, but it doesn't look like it will have any
>> effect right now unless big things change.
> 
> Yes, please do.

Will do.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
