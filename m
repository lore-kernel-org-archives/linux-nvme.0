Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065E7C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 09:51:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9B660FF2
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 09:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9B660FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3+f7R6qje10eYBTwuDYPPW+uJRyzZ0/u7J0Ln9wKtog=; b=h9DSjzTXHyqOqv4RREGlm2+oP
	/BSuVQrdJhpuKkxvFGo38qzMXMcW2J6bZAAyPW6/uxeDyy2Wm3sunOD8I9wr2rbHeJhxKN6mgHlAW
	9caRa2g5YK3bLrgMHBdp8hBGFEyP4gKsnE9V+FC9OD2/nwt0ZISY/jkQyuJln35VRVOL533HZvluK
	NApjd1N4dp/AxXUsFVKqdYY/0iE/1f2EuFulsLouRK1LlqXXCFIwv80IK9fsrLEa4Ng+8D6tW9+Ms
	mdmz3c+S1XPXOEk6ACG5cfXFAGCc8pUNZvviPX2Dm/AH5ArmeN/JLI+8xGxf6/0mu+IaPlJiuGc46
	+BIo5QlDQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhUTI-007gkg-NW; Fri, 14 May 2021 09:51:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhUTG-007gkJ-PR
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 09:51:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0v2WTfoTYYFvI5g3TxNROF/jrQek1EySSdju9KXEFoA=; b=0xAc8a/gyYXtYu8q1Oce248dLa
 dR6w7rl9Xu/zXynN5lm+wDNWH2cINcvobmejwiZ7A9DqtAXTFM/KRxV4mYvT2EV1u1SOKV8PgYbXc
 cPQDOw2Yk6fhXeDc/CR657uAhvVGs71oYEx8xXOwtl9kJjmC02IT4t6tlk1tHdMjjHkLzo04lel4l
 L46kKiKqSwZdfMyV+VFJqutpKmWxb0y1y6/JXrqdMVoC1pigJn4IFv4YfXP1AEPLCwY2VUR3y5sSm
 xz1EiNlPd7/T/Aqqo0lSRTjV3Sc0ZsJ8J8sEtAdU4vV4xg4m9xusINEK+s9hGGe5ox8oRb8GHyRB0
 xtaGLHfw==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhUTE-00BsKm-5k
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 09:51:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620985858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0v2WTfoTYYFvI5g3TxNROF/jrQek1EySSdju9KXEFoA=;
 b=PG6dlv+kcGF4BYU8kCgNxFC/2VLAWWk9jiKXDFgiGHIYZkZcr2b16biC02wSKHQQbQ5kea
 rSsgxnNh9EagftB/KRZE8DACjhRGdbc9NXqetcgJ4C2RG2+dr/9R82cdw4NruUlyEZs2Ow
 M0sNqoBQqth03LeFJPSEe/kvfwSy7n8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-i_GH1KlpNd-xW5uWh3gvOQ-1; Fri, 14 May 2021 05:50:57 -0400
X-MC-Unique: i_GH1KlpNd-xW5uWh3gvOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC9C38042A9;
 Fri, 14 May 2021 09:50:54 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com
 (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2C986788A;
 Fri, 14 May 2021 09:50:41 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id
 14E9of0U023228; Fri, 14 May 2021 05:50:41 -0400
Received: from localhost (mpatocka@localhost)
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP
 id 14E9oebu023224; Fri, 14 May 2021 05:50:40 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka
 owned process doing -bs
Date: Fri, 14 May 2021 05:50:40 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Milan Broz <gmazyland@gmail.com>, Bart Van Assche <bvanassche@acm.org>,
 "Theodore Ts'o" <tytso@mit.edu>, Changheun Lee <nanich.lee@samsung.com>
cc: alex_y_xu@yahoo.ca, axboe@kernel.dk, bgoncalv@redhat.com,
 dm-crypt@saout.de, hch@lst.de, jaegeuk@kernel.org,
 linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 ming.lei@redhat.com, yi.zhang@redhat.com, dm-devel@redhat.com
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
In-Reply-To: <alpine.LRH.2.02.2105131510330.21927@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2105140544010.22439@file01.intranet.prod.int.rdu2.redhat.com>
References: <a01ab479-69e8-9395-7d24-9de1eec28aff@acm.org>
 <0e7b0b6e-e78c-f22d-af8d-d7bdcb597bea@gmail.com>
 <alpine.LRH.2.02.2105131510330.21927@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_025100_357630_F0537294 
X-CRM114-Status: GOOD (  23.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 5/13/21 7:15 AM, Theodore Ts'o wrote:
> On Thu, May 13, 2021 at 06:42:22PM +0900, Changheun Lee wrote:
>>
>> Problem might be casued by exhausting of memory. And memory exhausting
>> would be caused by setting of small bio_max_size. Actually it was not
>> reproduced in my VM environment at first. But, I reproduced same problem
>> when bio_max_size is set with 8KB forced. Too many bio allocation would
>> be occurred by setting of 8KB bio_max_size.
> 
> Hmm... I'm not sure how to align your diagnosis with the symptoms in
> the bug report.  If we were limited by memory, that should slow down
> the I/O, but we should still be making forward progress, no?  And a
> forced reboot should not result in data corruption, unless maybe there

If you use data=writeback, data writes and journal writes are not 
synchronized. So, it may be possible that a journal write made it through, 
a data write didn't - the end result would be a file containing random 
contents that was on the disk.

Changheun - do you use data=writeback? Did the corruption happen only in 
newly created files? Or did it corrupt existing files?

> was a missing check for a failed memory allocation, causing data to be
> written to the wrong location, a missing error check leading to the
> block or file system layer not noticing that a write had failed
> (although again, memory exhaustion should not lead to failed writes;
> it might slow us down, sure, but if writes are being failed, something
> is Badly Going Wrong --- things like writes to the swap device or
> writes by the page cleaner must succeed, or else Things Would Go Bad
> In A Hurry).

Mikulas


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
