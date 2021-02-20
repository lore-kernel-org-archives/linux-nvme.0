Return-Path: <SRS0=hrUZ=HW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6D0C433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 19:20:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1502164EB3
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 19:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1502164EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cmStZ7UyxiS4TDvfGdGmdBfsYEsgeOgZiXi5bXQiZJw=; b=UowYG4iowW5Jq2ROHNv5MzxVo
	oRlCSpnpv8Am3jgw9lbnySvVu5MUn7g4Fe1iaDgH/t+Id0CfgpBQOGnLq4g3Z4N5mB/YpXhOQ4ZvU
	Rmp8qlzgq8TnP+sFcDIvry84mKU1DpKscGWZRkhl5DqrGG0fdW9/40sSFZeY7Re6EWUyTw4lpCXAm
	AjA1jhXzIo5ka1uGOVIB47tFYa5RJ0i8ma3qC113OYOVCVYscZEUeMmbBQYxseIbIyRsK/aZ06S3U
	L92AnRAbJDTBGpKHChAu8DSJTe/tzVGDH2S+LKX1XODjvzXiUVy2yXU8AfM0eGAtzrKBD7F/VJIr8
	0ede8m0ow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDXmu-0004eN-OA; Sat, 20 Feb 2021 19:19:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDXmq-0004dW-W9
 for linux-nvme@lists.infradead.org; Sat, 20 Feb 2021 19:19:31 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BF2264E51;
 Sat, 20 Feb 2021 19:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613848768;
 bh=opkZV9+iiOg5i7CeRhciYmBMWsz/qz9Xmo/qIEL+++w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lAzR3vLqQJN7zA0sj+1l2vnXCMVW4WzYcT/7zoi2XEkR75dxEfZxsr9ZZXs0vfoPA
 MIIgjdK8Bfi/OCFnVUkAXbnH1QuOe78GE9Zog3tA5xLd9ntizTOGRftkJ5DbbTpQLW
 omYiai3857LXH2o97xCBrMSxBqmNpxN940EtlMYI230TK91985WJW6trAwt3FkdY/L
 VqIe5cfn3Bm95NdASEstDvnzMUXt7VhCJVGdKAJfJ58WvX9DqAgAts08MiZ6GAolne
 0nuR0yF2z+6rnQQ4z7QrJaZEUfQQrwShmPsQQ1TDKXSeEoktfn9AzBO1+I/LSxew2+
 2ipaElzzXH/Mw==
Date: Sun, 21 Feb 2021 04:19:21 +0900
From: Keith Busch <kbusch@kernel.org>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
Message-ID: <20210220191921.GA7968@redsun51.ssa.fujisawa.hgst.com>
References: <CGME20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44@epcas5p1.samsung.com>
 <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <146c47907c2446d4a896830de400dd81@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <146c47907c2446d4a896830de400dd81@AcuMS.aculab.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210220_141929_125491_9AADD1EE 
X-CRM114-Status: GOOD (  14.92  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
 "kch@kernel.org" <kch@kernel.org>, 'SelvaKumar S' <selvakuma.s1@samsung.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "selvajove@gmail.com" <selvajove@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "joshiiitr@gmail.com" <joshiiitr@gmail.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Feb 20, 2021 at 06:01:56PM +0000, David Laight wrote:
> From: SelvaKumar S
> > Sent: 19 February 2021 12:45
> > 
> > This patchset tries to add support for TP4065a ("Simple Copy Command"),
> > v2020.05.04 ("Ratified")
> > 
> > The Specification can be found in following link.
> > https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
> > 
> > Simple copy command is a copy offloading operation and is  used to copy
> > multiple contiguous ranges (source_ranges) of LBA's to a single destination
> > LBA within the device reducing traffic between host and device.
> 
> Sounds to me like the real reason is that the copy just ends up changing
> some indirect block pointers rather than having to actually copy the data.

I guess an implementation could do that, but I think that's missing the
point of the command. The intention is to copy the data to a new
location on the media for host managed garbage collection. 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
