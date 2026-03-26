Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C9410A62F9
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2026 14:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cqAo4B4Zn6p/GYAnn/u81HTFZV5FsFBQHnaL2sPYiTY=; b=hXnTpe221OedoMglKQUwZ76eIb
	Zk/b6oMUP9/ILIk7f7z+f+O12Et5kTlcMxHJrF5MSyJLFGDZ8R/T47yqR71IxrlHnCe6IrlnL0MTL
	ZDFKbRzY7gENCFCON3PRXrdTXvQ2UBVJVB19UvTN6gvDI/cR+4ceUOELSFg9OCJ99mltxNDnsqTDF
	qWM8XZiEWpkXWF4ou16JGLC0GAPWYgAP8MPMk4sP/cSE3BpRHo2FsfqKZgx+7I3lrDLmZbrT1pocL
	02u4vDx0+NVUZbZQnJIYv635tKWK/r2VVOwjE/PV3Yu2OcJ1f0m1lnpEVsQvq61Bgz6HTyDB0HzmY
	3Ttm9wLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5lkE-00000005eSt-0Th6;
	Thu, 26 Mar 2026 14:31:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5lkB-00000005eRS-1JDn;
	Thu, 26 Mar 2026 14:31:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7013B68CFE; Thu, 26 Mar 2026 15:31:24 +0100 (CET)
Date: Thu, 26 Mar 2026 15:31:24 +0100
From: "hch@lst.de" <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: =?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>,
	"hch@lst.de" <hch@lst.de>, Justin Tee <justintee8345@gmail.com>,
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
Message-ID: <20260326143124.GA17507@lst.de>
References: <20260326061443.GA23850@lst.de> <acQxjZMOqj74yIJf@kbusch-mbp> <20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p4> <945a3e98-ee75-453c-ae80-f3c9e3e57e58@gmail.com> <20260325063333epcms2p60954532c1b65a1665bad6dcdcfd7d62c@epcms2p6> <CABPRKS8-x6Tfr90inpz1fR0=8a5HD=mkujtfLJ1h9ikEUjTvxg@mail.gmail.com> <20260326014429epcms2p135ffd3c2b2fface6423d045e9614c262@epcms2p1> <CGME20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p5> <20260326065152epcms2p51a18d3bbecb6eb6dc2ddba09651e5152@epcms2p5> <acVCnozG1WKPkq1L@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acVCnozG1WKPkq1L@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_073131_514380_00679F63 
X-CRM114-Status: GOOD (  17.44  )
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

On Thu, Mar 26, 2026 at 08:28:46AM -0600, Keith Busch wrote:
> On Thu, Mar 26, 2026 at 03:51:52PM +0900, 전민식 wrote:
> >  {
> >  	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
> >  
> > -	trace_nvme_complete_rq(req);
> > +	/*
> > +	 * The idea for these trace events was to match up commands
> > +	 * dispatched to hardware with the hardware's posted response.
> > +	 * So skip tracing for undispatched commands.
> > +	 */
> > +	if (nvme_req(req)->status != NVME_SC_HOST_PATH_ERROR)
> > +		trace_nvme_complete_rq(req);
> > +
> 
> Well, how do we know a controller doesnn't actually return that status
> code? I was just suggesting to skip the trace for the condition we never
> dispatched the command. An added bonus is we don't need a mostly
> unnecessary 'if' check on every IO.

The 7?h error values were added for host use.  The description of
the section in the spec suggests this, but isn't actually as clear
as I would like it.  I wonder if we need to verify that controller
don't incorrectly return it, as that could cause some problems?

Independent of that your patch below looks sane to me.


