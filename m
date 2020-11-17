Return-Path: <SRS0=6Yp5=EX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86153C2D0E4
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2020 15:32:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0879B2222A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2020 15:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dO11h6SM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lf362c/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0879B2222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eskly6PLHR9A63dsZfLmrQB5Nighbr1VqryzDYLVqOg=; b=dO11h6SMGrvBV/0rnsp0yxpte
	RDYzxRxYukZAGcYwobXHaACjBzfKT5JHEsDZpfxAR/qMPD9vtPYgUUZzSbMQrN6ETE0LRqq6ouDcC
	OUN8abOibHGhN/Hgxhh4du94HrpfXCet4j8GQkJxTfvLlcHj3KlSny/xhzRQBvbUfJCPi8LqZqCIq
	1onOxesB7bwTuPnkzpcq5a00KWTZMSOz0ESih/j9j56XXwf2zmyuI0fx+PT6pefvLNwyI5T14Plxy
	MMXJl7EYl8mMKEUYI1O0Z5lERrPjMtjKmU7S0vVfQa/NfxQqtqDFPvS2vVI/n/KBwnclJ5bqggCIk
	TqjdE7Iuw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kf2yS-0003hM-8W; Tue, 17 Nov 2020 15:32:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kf2yQ-0003gw-0m
 for linux-nvme@lists.infradead.org; Tue, 17 Nov 2020 15:32:50 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 519552222A;
 Tue, 17 Nov 2020 15:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605627168;
 bh=Eh3TzX3E4Pu6T341XVPPjomG/WCVoY+xIoBpIp9fbJM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Lf362c/BmgjnAhMkLmVoieWMyed+RnjYmocF+IKUFCLcIVhqEAhz8ZWMfwd8okieF
 +xtYWLZU4GyfAK3XQlNBz25k7h9Brh/WG/oSUeT45tn6mbLZBokFr3axCGo0oiGFBL
 AyddwJzEp+6jRWYVBdh6J+V3+t759+jXVS/4uxSM=
Date: Tue, 17 Nov 2020 07:32:46 -0800
From: Keith Busch <kbusch@kernel.org>
To: "Rajashekar, Revanth" <revanth.rajashekar@intel.com>
Subject: Re: nvme: subsystem handle not released on hot removal under raid1
 configuration and multipath enabled
Message-ID: <20201117153246.GE2715864@dhcp-10-100-145-180.wdc.com>
References: <fa9e6605-9d6e-0bde-749c-8987f68320a5@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fa9e6605-9d6e-0bde-749c-8987f68320a5@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201117_103250_168218_D0621850 
X-CRM114-Status: GOOD (  13.96  )
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
Cc: "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 16, 2020 at 04:06:54PM -0800, Rajashekar, Revanth wrote:
> I guess this is because the md-raid1 driver is still holding a reference to the nvme driver (kref count is 2 in the nvme removal path).
> Is this a bug in nvme multipath? Because it works fine with multipath off.
> Please let me know if more information is required :)

Correct, the md raid is holding a reference. It's not really a bug, but
others have commented that this behavior isn't necessarily desirable.

I posted an RFC about this issue here:

  http://lists.infradead.org/pipermail/linux-nvme/2020-September/019873.html

The discussion evolved a bit since then, but hasn't had much activity
recently. I'm hoping to get back on that conversation soon.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
