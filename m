Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1911AC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 07:03:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD6C64E70
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 07:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD6C64E70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=596/c3WLV/PJdDWGlghI+pV3LUN3yoznbCFMFfVzs0s=; b=YaSt3peamylMYSHEA9OmTJbNy
	gWozDCEdAvqociys7WD9kAJTJHQh0hs+4fQffc89vDmIxgLMiedRmt6icitLiKAJShyJMJqPam/0R
	g1j85iCwlHcznOPRfnj8d/56hMArTiG70xxh9hTbwafPtWUD61UBya5B+cI+RRocCwdXJ+C+heRc7
	EtHs3+tnYp33+/lHB0BAxTR9DDS7P/HliVvKssnGD/5aRGzpEnY4zIJGfICeJr2pBG98m4lbwE2cQ
	DOmQcPvFp/tXODIBIlUfqtVv9TuNHSpfaAujtmRnY0H5NsLRJEvSs6F2/oL6t/Csl/kN1tH/A/vbG
	AZgGhVP8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lA60B-0002UH-7y; Thu, 11 Feb 2021 07:02:59 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lA607-0002Tq-W7
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 07:02:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C094C68B02; Thu, 11 Feb 2021 08:02:50 +0100 (CET)
Date: Thu, 11 Feb 2021 08:02:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme: don't set iosqes,iocqes for discovery
 controllers
Message-ID: <20210211070250.GA13708@lst.de>
References: <20210209101235.1539917-1-sagi@grimberg.me>
 <20210209101235.1539917-2-sagi@grimberg.me> <20210210101126.GA26624@lst.de>
 <3702938a-cfd5-b725-bb75-7c9072a42fde@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3702938a-cfd5-b725-bb75-7c9072a42fde@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_020256_168453_E0D23510 
X-CRM114-Status: GOOD (  10.68  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Martin.Belanger@dell.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 10, 2021 at 02:37:09PM -0800, Sagi Grimberg wrote:
>> So if we change this we break interaction with all old Linux (and maybe
>> other?) targets.
>
> Well yes.. Do you think that we should do a retry in case it fails for
> backward compatibility?

I think we have to.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
