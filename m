Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0992EE80AA1
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 07:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nha255vNUUb3BKJIA9k4YNw9DwAU24wh8mxriM51OuA=; b=XQct9IpCj9a+NinrPqJ6sK9med
	XkOYJHy4qzv16nfTPzWRsCZQJKLdTCdsSvTBWs3JGG6PVmV/4MBK7QRrsQUDm3u+mQMpMplMlJJpS
	BZ39dt0kJS0SUCZImF39tGE/ZiE6/hKNha31jFhxptdj+QBF9DHVZWAxAKA79vi5VAln19NYGbJvt
	rFt0vZAHd0BXK5IM16EBzUFXQk+2Ly10SnYeTlelbQKi/VwSNG8UFUiWQO1P35bkbm64gR9C+k3Vl
	+y7AVX3euZ63w0LcCMt9DlvMhX4X9j5J6//NPGVD5NnegQmAEbs746lfWEhkEen56JrAWbY7LfDPW
	e5baRSGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlPB0-000D8L-2a;
	Wed, 27 Sep 2023 07:41:42 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlPAx-000D7R-3B
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 07:41:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E043E2189C;
	Wed, 27 Sep 2023 07:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1695800497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nha255vNUUb3BKJIA9k4YNw9DwAU24wh8mxriM51OuA=;
	b=UWjuYQZAwBJFqHxYTXn9uUi0j3sfNHEdb0+HWd8WnhkdRK3TqIml1ky6tCXFEnKFuS9ZX7
	QcWfkJigceZ2UlwmJAV2h2qLAZVTmjP5taI4nKI6B3SzzOmKjEdG5I5w2VMa95eIvl+9TB
	ja2saZWOS82Za3Ug2EjgjqzhbHCIUjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1695800497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nha255vNUUb3BKJIA9k4YNw9DwAU24wh8mxriM51OuA=;
	b=64axTb6DiC9Lp+mN/wa2iGnowZpXj/3/MSafR3XIdGEU0WZ22WR69GFLV/B6qGGtqsQnsA
	wFqrkyeFRp0YwDAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A2AD1338F;
	Wed, 27 Sep 2023 07:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id gV/wHrHcE2V9TgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 27 Sep 2023 07:41:37 +0000
Message-ID: <5df9a1f8-fb2d-4819-88a8-a3f3c32cdab5@suse.de>
Date: Wed, 27 Sep 2023 09:41:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-multipath: add "use_nonoptimized" module option
Content-Language: en-US
To: "Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
Cc: tsong@purestorage.com, jmeneghi@redhat.com, mlombard@redhat.com
References: <20230925163123.16042-1-emilne@redhat.com>
 <20230925163123.16042-4-emilne@redhat.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230925163123.16042-4-emilne@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_004140_169414_31286290 
X-CRM114-Status: GOOD (  12.20  )
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

On 9/25/23 18:31, Ewan D. Milne wrote:
> Setting nvme_core.use_nonoptimized=true will cause the path
> selector to treat optimized and nonoptimized paths equally.
> 
> This is because although an NVMe fabrics target device may report
> an unoptimized ANA state, it is possible that other factors such
> as fabric latency are a large factor in the I/O service time.  And,
> throughput may improve overall if nonoptimized ports are also used.
> 
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> ---
>   drivers/nvme/host/multipath.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
No. Please don't.

There's a reason why controllers specify paths as 'active/optimized' or 
'active/non-optimized'. If they had wanted us to use all paths they 
would have put them into the same group.
They tend to get very unhappy if you start using them at the same time.
(Triggering failover etc.)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


