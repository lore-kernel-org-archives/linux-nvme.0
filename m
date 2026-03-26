Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BE810A62FD
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2026 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hztpmvPQiimJVMEkUlBkN90snzIBjEq9me3iQ8P9seI=; b=vNg0fKEp32xDU5Da3YHqfVmzzg
	7K1ywadvHh0fwGdHpCbkvS6epET076bCIPJCA7GyDGP45PQXbx394IzLhM6C7oovHs9WGBTcfroVf
	6wFYfFCfaIWMeBYO9/UTAHp63LgqGgmaS7ExmIaDtZEyvNUdBCTrV5UKLsLluMIWEtpOVgjBW5oF0
	sXM9hW9KVeLNmPCZcshUAaLen/X9pyaB0htxuJA7ubURzpvRTyFIKa66MCEkfoY+lrvHje21nVJfR
	345zy1+HWOfK4MlEtpgMkeDxQipTpQ7Y3xt0fhuO/H6Q3KD+qGL0H8KZw2QVeFchBUqNa5hNRwp8o
	8RTEBY/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5lvq-00000005gBG-3qxV;
	Thu, 26 Mar 2026 14:43:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5lvo-00000005gAH-111w;
	Thu, 26 Mar 2026 14:43:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5288260053;
	Thu, 26 Mar 2026 14:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37262C116C6;
	Thu, 26 Mar 2026 14:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774536211;
	bh=QCP4s4j85foSGpz3Jg5C2WeljmjT3n1LUgByDDCaay0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFFU9k4Q9jFBVoJNp/Q3T+UOUF/TqBkwaUXEIUoxafyytcHSsU1+sCaPAJ6v9sD2b
	 W/N14Tjytjd+HUiI+f4fu30PhI7H0uzEeJQ9w9xE6CWPScA9w5yez3QW29xmsyiHbu
	 /Nfae9vgoUTW0Js1ml52Koj8z1jzlsPLrA47WpBXuTiSL0jS9AHQhvm+VIAv8vZsG6
	 eB38zs2Lw1Y6MFk02nDjnelv3vUE6Lz0HBLLod18p/Nir7JyUB4XaNYgRJSupZNkct
	 nyqqKQvEG+UPXSaRHdP/Q8SxjQlwt3IkCCDEX8Gf2aK7rN4Zog9Qs32XO+av5Xtwu/
	 6xVRVHfdozfoQ==
Date: Thu, 26 Mar 2026 08:43:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: "hch@lst.de" <hch@lst.de>
Cc: =?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>,
	Justin Tee <justintee8345@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sven@kernel.org" <sven@kernel.org>, "j@jannau.net" <j@jannau.net>,
	"neal@gompa.dev" <neal@gompa.dev>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"justin.tee@broadcom.com" <justin.tee@broadcom.com>,
	"nareshgottumukkala83@gmail.com" <nareshgottumukkala83@gmail.com>,
	"paul.ely@broadcom.com" <paul.ely@broadcom.com>,
	James Smart <james.smart@broadcom.com>,
	"kch@nvidia.com" <kch@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?7J207J2A7IiY?= <euns212.lee@samsung.com>,
	=?utf-8?B?7Lm47LCs?= <joshi.k@samsung.com>
Subject: Re: [PATCH v5] nvme: Skip trace complete_rq on host path error
Message-ID: <acVGECskf5pg3_MY@kbusch-mbp>
References: <acQxjZMOqj74yIJf@kbusch-mbp>
 <20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p4>
 <945a3e98-ee75-453c-ae80-f3c9e3e57e58@gmail.com>
 <20260325063333epcms2p60954532c1b65a1665bad6dcdcfd7d62c@epcms2p6>
 <CABPRKS8-x6Tfr90inpz1fR0=8a5HD=mkujtfLJ1h9ikEUjTvxg@mail.gmail.com>
 <20260326014429epcms2p135ffd3c2b2fface6423d045e9614c262@epcms2p1>
 <CGME20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p5>
 <20260326065152epcms2p51a18d3bbecb6eb6dc2ddba09651e5152@epcms2p5>
 <acVCnozG1WKPkq1L@kbusch-mbp>
 <20260326143124.GA17507@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326143124.GA17507@lst.de>
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 26, 2026 at 03:31:24PM +0100, hch@lst.de wrote:
> On Thu, Mar 26, 2026 at 08:28:46AM -0600, Keith Busch wrote:
> > On Thu, Mar 26, 2026 at 03:51:52PM +0900, 전민식 wrote:
> > >  {
> > >  	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
> > >  
> > > -	trace_nvme_complete_rq(req);
> > > +	/*
> > > +	 * The idea for these trace events was to match up commands
> > > +	 * dispatched to hardware with the hardware's posted response.
> > > +	 * So skip tracing for undispatched commands.
> > > +	 */
> > > +	if (nvme_req(req)->status != NVME_SC_HOST_PATH_ERROR)
> > > +		trace_nvme_complete_rq(req);
> > > +
> > 
> > Well, how do we know a controller doesnn't actually return that status
> > code? I was just suggesting to skip the trace for the condition we never
> > dispatched the command. An added bonus is we don't need a mostly
> > unnecessary 'if' check on every IO.
> 
> The 7?h error values were added for host use.  The description of
> the section in the spec suggests this, but isn't actually as clear
> as I would like it.  I wonder if we need to verify that controller
> don't incorrectly return it, as that could cause some problems?

Yeah, the spec is not very clear on their use. It just defines the codes
and a one sentence description, and then never mentioned again. I think
it allows the possibility for the controller to internally complete a
command with such status from some undefined OOB mechanism. I'm not sure
why the host needs to have their own self-generated status codes anyway
since it can already attach whatever arbitrary flags it wants to its
private data, like how we use NVME_REQ_CANCELLED.

Anyway if a controller did return it for whatever reason, even if it is
a bug, we'd want to see it in the trace.

