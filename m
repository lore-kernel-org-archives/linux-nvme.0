Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32716C43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 00:46:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043CF208C3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 00:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sD/V14E9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043CF208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=sD/V14E9JhaOJa+GDW0L+ZEKH
	bIDvGYw5pusQwURnnZdCkH5GfYI2d3imwP57/QgYrb7hNRfjY+e2r/bbu+noqxd1+ADSBzO9HhCQx
	ENIB3PizUSTRfpUyX067WSg/g3acsoN5/4XrzeaNMZGJQMjY89iSpsC7coJQLnM6Gv4IM0ThrLLR9
	H41dTzCuvdDIG3+9zES7W3YFTsvay46BHL6jhvWSy9snGk0wCCiAkqZVgA8wWFpxh+NtRngBS7mMk
	nR8DQzpEZm/Vf5qoxZZrmbpnaYRf7XRoMctluw0ZYRk2n3CW1XfIAR90ejmZKXe7B3laCIkVfoGKg
	GUtLZe/9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifCcG-0005Ks-OP; Thu, 12 Dec 2019 00:46:04 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifCcE-0005KQ-NQ
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 00:46:03 +0000
Received: by mail-oi1-f196.google.com with SMTP id v10so382601oiv.12
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 16:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=jK8dCc/++Xj6KvwXin7dYCXf61PESeo13WC8Jnv1RJ7/HWUmZk6WjeMCw5iz3oNqn3
 XvzT91jamVI/+4/F7+3x2YqQK4eWyyad2bzy2ejo5InPkAx2kFRBb5PSS2D6D4nhRqX6
 IxhniyFyBj03MGHMhIaDSBAlEZ0dUzfOMAhE+99wYa1Qy5wxTsMaJQ+FyskYkYUZuOp7
 FcqK8kVRKZFjsJikD6NpVE3eRRfsm1UqF8xqExa7lm1f6uN2DU1uZIyj8+LT+PIiE6wp
 WC7VKFL4oK/zETZIn8ZMioeNIl3dV/4bdk3Ib+xZ1noflf5JC/pkvqbJIdiJSLYNMyok
 J4Wg==
X-Gm-Message-State: APjAAAXV21OitvLQm5pBjirvX25pLtgG05Z+o5YKC1rTJ0z86pANam30
 qADOIcleRrDKUSxTvRpVi5E=
X-Google-Smtp-Source: APXvYqzVpzmeobZHnj6w72gXpRf7c4g8pQPA7VhADSVDxuJ42NTnofK/C9oazRTqoIevcx7/A+SIMg==
X-Received: by 2002:aca:3b45:: with SMTP id i66mr4194954oia.5.1576111560635;
 Wed, 11 Dec 2019 16:46:00 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id h1sm1506967otm.34.2019.12.11.16.45.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 16:46:00 -0800 (PST)
Subject: Re: [PATCH V4 2/3] nvmet: make ctrl model configurable
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20191127094034.12334-1-chaitanya.kulkarni@wdc.com>
 <20191127094034.12334-3-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5d10acfc-5f1c-c8b6-bf96-8c43b0aa7b8d@grimberg.me>
Date: Wed, 11 Dec 2019 16:45:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127094034.12334-3-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_164602_767606_3463A89F 
X-CRM114-Status: UNSURE (   8.04  )
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
Cc: Mark Ruijter <MRuijter@onestopsystems.com>, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
