Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B17C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 04:40:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB84064F24
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 04:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB84064F24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dwlM+l7TaxbBvVmcljvggHB5bSUZhyKzKv/fdCKqRoQ=; b=essHcO1P4vtCK6kVp6lYw/VrG
	rny/ysgZgjEu9oQe9mqRMQffnwf4YE0eZTD7HkvMTIlvkuVf0VE62fJajFBO7/oP/HuhkFshzAw2X
	hY9xcsUakT3/hjViNyuO+ex7APNnzM20LXsTtLM/KpQNHMZzpTfrA7b5v2MDYXchar6gUrsdsWcLr
	G4lvlBAFjfpXuAuYYCmfUvasY6TCB+yLrTK8e4fPEQw8hwRtbVdS1wlgfwaJ+b4+xukxlVoQ5ouFE
	kEJ3q3hUCNS90ZqKga0b4etl3EVs+4XHY++xNnUqrKwEDYFsXHiSf5RTkxIq4karrGWaBggSV2/+2
	wIeId4G9A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMkS0-004Q6l-Vj; Thu, 18 Mar 2021 04:40:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMkQY-004Pwj-Ck
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 04:38:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F387368C65; Thu, 18 Mar 2021 05:38:28 +0100 (CET)
Date: Thu, 18 Mar 2021 05:38:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Message-ID: <20210318043828.GB26988@lst.de>
References: <20210317204615.13971-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210317204615.13971-1-alan.adamson@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_043838_294827_EB4FA7E6 
X-CRM114-Status: GOOD (  12.45  )
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

On Wed, Mar 17, 2021 at 04:46:14PM -0400, Alan Adamson wrote:
> This patch exports the NVMe Controller CSTS register via sysfs.  This
> feature can be used by userland executables that accessed CSTS and
> possibly other registers by mapping them into user space.  Since this ability
> may not always available, exporting certain registers via sysfs provides
> a safe/read-only way to access registers from outside the kernel.

So what is this application doings with it?  Should we just have a
ready attribute instead of exporting a raw register encoding?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
