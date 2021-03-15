Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB50C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:44:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FD064E27
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FD064E27
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uDM216FykP1LLcG9w27fH11Q1iqd9xmqXVRmKjxfA94=; b=lJLso6po4/RfpAHRK9ZySFTCv
	sMnOA3zVirV80KkJsevjqmGiusTszBMkl4Fu4DcWbQwJF0czsUvSw4ikIaMwDrSk+uyF2u8OZXSzI
	l0Q7YaDrOjTRwipABFOomJ8czKw19H0mbmCauxwonBbt2AIMaahhu+Y6X26o5p3ShMVg0qy50DSw6
	G181K7r+Ymso3NE6H9Vv6DLhf3zFb9KgtCFC+2L7po9QWA4g6z4IQ2MMFi6lnGFfOGESenKMFUptV
	MdrUAT2KbJU79FKhnr8rWzc/gz9Lv3X5cKXhBytMmtYEIu1qvwo3PSWhG6AkAQ3UaNW9YF/l96e1E
	urtQpvSGQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLrG5-00GZhJ-UH; Mon, 15 Mar 2021 17:44:02 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLrFW-00GZVz-CT
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:43:29 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1615830203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOmyqqNlncmFIQZ1lnmYKLcXfnYbqjUl1VeBLe6ss+U=;
 b=EyweMNbnQYeQKdGRS8J7aNUKNCtAqfqPGChz4vBCRmhlyNPsRly1ycQ5Rk4kfAAtKvrTsI
 uLQ9igrlQvO4pHblHsWv8lFhfTOVm7ce9fGCTXun2BFdqA3vLNSpFpOGn07MztJrb6Q0rt
 ZWrL8QR2vQAQJ/GMST54EYf/0A6OiW8=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B2A86AE3D;
 Mon, 15 Mar 2021 17:43:23 +0000 (UTC)
Message-ID: <ec36e8e054c5a6b59e67f780be7aa4d88a518194.camel@suse.com>
Subject: Re: [PATCH 01/10] nvme-discover: lookup existing persistent
 controllers
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Keith
 Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, 
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>
Date: Mon, 15 Mar 2021 18:43:22 +0100
In-Reply-To: <b7f98f09-c21d-579d-c925-5b511796c7f5@grimberg.me>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-2-mwilck@suse.com>
 <b7f98f09-c21d-579d-c925-5b511796c7f5@grimberg.me>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_174326_778610_9754C4C8 
X-CRM114-Status: GOOD (  12.99  )
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

On Mon, 2021-03-15 at 10:38 -0700, Sagi Grimberg wrote:
> 
> > From: Hannes Reinecke <hare@suse.de>
> > 
> > If persistent controller connections are present they should be
> > preferred even if no --device option is given on the commandline.
> > To avoid selecting a temporary non-persistent controller the
> > 'kato' attribute is checked; any controller which does not have
> > this attribute or for which the attribute is '0' will be skipped.
> 
> Why?

The idea is that an existing non-persistent controller is likely
controller by another process, and could be disconnected any time.

> 
> You also need a fallback in case kato is not exposed in prior
> kernels.
> 

Agreed. That's handled in patch 02/10. I didn't want to modify Hannes'
patch directly.

Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
