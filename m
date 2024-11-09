Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089B5D5E373
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Nov 2024 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+kJiu77cev1UhnhbfTdtLCPogLNUn93jFhMgIk+X/A0=; b=z19g9dEh5Devk1rK1OWzApQZZw
	cxFSmn1VKQFf9/REEjZcixx7W08mFKK/8d6fg+mp7XDGYbhbv5hNpbiqYSxM+3Wj7H10vF9BFFVKU
	KuG1qwdR8e8b7GCFP56turtQfAxgkwRBW8LmC+b+BWKd8qb2yUB2ACtu4alMX7D9lqgVUdWVcXdtP
	WVbuOt68IrIOkwaDKKpqeB163FEqcJyutwgAI+skHwD+Yxy17hgngshCZVBG2qtgCYh+n+QOOVBQs
	RJk1AummUQotqKU7Y/LeP9NzJQd97D+TsfpGWSOz10/coinSLEekWg4wCBptfOBQVHMceAuNiOZFA
	QKbvnWPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9myV-0000000DVp3-37Pj;
	Sat, 09 Nov 2024 15:02:07 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9myT-0000000DVoX-1LYL
	for linux-nvme@lists.infradead.org;
	Sat, 09 Nov 2024 15:02:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731164522; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+kJiu77cev1UhnhbfTdtLCPogLNUn93jFhMgIk+X/A0=;
	b=J116lzVVGI+s6Yfcdd04MSdScEEErIKCpRxMOfZGB6o4/ReBGEF86HgBR/f7C1unqgyEb1uRK6YrjNABr7N09Bx02M15cu6j2T/QlLAmxAHGcLcLo3ExbfZEwNsElLHbISHT56cVisGLj4gyrVyWO8sMjsPNf91unGNBiKbq87Q=
Received: from 30.120.40.73(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJ0fNYr_1731164519 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 09 Nov 2024 23:02:01 +0800
Message-ID: <44dd29c6-8806-45a3-b1f0-11935b84ee65@linux.alibaba.com>
Date: Sat, 9 Nov 2024 23:01:59 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCHv4 11/13] nvme: add rotational support
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, m@bjorling.me, matias.bjorling@wdc.com, kch@nvidia.com,
 Wang Yugui <wangyugui@e16-tech.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
References: <20241107193849.995554-1-kbusch@meta.com>
 <20241107193849.995554-12-kbusch@meta.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241107193849.995554-12-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241109_070205_593132_5EAAA347 
X-CRM114-Status: UNSURE (   2.23  )
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

Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>

