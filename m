Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF00BE77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=xHYDT+/nbB988xzuatc05OpIwa
	bY0GhuA3qlCotngKsaoRY+xdBSKepkEyfP9BRjYhP6ihKsG8IQ/YKNqyp47ksljjj3iDSZcaZnp9I
	NvB8TQmIIeuM1nDu9D7ZAlhwoBu4glAulJN031npHDIZaV2OkG1fDP2Emgt3HQRycB5WBVv/1qIap
	c/VBruaX8Bn4N5FfWipqFvcYwdmr1jN406675He+rAmnYUyhY8PJDkCZbAGCihxEIt3OHejPicO7P
	cL6uoVyLA8zMyoIEc3EyC76+jcNkKc8CX4B2CAhpe7ajSdk7auKlsQg6dYts1TGhnMhet38Zm4G18
	P4ZP3+Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ373-0000000BrSP-18gB;
	Tue, 24 Dec 2024 11:30:09 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ370-0000000BrQv-3Zdz
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:30:07 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e87b25f0so3925384f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:30:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735039805; x=1735644605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=TFcSK9Wqo7UQPlek/wMeyJfPx9LbRDfVHMgbhpBxqNjuHkoSHO9H8nhDOjwOwnfol2
         yhtAh/bBVpIGtbCT0UGpAfqS+wlEB2y1OJLAuRxn85kwVfbuahlc5H/wUFr5KvKPqvFb
         77EjYVH7SBu9brBYWlYhsDaLDZKu9i2vCyUpo6jaT/hBaonGWUAIHaRuzBBppHr61pvj
         KAYfyDXEMopqjD+lQolbqVwifNX7CtbL3IMq//SpJOsU8OtmArSDRaXYab+QOx0/G5Ns
         g8LrFPWACI5C4+pXK2vJm+4EhpS36C3XphMhTpGjDlmwpx1fPIiwS+OGrpO44WIo+T7k
         1FBA==
X-Gm-Message-State: AOJu0YyPqdjhqb2mDxSDgq04GA5ta+mLuYiTZ3OL4fWotqHFUpLJgX2R
	X1yHrW2MPk3lUwPzDqVj0ZFRne5vvZ9zWsjLy9/WctKnwBto2hSo
X-Gm-Gg: ASbGncvsUaRhkEZEPVjU9lN936vnazxYVxbGSj+Z5WfChT+mvxFKkf9td1lXrbYdAHd
	QNO6FuVjnLIGjJQ/8+I8weKMS0wh3Mom4T4SwZ60Hg7ukx6e8/DSU1/teHiikDlvevMPrGEhUd4
	7AyjCWO1Y0FIwz+CpvROaVVvwK4Gl4X4TApHV96o8QIhYNCf46F0tyVMxceScSiC1MIYWr5JjL3
	RFiaArSkQH+eiMEVRvX+0VGOQIcEKNZpKjaaAxBlVvTGTW2FkpXH5cX8AdD5W1FkprxHe1MO7wx
	pRYpze6j56x+qeRBBuQDVJI=
X-Google-Smtp-Source: AGHT+IH9DwfSTO3YGeJUcRxLD4KOTyOWjXUb58cjnJwJpTig0afKwAJlMOLKAy48ZDswJJYBnAF+tQ==
X-Received: by 2002:a5d:6d03:0:b0:386:3213:5b80 with SMTP id ffacd0b85a97d-38a1a274920mr17868784f8f.24.1735039805231;
        Tue, 24 Dec 2024 03:30:05 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b417afsm200902375e9.36.2024.12.24.03.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:30:04 -0800 (PST)
Message-ID: <6eb52426-220a-41b8-a004-671c9b386b7a@grimberg.me>
Date: Tue, 24 Dec 2024 13:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: fix comment typo
To: Baruch Siach <baruch@tkos.co.il>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
References: <6460798716383804d15e987b0c218bf9969b33d2.1733657672.git.baruch@tkos.co.il>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <6460798716383804d15e987b0c218bf9969b33d2.1733657672.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_033006_888033_13A0C9C1 
X-CRM114-Status: UNSURE (   5.59  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

