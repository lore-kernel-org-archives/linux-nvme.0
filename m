Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5066C25B76
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Jun 2024 22:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kdzktv4HMwYiYyc18yB9P8ibHRfxPOPvOsHdEkW5tak=; b=Nzvd3mhneT0dg3VUnX/LdF8Lbd
	jw0pRna6D+9JdRN2Uq7j9RdU4Pyy19LEUQt823JkC3mUM5CMBhLVtbEVwM2HSsgUBbdkKlMlE0DD3
	4zVsaULnk3M/71i0IAQBb8VxFYtJGGNchT65iZLBcjaLCLKrN6ZVqi4dlzQmNV2lu9I3Ol9BUDId/
	CEUaACKV6b6lY6JaeJIDBlWiFvgtJd8iswidmHmXe3q7ynTaDVOd6Xh8qJx4yYA8W0NQMioSgUs+N
	f97u/stZJpTNnzmBUneLx3l8YJ9WloBae1esZtlpCsBuYFMMH3u7r+X05ngWjUZzzj2UXtePI61kC
	DOc9x0UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDXJA-0000000DMa6-2cc1;
	Sat, 01 Jun 2024 22:34:40 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDXJ8-0000000DMZa-0rB4
	for linux-nvme@lists.infradead.org;
	Sat, 01 Jun 2024 22:34:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6F84CCE0138;
	Sat,  1 Jun 2024 22:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC77DC116B1;
	Sat,  1 Jun 2024 22:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717281272;
	bh=/7RICJIhdkyAioWDSfVcToOPLi7N+lZhkwn9ZdLZwdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qk6XOP7QLxQvaJzodYjBXICKyCzfEgMKoWWU5SAiIbhOXBRMoPxzxtGW36qKFUYTY
	 /lgnajbB7HY9YMb/JuGjrMvoPQ5asrGNOcOtsPfFxEbxOahDO2ApTq3E5kzMs9u9+R
	 S3tmpAldw7pcUxWvJh0KGWS5YSMUyyCdSUoXi406ZHFVCnl6Ruua3qdN/iaUqLAsCC
	 Vd7vTTN1qfvuCS5KgZestXPC03BlHzd+Futp2/PA4hpbMRuL1os5Yglx/0q8dD5mic
	 /B94tN1RbmdJ/e9shnyaY/YQevuckGqbZEVsFdUSFvCVLIxaGJMMebvp0unYLGI6YK
	 zdfpZ3X8A/9Ow==
Date: Sat, 1 Jun 2024 15:34:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ofir Gal <ofir.gal@volumez.com>
Cc: davem@davemloft.net, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 ceph-devel@vger.kernel.org, dhowells@redhat.com, edumazet@google.com,
 pabeni@redhat.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v2 0/4] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
Message-ID: <20240601153430.19416989@kernel.org>
In-Reply-To: <20240530142417.146696-1-ofir.gal@volumez.com>
References: <20240530142417.146696-1-ofir.gal@volumez.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240601_153438_461801_D862F5CF 
X-CRM114-Status: UNSURE (   6.22  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 30 May 2024 17:24:10 +0300 Ofir Gal wrote:
> skbuff: before sendpage_ok - i: 0. page: 0x654eccd7 (pfn: 120755)
> skbuff: before sendpage_ok - i: 1. page: 0x1666a4da (pfn: 120756)
> skbuff: before sendpage_ok - i: 2. page: 0x54f9f140 (pfn: 120757)

noob question, how do you get 3 contiguous pages, the third of which 
is slab? is_slab doesn't mean what I think it does, or we got extremely
lucky with kmalloc?

