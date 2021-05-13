Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9B4C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 14:16:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DE36142C
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 14:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DE36142C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hgWnMj2B2a1caLK/9m3+yXdZ48h1igUhSAx03PXzuf4=; b=L3gx6LIUmTre29YbgIQ9YjTC3
	brqsNEXURHZWGs96We+yivOI7ycToinv2N6RXIV10ygvL3Y4UJSkdywNiHBSPpWCL/yYK7uGe37Pc
	9XNIBiTtfjgJUMEu90bi+NDAenBal9ySzoCTJex/1D+7slf5AZXnDjP3w2TNeFUCMaf0CszOTRlAW
	i0yn1jXAJmIGLf6WmK8gQxRBzqNBVpC4+IYgapQOBASn+xSNPXrd/MBN95OcKV3U0abGT/tRhxzbw
	RD8ubXwc+TYNarnYnj2fLfIvOa28bqwIptv23AmobGHUPG/3ZHFne85IAVWWf3k4AJIEJZnkBAhth
	9/1o09xgg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhC7w-005iFP-Gm; Thu, 13 May 2021 14:15:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhC7v-005iFC-89
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 14:15:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=5BSgGVw6nC9siicJYeN46fbSLDImjpRgoJK+rUd04VM=; b=OFXpD4vfi5cR/+44NSlKzBDzcz
 goXEz7GIpD5hIHckgXHAUpedKLlTyw6kzUWCzU4d89IOUjJiBxquSjLgTqXVSvHEO3Ap1qeoECS59
 oy4y03Rn2PcyprfDQTVtbm0h/ircDthRzGHFeXe9le74CbveHmWw75D+7pbrxTz+QpG03zbV+k28B
 DaEZ1lrv8k13OzqV+drRhCXFA3ZcQrjINUGOw2V9llP4MzsZ4TAPqkoWXuECHVfGiW1ufeNj0b9dF
 hDL+Y1c2fl0T9X+qFAQBCaozp/elIdRqXauTCFpiOw+JfHgFmkYnJx0LAaAWO9qJKySoH3JdgZsnT
 2yX0BEsg==;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhC7r-00BJB6-Sc
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 14:15:45 +0000
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net
 [72.74.133.215]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 14DEFVOa009307
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 May 2021 10:15:32 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id 9B67515C3B1D; Thu, 13 May 2021 10:15:31 -0400 (EDT)
Date: Thu, 13 May 2021 10:15:31 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Changheun Lee <nanich.lee@samsung.com>
Cc: alex_y_xu@yahoo.ca, axboe@kernel.dk, bgoncalv@redhat.com,
 bvanassche@acm.org, dm-crypt@saout.de, hch@lst.de, jaegeuk@kernel.org,
 linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 ming.lei@redhat.com, yi.zhang@redhat.com
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
Message-ID: <YJ00g8oBZkduQXIe@mit.edu>
References: <CGME20210513100034epcas1p4b23892cd77bde73c777eea6dc51c16a4@epcas1p4.samsung.com>
 <20210513094222.17635-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210513094222.17635-1-nanich.lee@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_071544_130659_25E24DFA 
X-CRM114-Status: GOOD (  13.15  )
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

On Thu, May 13, 2021 at 06:42:22PM +0900, Changheun Lee wrote:
> 
> Problem might be casued by exhausting of memory. And memory exhausting
> would be caused by setting of small bio_max_size. Actually it was not
> reproduced in my VM environment at first. But, I reproduced same problem
> when bio_max_size is set with 8KB forced. Too many bio allocation would
> be occurred by setting of 8KB bio_max_size.

Hmm... I'm not sure how to align your diagnosis with the symptoms in
the bug report.  If we were limited by memory, that should slow down
the I/O, but we should still be making forward progress, no?  And a
forced reboot should not result in data corruption, unless maybe there
was a missing check for a failed memory allocation, causing data to be
written to the wrong location, a missing error check leading to the
block or file system layer not noticing that a write had failed
(although again, memory exhaustion should not lead to failed writes;
it might slow us down, sure, but if writes are being failed, something
is Badly Going Wrong --- things like writes to the swap device or
writes by the page cleaner must succeed, or else Things Would Go Bad
In A Hurry).

						- Ted

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
