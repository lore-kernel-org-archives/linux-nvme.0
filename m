Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF91C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:57:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 871A920708
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lWyiInmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871A920708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dw4QDO/HELL5co48yjQ3x40FiH0OrjDJZE4BNUA//zU=; b=lWyiInmfZXily0n1PX+nsgCVX
	3qzHXDu4ne3eEtrZWa849jmtNW/C18nrrP5Bet//1z0iJi6TcNmnm6vc9bUSMjwQ0G9nXznkVjA+y
	2gtjnZvUUkbnqQbHUGickS9MP0n36V6I41L5uKkNJewMUbL3jNHjLaZlHuZ7tYSlTpkSPgNPi87xG
	FnsZCWm8UG7DX61k9/CzXHl0WlcRKk05d7q1Lohr8dFxM/bC9+dQg06DuQkOz+IlCKDgH75oBUmJk
	4rwRv2ygJYKSVIb3QaTX5AC7sE6evHrXW3ZCgQDnlAnPe1yYWZXjAYyB8iqYJFitrLxpHENkBMA2C
	aM/Wt4NdA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6TeP-00077f-IH; Fri, 14 Aug 2020 06:57:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6TeM-000772-7Z
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 06:57:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E4E5068CEE; Fri, 14 Aug 2020 08:57:11 +0200 (CEST)
Date: Fri, 14 Aug 2020 08:57:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATVH V5] nvme-core: use xarray for ctrl ns tracking
Message-ID: <20200814065711.GA2070@lst.de>
References: <20200814021612.5161-1-chaitanya.kulkarni@wdc.com>
 <4654370f-40b9-1b35-1e22-864e762c3001@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4654370f-40b9-1b35-1e22-864e762c3001@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_025714_440400_DF02FAAD 
X-CRM114-Status: GOOD (  15.36  )
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
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 13, 2020 at 11:33:41PM -0700, Sagi Grimberg wrote:
>
>> This patch replaces the ctrl->namespaces tracking from linked list to
>> xarray for better ns-mgmt on the host side. For host side
>> nvme_find_get_ns() falls into the fast path for NVMeOF passthru target.
>> This allows us to have better performance for NVMeOF passthru backend
>> since XArray has shows better performance numbers over having
>> a combination of read-write semapore read + linked list in the
>> nvme_find_get_ns() to find namespace in I/O patch from nsid specified
>> in the nvme_rw_cmd.
>
> This patch scares me to be honest...
>
> We have such non-trivial synchronization paths for ns scanning, ns
> removal, quiescing, freezing, path handling... I'm not even sure
> how many tests we'll need to verify that nothing breaks here.

Yes, same concern here.  That being said I have plans for this or
next merge window to fix a lot of crap in the block layer about
the bdev mutex to update the size, which should lead to major
simpliciations of the nvme ns scanning/removal path.  But I'd much
rather sort that our first rather than touching this code now.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
