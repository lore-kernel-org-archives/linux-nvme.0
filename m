Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1573C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 22:01:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B126F60F48
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 22:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B126F60F48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WUIO3Xhdsykn6u4f8qVRORem/mtqkdEDRV2yqOUiW/4=; b=XG8WHfd/jX7RH3
	aG5KP+yT8VuJiCuoVJt5//H3CpleTgvvtfpFdWQHKQLZ9PSXp4h1hi+RQVym9j5DfvNvJHtJk07Wn
	y/pOfNZNmJ+x/C+N/ue1r5IiQPhgrPFtTL9wceTYPoNruixK4UEWLArHugVWqOxv4BhLjykrJ/3QO
	NNxXqS+9f4vB1iWjo76+s/k2kLJxwntD21G2tLxh/YlVRzPZwMmA1RYASDuKUNQx0t0UHfO5w3E4s
	21HSlw+62+bhmj8FlqOxWzyhXbhibKvFOyKU9ttUYLIlu2JVSpIxjFyjkdQ9KeYeCqZuGJzLkThxf
	ovO30ewBEAA9/S7Zop5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQGUf-007Er4-Pe; Tue, 14 Sep 2021 22:01:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQGUd-007EqD-Jf
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 22:01:32 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC54A60F3A;
 Tue, 14 Sep 2021 22:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631656891;
 bh=MuLjlcjJDljDHO2s75ehvGijd9LFxUCgdW1hac4gDjM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iRtjXTLuIiS73jhgwK7BSq4gBvAn31WIUiQ2lI1p0aEx9X865xXCQWBBGY0TmmkNO
 rG3UHZ3Vpg1qF1TwwDbCynOv4UIeo9kNIPxK2n56uL8k1E/qrXnPgNKFLxFWqidKYb
 LstbyA4vB2Fvp6ZWFuc+Jjakz1z3EJT6xj3RatKiA1MpnHcyM99sRQp3V3bIZBNbIt
 d1KSwtQZUqjsyMTsvZWjDeYmG061nz6n966dnuBZpwm2wdQyXO3zF2KdymIQdDZhcw
 YIDjcN6wzV/u7BcaRzRbH8ILKI2uCSFP5m2YoTPQA8hUcfHNroUoj1pcKKQkMyD8JP
 o3CtgTHOYfbtA==
Date: Tue, 14 Sep 2021 15:01:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-tcp: fix incorrect h2cdata pdu offset accounting
Message-ID: <20210914220128.GA3778445@dhcp-10-100-145-180.wdc.com>
References: <20210914153855.16177-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210914153855.16177-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_150131_724747_B6608CDE 
X-CRM114-Status: UNSURE (   8.98  )
X-CRM114-Notice: Please train this message.
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

On Tue, Sep 14, 2021 at 06:38:55PM +0300, Sagi Grimberg wrote:
> - Keith, can you ask the WD team to test this as well?

I'll send this their way, though I understand they've a bit of a backlog
to work through so it may be a while before I receive test results.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
