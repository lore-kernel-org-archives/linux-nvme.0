Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601B7C4346E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 06:14:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F22235FD
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 06:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bz8ziJ8u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HufeTw01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F22235FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Jr/Ux2clp9VDiZabTOonsUs5C3Ljway7Q7lJ5mNenjY=; b=Bz8ziJ8u+To0jDLNZQl04beKQ
	pKiUEULZLN98ZUQYcMvKIvQzNvyoK91ZAEtdaxCN3jBZxqrAoAtJq+MeR966Wdt5OwkTwBL9JCmFk
	zGygDANXuN3FMMwvdyRrb3LcwO6VH6vTVUyWEXjFcOqoAqykQH6mIWOuqwEFRR3h/Ocu5krfN+kHU
	0IOg394YCcz/m0QokDE2lF1dbiJ3WJTusOD6w9tdfkMGA60xCDHd4I9+R2t7OPNVZpZTd8LyUyTW4
	GaTav9cxneCtZMqTDlWaBcVLA596SA6C9V3qNmKolVBzlAnzYAHH22mXKXcghPFyAtipXhxCkBvyM
	65DoSK6Mg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLKWV-0000D0-LV; Thu, 24 Sep 2020 06:14:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLKWU-0000Cj-0A
 for linux-nvme@merlin.infradead.org; Thu, 24 Sep 2020 06:14:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=D+TOu2srt5VOVE0VxWi+f0Vl3mBQx4wUeJiEQxkwvxw=; b=HufeTw01uTMt//ilJGlEvZDYPz
 +0jUm+R0fsPKg6k7emokrrm15FYZPWnQlxAygahjGQXRjlqPgOw+0+pAnMjPYkL+tfzHhIYFy6jdA
 X+8hSCF+u/C1FgnbaE9h0QZV+YiAz+2L1odokpm2hM51UnsBc54JkD7tcdPbEmDmMxEq9bQrCyTIc
 0T/CwroD45kEoPTRJar72uxw5AYieIY2dJko3tKLKIP7NMTbcpTLRRdAi9zhzpE5JPTMb2zWnBpZ7
 1V8r9Cz+QbQDueoF6W+YXA+fdc5wCKyW+FhjtQVju23nNKadvygeVbKi8BiQNZ93XLAcNcF6JjmPc
 wznD87bg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kLKWS-00077q-Oj; Thu, 24 Sep 2020 06:14:28 +0000
Date: Thu, 24 Sep 2020 07:14:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Meng Wang <meng@hcdatainc.com>
Subject: Re: kernel panics when hot removing U.2 nvme disk
Message-ID: <20200924061428.GA27289@infradead.org>
References: <BYAPR10MB24561C62C45813B7092E346BCB3F0@BYAPR10MB2456.namprd10.prod.outlook.com>
 <20200919014401.GE4030837@dhcp-10-100-145-180.wdl.wdc.com>
 <20200924051230.GA16433@infradead.org>
 <BYAPR10MB245671198E40D4F44B2365C1CB390@BYAPR10MB2456.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR10MB245671198E40D4F44B2365C1CB390@BYAPR10MB2456.namprd10.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 24, 2020 at 05:47:12AM +0000, Meng Wang wrote:
> Thanks for the info. Is it a problem solely for ext4 + nvme combination? If we change file system or use SATA drive, will the problem get workaround?

This will be called for all removals.  I think the root cause probably
is in ext4 where the evict_inode method doesn't properly deal with
non available storage.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
