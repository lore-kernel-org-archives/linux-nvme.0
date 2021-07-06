Return-Path: <SRS0=sCQG=L6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DB2C07E96
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 08:46:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961116121F
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 08:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961116121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CJCB2id4WtAXgXm/Tid2GoRvwTFVogzKc9lsXFo3sqY=; b=EuJdlsIBVAsF5E
	BcX2xZB5LMeX2jXHvBw6el2laxHnzIVQthj84YEPedFoLgHTRvyIEnTYVODsKe2r6hszklK1+CKxY
	XJscaQpgdLBIBAL1OLaX6SGdbDe6C9ASC7YzgC1VD2grQ2A6nEJqREcwoJry0cM78L8vjNTf8eZnA
	PK2u+EYMcsNygDtamRyo1GqpKmO3QotdkDruMLQu2XuuaMd7J9pl2+ioNH8L+z2q/26wmT99roxu6
	U3Y/ue6W2xPHeB7tyvpZKn7UcVkXW7VYaPCn5jdbzAyOR8Du1k8W3xxhzfivFNNga0EwVmAiuHV0F
	ZnrDfW5aeF5ux16WA+Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0giE-00Apid-R5; Tue, 06 Jul 2021 08:45:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0giB-00ApiE-Gt
 for linux-nvme@lists.infradead.org; Tue, 06 Jul 2021 08:45:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625561145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TmP/CP+r95G7grSdPIW18dia2dKSqY5syV3kf7Ux4EM=;
 b=GdSW6oqNEcupBQEiXETQCqhfTDzKZnkfTVyfMv4WAbmA7JUxu6A95OEcN1LEoboPa49IlM
 Uy0KnoN01TsCOodNR0hxc3cPK+lg475Zx9DXBQVt207D3Q8Z3xjxUtNuCIUfncRoHUudpd
 +EPDGI7QLZ/i2wL8R22d/VJlV019LvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-_MVr4dIrOki0r5CkufaFbA-1; Tue, 06 Jul 2021 04:45:44 -0400
X-MC-Unique: _MVr4dIrOki0r5CkufaFbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD0AC9126B;
 Tue,  6 Jul 2021 08:45:42 +0000 (UTC)
Received: from T590 (ovpn-12-27.pek2.redhat.com [10.72.12.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84E6B2EB17;
 Tue,  6 Jul 2021 08:45:35 +0000 (UTC)
Date: Tue, 6 Jul 2021 16:45:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <YOQYKn+POVR2g/h1@T590>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de> <YNp50pmlzN6M0kNX@T590>
 <20210705162519.qqlklisxcsiopflw@beryllium.lan>
 <YOQGRwLfLaFGqlVA@T590>
 <20210706081010.dqmg7bxik5gnym5k@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210706081010.dqmg7bxik5gnym5k@beryllium.lan>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210706_014547_696120_6DBE6CE6 
X-CRM114-Status: GOOD (  17.06  )
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

On Tue, Jul 06, 2021 at 10:10:10AM +0200, Daniel Wagner wrote:
> On Tue, Jul 06, 2021 at 03:29:11PM +0800, Ming Lei wrote:
> > > and this seems to confirm, no I/O in flight.
> > 
> > What is the output of the following command after the hang is triggered?
> > 
> > (cd /sys/kernel/debug/block/nvme0n1 && find . -type f -exec grep -aH . {} \;)
> > 
> > Suppose the hang disk is nvme0n1.
> 
> see attachement
> 
> > No, percpu_ref_is_zero() is fine to be called in atomic mode.
> 
> Okay, that is what I hoped for :)

> /sys/kernel/debug/block/nvme0c0n1# find . -type f -exec grep -aH . {} \;

It is the mpath device's debugfs, what is output for the nvmef's
debugfs?


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
