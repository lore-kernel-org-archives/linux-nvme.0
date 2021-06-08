Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B35C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:26:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7536023E
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7536023E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZvXxoPTMzX0ck1/vVtMYRbgMCRF8VrdGubCgylYLV4k=; b=eUOqGjVQeUGTJz
	3iSbePqxBZ9eRyCR8FKcRCOwuxTCg75KnR+zVpayR7+5RcuWY1PxbBMh4t3C7svfD0ZEVorIxV3fW
	xADlW16DeDv6vwfWY4Y270kEvAIexZojqqtQZ/58UUPhVlVb+piBuxRxbWviPb55g8SaehjDCeaII
	+1haf92l1fhjIU01q0sRPuHhAieE67xzBtH1UxxmnuOfghe7zyMDusSIM2LSVvIXZ1dX+jTLf+vUu
	m640SzCGMJJuGqj77GHCb9/LNPppNgIlgIh2Zr62IAolsBvPbUhRNCaCtBQo5aCBHW31klUprHNe+
	Bq3Pg+xu2Qc6w3PiKrPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqUFi-006XU4-B8; Tue, 08 Jun 2021 05:26:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqUFf-006XT2-H0
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 05:26:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E9B8867373; Tue,  8 Jun 2021 07:26:07 +0200 (CEST)
Date: Tue, 8 Jun 2021 07:26:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, axboe@kernel.dk, linux-block@vger.kernel.org,
 Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 4/4] nvme: use return value from blk_execute_rq()
Message-ID: <20210608052607.GB13828@lst.de>
References: <20210521202145.3674904-1-kbusch@kernel.org>
 <20210521202145.3674904-5-kbusch@kernel.org> <20210524080428.GA24488@lst.de>
 <20210607165827.GC21631@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210607165827.GC21631@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_222611_736782_49BED489 
X-CRM114-Status: GOOD (  18.08  )
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

On Tue, Jun 08, 2021 at 01:58:27AM +0900, Keith Busch wrote:
> On Mon, May 24, 2021 at 10:04:28AM +0200, Christoph Hellwig wrote:
> > > @@ -168,7 +167,8 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
> > >  			nvmet_passthru_override_id_ns(req);
> > >  			break;
> > >  		}
> > > -	}
> > > +	} else if (status < 0)
> > > +		status = NVME_SC_INTERNAL;
> > 
> > Don't we need a better translation here?
> 
> Did you have something in mind? I couldn't think of anything more
> appropriate than the generic internal error. The errno's we get here are
> -EINTR or -EIO. Both indicate we can't communicate with the back-end
> device, but these problems are internal to the target from the host's
> perspective.

Ok.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
