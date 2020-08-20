Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DEEC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 03:45:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8574F2078B
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 03:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jX2fzNHk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ3VRVB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8574F2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3njdwtGiwOKCdfGoBesGxr0/HTLRYxAiUyyvNMHrBVc=; b=jX2fzNHknW9E6wA9XpCKttw92
	G90OBFDffN5sb4rxEl3plBg9egc2017nUpZY31RYK9sTP/anWq2G5/E6cKKYUMKdW8Hp5MiGZgBNc
	+E/jUGEDOEudWHxxG+kLyEHyVdE6LM3RKx7I+xqIhIjNWyJg/odwEYS1dl39GmOH5tAOiXZQCtkIP
	vShZGkPZZVz2546z3seB8kCGef7LwTYgSuX+HodQtmOlj9Dc8Akb5XodO2Hi/KKGAio8i3KPhCYtR
	M1ZhMBADa/ih/5047pj/FVjbgySqbLCpn58Ma3pW/Am96cSP09Tndq7ttVTSsB8U+ep3ZpxVH93Yi
	ehe8L1fwQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8bWM-0005H4-Sp; Thu, 20 Aug 2020 03:45:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8bWJ-0005Gi-U7
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 03:45:44 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BF00B2078B;
 Thu, 20 Aug 2020 03:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597895143;
 bh=T1vQebJsoBRqHO3+NwQVF50ZvFopAiB6Kd6Ov1R16GE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AQ3VRVB326vzAgsOF5FG+wpRyVnXx466Dz8HAqWvGnsHXlitWdkRwUClhZBNYJbwY
 G4xCwKnek5kRRMizDBwosfwHYCzJIyECD6GiJrI905muO3LMrbt915WKazYRz1muXq
 WVS5iNPDwXSTFUGkvO6yyQJ8tCwSFzIXYZeQwS/4=
Date: Thu, 20 Aug 2020 12:45:39 +0900
From: Keith Busch <kbusch@kernel.org>
To: David Fugate <david.fugate@linux.intel.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200820034539.GA12222@redsun51.ssa.fujisawa.hgst.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
 <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
 <d19605da52eb7aa3eb4132ad1781b5fbf636a8a0.camel@linux.intel.com>
 <20200819221054.GB26818@dhcp-10-100-145-180.wdl.wdc.com>
 <d9cc3ece0c70b51c2d40998081375ad3fa39ece2.camel@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d9cc3ece0c70b51c2d40998081375ad3fa39ece2.camel@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_234544_072802_BF236356 
X-CRM114-Status: GOOD (  17.67  )
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
 Javier Gonzalez <javier.gonz@samsung.com>, Christoph Hellwig <hch@lst.de>
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

For the record, the suggestion provided, which you agreed to look into,
most broadly enables your hardware on Linux and was entirely to your
benefit. Not quite as dramatic as a political conspiracy.

You later responded with a technical argument against that suggestion;
however, your reason didn't add up, and that's where you left the
thread.
 
> It's not fair to make this same "your drive should align with the
> driver" demand of Samsung because we *are* talking about a spec'ed
> feature here. Technical critques of their patches and real performance
> degrades observed are fair game and objective; "your company did
> the nastiest possible move violating the normal NVMe procedures to make
> it optional" is not.

Sure, but you're cherry picking comments from the discussion. The
performance impact exists, and it's generally not acceptable from a
maintenance point to duplicate significant code without at least trying
to provide a common solution. 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
