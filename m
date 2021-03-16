Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84877C4321A
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:03:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10DFA6512E
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DFA6512E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cjL960P0b1FfGs8r6jmP96Ci/LtJ4Kr/knwQZ89ps6c=; b=GO5Zslsr+eWNcjjybXWardMo3
	52tw8On/c624kDglxDndIXjeXQ0AVge2kIsEG1/WxJVaNVmQJozzAvP+qnyHSrddAMp7eQZ3OpmCM
	7HRm46PhAgKzur0HzA4oDE3ZWrlfbO7wGjtvRYqxmrnkCzVenT96faGXDjkoNNWGb6WjH3FFPeu6I
	wyrCuGmuOLcNkTiNegbrKuc8kATVotcpB6ufOsyuSh9DKFRWRW5pdJL/wtMFH41ZFkNVKyiG3qHk3
	Gu4aG+UjURkhJhYE/OwMHZksDi/oUKklmSLTT1bvHaKeJffSS83E0o6ksfSCR8NdV2qIBUDrL+S1M
	6469YCn5g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lME25-001Wbm-Se; Tue, 16 Mar 2021 18:03:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lME1z-001WZl-7N
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 18:03:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A629168C4E; Tue, 16 Mar 2021 19:02:55 +0100 (CET)
Date: Tue, 16 Mar 2021 19:02:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 1/2] nvme-pci: allocate nvme_command within driver pdu
Message-ID: <20210316180255.GA30086@lst.de>
References: <20210316170632.4161183-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316170632.4161183-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_180259_993422_458AE5DF 
X-CRM114-Status: GOOD (  12.61  )
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

On Tue, Mar 16, 2021 at 10:06:31AM -0700, Keith Busch wrote:
> All the nvme transport drivers had allocated the nvme command within the
> driver's pdu except for pci. Align pci with everyone else and replace
> the stack variable with the pdu command.

At some point in this series nvme_request.cmd should become the
actual structure instead of a pointer so that we can remove this
indiretion.  I'd be tempted to just do this in the initial patch,
but I'm fine with any kind of patch ordering.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
