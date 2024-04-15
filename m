Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E385C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Apr 2024 20:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R0BVcMyAX0yyUmOHjKt7F46lAfNlP4crD4z4H9AjoEE=; b=GpK6HPfIPFZG+HDCwdil0gshWI
	BgUPVphGhnMt69KOKKEcXq0uqn4yzPdOresdNwYI91KAVxs6CmZq+5q7+oHoeBpnFzVS+IzS5SisX
	SKRSt09i3v/sUQnuTN71dN3XPjQomRDi7t+3lEnmMPwkAuidetVDul/NLGfANnRn0kHUnLwjIMRmW
	HTww2mHki56rbMiBsWTfaUxjyTcJg/986XoC6ajkCF2rzRZTJdc9djDECGoq5OnYJYlRF1+xnVTwh
	Gl8icpJ6uufLSXOKZHfSrx5CzMzWSVUS279fGE08oKOPzO2dmoQqW2AluGp4BL9Xd978C4B2BnU0p
	iKgtTkrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwTLx-00000009tV7-31VD;
	Mon, 15 Apr 2024 20:55:01 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwTLv-00000009tTJ-0vRW
	for linux-nvme@lists.infradead.org;
	Mon, 15 Apr 2024 20:55:00 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-346a5dea2f4so937710f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 15 Apr 2024 13:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713214496; x=1713819296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0BVcMyAX0yyUmOHjKt7F46lAfNlP4crD4z4H9AjoEE=;
        b=ENaPcZMD+B+BBlbalvNZC5+9jW8OsUSeNXiz8LxGb4d+eOcN46gAVCrq+3myC/kn7p
         ImUtRIp7xNomF2d76e3guQ5dzD+N3YK9NMEdJd//GLrK/VHELdEo/WAqJu3YBn3ENyfL
         XCrUkWz76Opn6z2oqYKkWIHzI+P+dBjPp9S5OS8h8/83SarS5UiO6Y1UXapU3fPl3Dun
         c1O9jaw0b0Fra4ckH3XnIBb3afMAVpeifo5HN/hFIYOb5iYbzDVoUtmDMwr2jhEz4SQv
         z5b4DoKde9Ag0m4wW8oIC9mvT8X56n3ByZX5zxTmd3IHZT20PIS2ySXwBSe+/1dcNh6h
         7ZkA==
X-Forwarded-Encrypted: i=1; AJvYcCWaMFSDjWuRNraS6GxHtWc++qc8cblZ8qQ+Sw9VBuCF7HsWgGZ9ypDudfh3N2jjVSgY6vwNs1jkFskjWIjJ85NxM7Z5lWuP9/cXwwKN+cs=
X-Gm-Message-State: AOJu0Yxg3HDNTwRhwDoQCSgqMY8MdhE2vaFQspg3YxiIryWKunblTN49
	heNMNPswhQSDHeXcKujSZFrYTgxZUNLBqOvQFtAAy9j+2aN3C+Dr
X-Google-Smtp-Source: AGHT+IE/paPUbrIslqaXJKLp+/BJsQEW7OGj14bOiph44kp5xaK8bC6EH7BWoj0LyO4kd3XMNFi2Ow==
X-Received: by 2002:a5d:5985:0:b0:346:408d:42e6 with SMTP id n5-20020a5d5985000000b00346408d42e6mr8828519wri.2.1713214496534;
        Mon, 15 Apr 2024 13:54:56 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600000c900b00346c0062b0dsm12601268wrx.11.2024.04.15.13.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 13:54:56 -0700 (PDT)
Message-ID: <1080e784-154e-4308-8186-a672a6803ec9@grimberg.me>
Date: Mon, 15 Apr 2024 23:54:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] nvme: authentication error are always
 non-retryable
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240415124220.5433-1-dwagner@suse.de>
 <20240415124220.5433-4-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240415124220.5433-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_135459_303988_7654E1F0 
X-CRM114-Status: UNSURE (   7.29  )
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



On 15/04/2024 15:42, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Any authentication errors are non-retryable, so use negative error codes
> to ensure they are not retried.

The patch description conflicts with patch 5 no?

