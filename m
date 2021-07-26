Return-Path: <SRS0=7ItS=MS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79994C432BE
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 17:27:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359C360F5D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 17:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 359C360F5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fB4SvGIRRd5w5+aLhsXN0l+UE2j0/MzuiAL8JZUmFfI=; b=3m9CP6UOsWZfqN
	7VIhG+OP2aQsokoDDIgnDeNQhFmnI9dATIXpneq2i8RWWZxWgputv5wGIquQX9RelBgZibPtL5eOn
	xYOKvteo8ap93nmuu6B+MFaYP57qNXTUMKjeiVIxhEal7H+bg1LNp7t/A2eaGMdM2lpzdZLDwUtQ8
	755RAOQSBDsDw0fegZRJf2itvV4oHDerpQbkhJ5PWTLKlV6IELpPvX3cn8OHi2xzIVB1OesGD+Krk
	/FqtlQNhvOfOY9LKyFSI+cBRKB+r5iFm2xhoDj/Tpg6UHGvQ2PunUzPC9qjx4Jadx87Wm89baSQCl
	387lG0/LBGjp1J74QPCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m84Nj-00C6bI-1U; Mon, 26 Jul 2021 17:27:11 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m84Ng-00C6ap-3g
 for linux-nvme@lists.infradead.org; Mon, 26 Jul 2021 17:27:09 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 055E61FEC6;
 Mon, 26 Jul 2021 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627320425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drwSswYjaqXt+R8keQ8tn2ECB9MnkEVK6sFZPPriypY=;
 b=V+H5wEJ9xp39BB8KJSgKpbiilfRE9vbZKJFAynQScSnhOClyh13HxfZi97GV0sFmyDW1Yf
 scMxBp/DW8X5ES/7/u7oPkvB7PJGnd/IlqjL2+i6NhZZRm+z/uD6WvKVP8e6jcWlmaiTvP
 55tBOHx4DTBONm1NlXidkVTTL/WZdZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627320425;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drwSswYjaqXt+R8keQ8tn2ECB9MnkEVK6sFZPPriypY=;
 b=mN9vfW5upwlrhKcpzEtNBxpcESJP1Bqb3Ri1ba1WR6O0MMUzF/o5WOzvuCbmQ5vpwobJXP
 Ff4EmnrQJj9O6rBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E3E5D13A96;
 Mon, 26 Jul 2021 17:27:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id tAA/N2jw/mC2RAAAGKfGzw
 (envelope-from <dwagner@suse.de>); Mon, 26 Jul 2021 17:27:04 +0000
Date: Mon, 26 Jul 2021 19:27:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 0/6] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <20210726172704.j6cbv2qmox2cl2dz@beryllium.lan>
References: <20210720124353.127959-1-dwagner@suse.de>
 <20210720124800.i2lo3hal7kjfc7rk@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210720124800.i2lo3hal7kjfc7rk@beryllium.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210726_102708_346423_54A0AE9C 
X-CRM114-Status: GOOD (  11.75  )
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

On Tue, Jul 20, 2021 at 02:48:00PM +0200, Daniel Wagner wrote:
> On Tue, Jul 20, 2021 at 02:43:47PM +0200, Daniel Wagner wrote:
> > v1:
> >  - https://lore.kernel.org/linux-nvme/20210625101649.49296-1-dwagner@suse.de/
> > v2:
> >  - https://lore.kernel.org/linux-nvme/20210708092755.15660-1-dwagner@suse.de/
> >  - reviewed tags collected
> >  - added 'update hardware queues' for all transport
> >  - added fix for fc hanger in nvme_wait_freeze_timeout
> > v3:
> >  - dropped 'nvme-fc: Freeze queues before destroying them'
> >  - added James' two patches
> 
> Forgot to add Hannes' reviewed tag. Sorry!

FTR, I've tested the 'prior_ioq_cnt != nr_io_queues' case. In this
scenario the series works. Though in the case of 'prior_ioq_cnt ==
nr_io_queues' I see hanging I/Os.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
