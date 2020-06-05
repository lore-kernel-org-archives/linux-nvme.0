Return-Path: <SRS0=Oz+k=7S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247C1C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jun 2020 16:50:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19B8206F0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jun 2020 16:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WayAqGiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19B8206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JzC0TaIlbMmaHUx86bn7mVz9D8dd1fycAgpBTl1R2do=; b=WayAqGiBvDaPX1voIDnflAXWM
	Jsh5vUbBu20ShtWtgyAx/wTfoTRXasWPB3krDnIurRRoAlSL/czmV526FeE/vIViisWCqYFH/vkbq
	bYHxqEm9EVoUh6uQ3YJGvrHojpXUJ+UAkZPRItToa3WRBmpEFPHcivHaxu9x25u8oJkKwcddtaKGR
	cZkVdpDufdJ019SeQC4LMpLN+flcZptU8LWtRJvyhSyckTFOVXRph4b18337nOXUfpyaDGHmDnqOp
	r8ZuL29iUH4/nsK9Ds4CvNDy8p5HVpe+vHmpV9js1q5WDKgrMBCfud12ck3h/yqhAtrlZ1r4TIxU/
	dlELgNPiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jhFXd-0001nB-JZ; Fri, 05 Jun 2020 16:50:01 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jhFXa-0001ki-Sc
 for linux-nvme@lists.infradead.org; Fri, 05 Jun 2020 16:50:00 +0000
Received: by mail-pl1-f195.google.com with SMTP id n9so3887637plk.1
 for <linux-nvme@lists.infradead.org>; Fri, 05 Jun 2020 09:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VsK1kJCgrVMH7oyBXBvsic9i8TY6uRk9QYBuZQjY60c=;
 b=ilvlbyHHexvfT7FDw+BVlzYIvpM6kL/qwT4stUql0v8wU1zNvensbFGXxKRPMve4vl
 QWieg8CjQk66DRAcfq/QZL0CzhMU7f+xn+BqtX6h9WG/28fsOS+g98GK9rrE5ACVnymy
 Tqbt0grRY048BLT5gszH4qyfWZCMoF2KNLXiJsQXhjMCuvW2eA8ZV/9/1ZtffnpBSj+V
 JyYiup2cdMVEKhbA6VGpeX6knMuCg9Vb7xUO59EP7Jp8RpVALZYR3G6RzTn4qs0tMepk
 UfUozNNrbC1l+83IpwUovnn6Ore1eJ4LBSwL4EKZVl4xR0ijzhhnYXuZUGamPfUTa0sR
 mPmg==
X-Gm-Message-State: AOAM530nbOZm6pk+h8b0KdX7R+kWK/mrlBf3mAY80LPP4i3F2MzKGNNq
 eOKqIBd4hawiguO6V4NDRb4=
X-Google-Smtp-Source: ABdhPJxZSK33tH2NFW4qvUuwQvaKpnKLbnGl0noA0rz2MT2Ofz2YyUvk1l+V02Ap8W1dX254hrqXxA==
X-Received: by 2002:a17:90a:2270:: with SMTP id
 c103mr3823175pje.184.1591375797450; 
 Fri, 05 Jun 2020 09:49:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:29e8:cf62:7c9b:35c2?
 ([2601:647:4802:9070:29e8:cf62:7c9b:35c2])
 by smtp.gmail.com with ESMTPSA id j15sm8697101pjj.12.2020.06.05.09.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 09:49:56 -0700 (PDT)
Subject: Re: [PATCH 3/5] nvme: replace transport name with trtype enum for ops
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, james.smart@broadcom.com,
 chaitanya.kulkarni@wdc.com
References: <20200602131546.51903-1-maxg@mellanox.com>
 <20200602131546.51903-4-maxg@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <95ef47bc-bd1b-1935-fd03-9470e033f265@grimberg.me>
Date: Fri, 5 Jun 2020 09:49:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602131546.51903-4-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200605_094958_924307_4818937F 
X-CRM114-Status: UNSURE (   9.80  )
X-CRM114-Notice: Please train this message.
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
Cc: israelr@mellanox.com, nitzanc@mellanox.com, oren@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Use common code to map transport type to transport name instead of
> duplicating logic.

I'd prefer to keep the driver ops name and not rely on the trtype,
userspace passes a name so I'd rather keep the transport registered with
a name.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
