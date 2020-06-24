Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151CBC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:57:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58042072E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GZI5qb5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58042072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=suz0xIwxiTiw6bufJ15SgZEqqd27zJFsGTMppHb5/VA=; b=GZI5qb5vef3niB80gJQT1hEEt
	zfdubdRWbs9hWWHWZwsCk8cEYeJbHA9P4IU2ToNaHDI/cchfjdHJCdhvHXazmmYFdI4bBFE7EuHuD
	m6jyD6zJOuZogmCCNJOZ8ACdJXULLYlS70kUHNPEQkKnlEdrY+E84d07DKoXgwUn/eJs5ePYwCNqp
	rZ8gzi0TfiDR1WK8WqxzpUcZXnc/DbAA+AfvIifZCME6S/RB5AdDXJ1EbGhjb3zNCEgRHKKXXcBr4
	iiWbvvIq/BgNn/zMTQjeB1NKl4mIYlZS+4whEP2BJumbud+qCQsnpcj8D/sIBP8QUKLrcX0VjFhqU
	bbSGBmVIA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnzM0-0001uw-2G; Wed, 24 Jun 2020 06:57:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnzLw-0001st-3P
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 06:57:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8EC3C68AEF; Wed, 24 Jun 2020 08:57:45 +0200 (CEST)
Date: Wed, 24 Jun 2020 08:57:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 for-5.8-rc 1/6] nvme: fix possible deadlock when I/O
 is blocked
Message-ID: <20200624065745.GA18207@lst.de>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-2-sagi@grimberg.me> <20200624062902.GA17594@lst.de>
 <84583b2e-d59b-01bc-1737-5db107999d84@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <84583b2e-d59b-01bc-1737-5db107999d84@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 11:54:31PM -0700, Sagi Grimberg wrote:
>
>>> Revert fab7772bfbcf ("nvme-multipath: revalidate nvme_ns_head gendisk
>>> in nvme_validate_ns")
>>>
>>> When adding a new namespace to the head disk (via nvme_mpath_set_live)
>>> we will see partition scan which triggers I/O on the mpath device node.
>>> This process will usually be triggered from the scan_work which holds
>>> the scan_lock. If I/O blocks (if we got ana change currently have only
>>> available paths but none are accessible) this can deadlock on the head
>>> disk bd_mutex as both partition scan I/O takes it, and head disk revalidation
>>> takes it to check for resize (also triggered from scan_work on a different
>>> path). See trace [1].
>>>
>>> This is no longer needed since commit cb224c3af4df ("nvme: Convert to
>>> use set_capacity_revalidate_and_notify") which already updates resize
>>> info without unnecessarily revalidating the disk.
>>
>> Did you look if any other revalidation gets skipped this way? E.g.
>> LBA size change?
>>
>>  From purely the size POV this looks good, though.
>
> The only reason the revalidate was added was to update on a size change,
> which is redundant.
>
> And if you look at revalidate, it only calls fops->revalidate_disk
> (which is a noop in the mpath device) and checks the size change.

Please add this blurb to the changelog for the next version.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
