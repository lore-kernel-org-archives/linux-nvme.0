Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEB4C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 01:27:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 933E1613AB
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 01:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933E1613AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7b80gAkWCZKo9QtwkBqsnKNz4P45Z34iaD0jVzEUi84=; b=LIKWRPdKByqakw
	wvlCnbiUjmQPfjrfF8xDOeUwgxAnNOxyvv/X8J4zjk1SuAOd3IxZD3HQ27CSJ6goEqpZ1xh8IQp+Q
	RqLt+FzedSDz7lTIuWFAeJ6U4vCDv3NZzTQBjTeE9ipNdOIHuEXR7U7ZjqNRzrqfsWE5JHOEinbjt
	jElRLdAHhALQnxD+6WUkK/+uT7V6osUKL2xo3RbX65iCGiwCtYs0vL7kS+Pt/IZAivrnwdIo0E6Od
	mlBrDCYnyLKXnqRhlJnSjWTk/EeAlrQAus5OdhuNF7UwOvYmHqgwBWJc6G3FRbf9E16bkUI4i2Ohd
	/7/FXWAqSDgloHcdEujQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYfA1-00AvkT-Jm; Tue, 20 Apr 2021 01:26:41 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYf9y-00AvkD-Oe
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 01:26:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Reply-To:Sender:Content-ID:Content-Description;
 bh=Pb8klgKs61TRFSlppBqJaYi3u4BGt6rIhr4kJOS/kXs=; b=vU5i+yLIrkV/1oJ7wBPYZ7wToq
 vcv0efGq3Cx2J0nBKf3M7+fR/mgCsH8vrapy6bYaQQ0Hcr0DXLu8LLhDZvzyedPqMOsw7PHWZX/iz
 FTbFZ6N+wVbJt9BrV6pkM+m63wMQghootqceP9IlvncCTVv1fQ08bt35sqJprGjIVFPI8smjM52E2
 yl3dvoF8pPt9HA2toibsFAbfNbojBVsZLtbO846dcmF3WuTfLe70uxI4YX4O2qPssQO0k/6HgHEwb
 MbGAlYFZnm8XCpyHHuS+f1ihELmDeAORI0BvTvkd46ZmDBes/czzuz1ln9Cmd4UqlHJv0x0Kw6Ph4
 TC6ZEI/g==;
Received: from mail-1.ca.inter.net ([208.85.220.69])
 by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lYf9u-00Bkyt-KE
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 01:26:37 +0000
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
 by mail-1.ca.inter.net (Postfix) with ESMTP id 477922EA15D;
 Mon, 19 Apr 2021 21:20:42 -0400 (EDT)
Received: from mail-1.ca.inter.net ([208.85.220.69])
 by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
 with ESMTP id 1qZYRuf+pZPQ; Mon, 19 Apr 2021 21:01:03 -0400 (EDT)
Received: from [192.168.48.23] (host-45-58-219-4.dyn.295.ca [45.58.219.4])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: dgilbert@interlog.com)
 by mail-1.ca.inter.net (Postfix) with ESMTPSA id 9818B2EA124;
 Mon, 19 Apr 2021 21:20:41 -0400 (EDT)
Subject: Re: [PATCH v2 3/3] zonefs: fix synchronous write to sequential zone
 files
To: Christoph Hellwig <hch@lst.de>, Damien Le Moal <damien.lemoal@wdc.com>
Cc: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
 <20210417023323.852530-4-damien.lemoal@wdc.com>
 <20210419064529.GA19041@lst.de>
From: Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <9a4d5090-1a70-129a-72f7-3699db0038a1@interlog.com>
Date: Mon, 19 Apr 2021 21:20:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210419064529.GA19041@lst.de>
Content-Language: en-CA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_182634_757206_E9EB63CF 
X-CRM114-Status: GOOD (  11.87  )
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
Reply-To: dgilbert@interlog.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021-04-19 2:45 a.m., Christoph Hellwig wrote:
> On Sat, Apr 17, 2021 at 11:33:23AM +0900, Damien Le Moal wrote:
>> Synchronous writes to sequential zone files cannot use zone append
>> operations if the underlying zoned device queue limit
>> max_zone_append_sectors is 0, indicating that the device does not
>> support this operation. In this case, fall back to using regular write
>> operations.
> 
> Zone append is a mandatory feature of the zoned device API.

So a hack required for ZNS and not needed by ZBC and ZAC becomes
a "mandatory feature" in a Linux API. Like many hacks, that one might
come back to bite you :-)

Doug Gilbert


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
