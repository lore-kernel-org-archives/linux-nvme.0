Return-Path: <SRS0=sB0J=33=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B0AC2BA83
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2020 20:03:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA20214AF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2020 20:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S01/pSHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA20214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=S01/pSHRM6/XAQCCUzHtQccN/
	y86PxCVmFhAt8oQ+XZ1U5G1HlTjJlKtZdMNSGWQrvnvRkR6pxrTRLYfCs142JZDTAhlR+bS6xfBcv
	uzwxUWRg7fT9VVf6/ueuEjjRtXTF51KFmuLIAt6JokFrM7Od9ttchHGb8Lbi9EkLre+JITbaO+1ar
	qwgIKcu3NJbCw8zzPnImgFLBCHOj/+9Btu8nV5eXV0UJLS+kQEG33IWMxDItHgeLHX7ubzyQX7IbH
	U7pVFZeiFJXUgmC3LwagsEp7OqK8M9k6cvkLJOMS3cs4UjzWhiispROi6NRzlAsjczjBxGEy7Ei26
	S61bc89tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j09qY-0004Bn-Pr; Fri, 07 Feb 2020 20:03:26 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j09qV-0004BA-6M
 for linux-nvme@lists.infradead.org; Fri, 07 Feb 2020 20:03:24 +0000
Received: by mail-ot1-f68.google.com with SMTP id a15so515926otf.1
 for <linux-nvme@lists.infradead.org>; Fri, 07 Feb 2020 12:03:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=I8fRnpb9ES6Hy0eVuObeJYcLnwCll2K/Xm5B0rxC2NNHgG0MWf8tT4Pi5/vi5bbkTY
 0bb9JTIPIZMwFI6f34FG1I2SL2zs5qQ+2KYi/YQKSaIQMt42xRs5Hp43nTqBM48lbyAJ
 2QAjrIWIcOJ/0+2MMhtF8Ld6yXFa8WH0tV4ycWs9QuFrr3cfTHBpjl5JN39NMF2JAuFd
 i1Q+8Xp2AQh+Q1UQtQ/Ok2aQjbGoe41RbhYBpjymfBXCGNFdBFf3VwHmIq5vroijKAHV
 YF5NMkN9ouboxBY9AwRGfM+Kl4B267vWPUDqUa0LSheJ6Y+kB/LHNnQiicyWKeZ+FFwQ
 hpFg==
X-Gm-Message-State: APjAAAXLJnhN/Rt0XRDJ1JpgexmzglP0qePTKwKl1zGUbTjv8FMYLRip
 gXWgNncN9Jc0U+FOX/YPu5A=
X-Google-Smtp-Source: APXvYqzQy6bcmeyjbY9yqVxViacV6nmMJjTcpH1XcDCLGv0G3Y7Y3IJ9VhMMCTDuzMf/TKe6ysMOsw==
X-Received: by 2002:a05:6830:1691:: with SMTP id
 k17mr861867otr.282.1581105802121; 
 Fri, 07 Feb 2020 12:03:22 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id t131sm1366490oih.35.2020.02.07.12.03.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Feb 2020 12:03:21 -0800 (PST)
Subject: Re: [PATCH 2/2] nvmet: Fix controller use after free
To: Israel Rukshin <israelr@mellanox.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1580819890-11455-1-git-send-email-israelr@mellanox.com>
 <1580819890-11455-2-git-send-email-israelr@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <75c7fc50-b2fd-31a4-b16b-e06d20ba1380@grimberg.me>
Date: Fri, 7 Feb 2020 12:03:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1580819890-11455-2-git-send-email-israelr@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200207_120323_234122_343351A4 
X-CRM114-Status: UNSURE (   9.60  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
