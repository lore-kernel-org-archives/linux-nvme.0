Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919BCC6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 17:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ilcU16OvFM7LpQwNmc5NumytUf/NgEVBlbswBNRRrXw=; b=rn5LsNQvpws9bRJHLYZawQsiUK
	wnJcC2jijzCqYquxByHmJPpAT04D6bSdhTRIGe4Scaa/R/8MW91r4sAUBX8zt6zc9U41X3/r9jHxu
	oZJvG8oWAspfz8r3HWuKY43Jp8o7e55v7ztuROqPPpGW/YK/923pLr0u4wyEJqYiihENsjb8T+2NK
	3mzqHm9vzP+4bDLsJyaNf8+kmQrjFylOlYB0nMmjdHkGA+po+zFjU+5FC4mq0PVIr4oWL+q5TBpoo
	2mY6x8WSuoSpBo4EkB2rlxtAd0X7yWoBfFRddM/Hw+N+j3MEGUziIJEJiw413UIDJFqp2SSGQ8M8L
	En8fvQHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcrGd-00H6vH-35;
	Thu, 16 Mar 2023 17:19:55 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcrGa-00H6uR-38
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 17:19:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 6E2E0B8227C;
	Thu, 16 Mar 2023 17:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD018C433D2;
	Thu, 16 Mar 2023 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678987190;
	bh=HgXJVEMz0UKAMunpo1kCo7wWr675oIHpUVMtvr6azWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lerBTDO8iCIqBbfTTpiVLf2M1IK6YSLNq3CoWNuZ8dtxiZkZmW0aQRSVxn8VpVJNg
	 V5rjAJteb+LTuZ1HsVScBS2a4ZhraQ+PYzIKeWqZJGFbmsQYh/FkOfynBxkxG/8wkF
	 3U7JSiE11QF3rbnCzTx7Ji6jdyeE/Fc+UfeLIh/EQQVnAIuyMQG6jGOowdyPijfVKM
	 LEAO779tYMB6gM25gQ5wFYTovlCCsSdZj5BNVeB87i/3uE2F13uykKXealU2LtOR2/
	 IAqPEpEhmjrMFr4C5bpyvVtF8k47/60OyKq/deNKaQ6L2ZSBl41KX6UG8Hovvuk22M
	 8AuTuI4c3FnTQ==
Date: Thu, 16 Mar 2023 11:19:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "Belanger, Martin" <Martin.Belanger@dell.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Message-ID: <ZBNPs3ukEpbm/NSn@kbusch-mbp.dhcp.thefacebook.com>
References: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ZBJFnEY664s1Hm/E@kbusch-mbp.dhcp.thefacebook.com>
 <32741f55-f5aa-cd59-351c-df87ee2b2818@grimberg.me>
 <ZBMz1FUB3qJGKXeW@kbusch-mbp.dhcp.thefacebook.com>
 <6232d774-bc94-fae8-bab9-7151fde4f719@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6232d774-bc94-fae8-bab9-7151fde4f719@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_101953_148167_7963CFA4 
X-CRM114-Status: GOOD (  12.93  )
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

On Thu, Mar 16, 2023 at 06:11:57PM +0200, Sagi Grimberg wrote:
> > And since we're talking about this, what happens if a command is dispatched to
> > a polled queue, but has no data transfer? The nvme driver doesn't attach a bio
> > to the request in that case, so no cookie?
> 
> IIRC, initially NONE was called once, and the loop in blk_execute_rq looped
> until the completion was met.
> 
> I would assume that any other cookie other than NONE would work here,
> because the driver .poll() would be invoked at least once (maybe set
> ONESHOT as well).

As long as the cookie points to the correct hctx, then it would work.

