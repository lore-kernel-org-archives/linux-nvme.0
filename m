Return-Path: <SRS0=KsQz=E6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCA7C2D0E4
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 14:36:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75FD206E5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 14:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IFqzI8ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75FD206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XJEMMJcQMleloZXPxSV2e0ZNsXvMITLe8JU4QZ70qVg=; b=IFqzI8nsctrs5ky3/NEC5O2bA
	hTRFd6maPphkZ4v5/V+fx3yA+sbmC47hdMh4h8//E4BAowVwBgF0skRaJZ48FkxrP5cIIjDn8QlYS
	P0zc81sgxPiQkVIBqp+lRF7Y0rhwFIekJOakCa6yxwejCRLSx8skkakOy2jgQTen29hHKG0sA5CHM
	MiOA9EvJVmTeEJFF/SJLaLXe2r+UUA5qxfgc0U/zOl4CAFWfNz+HeGko+SyQtm+IKDidlMwB5OqzS
	8QNS/UXAXm9qmmWjIXJKagJoxvLwyLOUo9DGCHkcvmnL8mCTAe8Y7qbCNjvoGtXhlKM8I4NI0Bl3v
	gM/nhJ9VQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khZQL-0003St-Ea; Tue, 24 Nov 2020 14:36:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khZQF-0003RY-Fq
 for linux-nvme@lists.infradead.org; Tue, 24 Nov 2020 14:36:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DF3E36736F; Tue, 24 Nov 2020 15:35:54 +0100 (CET)
Date: Tue, 24 Nov 2020 15:35:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Victor Gladkov <Victor.Gladkov@kioxia.com>
Subject: Re: [PATCH v10] nvme-fabrics: reject I/O to offline device
Message-ID: <20201124143554.GA3046@lst.de>
References: <95f582e9dcd648a9930e85b397d39898@kioxia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <95f582e9dcd648a9930e85b397d39898@kioxia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201124_093559_671395_12570487 
X-CRM114-Status: UNSURE (   9.42  )
X-CRM114-Notice: Please train this message.
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
Cc: Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Ewan D. Milne" <emilne@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I tried to apply this, but first it didn't apply as it expected
to be indented differently from how it is in nvme-5.11.  After
fixing this up the commit message didn't show up as it isn't placed
correctly in this mail, and the code did not compile because
nvme_stop_failfast_work and nvme_start_failfast_work do not actually
exist.  Can you please resend against nvme-5.11? 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
