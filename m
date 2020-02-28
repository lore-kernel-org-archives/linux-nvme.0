Return-Path: <SRS0=58/p=4Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47882C3F2D4
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 20:36:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10614246B0
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 20:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P94Oel2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10614246B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=P94Oel2dSsXFNlPAbkK4lOeW/
	8howSV9zKejlna7Wl2ogGqZM5nFDidhKHDXVQfGVxO5cbPwB0v57Mp2PjIJ2i7GM5Wg89mEFTuttO
	PBivcAeeg959o22BoRFXgGDHp26pWOAemg1hbfjfzgr+ngOL9nbl+76CqV8RvZA4g9f7d/N9T3Pzv
	PilcmbXucAycocJFHSzYbeqz+yG8n1IQEoYNZnHuikYqBlFBbQu1PxC125wYLut4cvWvgUjHKiveH
	zM0SmLhjgWuYZA2Hfkp3394McTTRBmSowDm/1LY0YnnHIsjFg3D42B1/X68v1HRY/duNsqvuv7s4c
	jk3c5I89Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7mMz-0001sL-N8; Fri, 28 Feb 2020 20:36:25 +0000
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7mMv-0001pJ-UJ
 for linux-nvme@lists.infradead.org; Fri, 28 Feb 2020 20:36:24 +0000
Received: by mail-pj1-f51.google.com with SMTP id i11so1688565pju.3
 for <linux-nvme@lists.infradead.org>; Fri, 28 Feb 2020 12:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=YqHLX4oRbd5cgkZIwGutPeqIiMfpTSxWtzpbUqrFjhcGpkzmWoip+YmY+Y4yrwILsH
 LRySQsHfpc20P1iwLg4OqiTQnZgw82bB2SSSZ3/CRMlQWGT2L7a/oi3rpVLByHvetlTO
 epYzXKem3evDnw+tIU+J++yz7y3tLfsjLjo1PGF8KmniAA7u3A25KQgAQc5kc0atpJ4d
 afMTghtFnzFgGeRMY/KkFpuS1O8llPKZ8xOuyu/Y7KfawxUdGTu7tQwAKdPXcZip30MS
 PVws65sIXqP8YCE5rovbP4nRPZgr8AkGsBp5zSweifF1vrvl/hS+sYnFDg84zreqWwDV
 BIrQ==
X-Gm-Message-State: APjAAAXdIJdE/TNiK29+IeCxsF9cK6CvsKPNJ3lxbcJV5hXmsJvSANdB
 vdyLC5VfZE7Gk2e82VquAEg=
X-Google-Smtp-Source: APXvYqxWkuVRcdDnKp0w2hkWFbqlECsFTQophSCTFSp3bXKeq45T0y9SnNnWV77DVCWYaSMmbiwDlQ==
X-Received: by 2002:a17:902:708b:: with SMTP id
 z11mr5832527plk.121.1582922180998; 
 Fri, 28 Feb 2020 12:36:20 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:d1b8:1f12:d98f:3f23?
 ([2601:647:4802:9070:d1b8:1f12:d98f:3f23])
 by smtp.gmail.com with ESMTPSA id i14sm10902854pgh.14.2020.02.28.12.36.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Feb 2020 12:36:20 -0800 (PST)
Subject: Re: [PATCH 02/29] nvmet-fc: fix typo in comment
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200205183753.25959-1-jsmart2021@gmail.com>
 <20200205183753.25959-3-jsmart2021@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <08e7afce-629e-21c6-b7d4-c3d36de59d38@grimberg.me>
Date: Fri, 28 Feb 2020 12:36:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200205183753.25959-3-jsmart2021@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200228_123622_011679_23D0C6EB 
X-CRM114-Status: UNSURE (   9.30  )
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
Cc: martin.petersen@oracle.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
