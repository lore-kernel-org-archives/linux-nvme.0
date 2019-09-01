Return-Path: <SRS0=oU3s=W4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1011FC3A5A4
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Sep 2019 15:11:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3652339D
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Sep 2019 15:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JpkHobeN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqM7exBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3652339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=irCv5ELh05lDPgdZek2VQ02VSacpY3UqLIpxt9PIopE=; b=JpkHobeN4k5Pg4
	a/FWwX5CwaBGP+e8RmFMo96TCTTsQ9g2dpd+fIo93z2kQJ4pU4UAGUiv28IkNMEskDNKKZ9IPZfvQ
	gdeq1UvzKwsEGyY8RsRxdrEd5b8tcymyC+4/KF8Rco5+sjeh9bru4LYa7yGxIStbUfgLd2Y5mf+J7
	vZftvKol/1Qp8bgwakdd/8bYM1YYtry5bFx4KMzeQ5N5AgNW+p63LnVuIltiaj0OXIqui4haFoPFC
	Vcl0TzNaZ53LpeML+r82a0l35JdGKDeQY+k2zVFEc62DMvZdnZEeXciEOSyD3bAOzRXGVCDKoD/Z9
	yjMVuMlsgfENYdgUmUDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i4RVd-0004fa-OI; Sun, 01 Sep 2019 15:11:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i4RVa-0004f9-FO
 for linux-nvme@lists.infradead.org; Sun, 01 Sep 2019 15:11:15 +0000
Received: from keith-busch (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF2BE2339D;
 Sun,  1 Sep 2019 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1567350673;
 bh=Z8sw3tgY7baK8L+iD4h9oHAmm49CXzTyqfWJlt83eNQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kqM7exBraOp5iaUAN++hPDm/2dtfP5jNbq4TeEl9pqe3ShAXIioeCOMaHdnFtvpMO
 FPTwWb9//7KVFwY5+DPcXtBQzyiCvyB0iFLKBX+TbbM71AasSGtIKKswWSzEJI3mwt
 bP5iv/bZKChvGMdxjRz9/FeZ2II34cZ7+Dgsruos=
Date: Sun, 1 Sep 2019 09:11:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 0/5 V5] nvme: Add type of service (TOS) configuration
Message-ID: <20190901151109.GA2515@keith-busch>
References: <1566119335-15058-1-git-send-email-israelr@mellanox.com>
 <054fa45e-a2ee-d291-4c71-75f7a1872f9a@grimberg.me>
 <43fd7638-a5da-1ca1-0a3a-e86c3e287f4e@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <43fd7638-a5da-1ca1-0a3a-e86c3e287f4e@mellanox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190901_081114_542695_98EFC7A9 
X-CRM114-Status: GOOD (  10.47  )
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
Cc: Keith Busch <keith.busch@intel.com>, Israel Rukshin <israelr@mellanox.com>,
 Sagi Grimberg <sagi@grimberg.me>, Linux-nvme <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Sep 01, 2019 at 02:18:51PM +0300, Max Gurtovoy wrote:
> 
> On 8/19/2019 9:49 PM, Sagi Grimberg wrote:
> > Applied to nvme-5.4
> > 
> > Keith, I think its safe to take nvme-cli patch as well.
> 
> Keith, was this merged to NVMe-cli ?
> 
> The series was pulled by Jens for 5.4 merge window.

Got it now, thanks. Hand applied due to some other conflicting churn.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
