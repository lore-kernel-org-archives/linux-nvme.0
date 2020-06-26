Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EEFC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:27:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E165206A1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z/jGTsgE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kg4MfJYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E165206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vzBX45brUvvxQpbklq0Rfs+3OQPHRQBRrRhC38Hsvho=; b=z/jGTsgEVqJgQujPJuNJjGxsW
	PhRvnviMXVTaSO0fz+jmzod05mCnQfGm4tEJ8T0hcQsCNQwWYm3zU4lv+xzOZXEvGpb0E6G/goy+z
	ZH4LXWj1c0rvM4fAHKR0Q5f1cH49i3zrrFD/r4vIcdQ05CdPNKgzzb0HV2jFR+OQ6/qUo7kkBxOXR
	RroXIhlTI/Or4G3wwjG4cSoXstUa99fgkj6SD8b7PT83fv3mrDJAx/DNAVwoW2OPEKAgYymrGh1F8
	VtoAvjKXML0flCRf2UekzNVlGICX0q6szse0ffzK+XFhR427OZeNf1oygrOBHm/pNoKtB3qEAnCaf
	CxIykMq7Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomVj-0002nP-Cw; Fri, 26 Jun 2020 11:27:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolFI-0000z2-0q
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:06:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=XEx37MJDDyxWJOTs9gwq1he9gSMXYzOYVEVaYgwJYw0=; b=kg4MfJYsfza0Tas5Jpfx7RAmLM
 lym2n03hw65YRv6v1n3fQxUSuFnUsecYH5OxwhLBYIOI49e7ysOdr9lxupbaLGb0mWc7riVzbSwNm
 vrTgy6NrHCdhRf/3bw1Uo35Fk5viUnfY8BFz8kpDZW7lKl5c4TH09SDS0nvgxODysCDYZ5dO4LjKk
 unnQ/fPHXlyFG9PspvBzM/9ex+9CvNwLh9S6f+YGXxXmSXClgMW4Ug07rZQ5XmKwFYKjBgbyy8lp4
 cR7PeiTrRByjl/8bj5dhdzGC1NmuOo6922d/GLitjZcudZC11FxTSmWGQYcAz4FEwbQb29St4KXUA
 cQ3Qz9Qg==;
Received: from verein.lst.de ([213.95.11.211])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jokrS-0005WR-T1
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 09:41:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DAC7A68B02; Fri, 26 Jun 2020 10:24:37 +0200 (CEST)
Date: Fri, 26 Jun 2020 10:24:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fix identify error status silent ignore
Message-ID: <20200626082437.GA23888@lst.de>
References: <20200625000257.29981-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200625000257.29981-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_104131_656142_BA4E8077 
X-CRM114-Status: GOOD (  15.14  )
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
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 05:02:57PM -0700, Sagi Grimberg wrote:
> Patch 59c7c3caaaf8 intended to only silently ignore
> non retry-able errors (DNR bit set) such that we can still
> identify misbehaving controllers, and in the other hand
> propagate retry-able errors (DNR bit cleared) so we don't
> wrongly abandon a namespace just because it happens to be
> temporarily inaccessible.
> 
> The goal remains the same as the original commit where this
> was introduced but unfortunately had the logic backwards.

This probably also needs to be added to the comment to explain WTF is
going on here..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
