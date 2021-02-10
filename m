Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9641C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 07:38:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475C064DF2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 07:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475C064DF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+Zz5QsRwBSTD+3oXLecAmXssVaXxp48u8ZUS4MjuPwo=; b=sFmgDcts7AqAeFQ0q0az/9JJ9
	ipHMv8Vq5ygJML7G/d3H4RLV7Fd9t8zDGuKhzOaiosdwiLzEYAs4uW+L5rwR3qwCTZtzYsL5vOWW5
	S9oiep8iMVCiUZfAAPZCMVDrl32YL5+g/Vy1RHTGNdjhFrS6Se+sF3S+hT011Pa/PqpQHmg5BdhAy
	e3Z4f3dSof7No+KZFXZpnkECdM5O4tlfp6hSCDmX3KiVh7t7MmNEqwpE99Q0ToPVyj01qAFUd6uMc
	lwgivbG4mfq+5DRax4q9gPX+bX8glmPTnVJka+z+s7UQod1DyYaEuqtV6R82/UiRpgzXLrPF94knB
	QdnLnnQLg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9k4d-0007B3-Qu; Wed, 10 Feb 2021 07:38:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9k4Y-0007Ah-Nd
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 07:38:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EACAD67373; Wed, 10 Feb 2021 08:37:59 +0100 (CET)
Date: Wed, 10 Feb 2021 08:37:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Filippo Sironi <sironi@amazon.de>
Subject: Re: [PATCH v2] nvme: Add 48-bit DMA address quirk for Amazon NVMe
 controllers
Message-ID: <20210210073759.GA23269@lst.de>
References: <20210203094338.19473-1-sironi@amazon.de>
 <20210210003942.25700-1-sironi@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210210003942.25700-1-sironi@amazon.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_023802_900683_BBD7F4E3 
X-CRM114-Status: GOOD (  10.63  )
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
Cc: benh@amazon.com, sagi@grimberg.me, serebrin@amazon.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 kbusch@kernel.org, hch@lst.de, dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 10, 2021 at 01:39:42AM +0100, Filippo Sironi wrote:
> Amazon NVMe controllers do not support 64-bit DMA addresses; they are
> limited to 48-bit DMA addresses.  Let's add a quirk to ensure that we
> make use of 48-bit DMA addresses to avoid misbehavior.

This should probably say some, and mention that they do not follow
the spec.  But I can fix this up when applying the patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
