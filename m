Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED1DC433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 06:47:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48BBA613C8
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 06:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BBA613C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=20t7BeIwBJ6227YUPv3xXMoLu6uXn8V4XA2KvR488VM=; b=bzwKrgtwd2ZIMXLZWmP6KCmql
	uGX2Q1iR9/77zscKM/nbi6fFJihpnGrUDqjQWAa+S6lETGdVAab3BXDsQnKZObZ+txU90HoBRMslL
	FerGCZQuqtqXHhiqeXww0xX0bqH3VlahzHtulid99A3nIk8TllWbZimZMGCPIrhr3qDmrpZJRQHp8
	IKpFLr1dw1yXEksJozP6gwQNjIiX2VzZybZgGgYdTeORvIgcUxXaoH+37vpOu8TFIUx/G2/XpcXv9
	LSuNoJODRVUz2EGeaRGkVfrwX9ljJPmgStuVl6LoFmMJ+FMJuZqe0A26APqnm0X6le7KTGbhtic2E
	BU8up0xvw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leuGR-006JCi-EF; Fri, 07 May 2021 06:47:07 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leuGO-006JCZ-8S
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 06:47:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=k72BgdhUbKBLPkhc+kj3GnbNkRaNUNrpL6TcT6PJvOk=; b=5CiMGhT2td+jGmTbR9/XS1M/tC
 tE3BDd/+JDvDSYoiCdxLrwBJfv+KpLfaPhkRxjzmkhgXYsvpWj5rSO3UzmWAZb5ig28c0GeTl2k+L
 D4AElCeA3Y4ZN5S6ljxXw2DowRzZrvpvHWn3TKIYs6WSe9BeIlwNKqv3bJNQzEZRlyUQbgLGDzvx6
 i+yAHhePJKt3XS5+ncVpLxmJnmZrLlR4Skieyna7prgfZ8zQlTgLbv0BmD9cDzqi0Q3fNWyvmU6zz
 J/ZdNYhxE5VPn0Ht4LFS9c+SDehQigE+QE61HFtzDa3dBAVsclBWYbZ/KgZ+schkKq/vQCzYsOC8H
 q3q71RUw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leuGL-006d44-DR
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 06:47:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 02CA968AFE; Fri,  7 May 2021 08:46:57 +0200 (CEST)
Date: Fri, 7 May 2021 08:46:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <daniel.wagner@suse.de>
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
Message-ID: <20210507064656.GA24437@lst.de>
References: <20210501120447.45478-1-hare@suse.de>
 <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
 <20210506074341.GC14615@lst.de>
 <96fbc678-a7e8-aaf3-5f15-8c866e683afe@suse.de>
 <d50ca6e6-5340-6f38-bc56-6f10b49d7801@grimberg.me>
 <20210506120855.GA1546@lst.de> <7cd891d9-6aa0-fd98-cbc5-1df2eabbe31d@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7cd891d9-6aa0-fd98-cbc5-1df2eabbe31d@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_234701_622768_C212AF3D 
X-CRM114-Status: GOOD (  11.21  )
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

On Thu, May 06, 2021 at 05:54:29PM +0200, Hannes Reinecke wrote:
> PCI and fabrics have different defaults; for PCI the device goes away if 
> the last path (ie the controller) goes away, for fabrics it doesn't if the 
> device is mounted.

Err, no.  For fabrics we reconnect a while, but otherwise the behavior
is the same right now.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
