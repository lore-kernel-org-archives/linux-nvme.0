Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9ADC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:55:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA36207DA
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZQjdLXUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA36207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fSZTT/QhNzOr2CruDQEHGGGeKE+g1ON3qaIXsujGeGk=; b=ZQjdLXUWhlyxzNpE/++TEWH/p
	r0oyvN2FuE/8g25ZE5TUKlNArKSpYLX4+8g8lxpQMJ+46ozlsBRFxg0Sb1oPFFTs4B8veHjBJnXph
	OcRt5gN25XzxeNQ9IeV3TxcFWQ+pw1Nnzeh6XGTxViXiA++rpdLvWXkPAfhUJAdybsiZG6GGjNTLY
	4SVBJknP+X8QD5/6X+zUX2AK7kslBFuNHlAtI4KgfWPRlGNtlqjb3DA/M6OcqDCvp+yurfe2ukrtH
	RtDprJrH/cCVfWcObc59dB1xNGHH6gluBu1o2/v6yiHjCyYHlpFYCu3NyjspTbnYnaIPNGvtzBNoG
	mPLbDnYzw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8dXH-0007QD-MQ; Thu, 20 Aug 2020 05:54:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8dUU-0005nT-55
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 05:51:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9F2D568BEB; Thu, 20 Aug 2020 07:51:54 +0200 (CEST)
Date: Thu, 20 Aug 2020 07:51:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Fugate <david.fugate@linux.intel.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200820055154.GA5758@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
 <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
 <d19605da52eb7aa3eb4132ad1781b5fbf636a8a0.camel@linux.intel.com>
 <20200819221054.GB26818@dhcp-10-100-145-180.wdl.wdc.com>
 <d9cc3ece0c70b51c2d40998081375ad3fa39ece2.camel@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d9cc3ece0c70b51c2d40998081375ad3fa39ece2.camel@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_015158_453934_D5D9CD00 
X-CRM114-Status: GOOD (  17.08  )
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
Cc: Jens Axboe <axboe@kernel.dk>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, david.fugate@intel.com,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 19, 2020 at 05:43:29PM -0600, David Fugate wrote:
> There were queries? My key takeaways were a maintainer NAK followed by
> instructions to make the Intel drive align with the driver by
> implementing NOIOB. While I disagree with the rejection as it appeared
> to be based entirely on politics, I can accept it as the quirk wasn't
> in the spec.

Stop the crap now please.  I'm really offended.  I'm offended by you
implying that I pay corporate poitics.  I'm primary a Linux developer,
and I stand for what I think is good for Linux.  I fight inside companies
that pay me what is good for Linux, I work hard with companies that do not
pay to convinve them what is right.  I waste a lot of precious time to sit
in standards meetings to do what is right for Linux.  And now you come
here with the politics arguments.  Stop, it please.

The Intel NOIOB quirk was in the driver since day 1, added by Matthew
probably with no bad intent, but we kept growing the lists and finally
got Intel to standardized because it was good for Linux, and to be
honest good for Intel as updating quirks in half a dozen drivers
simply does not scale.  We got a really nice trivial TP out of it.  But
we really should not see any new drivers that do not implement one damn
trivial field a long time after the TP has been publushed.  That is not
politics.

Making a fuzz and playing the corporate card on a Linux mailing list
is politics, really bad politics and you need to stop it.

> It's not fair to make this same "your drive should align with the
> driver" demand of Samsung because we *are* talking about a spec'ed
> feature here.

Huh.  Next time Dell or NetApp or Facebook are going to require an
optional NVMe feature, and OCP feature or even a vendor specific
feature you are going to go to them and say "you don't play fair"?

> Technical critques of their patches and real performance
> degrades observed are fair game and objective; "your company did
> the nastiest possible move violating the normal NVMe procedures to make
> it optional" is not.

It is pretty fair game if you know the background, that is that I spent
countless hours to make this feature fit the Linux I/O stack requirement
perfecty and worked that it is there.  We might as well rely on it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
