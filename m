Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE72DC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 01:20:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32ED761042
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 01:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32ED761042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jua9nuJlx+Sl4sNEXtyncKrfHxPE0Ro9DT7RfTGS0mU=; b=DIOEl51XEcyhk6j3L5fd6S7xJ
	6NgfzwT+ca64cW0i2NXlDr+0AAWq12UiCyCp6EomJk+ofQsUeQHeziCi1VQMrd26TxYQmScJbA1xq
	JVl+tEDu7pDxtKM7EsdZTB6NrMy1FB8NctEGMI72PKCxrtZj9dnsOwB1ILOFYPHHGFy9q0UcsVaEF
	aidodAE3OJhx/KfeWz94ulQo4KPwcCjQl8JkcSJXg1fpQQA5S1r8qBTct+kouVBsvlKRgWFshYHor
	j1Zioktm0MXW3Pb8c1Qu1lwSnMXZAeCrne8hrYbIscQipYnMFPBVoEIQh7nZuFI/xSR7jxB2oFhEw
	k4bnQWL/g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lapv3-006bTr-KS; Mon, 26 Apr 2021 01:20:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lapuo-006bTU-Dm
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 01:19:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0vq31kXoXdJ37A0m+hl8ciNYW3IbDYlul0jI6X5aa5o=; b=DB22Hc6cB6TpTZ+LK9xISRVFud
 FIKX9ppniT3d2lBGdTrOPnwSuC4DdmDQnoDMdlwvnE7135Q7J6a47VE+PBFmi4CDb6bhThpsJJsNY
 h1ZuL24M3t+UAKUZzRKggottLoPGuV9gwbROFNYX+KlbUB1/c0seDutoQqUztX6D/slB17uAAbcY3
 Yaf8Vp3oI1jtPmCCilLmhr7KwbxK4B3i38skWOFFVRmin7Jum9aDDp6RoRw4OczFcKkznDtAxJf0J
 ZvOVT2mIF2A/85Zr4/KERt5rV7JH6B3RWrSMNrb/fIvRcYnSgv8frYORrtb2Q+gQwREmuaccjwmBd
 Z76jOC2w==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lapul-00FgAu-U5
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 01:19:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619399993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0vq31kXoXdJ37A0m+hl8ciNYW3IbDYlul0jI6X5aa5o=;
 b=ItIj5rVSXRxS/RwGQdx0M/2TnTnwUbsyNx1RTvI6CGyDNp1Sg5RESz3uwvGsy9eRpEcZ0X
 H8/fodajEpTyHY6+B9k/7L33xD6KqTqWepg1Qt60Pwzk55X8vGQT6ZN8aJw73QhM+JOz7G
 LvNsKneWZn+Us9YEugLf256hh/L+CoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-C_6IIY35NuqtfY0jnz3Pbg-1; Sun, 25 Apr 2021 21:19:51 -0400
X-MC-Unique: C_6IIY35NuqtfY0jnz3Pbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46E18343A6;
 Mon, 26 Apr 2021 01:19:49 +0000 (UTC)
Received: from T590 (ovpn-12-48.pek2.redhat.com [10.72.12.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44B4819D7D;
 Mon, 26 Apr 2021 01:19:39 +0000 (UTC)
Date: Mon, 26 Apr 2021 09:19:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH 0/8] blk-mq: fix request UAF related with iterating over
 tagset requests
Message-ID: <YIYVMQmAZgKL2qdP@T590>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
 <YIU2BhuYZAAgonN0@T590>
 <5c1ef3ec-dd6a-4992-586b-6e67bcd1a678@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5c1ef3ec-dd6a-4992-586b-6e67bcd1a678@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_181956_068127_A5B19BED 
X-CRM114-Status: GOOD (  21.04  )
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

On Sun, Apr 25, 2021 at 01:53:16PM -0700, Bart Van Assche wrote:
> On 4/25/21 2:27 AM, Ming Lei wrote:
> > On Sun, Apr 25, 2021 at 04:57:45PM +0800, Ming Lei wrote:
> >> Revert 4 patches from Bart which try to fix request UAF issue related
> >> with iterating over tagset wide requests, because:
> 
> Where were you during the four weeks that my patch series was out for
> review? I haven't seen any feedback from you on my patch series.

To be honest, it is just two days ago I have to take a close look
at your patchset because we may have to backport your patches for
addressing one RH report with high priority.

David is in CC list, and Laurence/David is looking the report too.

> 
> >> 1) request UAF caused by normal completion vs. async completion during
> >> iterating can't be covered[1]
> 
> I do not agree with the above. Patches 5/8 and 6/8 from this series can
> be applied without reverting any of my patches.

The thing is that 5 ~ 8 can fix the issue in a simpler way without
adding extra cost in fast path, and the idea is easier to be proved.

BTW, as a downstream kernel developer, I really hope all fix are simple and
easy to backport. More importantly, I do prefer to approaches in patch which
can be proved/verified easily, so further regression can be avoided.

> 
> > 4) synchronize_rcu() is added before shutting down one request queue,
> > which may slow down reboot/poweroff very much on big systems with lots of
> > HBAs in which lots of LUNs are attached.
> 
> The synchronize_rcu() can be removed by using a semaphore
> (<linux/semaphore.h>) instead of an RCU reader lock inside bt_tags_iter().

I am not sure you can, because some iteration is done in atomic context.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
