Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EEC105F7B5
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LJU0YUifzg+Q61M187SOuGczoNish3+SM+1TQzx24E8=; b=WnGrTj2NMffvD7djsH0ruolCqp
	0RGjsd31l2Rqp6Ifivue3ZHtqXJR6uAqjrZtCdrXCttxcGxJu/+rCXbqGs52VnopluvGTuuKSsu48
	3uPGGrh0H25LT7CT53nd7oC66bF+ipSutZA9oVaxH6ydkhhD+i544TY5KY3wTZfAyf7NXfiv81j0k
	LOmul/AzLJ0cYgNXGCihOr4DcaCE1qFzmyFi0mVwgJZqOvJSYhOvzOFA3oJUchACNaJFhVDumBImV
	0LXR5rd/1rw6Z+g31yNeGw5aD4DUUOrSoz7XPOxULyMn2iEroCO4ILNBZznMUVT8srylowh0fLzjv
	rL92WJXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w14TH-00000000YW3-02yg;
	Fri, 13 Mar 2026 15:30:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w14T7-00000000YVi-0OnM
	for linux-nvme@lists.infradead.org;
	Fri, 13 Mar 2026 15:30:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773415826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJU0YUifzg+Q61M187SOuGczoNish3+SM+1TQzx24E8=;
	b=NqsSSn5PaH93QwfTOs5s5DnU6CgNxbWnKV63eEzecuKf8fOyDbchIjExksmsSLJ3PzsxUd
	QnWiBYm0kpiIUbtvrH0QWF2Gg9I46rUgkAxxWdxA0U3znHIKcldBel585vad8UUx8VO6aV
	Ve7qt/4Oe2Ew5pJksoWMcA4pshDY1jc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-7oC3onbHPGyr0HeZNfiUig-1; Fri,
 13 Mar 2026 11:30:22 -0400
X-MC-Unique: 7oC3onbHPGyr0HeZNfiUig-1
X-Mimecast-MFC-AGG-ID: 7oC3onbHPGyr0HeZNfiUig_1773415819
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50745195609D;
	Fri, 13 Mar 2026 15:30:19 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.16.140])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3EC4619540C5;
	Fri, 13 Mar 2026 15:30:15 +0000 (UTC)
Date: Fri, 13 Mar 2026 08:30:14 -0700
From: Chris Leech <cleech@redhat.com>
To: YunJe Shin <yjshin0438@gmail.com>
Cc: hare@suse.de, hch@lst.de, ioerts@kookmin.ac.kr, kbusch@kernel.org, 
	kch@nvidia.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, stable@kernel.org
Subject: Re: [PATCH v2] nvmet: auth: validate dhchap id list lengths
Message-ID: <20260313-much-handbrake-cb4c6e4f1318@redhat.com>
References: <ec03d5ca-a26d-4427-823a-17c5709391f7@suse.de>
 <20260313052444.3865842-1-ioerts@kookmin.ac.kr>
MIME-Version: 1.0
In-Reply-To: <20260313052444.3865842-1-ioerts@kookmin.ac.kr>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 42C5_mzFRb4DSLa4q6J7DUbrF_8pucIPMuEYUNysOHU_1773415819
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_083029_222013_41068EAC 
X-CRM114-Status: GOOD (  15.26  )
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

On Fri, Mar 13, 2026 at 02:24:09PM +0900, YunJe Shin wrote:
> From: Yunje Shin <ioerts@kookmin.ac.kr>
> 
> The function nvmet_auth_negotiate() parses the idlist array in the
> struct nvmf_auth_dhchap_protocol_descriptor payload. This array is 60
> bytes and is logically divided into two 30-byte halves: the first half
> for HMAC IDs and the second half for DH group IDs. The current code
> uses a hardcoded +30 offset for the DH list, but does not validate
> halen and dhlen against the per-half bounds. As a result, if a
> malicious host sends halen or dhlen larger than 30, the loop can
> read past the 60-byte array into adjacent slab memory, triggering a
> KASAN slab-out-of-bounds read.
> 
> KASAN splat:
> [    4.241646] BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_send+0x19b8/0x2090
> [    4.242874] Read of size 1 at addr ffff8881045754e8 by task kworker/1:1H/41
> [    4.265342] The buggy address belongs to the cache kmalloc-96 of size 96
> [    4.266291]  allocated 72-byte region [ffff8881045754a0, ffff8881045754e8)
> [    4.270337] page dumped because: kasan: bad access detected
> 
> This patch fixes the issue by introducing NVME_AUTH_DHCHAP_MAX_HASH_IDS
> and NVME_AUTH_DHCHAP_MAX_DH_IDS defined as 30, which explicitly indicates
> the maximum boundaries allowed per NVMe specification. The lengths halen
> and dhlen are validated against these boundaries before processing,
> preventing the out-of-bounds reads.
> 
> Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
> Cc: stable@kernel.org
> Signed-off-by: Yunje Shin <ioerts@kookmin.ac.kr>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
> v2:
>     - Replaced the runtime 'sizeof' calculation (idlist_half) with explicit 
>       NVME_AUTH_DHCHAP_MAX_HASH_IDS and NVME_AUTH_DHCHAP_MAX_DH_IDS macros
>       to clearly reflect the 30:30 split limit per Chris Leech's feedback.

Reviewed-by: Chris Leech <cleech@redhat.com>


