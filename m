Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EB8C30658
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 13:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jjfn4UzRqTW7y9AvBzOaJtg5jIRBrm0UiVXwP0OsJ5U=; b=gRpeCQukC9zZAaBrhASXAxSqb0
	HiuOc5dGOWuQ43GjlIOmjMgFq0cKn5HAmWFC3am+fwqWB5COVg4xV7oWL8ARu206cNRlmG8tkqUbe
	zcVcDDsRcCqK1wHP1l8WjkwoaC4S9u1r9hQvXU+Za8Yf80SkW7C5Qc9AjiY3Zrq3oiMb9noRpMGHv
	2/km1iaVkj0HQrZXugWVgmhAIpASUGdEE7mriKLdrkTrYJTHg4jvwnH1DpPxG1Go61VJUjElbZm9D
	QQ1CxL6VCkchlidiibWQh9G5/ygZb8StPOcD78jSR+LkC4mja/g5RxpoQRu7qWULVQN+CbTgbDYVJ
	zZbK0XwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMSr9-000000070HD-1Q5D;
	Wed, 26 Jun 2024 13:38:39 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMSr6-000000070F7-3gBW
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 13:38:38 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4247102da30so7763255e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 06:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409115; x=1720013915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjfn4UzRqTW7y9AvBzOaJtg5jIRBrm0UiVXwP0OsJ5U=;
        b=fIB2gwA84ki4nq1l/dGAFKFysthN1lON4Wjndtnrg/WTig7Fe7RdzRpEIUXmONRttw
         y+Lpeypv72/p3XtNSK8sVpOOkpRjtPoXtIK+YL1ItrqwNw+jCgAOXtjKffhi5F4Y902F
         h3NEWZA4POT0ySHNGG9mlLkJ5/yC2T6nRB7hutu2EQNRbQwi/UWOKpArr4LgFoz0C6Kj
         Bf9GUBE60CWu/XQEdC71f0IN/5pIySDQKN4bSM+FNOb2hma3VLz7Xd6ycOzOVqenjEqf
         TY3HgXtCzjLzyNLMx1zJIy7E8aGYoSglUKO01EdrqIjOZ5lEJ8WzQ+JMCqLGhfK5ViNy
         EkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMxPufajVGR7GtN6F7sgrBtq/ISGdjxbf5AgXAQjTbtVHO3U6m1SBHCrQ513q37eyELDsxwss9O9B+w0sWHW2XOdsskmztt99c2AAqt4k=
X-Gm-Message-State: AOJu0YwTUizvJxUsm37ZnkoRjIS5EEJCgTfyqqWJkjtQDR1QtZycLWbl
	SUVih5FaoA/LFnxqLyV1oLX4y2NZRxB6dI+i7a1Gvyc13V3mn9Opy7yaKQ==
X-Google-Smtp-Source: AGHT+IHWzXYmZq0IXY3yMng+nhH7FAuviYxj/dVLW42FELdHiFeJmY+FdKSb549Vi51zdt9wVsbMGw==
X-Received: by 2002:a05:600c:1c0f:b0:424:a74b:32d3 with SMTP id 5b1f17b1804b1-424a74b3420mr28833825e9.0.1719409114981;
        Wed, 26 Jun 2024 06:38:34 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6bd2sm15701718f8f.66.2024.06.26.06.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 06:38:34 -0700 (PDT)
Message-ID: <8c08512e-dcf2-466f-aa0e-a26902072edc@grimberg.me>
Date: Wed, 26 Jun 2024 16:38:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] net: micro-optimize skb_datagram_iter
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240626121347.1116-1-hare@kernel.org>
 <20240626121347.1116-4-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240626121347.1116-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_063836_984430_83360D01 
X-CRM114-Status: UNSURE (   5.40  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This should be removed, an alternative patch was sent to netdev.

