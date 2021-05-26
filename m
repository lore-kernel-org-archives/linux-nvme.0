Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6626C47087
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 00:39:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0C761417
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 00:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0C761417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EP4nqnv7sYKdt6zj3TqdBu2bDwWGYroXMun//Wr+NsM=; b=tRBk14fPaaP40y
	g8sTX/juKIAh13mRlQoI3N+aD6j8CXpiafozeK/1fKZX70Y2Uo76MOy5+gLG9s4qrOiYDYYjsxbwa
	t6f/+PyCp5tWysdxOAiVUELscLp4vs6eBHUrA7DCOJ4Jsw+UkqWsF17bqyD65uik5AxyChTElkg+F
	YuPk+IbjN9pW4iaZaDAmaeymktc2FNMAwr+gHLAs338D6jFZA+DLHpKkM1J1O5ad444NtzZAgGmvp
	5ANxSMdcnqo7rlKRyVWM8R9uoSqAn3jUQWNVdiugpweCf4wMB4D07Tu4d5kmCWnjymHZ5owy6kioO
	xvKPCwPUgYQ29yPkT1ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llhZj-009Xo8-AO; Wed, 26 May 2021 00:39:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llhZf-009XmQ-SY
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 00:39:05 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4708E61417;
 Wed, 26 May 2021 00:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621989542;
 bh=qPLt8mOSoE1aybBKZtUhKhacTN+oQWJB6bKKC3DTDTs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cWNfRyBSZyHW7cHcdFAFFwFLqsvXeJp7mOsQ3Accjd0TTScin3sf7ZAmaX5Q0tEwK
 GxzLIIchlVni+e1VD3RcD2HjY6BwdnWF1jMLvJkTW7BP7V97XixyJB8LDK0RE/EZa3
 COuzZ94mbthFDsomDgllKUoIFaFGtlDSfk6WLzSi3dshw7oSm8I3lCgk/miiAj1XZh
 8s6G95o+bY28tXv5Xy4dn4Z9xd/GOGdHkKGweKJ0ximS7/qM6cIAkxsJbRv4sQ5QVf
 FBKo5RE0smJ/TBLulyGqisj/QKLhwt6Xi9mwVeoRC2fQ1rMzCYerxRMbSeB2o2QDn7
 v5uVzWAAl3nIg==
Date: Tue, 25 May 2021 17:39:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 4/4] nvme: code command_id with a genctr for
 use-after-free validation
Message-ID: <20210526003900.GA3704949@dhcp-10-100-145-180.wdc.com>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <20210519174340.1144806-5-sagi@grimberg.me>
 <57030aa5-976c-8d0c-b6ee-7c69fb5f807c@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <57030aa5-976c-8d0c-b6ee-7c69fb5f807c@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_173903_972879_C597990D 
X-CRM114-Status: GOOD (  21.91  )
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

On Wed, May 26, 2021 at 01:50:29AM +0300, Max Gurtovoy wrote:
> 
> On 5/19/2021 8:43 PM, Sagi Grimberg wrote:
> > We cannot detect a (perhaps buggy) controller that is sending us
> > a completion for a request that was already completed (for example
> > sending a completion twice), this phenomenon was seen in the wild
> > a few times.
> 
> The bad controller should be fixed.
> 
> In the past, I've sent patches that check that sqid match in nvme cqe to
> protect faulty drives that might send
> the completion on a wrong msix.
> 
> My patch wasn't accepted since it added an additional "if" in the fast path.
> 
> Now we're adding much more operation in the fast path because of buggy ctrl
> ?

I shared the same performance concern on v1 on this series. I haven't
been able to test this one yet (only have emulation for two more weeks).

Hannes says the bug this catches happens frequently enough on TCP. If we
don't catch it, we get kernel panic or corruption, so we defintely need to
do something. Sagi correctly noted this type of bug is not unique to TCP
(or even NVMe, for that matter), but if there is a performance impact on
PCI, and no one so far reports such an issue, I would still recommend
this type of mitigation be isolated to transports that actually observe
invalid CQEs.
 
> > So to protect against this, we use the upper 4 msbits of the nvme sqe
> > command_id to use as a 4-bit generation counter and verify it matches
> > the existing request generation that is incrementing on every execution.
> > 
> > The 16-bit command_id structure now is constructed by:
> > | xxxx | xxxxxxxxxxxx |
> >    gen    request tag
> 
> Is this new specification for command_id ?

The host can put whatever it wants in this field. It's an opaque value
as far as the controller is concerned.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
