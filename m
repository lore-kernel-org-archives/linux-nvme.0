Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEF0CFD376
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 22:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gfozy9EoknKQTDkatcXJHiu/b3D1vfYVA+aR98/klrk=; b=cFP5ooQl1lRMTVWypZg2PstmuN
	SoaMVYR+jeKQvPdkM7ZYHOflDa3VOlQnywFcY5EB324BigNYDuyLiVtxsRtoxulH3/qwE7nE8RfEw
	PJ/7BudRkUX9sTDIC7+lxNWyYkKj9QZhR0dC4sPkUcYcjlavRTDtW29YAqx+rx7f6J738AkLbMa+K
	vEgJ0j/Pwn1OislnmmDEGuVl8fL/L4cliAA0hATxZrhtmjdugfF2NGSQJIOMX8znHcWno1Zkm+jJz
	3/zqQ8B9iSVpiHAG70VNlVRTD9K9MurlXtDZlGRyJWwb8CHLI1eompNWilzqtR+Oe5S6Y8iTqD+XS
	dpOYgzRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpax-00000002boH-3b35;
	Sun, 30 Nov 2025 22:08:39 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpav-00000002bns-3x5i
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 22:08:38 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47118259fd8so32130475e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 14:08:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764540516; x=1765145316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfozy9EoknKQTDkatcXJHiu/b3D1vfYVA+aR98/klrk=;
        b=uNzh1tc0zlkBd+D29qyzvkpV0NrwU0TA537/sE+l7IcQD7fRCrbfGzXEmqepwOf4bt
         Unr5vEBq4uRPqtD2xfbAlfRsa4pInTqPC1qJtr2P8HcaFLphhwRHUgKzYtTsQm5Lxipe
         CTBjPdqpGDx6Fq6A4gmsgunW6gpmfA+tP1NgqfMo1TkfagG568DtKi8E7uY5067Hgou3
         KyVNd1Th3xjdesEp/JsONHBaz2CKtcA2mgl34mTLKwg9kel4OgEpiJAzZnwPamH1a1Bu
         WjYxmFrnzI/oa/+c5J5wjpFeeg5GPjyQ2FpymQ2qp5lhRgBqLT2Fl/RZPzQCUUCYHz/7
         YBvA==
X-Forwarded-Encrypted: i=1; AJvYcCXJl98xL5z/LOCwVtJsSb8hkCO7kzwc26kuz6tHnNb5maIXhHedhsa3cJNarxxwRDmC7dNiAVcSAY33@lists.infradead.org
X-Gm-Message-State: AOJu0Yw9MfXbHAIncT+lNr9p8xrZPaXTjIdXuraT1xMN6YYCmpbGnX1J
	HBrHFLB2oJzFzk1CBsJ2W/1pJAnZWElpvSDNLHY+A6CEiflknxZ0P5U9
X-Gm-Gg: ASbGnctJVhMxA4Br0zxaxNYYnYFQc2nSgj1/unFh/zr2rXE9cJmlx2JSreQyDxjitVw
	eFnENJM1zbY62Am9EtSWOLK4rxFh4FrCOrxs9krDZcorSMGLUwkHQSoWRvxPxDeggP77G+rdKXC
	c3M1341K49tDMU0SNfNw1gzkqfrMXpBk7vMmU4IvINMiYDIuBq/eyB9DDr96UOsTMWgN7fFuAFR
	jt3jN+FvNla+SvlqA6peFYQxj6grF238SR0GKYZ9ovASO83uXkLWrRmM3X3ruvsjrbHAJCMgdb9
	prD3EEpWVpciChfop1nyk86oGMg5IzpTzihNImZNd4u7HCrJgGG6hyaDS2Mm8nYtGqj4xmeybbZ
	Q7poySx+8JjSONN5oB9QjPzu0Fph3VFrde6s6pb+iqkdX6AZ0n5wk+5LYLooCzF/nlENxE0FuqY
	vkN35CQxTKTdpDLoq4lSeDCw3g4/M7rOiZH3LU39hg
X-Google-Smtp-Source: AGHT+IHYkQBXf0b/mxoZTOwYpX1eHK5PwJTOah49kTnhYuD1z8lWg9KNXy1Db3G7yB2ZMrDUeEKh1A==
X-Received: by 2002:a05:600c:4694:b0:46e:4246:c90d with SMTP id 5b1f17b1804b1-47904ad06f3mr226635525e9.11.1764540516027;
        Sun, 30 Nov 2025 14:08:36 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a396sm22126207f8f.22.2025.11.30.14.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:08:35 -0800 (PST)
Message-ID: <142896f9-658a-4964-8c4d-96e13176ea71@grimberg.me>
Date: Mon, 1 Dec 2025 00:08:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] nvme-auth: wait for authentication to finish when
 changing keys
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-8-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250528140517.3284-8-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_140837_994207_9F2B233B 
X-CRM114-Status: GOOD (  10.71  )
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



On 28/05/2025 17:05, Hannes Reinecke wrote:
> When changing DH-HMAC-CHAP keys in sysfs we need to wait for authentication
> to complete on all queues. Otherwise the user might change the keys while
> authentication is in progress, causing the authentication to fail and
> I/O to be interrupted.

This sounds like a bug fix. it should be sent out regardless of the 
patch set.
But even if its stays in, it probably makes sense to have bug fixes come 
first in the series.

Other than that, looks good
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

