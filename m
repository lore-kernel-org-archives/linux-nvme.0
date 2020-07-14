Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA43C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 11:13:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8092084C
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 11:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1Qv62tOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8092084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oSWanpt7pOmV/qjrg13+zBfBYCmuBvVqeqpdqHEwAXo=; b=1Qv62tOcCduJMRYulhEhy4+4D
	JakxmNuptoskygRWI/JGgHxeN2+vUOoC1zh4XPAXPfELwtq5NJF9suJb1AkzfLuQ8PXMmsE7b8FZ6
	fvSUHL7eT/6eFfGQf2fqkzZwJeJJVUJ8i0IDW0ZDEqVl6qvDIydUuATYrOrzckL7uhpTrXNaM3XqO
	uwvLriI6n124xs3Lmnfhjfaoxl1eMfeB9Oi0dEVIT93dpQzQ4uV/CMA0g4lMUmXlMoJmHXjBcA4XR
	acSYqfJSr4mwhuiZU2Indw1aun4WQzZqWZdqUuwTOIv7WXSDwFEXHbmiCw8MoJNz3Vg4cLpsnUPsl
	2ZZ1sxzpw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvIrq-0002rZ-BV; Tue, 14 Jul 2020 11:12:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvIro-0002qr-4e
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 11:12:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 047AA68CFC; Tue, 14 Jul 2020 13:12:54 +0200 (CEST)
Date: Tue, 14 Jul 2020 13:12:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anthony Iliopoulos <ailiop@suse.com>
Subject: Re: [PATCH v2 for-5.8-rc 1/6] nvme: fix possible deadlock when I/O
 is blocked
Message-ID: <20200714111253.GA17267@lst.de>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-2-sagi@grimberg.me> <20200624062902.GA17594@lst.de>
 <84583b2e-d59b-01bc-1737-5db107999d84@grimberg.me>
 <20200707105735.GA16868@technoir>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200707105735.GA16868@technoir>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_071256_318071_B1525BE7 
X-CRM114-Status: UNSURE (   6.09  )
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.8.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
