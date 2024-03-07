Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D1FC54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G5SEuU829SBeN9Z+FExisYI5Ruv+jv1Pb0lU4z6MqnQ=; b=mWpAbFa+ZGvYKvpkXht6l5LiVR
	wIOFuzsfLGhDSDpJoUb7bsLT2KdrU8fsQa8IrSiig372o/2vAOkBALBiv/BOQqpDcbgU+iX4L1cH7
	HqAbqMoQ8GmxLABJx4Xxfil5L7nIF6SHVRVYpe7r/4Y3Sm8UuEFRM0dXLJx3p32hGrpj+e4jlsArK
	aLLfwKnZAwMNhYu54OG03yqXb2TERpT3hF5k+o94/RwNbOc7KhkHTLOOxjct7KEBcmwWnUgjl4z8o
	hOKwJ4BKvCVbhC6N2TlvB9P/6juiaM5p+b5tADlSVytKegBSdFd/PXgtcOQHnVeJ2zQVvCAEvMCE4
	v8E6PB5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riB3z-000000046Oi-0q4W;
	Thu, 07 Mar 2024 10:33:23 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riB3p-000000046Gd-1h33
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 10:33:15 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33dc6df042aso170448f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 02:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709807591; x=1710412391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5SEuU829SBeN9Z+FExisYI5Ruv+jv1Pb0lU4z6MqnQ=;
        b=poo+C2JZDMzAGvw4NlpC+kH94+UJzCKhTs14VcO9e7jepZWxvPtQqk1asNwP9WdPGD
         M6Rzua9bazGHmGnJqgi1tZXV6vQWp90wxnNr7eY4BrS/zjOE3CsMIDrCD87h5amBZyYd
         nfHWDrADrjMbK4D3Fmin80RBD0JwjUfhEcPnr0k66i6LflQx3T2KdKZN8aqWRgl0hTr3
         LRZXHdIXc968O/b7cHG7Z9QVhbMqHIXzbiw/VcQXMiLb5Hl7MfWfUjubAok3nUxAzBGl
         usts7S69SOL2NyfWw8V4f4EomW3ZYGaliJREZJUN6yVv8477XjQisqrdLt1LwXqpQkff
         vzXA==
X-Forwarded-Encrypted: i=1; AJvYcCWGcdTT6TtgI9dgB7KmbDsbzcENYnmxVTMAfBgwP/UKHAfFYP7yniFuznzaDPNy9euyROqhkbXCzZ2T1H8zeh22OuOJhpP3fWrTq2+8aBQ=
X-Gm-Message-State: AOJu0YwTf2Jtc2VflfLr6D025kLKjHLzyti2VN/rwWAaw1iF8cCjJytO
	uiBGJUw3rHy2a4QDms8I5qskOs/ZAHHcDWUKuYzb2ETrfaDOP4mt
X-Google-Smtp-Source: AGHT+IHff/zjCAil3urGqIuISab9jNt7BVFuGYd3uE0CYWRalE1TN/cSle17tWJkT33DYNV96GXQFA==
X-Received: by 2002:a5d:5447:0:b0:33d:9ee1:48db with SMTP id w7-20020a5d5447000000b0033d9ee148dbmr992972wrv.2.1709807591497;
        Thu, 07 Mar 2024 02:33:11 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id u20-20020adfcb14000000b0033b7ce8b496sm19788995wrh.108.2024.03.07.02.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:33:11 -0800 (PST)
Message-ID: <6811acef-143d-4104-a814-d3cb0811192b@grimberg.me>
Date: Thu, 7 Mar 2024 12:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] nvme-fc: wait for initial connect attempt to
 finish
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-6-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240221132404.6311-6-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_023313_597488_D6EA9BE9 
X-CRM114-Status: GOOD (  10.77  )
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



On 21/02/2024 15:24, Daniel Wagner wrote:
> The TCP and RDMA transport are doing a synchronous connects, that is the
> syscal returns with the final result. The operation either fails or
> succeeds. The FC transport offloads the connect attempt to a workqueue
> and thus it's an asynchronous operation.
>
> This async connect feature was introduced to mitigate problems with
> transient connect errors and the task to coordinate retries with
> userspace (nvme-cli).
Maybe it is a better idea to let userspace handle this? the whole async 
connect (and reconnect)
just seems it is causing more issues than solving... I may have missed 
some conversations
about this one...

