Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF84C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 15:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=99CJJVFpdXwZKjA8J/WZPHQwZBw2iYXjy5+4OpppZOM=; b=X/5xZz+Q1WYKmKPrv1SGE1upZS
	ek2AIHIGCv9RVJ0ooUQSAkj9Wgp/AbudMPJcZ6G5T8StLikWZr+Lya9/1GqUbXEzoYuJ3Xp1Gzj+t
	zc65ec5lzN0uPHKz9o5xy8SjWr5JVxpFNkirl2eCurT2g3pEBJLGagjXvZT02F+ThbJIxEvVHCzmX
	3PMP0om/Pdx/IJ0783rfBfg0NG1jGRCCLjfhsDj9BrBDwwV9pzZNisGt++7xd7jP3Mxxd0gnnl3Iv
	1ZdM9uJHn7E+Fh1wlE95TNxrLmu1roydsOnH2ndIUy3LT74dUbVkiy69fIH2ojpco6yz7ycfpPIko
	a/fHoyrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o972y-00B3tJ-BG; Wed, 06 Jul 2022 15:34:36 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o972s-00B3oL-Pg
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 15:34:32 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9CC21FDC5;
	Wed,  6 Jul 2022 15:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1657121664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=99CJJVFpdXwZKjA8J/WZPHQwZBw2iYXjy5+4OpppZOM=;
	b=CzzbxJMzsUpdpgAbuCBHoZFy6NhaP8LgTnNIdWOz30kkPvcZC2AOf3FsFWguO9/kg8USZp
	XwEu6tOtZ/lB7/LaeLRb56supqWPeWH5AD5Zvjlua9KW9O0unAsr5sGhX3k1ZlySUb1U7O
	K0Y8X1EFlwHiNxtciwq6FPczLieS3Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1657121664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=99CJJVFpdXwZKjA8J/WZPHQwZBw2iYXjy5+4OpppZOM=;
	b=TLxnGJ6mBD6i03pQ24Gv+P/kGoeyoLC8ZGRnkL1DfndU11FVErsRTtASa0Djpg7UcCZZ26
	V989lFefUhJljcBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7298713A7D;
	Wed,  6 Jul 2022 15:34:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id KZ3oGICrxWKkYwAAMHmgww
	(envelope-from <iluceno@suse.de>); Wed, 06 Jul 2022 15:34:24 +0000
Date: Wed, 6 Jul 2022 17:37:36 +0200
From: Ismael Luceno <iluceno@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Enzo Matsumiya <ematsumiya@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 4/5] nvme: quiesce namespace queue in parallel
Message-ID: <20220706173736.2891776c@pirotess>
In-Reply-To: <Yp9avMfGDsOLIXeG@T590>
References: <20211130073752.3005936-1-ming.lei@redhat.com>
	<20220607132118.0bbb230b@pirotess>
	<Yp9avMfGDsOLIXeG@T590>
Organization: SUSE
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_083431_036261_9C186690 
X-CRM114-Status: GOOD (  16.97  )
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

On Tue, 7 Jun 2022 22:03:40 +0800
Ming Lei <ming.lei@redhat.com> wrote:
> On Tue, Jun 07, 2022 at 01:21:18PM +0200, Ismael Luceno wrote:
> > Hi Ming,
> > 
> > Has this patch been dropped/abandoned?
> 
> Hi Ismael,
> 
> The whole patchset wasn't be accepted if I remember correctly, but
> finally we moved srcu out of hctx in another patchset.
> 
> If you think the patch of 'nvme: quiesce namespace queue in parallel'
> is useful, please provide a bit info about your case, then we may
> figure out similar patch if it is necessary.

Chao Leng's outgoing email (lengchao@huawei.com) permission is
restricted; I got from him (through a couple of indirections):
> Hi, Ismael and Ming, The case: When the multipathing software is used,
> if one path failed, fail over to other good path may take long time.
> This is important for scenarios that require low latency and high
> reliability, such as real-time deals.
>
> This patch can fix the bug.

Same thing he said here:
https://lore.kernel.org/linux-nvme/cc732195-c053-9ce4-e1a7-e7f6dcf762ac@huawei.com/

Huawei is still looking for a solution to be merged in mainline.

-- 
Ismael Luceno
SUSE L3 Support

