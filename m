Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6132CC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 07:08:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E78823329
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 07:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cx5xoMgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E78823329
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=muikNSxIfecWjvpsClse8yBloaVSgKUOiXaoNT1h73c=; b=Cx5xoMgO/skftenJRuop6hpJO
	5KZlQ/xYILCQTQChiAUKSXba+mZH2yrWlGKkSSPnwZfGWl+IxqkQ4HzoKWMjaf30jq8FcCF3/sEqR
	UESVxyM+tzzNKE7TAgiKQMCdaiug/28WRpFOogO81F00o3XULhw2k1HyASFzGssxvLoPegXzBH/Rs
	zfgxv/A42M2fC64zRhmmNy4pa+X/i8APp+9fXe0QsAZ6fEev+0DRXz7wi+eQL+GIDKM3+774UTN00
	tU2VdX7rXtwMpZ9aNNdamlo4/InLyssEGrlxH1hRBW37GOGe0brzH+QADx5qTFLmp5SiUmhvhrugb
	kOVuQMPHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpnts-0007I8-DB; Mon, 29 Jun 2020 07:08:20 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpntp-0007Hp-Qx
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 07:08:18 +0000
Received: by mail-pl1-f194.google.com with SMTP id u9so3127019pls.13
 for <linux-nvme@lists.infradead.org>; Mon, 29 Jun 2020 00:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PhQn+UJ3JnbXlt1kdxECHDOqmzgS969Us1qiMpQUh0k=;
 b=KTaBVRuqt3omBWMsFyij7HLjOGwissU4wQ77OMqqvWExhIHJtfstKn1iVaSVl39Apx
 TOLZJV1SDC6Ob7bwx2HOKKAjDnaStoril8peipNWYzeG9+hwFyAZJx1Uds3m6Cvx6fIk
 bDcURyJknwIx8AysIfiwvLN2fhA9bcTAv62E0EM2SuRLqUinwxLRo7CtHUPaB1hv5WlP
 5fY0QebNPlROU0udESMhGtRJVUEcUWLqIBLTTg/mIeLa2EYduTs23ll/F6IMpwIiGvNP
 eHRF/jMlD0uykY4upGz399WF4LsXhTzMyjTEGm9PmFccCewiCMVYkeM5sNBri5QO09Oc
 thMw==
X-Gm-Message-State: AOAM532tmt+nMfolavgGJJ5uzjgVyAt81LA7F3KNg5zrbvzyipM+rY5i
 ZbQ2PnTJQtM/zdrfqKxVb68=
X-Google-Smtp-Source: ABdhPJwYHm2zuyT+MWMSKmdbtmF4E+rHL60XZ/K1Mk3bSh1HvagopzLWtpmUr2ZNrszD+NOe6XPGIw==
X-Received: by 2002:a17:902:b682:: with SMTP id
 c2mr4322139pls.273.1593414495353; 
 Mon, 29 Jun 2020 00:08:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:944d:12b0:5a40:4890?
 ([2601:647:4802:9070:944d:12b0:5a40:4890])
 by smtp.gmail.com with ESMTPSA id q24sm27957773pgg.3.2020.06.29.00.08.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 00:08:14 -0700 (PDT)
Subject: Re: [PATCH v3] nvme: fix identify error status silent ignore
To: Christoph Hellwig <hch@lst.de>
References: <20200626174629.115730-1-sagi@grimberg.me>
 <20200629064349.GB30821@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <58b278bd-a585-8240-bbea-5991cea4391c@grimberg.me>
Date: Mon, 29 Jun 2020 00:08:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629064349.GB30821@lst.de>
Content-Language: en-US
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Patch 59c7c3caaaf8 intended to only silently ignore
>> non retry-able errors (DNR bit set) such that we can still
>> identify misbehaving controllers, and in the other hand
>> propagate retry-able errors (DNR bit cleared) so we don't
>> wrongly abandon a namespace just because it happens to be
>> temporarily inaccessible.
>>
>> The goal remains the same as the original commit where this
>> was introduced but unfortunately had the logic backwards.
> 
> So how did this work all the time?  I'm really worried that someone
> this is actually going to break things.  What do you think about
> only queueing it up for 5.9 for now?

The code is broken now, the original patch was a mistake. It didn't
fix the scan/error-recovery race, but also broke the ignore we had
for pci. So I think this should go to 5.8-rc and also be picked up
for stable 5.7.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
