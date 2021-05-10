Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E47C43460
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 18:08:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482D7611C2
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 18:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482D7611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=k2A3fXF1BTpLumyGTdPaIKXItEOtazf93FtLxx48VPk=; b=qXL5gyQtGfh56RfzdHY0reFsZ
	AUlJ164qkspKxSygkyw7dAxOd3S9iRZ+nyNKdMrqdCaSN4hJ7SLw2wDJIlI7tpLXQFVFiqGCMmI9s
	hl2EnZI8QU95bRBpjwp4oGUq1bBh+4e/SvWwxSxFn7HK7vTdBRCc7+IGqGqYTgB21MIJKWNJ0ON/o
	yIrQDv+InoL8F5HW8cU0BFdLOGDVdEma46rFpKYcpEXBZICFuVzY5xctQK7iIRZUSQhSP+FCIvg5D
	CKdWOw/VlQLk80f6YvUZm5joyz7JDGuVySHPs0dnnEomA9oRGhK+ny0vjYYT81fKdMIkZcqYV0WEF
	xmhJwwaAQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgAKX-00FNS6-92; Mon, 10 May 2021 18:08:33 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgAIh-00FMnQ-LW
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 18:06:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=yTged4uukMIPKOc1zInVPuHMkZ3EVNdeD05HElAEyI0=; b=FLsO+3c/7EQKRpDl353gaz7vOQ
 XusoRqvMmrdgMpffZV2xviKDIof+Io9yeLwCWCNcp0vtaCu2uTFqWOP3R9T2W/3FcXj/uw4oXnpe1
 v1cb7zYONmcLwzQPkm5hlWUq4jMefil04oiGoHAdOQ22jwBrB6LSwBUvvY4tq3klvIQt8jAx6pY1A
 MwkK5xPG1eZ9XVLKxESJg5daPVn2i5+Yl3qEzq62J2xxMFz/6kg5TdPFEXPJtPbVRzsnzEn3Z4wLN
 O66d/hgc/0/Q8JMykEa/Pu9i+jDki+t/kNKn5ETskw5dNYSqceLnkIrBjJHMb2lhJ0QfoJDVQ3MNZ
 IE+xWtVg==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgAIf-0091Kl-4o
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 18:06:38 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C2DF611C1;
 Mon, 10 May 2021 18:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620669996;
 bh=eYwOX8mcpUJvGfKh14YQzA/DI56mAFMhwAZmqx7aNdU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tW6/mWDxyGLbSuJQySXNxQLtPquPdsOWO9WstCImvytvr+CytYdAJSngpnbxKYGxu
 M8iO0oaDQNj2Vvw6JOtx6W9hdFPbdvsGO8WhFza7Yp3XfHiMgETlezkCo6qfTvQBZd
 ybBU1R+5ckzjTlxoi3a65NFYvcc20ZNqJhlSEjKLRcAvnQRX48PsNzYVHCjjOWEQFM
 y06pDx8h7dUBkgIV+k2Lewj0y0Xpk9K0d4X+jrseoG/sJxLFz/hCbdaOgOr3NjkmQ/
 qMmLcW2hjcnQ8hlAgElnKIIw3WKS+duEjMPFjQQSXmU8hfUSeMaNyRvdkscv8ziQ7m
 s5INl/4f/ToqQ==
Date: Mon, 10 May 2021 11:06:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210510180633.GB1857448@dhcp-10-100-145-180.wdc.com>
References: <686a7cdc-a9a8-3700-3805-90d07db39707@grimberg.me>
 <d27ccec0-7b2c-790c-3192-96c6e2aeee0c@grimberg.me>
 <20210503142848.GB910137@dhcp-10-100-145-180.wdc.com>
 <8932c0f7-1d9d-90a0-dd9d-32ba43d03d76@grimberg.me>
 <bd69eafa-9f1d-4cdf-f1b5-8b71ffd78917@grimberg.me>
 <20210503194404.GA910455@dhcp-10-100-145-180.wdc.com>
 <ba05ff5a-b6bd-b6e4-a96b-fb9ee4e01f66@grimberg.me>
 <20210504143633.GC910455@dhcp-10-100-145-180.wdc.com>
 <76a715f5-6a37-8535-3fbe-1aa0f3a54dbc@grimberg.me>
 <20210504191441.GA911866@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210504191441.GA911866@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_110637_229569_2A5A05D8 
X-CRM114-Status: UNSURE (   9.45  )
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

Sagi,

Just wanted to give you an update on where we're at with this.

All tests run with your earlier patch removing the inline dispatch from
nvme_tcp_queue_request() are successful. At this point, I am leaning to
remove that optimization from mainline.

I added additional tracing to see what is going on, but we eventually
hit a memory issue after some hours of runtime. I've never seen an issue
like this before, It triggers in nvme_tcp_advance_req() when tracing the
rq->tag and req->data_sent:

  WARNING: CPU: 1 PID: 3428 at arch/x86/include/asm/kfence.h:44 kfence_protect_page+0x33/0xa0

I think the above is a distraction, but I can provide the full stack
trace and patch adding the tracepoing if you think it's helpful. 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
