Return-Path: <SRS0=k3Et=EK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C13C388F9
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2020 14:29:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2A9206E3
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2020 14:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QGw+NwC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2A9206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qNVnOSY7UwYmse++3HCMbkk4vH7gVHrAkyX2/qhdcIA=; b=QGw+NwC1UiJtbutKH8wuRkq8g
	AbMol1zpxI4W+zWPTizYj+6TUFbIlV3rt/AxZJMPp9ckA83YfsRJ2tHRuF9R91MsjMIr+H2TWtOAI
	ftisnbAo3c/vi2aIZEI32m3/9omfCGih8qOcNF2JRbOxULJYikIut//blbY5F2slMO+Ex3hihRbGZ
	WnK9tAnkwbJWBP6iOzg4RSI7B38adP+5ZI8t+EmroRkkjZdXpW0R2QyAoXj1hiHD8EkqH4D6Ot1+c
	cw+3mQRx0MS8DmWX+HE/24fXtxoTHMT0E/oTLucmAviGnihgJQBdrWUKECAy97rv10x4ZnkkbaJtC
	rblSMZrSQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaJml-0003Fb-Db; Wed, 04 Nov 2020 14:29:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaJmj-0003Et-7u
 for linux-nvme@lists.infradead.org; Wed, 04 Nov 2020 14:29:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1ACE968B02; Wed,  4 Nov 2020 15:29:09 +0100 (CET)
Date: Wed, 4 Nov 2020 15:29:08 +0100
From: "hch@lst.de" <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201104142908.GA7941@lst.de>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
 <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
 <20201102185851.GA21349@lst.de>
 <23e10fd1-d20c-cf77-4dc0-dd8b0774fd7a@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <23e10fd1-d20c-cf77-4dc0-dd8b0774fd7a@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201104_092913_432514_AE2A042A 
X-CRM114-Status: UNSURE (   8.28  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>,
 "javier@javigon.com" <javier@javigon.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "Klaus B. Jensen" <k.jensen@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 04, 2020 at 03:26:46PM +0100, Hannes Reinecke wrote:
> I hardly dare to mention bsg here; but the is pretty similar to what it set 
> out to do ...

Except that:

 a) we created a complete mess with bsg by overloading the scsi ioctls
    with some of the transport stuff.  
 b) bsg would not work with existing tools.  A character device that
    accepts the same ioctl will just work.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
