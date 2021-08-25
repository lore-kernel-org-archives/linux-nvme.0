Return-Path: <SRS0=n325=NQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41387C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 13:05:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC67261037
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 13:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC67261037
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YFDbyJ3YiQ0gaNxfNttyvM4X7kMpc3Zhuyp1N5wPWpY=; b=CD/rZlMBYTabyt
	+8hkxvR7nrhxBkusPdgO2/6IYnP7ZLntn6lxebhFEIGOobU6J+ov1F69UoRNFYqBTRMk85l6exs6+
	FrpH+khznD8Tj3Apjsuksb4zu9DR7UqYxmYEiHHw+JNF68iAEYiHRA7Rry8fef1Nzm1jtVxdjxKv5
	FGyo9zAScAw0RNAWQvBPU5teKE9XzmG0MsmPlYpZ+WyjRe2d5i5ZCtMHHYs6bJRQEduAWD2w3rmSv
	SotXthGNW+B7HUhjri44/nwHnnwE8YgRiLVEdJGFK8uGVRrAdLEcOiMLJG2qNSs1tkRF5FaRsnhNM
	r06brnW57M0sJaCcemLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIsa4-0070j6-6l; Wed, 25 Aug 2021 13:04:36 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIsZx-0070gL-8U
 for linux-nvme@lists.infradead.org; Wed, 25 Aug 2021 13:04:33 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C7C63221A6;
 Wed, 25 Aug 2021 13:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629896663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ihsN4xOKUhY3bLwnMqowm8Mza45SPZ5/Nz1hzigkS5E=;
 b=Q4heCSpauOFtmTxA1j8v01hm93NGSHPEoSkME7BXMvXSYMBzhddDXB+eH90A5T+0rvvpx1
 jCyW4gtQ9eGpJeUd0fPeHU8W/SaJTY8wwdRt0f56++NjsWlmf3inxAEOcl4GgU6OxM7A6R
 qeFHtyZG1OzfP01ldtbBGUZHvlU4KnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629896663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ihsN4xOKUhY3bLwnMqowm8Mza45SPZ5/Nz1hzigkS5E=;
 b=BEj/qJuDaLlxNbgQhHSvcOzi1ix9No6GdBxuPJ7zxPUFo4h4NLx1snItJJBMKlVgRZp/JN
 Ek0vZa3B0jlb+tCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B740513887;
 Wed, 25 Aug 2021 13:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id 93OOLNc/JmGFNQAAGKfGzw
 (envelope-from <dwagner@suse.de>); Wed, 25 Aug 2021 13:04:23 +0000
Date: Wed, 25 Aug 2021 15:04:23 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH v6 3/3] nvme-fc: Remove freeze/unfreeze around
 update_nr_hw_queues
Message-ID: <20210825130423.7tpeysh4xtcy2ark@carbon.lan>
References: <20210823112351.82899-1-dwagner@suse.de>
 <20210823112351.82899-4-dwagner@suse.de>
 <025942a6-4f57-b005-eb77-e9eed143522c@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <025942a6-4f57-b005-eb77-e9eed143522c@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210825_060429_493107_C6A116F4 
X-CRM114-Status: GOOD (  12.65  )
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

On Tue, Aug 24, 2021 at 01:38:20PM -0700, Sagi Grimberg wrote:
> > freeze before calling update_hr_hw_queues". It's not an exact revert as
> > it leaves the adjusting of hw queues only if the count changes.
> 
> I see that fc doesn't freeze the queues, so it obviously wrong to
> unfreeze them. But is it correct to not freeze the queues?

nvme-fc is draining the queues in the error recovery path
(__nvme_fc_abort_outstanding_ios). There are no request in the queues
hence we don't have to freeze.

The only reason to keep the freeze/unfreeze in this path would be to
make it look alike the other transport. But it would be a no-op.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
