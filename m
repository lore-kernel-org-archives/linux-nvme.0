Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B6DC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 16:18:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EBD6100B
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 16:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EBD6100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/Mc5Tw6CSANyFYtzwB1kmMFqZZ4Bth1oSqILZzy0878=; b=FJGLRiGjCPmuAA
	p4wQFpwc+//9czVFP7Tsa7aQ2uf0Z7iP1pQhPBB99KzfNOSMF7WSddXd4P7pu9ToA7gVEtsEsFmLq
	dXIZI7psHZnWkAxv2PUgwtqWvezxu9oUG4mlGjs+zW8Xv5OMAt2XI0583Fc70nxJOs+jfNEgvOyyc
	prerZobiR1M/DjC6jSkiDI368bESTVp1lRxINTn107ItzdagSVqGPv/butSXgBZ64IiWVFKelv/6E
	WXT1AhAOAgcVhY9okRxh5akKBA0JxrBPR19/n8PwLaMWYTJpYDAY/SRz1ne4gUqQCSfvFGkT9VDK+
	D1pfSr6Qhihv8beICZCw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRdYC-0072t9-2F; Wed, 31 Mar 2021 16:18:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRdY9-0072rl-Aa
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 16:18:35 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A4E86100C;
 Wed, 31 Mar 2021 16:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617207511;
 bh=Y8u3SvjO9gx3bfmv7/syUAiNsIUyAid9ctYmHSCzu14=;
 h=Date:From:To:Subject:From;
 b=sFid8M+cCRtxSqDKuqBn1qoznZtrQQMKIGGh08qYXhycHGg93pnsWILOB2PX1fYhi
 9e/QvSonKqK6Iz1pinRjboNs+22SjNtUQan/x6ZoegXnBtUryfiJGvtxbGDorkeIEh
 mcP/w95ZFh7stxkA2ADIWjMhx6e6d3Upqv3+J1mm7AOTb0dRjHiZNHANjx5T/3C3VQ
 wS8Q5NYve36TgEhHUiGyBsImWsIuRHwdZFoopNWvxb3ykMx06iHegEyqTUXep3qBjD
 cwl+0x5OodGQgZXzlt8m4oytEdzNx8xA7pH2RHhTr3jnmecT81t3efRqYlUVJc4DOA
 RFGUBH4HI+RKA==
Date: Thu, 1 Apr 2021 01:18:25 +0900
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Subject: nvme tcp receive errors
Message-ID: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_171833_558051_03240931 
X-CRM114-Status: UNSURE (   4.91  )
X-CRM114-Notice: Please train this message.
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

Hi,

While running a read-write mixed workload, we are observing errors like:

  nvme nvme4: queue 2 no space in request 0x1

Based on tcpdump, all data for this queue is expected to satisfy the
command request. I'm not familiar enough with the tcp interfaces, so
could anyone provide pointers on how to debug this further?

Thanks,
Keith

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
