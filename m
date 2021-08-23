Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58182C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 09:14:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9216136F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 09:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C9216136F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JAS4UwF3X1DH9hrmg5ZzEkbr9EQYSMbZv6Bch+mr0WY=; b=QQtE3jNKqW4c+w
	ZVXB9UNnmT+uHDx/Yzu3CDCJ8AsllVX4J4r8BJq3VF1dhBJryc0cih1ctba+kqD3DBqY1bEs4cUVx
	eQfbbF2JrZ6OFbClg5JL9A/1B8HhHyc1+8ND3S+0+3Im9RiJe+7oO+dM95ga9XC0GIgp4NNmtG2T1
	EGVxRRP7f2wxfgPkNGrOnbpj1vT1UCv0x5O7wLGK2Ngx9ydwtckqtCb1aA6cbDAX0cZPXvcNN+WSs
	UQ/iSW32gSPOOJMnhg+pdQ42MCjqgCcU5PeLUPIVGeg2qlA4881U/RAnrhJvjsSklKcPF5ONvoGRX
	bLwDUPnvGousqQBIDJIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mI623-00G3mV-9V; Mon, 23 Aug 2021 09:14:15 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mI61x-00G3jY-Eh
 for linux-nvme@lists.infradead.org; Mon, 23 Aug 2021 09:14:13 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 28EFC21F3D;
 Mon, 23 Aug 2021 09:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629710046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jf4RvD/mw/nbQWr8Y9Fj9qty0PSRsJZCDwZff4vyIj4=;
 b=e5X2ULVlQDy65O/CjPGxNBz/QjcZsHpbBKeGbk8jRdn28yHdab/k6Td5kP61d5/IgeDqqv
 42FRngk97eHUjHxqGBWtZPB27pJyClm3rXYHJwh/9T5AimnMbWFCqcC1fYCRh2wFZg1sgQ
 AUyCq3FuPmuUOJuKAeONyui0jD2eOAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629710046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jf4RvD/mw/nbQWr8Y9Fj9qty0PSRsJZCDwZff4vyIj4=;
 b=9bgUG/61TFYHpAaTjyONrAWKS/pIPZ/dvmgjy2+ewwQT6ss4s2K5sBUDJ7F1U4/26uMfV8
 dd8w0NzSJ+f6l4Cw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1233613A92;
 Mon, 23 Aug 2021 09:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id O/0EBN5mI2EKbQAAGKfGzw
 (envelope-from <dwagner@suse.de>); Mon, 23 Aug 2021 09:14:06 +0000
Date: Mon, 23 Aug 2021 11:14:05 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v5 0/3] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <20210823091405.pmmkubzgxodwgjij@carbon.lan>
References: <20210818120530.130501-1-dwagner@suse.de>
 <YSNV6vpaEnzc0Yv4@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YSNV6vpaEnzc0Yv4@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210823_021409_694040_8C20956E 
X-CRM114-Status: GOOD (  10.23  )
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

Hi Christoph,

On Mon, Aug 23, 2021 at 09:01:46AM +0100, Christoph Hellwig wrote:
> applied to nvme-5.15.

Could you drop these patches again? James just sent me a new version of
the series which addresses the points we discussed in this thread. They
look good to me but I'd like to give them a spin and will post them
shortly. Also James is giving them a test run.

Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
