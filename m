Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97740C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 01:34:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F73206EB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 01:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FP94dJru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F73206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YsUU4wJc/iuFVrygQRkoEsmnElGIj0mWtphljs1XfL8=; b=FP94dJruxqDQvGD7ukAFdvJ0vT
	rzySW448wJnCWEhJCHYE+XFU/g6ydvt11yM3a0fRIL7cypKvZcbaNlR2JwoYATVPYdr0XS+YsNkn+
	SiAaes1yS1P345Y+ssPpny255Fx0duD8u/bHIcqD/Hp7VftLrajKOVoBRb7pMRlC+aJxUIc/HurRo
	Iq/jKGG7ZlKes8938dw3XM+D+vOxgqUWgUIP59F93ZZRNY6ZUSSFcisdmZPoBk3RwWWhlscOEobof
	xF/ERGpbKaYvc2ux+wYXjMk1e9UF3BfzkBQdy7+Sm7IUPhpjNv2MMHROb+dj74w2O5Z+p6ZKnJWsd
	lQKWO2kw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnuIs-0001iw-J8; Wed, 24 Jun 2020 01:34:18 +0000
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnuIo-0001gf-Pq
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 01:34:15 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R851e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0U0Xwlnb_1592962448; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U0Xwlnb_1592962448) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 24 Jun 2020 09:34:08 +0800
Date: Wed, 24 Jun 2020 09:34:08 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/3] nvme: Add Arbitration Burst support
Message-ID: <20200624013408.GA40094@VM20190228-100.tbsite.net>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
 <20200623144014.GB1288900@dhcp-10-100-145-180.wdl.wdc.com>
 <38482b1b-b1c7-bb41-b086-6ce00f6a9d1d@grimberg.me>
 <20200623180108.GA1291100@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200623180108.GA1291100@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, baolin.wang7@gmail.com,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 11:01:08AM -0700, Keith Busch wrote:
> On Tue, Jun 23, 2020 at 10:39:01AM -0700, Sagi Grimberg wrote:
> > 
> > > >  From the NVMe spec, "In order to make efficient use of the non-volatile
> > > > memory, it is often advantageous to execute multiple commands from a
> > > > Submission Queue in parallel. For Submission Queues that are using
> > > > weighted round robin with urgent priority class or round robin
> > > > arbitration, host software may configure an Arbitration Burst setting".
> > > > Thus add Arbitration Burst setting support.
> > > 
> > > But if the user changed it to something else that better matches how
> > > they want to use queues, the driver is just going to undo that setting
> > > on the next reset.
> > 
> > Where do we do priority class arbitration? no one sets it
> 
> Not the priority class, we don't use WRR in this driver. The RR
> arbitration can be set from user space and saved across controller
> resets, like:
> 
>   # nvme set-feature -f 1 -v 3 --save
> 
> This patch would undo the saved feature value.

OK, I understaood your concern. Now we will select the RR arbitration as default
in nvme_enable_ctrl(), but for some cases, we will not set the arbitration burst
values from userspace, and we still want to use the defaut arbitration burst that
recommended by the controller, taking into consideration any latency requirements.

So I'd like to add a parameter to decide if we can use the default arbitration
burst like below, how do yo think? Thanks.

static bool use_default_arb;
module_param(use_default_arb, bool, 0444);
MODULE_PARM_DESC(use_default_arb, "use default arbitration burst that
recommended by the controller");


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
