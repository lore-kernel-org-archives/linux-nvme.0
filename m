Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A633C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 05:56:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 635E6206D4
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 05:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tzOqfIV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635E6206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vJc+U0EL1N1A2A4wChYMxfNQ8Pg7OrYu/Q8VU91VFmI=; b=tzOqfIV9P8bEPuoU/39VvhOSF
	O3cu+bex0ulxltpw2v2ByvRoSrRvYudQ24NVfNwOpynse4HdT0q3kNDwUg6S6w0FmgciS74CTT4aI
	K+aRJoYBXZH49kqfXJEEvoqv2C+buf4SDEm1BYM8Zd+5JeH28dYLQHhM3lR1VjSncSpkZGIWi1u/n
	OYuC+qgfFxhAvUcbjBW+LIAfmewww+XbDUyHrX2fIyprZOpfaWl26qcXnSzaJfKHivjRSKMcXyP1w
	ODY9yK9YjaIcWI7U08CxmhzHce3mU0s3dzwl6XpL/0jKDacxP/8UFpd7DHDCLLfiUrGRV9rK8o/Vt
	4z7MXNTRg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0f4z-0008UV-W8; Wed, 29 Jul 2020 05:56:42 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0f4w-0008U2-TK
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 05:56:39 +0000
Received: by mail-wm1-f68.google.com with SMTP id k20so1677957wmi.5
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 22:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G4jFF3+FCH5FuTWfXS8YmcvUrlyslMK7MecyKod/9NE=;
 b=auwWjwl91CxCqKyqLGV03zVUAvIOIv0eckvb1MwxBqbBmNsLDx8FLJ3AeeDnhjPGQ4
 G3MEHExbtz67JVtLCjkpBulI0TN8fYzgkmpJTvwImLNfISe8m8PadRlJx2YZHWisuNlD
 pkKwxwq5zaaTLiXft7PeHijKetvfLE/ZU1c4qVrs3FtwlRDAJiThBIpJAz2jnKLq4+lh
 /wjndI4TzqGVPxN8zGKTqokhSv3XtAfPsKvUrrY1dtu6TfNfF0Fc1OrYGSfTjO9WxsGQ
 3hASTnMM/tVdQI0K9FVCipgp7glXBDo4xlXw8HBw88V/vpJN+K8WVSGdJntC9AdGwgZ5
 3lcg==
X-Gm-Message-State: AOAM532q8EuNLDL5rV4da1TEOmvAcON35MUVh17lrGoS6cnPLAOzAldD
 b18+4R1dhbjOohLdK0JDDOZY+49q
X-Google-Smtp-Source: ABdhPJwPRF6WLD/U+pU8aSVNuuuHrGyFc3h+l2tp/SkRw6O/MdUgtvAR7Jp/nOrppOCvM34mex/eYg==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr3587188wmc.26.1596002197539;
 Tue, 28 Jul 2020 22:56:37 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8475:db3f:c2a2:c61c?
 ([2601:647:4802:9070:8475:db3f:c2a2:c61c])
 by smtp.gmail.com with ESMTPSA id t25sm2440772wmj.18.2020.07.28.22.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 22:56:37 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: add a Identify Namespace Identification
 Descriptor list quirk
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
References: <20200729054420.9049-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ac6b812b-1133-b53e-397d-e4842aa88ede@grimberg.me>
Date: Tue, 28 Jul 2020 22:56:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729054420.9049-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_015638_994581_77017F96 
X-CRM114-Status: GOOD (  11.81  )
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
Cc: Ingo Brunberg <ingo_brunberg@web.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This needs a fixes tag to catch the regression that exposed the quirky
controller.

Fixes: ea43d9709f72 ("nvme: fix identify error status silent ignore")


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
