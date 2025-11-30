Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E342CFD376
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 22:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O7+S01WCAyAvwKXcC4du6+FgnX+fk1+TM0vWaoterF8=; b=cdIlMLuknzefsORJJqdzT1+LvT
	qzTArU/89d/jjO6LI6HcABHMT+5XgonYpc9RH3occPJff2HEgaj2NYSfsnweoYCAgjhpbVRUp2Owr
	DlN7bvxLbj2/dfBKHzNK6aqFmrGfUZHRypO8ImM7tqeot16GeRlUljofTsBHBxdVXmJ6cMEqo92DU
	Cen9wfOBE7gBzDACvNEu2M6c1k7L3LTfNNJP+5z4uCL9s69xaHFZgiQh23za+1HuMCFFNksDsTq1E
	laEhispzMvG/vpfc9gt2ngf/etWmMuW7Pmtmx8fPvKfBff3uxXXBTP8PjNK/31GZNQGHAes5D5bhi
	HUL/ooXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqGp-00000002drJ-15EZ;
	Sun, 30 Nov 2025 22:51:55 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqGn-00000002dr1-2FSF
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 22:51:54 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775ae77516so36642305e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 14:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764543112; x=1765147912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7+S01WCAyAvwKXcC4du6+FgnX+fk1+TM0vWaoterF8=;
        b=nkoAW5LiaZMgGturCaehVJjEo5fgxgmpUjLY1tc6mQgNyD3ed2pPTAS3tdVN7a4uBm
         3zygYJYgsxKYrvPVX6wUgNL8JRkX8T7eKWauOLYraTX8wiQwdbDMTnhhcQtGtUPg+9a2
         nBGgc2HdFVIUFDDTtoprfI9CWVsUY+U2jy60mZ5GnRvrE5HeR0vsYj3OALL4xOPyDUGo
         +6lxaGmcOPRjY9BwD/IttNSJgGumaptqfHRMLm03Rd6mdUiiF7IId1uR9DJrSAb+G2Oe
         5wvXf199DOCfQk+YKFHmh42MBpKoz+7SjkxEs+UBsGSfv/+LwLHBFw6Z/ZVR3VVIgZw1
         JdJA==
X-Gm-Message-State: AOJu0YwkB+Seb8YiSI+o7nwKnME81XwqB1favbfWl8Ev+HQlOhExKLOX
	MJcOPr5F8iIn/5v25StY45HuDF3ec7nTBCSZrjdseYognh/EYBRrADNq
X-Gm-Gg: ASbGncsalQXYEsFSoAuKr7x/pYP70GQ2QWpK4sCK26qMLYV8QLt4fueGrWpWwS6694c
	XN735lTeNlgZY3JSz1AQ6g0IHKyPdA4vsnKaLcaHhDi2+1A9GPJe5UTfVSfIwTuIi4xMz5yQM4N
	6la6uwDO+NPSpjcSGXo7ybIrexTu+fRqh65Ciq0haOOyjLr3Hc3urA7DiYPDMOfH8GXOFPfM0bM
	xUD1K5u3Y8MTeFsnW9uA8JwZXoPsVHZGh4OXn6koNBUkYN8j7QMK9h8hJu75Iw8h0s7luq6j//d
	06PqqY7a0NMKLuHdC+lJ+bcDZpXkX50jBLWXaAI4Uw/WSIzZ2KEC/hFLgjj5V8ZC3oMUscrXZDN
	0V2fEaSue4MksQi6YrF/vaf8n+8ieD7Jk2UieDKl2c8s4/7nJ5BV87WM0WCNgNal4hXhIXpXGOl
	/KqkAfAnJFR12++ERr976eWGAWxMl+yCXI7G3wXgXc
X-Google-Smtp-Source: AGHT+IGzJADQPyNuDW9sZkpavP1iyKtdsUlVuVEujjRLnDD7w3mwPUGafcdUfDIopSi3fZtv378dWw==
X-Received: by 2002:a05:600c:4691:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-477c10c8e61mr340148885e9.5.1764543111613;
        Sun, 30 Nov 2025 14:51:51 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm22136242f8f.29.2025.11.30.14.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:51:51 -0800 (PST)
Message-ID: <1bd99963-95b9-4723-844e-22d4349addb3@grimberg.me>
Date: Mon, 1 Dec 2025 00:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvme-tcp: use __fput_sync() to avoid use-after-free on
 reset
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20251125005950.41046-1-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251125005950.41046-1-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_145153_582384_A7C28279 
X-CRM114-Status: UNSURE (   4.50  )
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

Thanks

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

