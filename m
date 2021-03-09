Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622BAC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 10:01:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E9265259
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 10:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E9265259
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=m/IFaax8HRKdQhigkcuhFAZ6mdcXAPDdB31IxU5wL/Q=; b=libR5QaAVW5WUSlvR1ZEyL+L6
	ShxHeaicpGqNIsHuOE7RQoKmdxqQnuJmSovi/kepOInNG+FkfcxYjEPLhXdShJMwCs2nqeOA5/dWQ
	yjpDEcYxt5o4qQffXhvszX6oDat0c1UWve/SsiO+wVmcqu5O1QX4XPWdBjZRw7BgKzuLJtm9DNDiQ
	cPahNCrEn1mLuJVcwrUT1OaeAJbefzS+10QRYygbT6NH5KkdQdAuLEprTfJaMLyISYNKyA+l7XZQ2
	xT+/IFGdbXOq5PywZandMmkHSAUUs5HgfKQHVvEzReDkq5HTbl6VUGpHirm/6o9M36Ac36HAmxyzb
	cDuS2rSaw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJZAj-004A6O-CH; Tue, 09 Mar 2021 10:01:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJZAe-004A4i-8B
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 10:00:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A335768B02; Tue,  9 Mar 2021 11:00:49 +0100 (CET)
Date: Tue, 9 Mar 2021 11:00:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: [PATCH V2 3/6] nvmet: remove unnecessary function parameters
Message-ID: <20210309100049.GA7051@lst.de>
References: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
 <20210225015642.29288-4-chaitanya.kulkarni@wdc.com>
 <7cf9d715-37a7-d2df-d10e-de2215767598@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7cf9d715-37a7-d2df-d10e-de2215767598@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_100056_620343_7A2CF15C 
X-CRM114-Status: GOOD (  13.37  )
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

On Fri, Mar 05, 2021 at 02:40:34PM -0800, Sagi Grimberg wrote:
>
>> The function nvmet_ctrl_find_get() accepts subsysnqn, hostnqn, cntlid,
>> nvmet_req, and out pointer to nvmet_ctrl structure. The parameters
>> subsysnqn, hostnqn and cntlid can be derived from the caller's
>> struct nvmf_connect_data.
>>
>> Replace these parameters with structure pointer nvmf_connect_data *d.
>
> Usually its preferable to use explicit parameters instead of a wire
> transferred data structure. Not sure this particular change is useful.

Yes, I can see that point.  Especially if we want to eventually add
PCIe/vhost support.

Chaitanya, can you respin a patch to just change the return value to the
nvmet_ctrl?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
