Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754D7C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 07:18:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238FE613D8
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 07:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238FE613D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jUqAcinr8NZ0G5AB+dZcAfHVgGf4ajG0+ihQY8KPSYk=; b=lAetdkWwVidmkIvLm0oTu+7f7
	CrVySvdQGi457B+icvYwPkv7d7rFG3s10CmznqfWAg7SE/EGzdrJTj8AEs/C6MzlxXQ4UpZ9BDiD3
	kykIAumtX+ok1aqj+TT4g3RnSaP6Ge2DLpLVWGH3HJ01lkvspibSC/e8/pVt1FZA5z61KbcK9BgL+
	4v2NiZweiAzcKP9e2vRLcFRiwbGTtgZ4G6HpUjN5hEMBu7CX7WQjujTfZmkjtqOkq/c5NdXeqx6Di
	jKVzmaiQjB0U7SjTNarglAVdhP3rSl9HVHa9Bd9QcmA7DgjcDgwH02whpxKXyUCUEES1Tk4X6Eq+F
	TZK2GyB2Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbeSB-0032eD-Um; Wed, 28 Apr 2021 07:17:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbeSA-0032e1-Af
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 07:17:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=S+bkcqG+Ie/03TCmvMIUiBz7CxTFimiWwpMx0sjvmy4=; b=NJ2hkCGtGkHOMOT2Pe0jkhpd8N
 3yMMRNdYF2yGTMILzGkB6p86+7u/mtMxyCUBSN1CmZSnXIB1wy1XilLtY0mazYxEpxh4gwEfsNoJi
 nB9H+nU7+7PNbR8563ni3qGhCtnlbP1uBQzfxJWjxQyfkwEl7hlP3t+oDBYcNGYrPz6ZbZbNAZM80
 ke7m2HWvid6YI5aSXQZpZ001fEA//8PAm8uKde7NK49RSfo0wVNIQMwjrpnPayzWTIVzIj95KvyFY
 +6ijoeHXVv841tfR2KEEPMSsfR5ET0JYHtA1S/sHrR+y+iTo1J79C7tjHOXyOK8NwWNboIMvhI96Y
 U8FMUHcQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbeS7-00HFEd-SI
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 07:17:45 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 805AFAF38;
 Wed, 28 Apr 2021 07:17:42 +0000 (UTC)
Date: Wed, 28 Apr 2021 09:17:42 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Arun Easi <aeasi@marvell.com>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, linux-scsi@vger.kernel.org,
 GR-QLogic-Storage-Upstream@marvell.com,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Nilesh Javali <njavali@marvell.com>, James Smart <james.smart@broadcom.com>
Subject: Re: [EXT] Re: [RFC] qla2xxx: Add dev_loss_tmo kernel module options
Message-ID: <20210428071742.rvgogvzigj2yypx2@beryllium.lan>
References: <20210419100014.47144-1-dwagner@suse.de>
 <YH8QzgWiec8vka20@SPB-NB-133.local>
 <20210420182830.fbipix3l7hwlyfx3@beryllium.lan>
 <alpine.LRH.2.21.9999.2104201642290.24132@irv1user01.caveonetworks.com>
 <20210421075659.dwaz7gt6hyqlzpo4@beryllium.lan>
 <20210427095131.zf6c4siewnrhv7qd@beryllium.lan>
 <alpine.LRH.2.21.9999.2104271531440.24132@irv1user01.caveonetworks.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.9999.2104271531440.24132@irv1user01.caveonetworks.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_001744_083324_0199D887 
X-CRM114-Status: GOOD (  10.83  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Arun,

On Tue, Apr 27, 2021 at 03:35:47PM -0700, Arun Easi wrote:
> > I am sure this can be done in a more elegant way. Anyway, I am testing
> > this right now, the first 30 minutes look good...
> > 
> 
> Looks ok to me. Just keep in mind that, with this you'd be setting all 
> instances of pn-XXX (multiple initiator ports seeing the same target 
> scenario). It looks like this is what you want, but thought I'd point that 
> out.

Good point. Yes, that's was the plan, set all ports to the same
value. BTW, an 8 hours port toggle test passed. With this setup we don't
need to add dirty patches downstream.

Thanks,
Daniel


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
