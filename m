Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9510C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 13:16:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C87F64DEE
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 13:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C87F64DEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7IDc/wiJK9ToUryoiv00SnZ+iTCAY3GypQXHDqr7uTk=; b=QcGNSkH4HrRWRigO3ob8Hk4nO
	VZxCeszw8UX86468kHqHzMLjYhANmP/Gn+HLQzZMBhzgT9r2Y3fDQZ0/ZRunvg9IHpHtJoRkbOEL9
	W1/isIzXfmWkRiV3KMIkWrMViZcf80Dr5sriaUyJlmjB540oxZOjDgJ+N2Uj5kjev5+k0UceHhfjl
	Li6vo4D8kxgW6Oaanq0d67QZ7ya1J3ghrIBbQiZFqfl5hEAVqXrP9M5buIcJz2Zk663tsOl2hGLJC
	LK0D5kg3TLTnJC2uxO05CSofJ8Mgzk8ErmqLsgrXOWLXgjrOxBwA0mvV9D3wuPN+Izn1L04FYMujS
	+MU79vlaQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9pLf-0007zZ-VQ; Wed, 10 Feb 2021 13:16:04 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9pLb-0007xf-Kt
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 13:16:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6CE4A6736F; Wed, 10 Feb 2021 14:15:57 +0100 (CET)
Date: Wed, 10 Feb 2021 14:15:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gopal Tiwari <gtiwari@redhat.com>
Subject: Re: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write
 Zeroes command
Message-ID: <20210210131557.GB29904@lst.de>
References: <20210209045902.72345-1-gtiwari@redhat.com>
 <YCOxjZhBTBchOq0n@infradead.org>
 <211078952.30654328.1612955843198.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <211078952.30654328.1612955843198.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_081559_928677_1395E2FF 
X-CRM114-Status: UNSURE (   7.42  )
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
Cc: Christoph Hellwig <hch@infradead.org>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

MDTS vs Write Zeroes is a common misconception.  We had that discussion
in the NVMe working group, and while the text should pretty clear that
MDTS only applies to data transfers many implementators did not understand
that, which is why we added the clarification you quoted.

Also the next NVMe spec will allow devices to advertise an explicit
Write Zeroes limit, take a look at TP4040 from the "NVM Express 1.4 Ratified
TPs" at https://nvmexpress.org/developers/nvme-specification/.

So I think limiting to MDTS unless the new WZSL is set might be a fail
safe option, even if it is more pessimistic than what the spec says.

I'd also love to retest most Write Zeroes quirks with that in place.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
