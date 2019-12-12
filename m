Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5EBC43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 22:20:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DA12173E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 22:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u/iXk5zl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C76X7I0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DA12173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FGvrJne0yI/v0L9oKnExi57YC8KqItmFe6KXnu83oHs=; b=u/iXk5zlX2DnuB
	KJ+9dT8rufSAoqmmmOtFGlI3o0uJbn4rP7P7Hqf27safzolnHNolE0MVD5z5j7D2zsBHFHfRUHIyJ
	OoStTFa4huYY1cu3kwqxxU6sndkBGn8fSAxx5zl9OzVE4WVsSamx84G4JmXZhz+ouQOejVWVvtJ12
	uWYq1qDUyVrA56hlrd+6bj2tYgE1ULkmvYwnYSeBqY0/58CYPzMXx8gPWudQ0FatqcHVvItTxbq0i
	2vz8+EKsv1nmh8mqz5JxwwaTUXyBJHRESVsGpaV4P/KZpjD0LBuXYNZ5G6zwXSYE8YSimxFIQp11G
	xFV1LG8mpyOI1ND/SFew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifWoR-0005YG-EH; Thu, 12 Dec 2019 22:19:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifWoO-0005Xv-Sz
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 22:19:58 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 311EB2173E;
 Thu, 12 Dec 2019 22:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576189196;
 bh=6wqM/8nuJbTo8PW4nFbDaXSi3DHfDv/lnU1COiTALT0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C76X7I0W/t6+u5063t1CUZHbu2JgTgOITbvJUNsHXwayJspBGLMpc+rJIUgo55wUs
 CrsJuLwBlLeAT5tyll96S6sUmKgWNFrH/Qy5R93yQVPUkyMy9R7ahMIrkh3jN3EcwY
 hifbQMvc3earqiuVJYueHl3lcBab6aVb05yEPy10=
Date: Fri, 13 Dec 2019 07:19:47 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
Message-ID: <20191212221947.GA32142@redsun51.ssa.fujisawa.hgst.com>
References: <BYAPR04MB5749B4DC50C43EE845A04612865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5749B4DC50C43EE845A04612865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_141956_974827_8D100453 
X-CRM114-Status: GOOD (  15.95  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Bart Van Assche <bvanassche@acm.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 Omar Sandoval <osandov@fb.com>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 11, 2019 at 06:16:29AM +0000, Chaitanya Kulkarni wrote:
> * Current state of the work:-
> -----------------------------------------------------------------------
> 
> RFC implementations [3] has been posted with the addition of new IOCTLs
> which is far from the production so that it can provide a basis to get
> the discussion started.
> 
> This RFC implementation provides:-
> 1. Extended bits to track new trace categories.
> 2. Support for tracing per trace priorities.
> 3. Support for priority mask.
> 4. New IOCTLs so that user-space tools can setup the extensions.
> 5. Ability to track the integrity fields.
> 6. blktrace and blkparse implementation which supports the above
>     mentioned features.
> 
> Bart and Martin has suggested changes which I've incorporated in the RFC 
> revisions.
> 
> * What we will discuss in the proposed session ?
> -----------------------------------------------------------------------
> 
> I'd like to propose a session for Storage track to go over the following
> discussion points:-
> 
> 1. What is the right approach to move this work forward?
> 2. What are the other information bits we need to add which will help
>     kernel community to speed up the development and improve tracing?
> 3. What are the other tracepoints we need to add in the block layer
>     to improve the tracing?
> 4. What are device driver callbacks tracing we can add in the block
>     layer?

I would like seeing driver/protocol specific tracepoint decoding for
users common under a single blkparse utility. For nvme, it'd be great if
we could set a fixed ABI, as people keep changing it by burdening the
kernel with making events more human readable. I'd prefer to simplify
the driver's tracepoints and do the decoding from userspace so that it's
forward compatible.

> 5. Since polling is becoming popular what are the new tracepoints
>     we need to improve debugging ?

Regarding polling, but not tracepoint related, but it'd be nice if
we had a new cpu state for this. Right now it just looks like all CPU
utilization from systat says 'system', which isn't really helpful with
analyzing how the hardware is doing.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
