Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD23C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 07:22:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B711F20639
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 07:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W1kAmkNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B711F20639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gvvrY/tw56o2DwMhy+JCHrhNjzL4/HO2om0vsHCDJmE=; b=W1kAmkNBleR6JrMukdLz8LnCi
	O7+ujRi427HG3lTnjxV0fHoFeCY+1So+v2uLQxFTTjKfsFWB3ZTiEX4CYzfrt/bXj2aSVgD1H9Db1
	7BUARVpdeeYeAkIDV6wGNNi/b3mwF6v+7T/QFH/c1qUjU2Yie3IznkBCIgd2ZFBDRmtgwNhStPQAn
	YF8lGiRUjWuinqk7OSOsisIVVPEoQ2ZHr903R5/z3/HqlOwZkb0W2Yy3ynTyDQ9RXEau9ouRV/kwi
	UDTjrU+qttFTH+Ibxwq+1V5kp9RlK4kjZ39IoY8k0X3w3dyre8FJ5sdxEN3T4m80DR5OJEQECFeSW
	SQzSaOVcA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6U2R-0003JG-PM; Fri, 14 Aug 2020 07:22:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6U2Q-0003It-18
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 07:22:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2310E68CEE; Fri, 14 Aug 2020 09:22:03 +0200 (CEST)
Date: Fri, 14 Aug 2020 09:22:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 1/8] nvme-fabrics: allow to queue requests for live
 queues
Message-ID: <20200814072202.GA2429@lst.de>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-2-sagi@grimberg.me> <20200814064414.GA1719@lst.de>
 <27f60468-269a-34d8-9e51-920106c3a139@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <27f60468-269a-34d8-9e51-920106c3a139@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_032206_228023_F28EE11E 
X-CRM114-Status: GOOD (  13.70  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 14, 2020 at 12:08:52AM -0700, Sagi Grimberg wrote:
>> Which will still happen with the admin queue user passthrough
>> commands with this patch, so I don't think it actually solves anything,
>> it just reduces the exposure a bit.
>
> The original version of the patch removed that as well, but james
> indicated that it's still needed because we have no way to make sure
> the admin (re)connect will be the first request when we unquiesce.

Is that whole thing really a problem?  All the pass through requests
are inserted at the head of the queue, so how could something else
slip in before it?  If we have a race window we probably need
to use BLK_MQ_REQ_PREEMPT or something like to force executing the
connect on an otherwise frozen queue.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
