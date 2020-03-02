Return-Path: <SRS0=ymBk=4T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB645C3F2CD
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 17:47:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A28C214DB
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 17:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KIMrpA28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A28C214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=KIMrpA280Egj8JxdLU8wRtebU
	fqw6+DHq6jesiRhZoiMtWZ/XQ3xR1/0jRS0DCkhlHcntT2dCtrmwZdMaAZkB1mkgbb55qOKREOxdx
	grQQMYz9cLHgW/4vXuQoGBvBcqzsqFXW2aMS0TryUh2NqA6mVJFIYX6qwpwKDrkkiniXW9t5XLHSW
	3lLZjtbpzD3NbjCRR+IaHnt4UPCIOFo05gvdHFwFHHigNJEQQWDstTEK2ieDAl4NZfr4BlucOne2f
	KuqUkpKZk0Xr7fOGFs+u63R+NQr5g8GpopUXm/SZQUDKfBmtgPO7mehOetIsysQUbO+gQQvbLzi1s
	Kl2nNl0Vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8pAS-0002RZ-WE; Mon, 02 Mar 2020 17:47:49 +0000
Received: from mail-ot1-f44.google.com ([209.85.210.44])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8pAQ-0002Qu-GU
 for linux-nvme@lists.infradead.org; Mon, 02 Mar 2020 17:47:47 +0000
Received: by mail-ot1-f44.google.com with SMTP id j16so127162otl.1
 for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2020 09:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=AmkzS6lajiZdG7hX7l1/ODxODhAhxw9mZqmxxSkcgewaWh2sZrn0yfrt5X22/caluA
 d0BZke12qce8cY+oOPUM0459rq8oGn9FGTaPYIpsk3ir6JovkkMRbr1Nu74c+LgMsu82
 1EOw9uwR806fkDJeLl9H4QAVkDU4l7gjfhgG8L0t7gVoavAZFjwxcXJK662nEaZnCmoF
 6LU6KTEDAMy2VF5UdI0d6d9g1Q7UGoOCrPn4objt5siXnGukaDGZUvbFLfvYYhHkxQxW
 2hJWI3+YQo9VfrWx4+jFNyIUcScvHVTS+6LchI743ZBc8NpToekskfurwcpB/HuwMv0q
 auJQ==
X-Gm-Message-State: ANhLgQ2Hxh352D4phjoNReWBVZghCvuYwwKD0AMmEBZyulgyJGcRto21
 IU6K1ufgb5RJodJ7ShbVF9/QlnJq
X-Google-Smtp-Source: ADFU+vuoLpu0ep/vm3FDkXWBx0qtoCsbODUZh9HeuClyiYve+gMlYbMgaoFrrrAuub39EnZJj3qinA==
X-Received: by 2002:a9d:6c8e:: with SMTP id c14mr212156otr.331.1583171265569; 
 Mon, 02 Mar 2020 09:47:45 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id q9sm6759665otl.53.2020.03.02.09.47.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Mar 2020 09:47:44 -0800 (PST)
Subject: Re: [PATCH v2] nvme: log additional message for controller status
To: Rupesh Girase <rgirase@redhat.com>, kbusch@kernel.org
References: <1582821926-26895-1-git-send-email-rgirase@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <713ce9d5-3a45-3478-c31f-5271520aa1ea@grimberg.me>
Date: Mon, 2 Mar 2020 09:47:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1582821926-26895-1-git-send-email-rgirase@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200302_094746_547022_52D7913B 
X-CRM114-Status: UNSURE (   9.83  )
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
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
