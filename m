Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F95DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 20:46:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5156F6138E
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 20:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5156F6138E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dn76g9fu2v1zIklAfAjnAdK/Ow8n+r8ZbwB2BKOszmQ=; b=lK2lIOvncH9k3YAQtD/ev7BkhA
	OyWLTULeCfaSku+6z83YBKfiDViU6hcVBPeMr1brrwePvjPR+GbH/PXLIlchvzFpjDHkNa+aDLo/l
	uqwWlQqfhkib9Np+IH/7NIl+Rhx7R/jx+r9NPZDJoldHyvEd0T4OXrsA2QdF2JkOEXy+8N1VnBHp2
	Cc2gg1vpEzJ81KmUlFowHftjZsnujaO8mNa2zxnnC74Ix1JQCgWfFKbbSJZdH5/IjWdPDg2j45Vqp
	Y5UC8i3jpyK5lSUmWEWJCY3japVZZe6RbIN1Lcax5sQpwrmnLIosvIneNKCZAHA0s/MEFancITEuG
	XM22K7Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVJyw-008n1t-PL; Tue, 28 Sep 2021 20:45:42 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVJyt-008n17-RR
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 20:45:41 +0000
Received: by mail-ed1-f54.google.com with SMTP id g7so106017edv.1
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 13:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kU/RhnR/mTB35hRcNkYdg4Gnf/B5MqhgFk3wEq/WDYA=;
 b=bBssaV7oxnzlw0xz7iFdiXQnFRrdorOHtLq9zOwfHEq1cNQ3+Qo4EratbH+iPboBAR
 GI99RbOBQHbxQ/6tunerao5W4HbcAjKnw1w33DzV33GimOhA7exM7XilIeI+u5dsrP3V
 7jiuBKo+HszVvkN0Hnv7HxzSqo5DNm5nGK5aSltUrt27rUHX0JKz4IPKIoB/vm59nh8g
 Lv5Mt/aoWDge10ZQdg7YrqPA1i3TVjMbIInENu749iGCZ/VwO4VUYqdNSe+tfPzU2ReI
 JxPsel0oG947SkadPbzMPAJL6ApNDHQiaSDrHr438cTE4Q0V4OKiC4Wl/gGJXIxrbQe2
 72EQ==
X-Gm-Message-State: AOAM530pKV98MHxmTAUgiA9bxJCHpuzBiLOHhkgByEz6KKHUSiY2eCoq
 iYFfKsN7eFodBSYXyrFArxM=
X-Google-Smtp-Source: ABdhPJxaVN+zcbbjD/1LBXL7YhGaLuzHifWSHhYtlzTV9ZC/ZNOxTJMzQ/11Du/bmRVJLmsW5lCOHg==
X-Received: by 2002:a17:907:1b06:: with SMTP id
 mp6mr8869213ejc.188.1632861937150; 
 Tue, 28 Sep 2021 13:45:37 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id q6sm102366ejm.106.2021.09.28.13.45.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Sep 2021 13:45:36 -0700 (PDT)
Subject: Re: [PATCH V3 nvme-cli 1/2] initialize disk "access" variable
To: chengjike <chengjike.cheng@huawei.com>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com
Cc: sunao.sun@huawei.com, jiangtao62@huawei.com
References: <20210928085050.4141-1-chengjike.cheng@huawei.com>
 <20210928085050.4141-2-chengjike.cheng@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e916dbea-8796-5ed1-06f6-4d89c72f3b69@grimberg.me>
Date: Tue, 28 Sep 2021 23:45:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928085050.4141-2-chengjike.cheng@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_134539_920502_B0837966 
X-CRM114-Status: GOOD (  15.96  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> (This is a prep patch, which provides functions for the next "patch 2/2")
> When it is failed to get nvme_id_ns data from NVMe Subsystem.

If there was a failure the nsid should be -1, and all the size info 
should be zero, that is enough of an indication that the ns is "faulty".

Also live/faulty is not a good terminology for path access.
Maybe full/partial or complete/incomplete.

I thought that this was about showing the completeness of the
path access for a given ns, regardless of failure of identify-ns...

Meaning that if I have a ns with 2 paths, where one is live and the
other is connecting/resetting then "Path Access" would be "incomplete"
or "partial".. Also in the case where all paths are live, but some
have ANA state "inaccessible" or "persistent loss" then "Path Access"
would be "partial" and only if all paths are "live" and ANA accessible
i.e. "optimized/non-optimized" it will show "full/complete" Path
Access...

Otherwise, I don't see the point in adding this information to
nvme list output.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
