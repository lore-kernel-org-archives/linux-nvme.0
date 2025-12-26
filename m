Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD59E7AD73
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Dec 2025 00:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pjCvzvOIpnrhFczHJJQpSV913B5DWe5UITV8eGvQLNk=; b=RCZy2uZo2T4d3z8vW1SX1iScMY
	6HGjWBbzsp02eceGj7qQLM6OczW/mDNhNjyeQtJF8ej6MHqCXKt0fdLiXxcUY0zvUGhZwfb3wUOnz
	IA2LZpA6z4dmCXM6/UqcQMS8WZbxwytmUlgPchVOo5cLOlkfYzI6BfD89RQtIklhjQwT1mAagI6zS
	ktN1JI/D2LvHpc7+m1uzqOok7gOwPQ0O8vbhVv8aR3LJjAPJGhIUpG2p9yxv4rbUeG4BIenUjslYL
	2lrtY1WmhPGYDy0d/Qm6Nc1o/+dBk2LJ+H5PNawlfuemhjeAr/JnvxCelO95QtziwhmvEv8P9a4Pe
	hbbBYq4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYvOa-00000000lzi-3c9T;
	Fri, 26 Dec 2025 00:09:28 +0000
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYvOY-00000000lzJ-02q6
	for linux-nvme@lists.infradead.org;
	Fri, 26 Dec 2025 00:09:27 +0000
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-56021b53e9eso1747850e0c.2
        for <linux-nvme@lists.infradead.org>; Thu, 25 Dec 2025 16:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766707764; x=1767312564; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pjCvzvOIpnrhFczHJJQpSV913B5DWe5UITV8eGvQLNk=;
        b=HCQ1L9MBl30qmAuQsduSPrUzpqgsNpsM8Sk1Ur/AIRNr0FtENznp+LLQi4ZuhbJkvB
         /jPbS7X04KvSof/UnPUnGle8yUnE2RZFfGTjgp9ZbsAFUjhK0ZNnknUkZmpUqOqsvfly
         5xW/guLjQ1xkacm0WxUnrxY1qrbsVi7Kdo9SLlfKbkiLmjqsEXMnkIhZC9/fsBuWXkRV
         qYg6CfyiDS3EEb1+zihdwiTZwgKFDcnYl4YZ/fNqgJyPYJyLYL8rBGX2qPo+i9XxLRdr
         qpeZ4GJ+K3o946D1PK/XzYIpHxQoGl1NLlRwX9s8yIQG7nv9Q2UayOiHmhYbNl03CePm
         Inqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766707764; x=1767312564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjCvzvOIpnrhFczHJJQpSV913B5DWe5UITV8eGvQLNk=;
        b=RIQtkrulZoYboRsTZ36Ry9PaVvzr0wDASqZGpIcBcQvtDeRyAQouJP6vYOkhSWMBh5
         gHY8IyKM9e7+KfiAW6463DlmjNIP/c3gsk0cDCU8le/Khij0t32POzIrXzIuWtBg1hqT
         /zA5Mqlu633NB+0RW59t+EXHDpX2M76WPOeq3QjVOX0NlO9dpr3JnnZgOoZJbNmSPewu
         v/u0ykG7ZMNPfb5pvDQkMo2ZuVjz5YY1T5REMqNS/eOMDplv48+sKFxUA684iAOQzffG
         LnSpAtEiJLN9UWdaQKU8yGq12iTX85Ehm8Velu2sH/m6zVYoIQPN244/0AoYheQbay76
         fh+A==
X-Forwarded-Encrypted: i=1; AJvYcCUiMLBybZrb7xkCqtDMhuWHpf+KckjZqVRMM0ohRtuzL7ETIqmKM+fK9+JY9YhhLpG2DIHgIEToVGMZ@lists.infradead.org
X-Gm-Message-State: AOJu0YwCyaSgzd0WB1+PsUy8gb8t8dPNfjDe9P6zYi30PaimFMv3fknM
	9mvmvkOndp3h0WTqaujfMPpE1OgUud9IskZiu7P/BC+FOGo7RMTlFdLVWswZa+JcxVXdaWzdhJm
	TmSn6QDTYn5hosfOKwdmlqVuqXf679yY=
X-Gm-Gg: AY/fxX78NbHPwuIJTDcdlnkOJQhNs6DncEbsfcvkjo0HlreTPNoNIswWObQprjIVKN0
	71GmTFbanxwGlWOb8CBd3gFYH2PVMBtLYEQqebjHckT7YTMecr9wa+FsGPr5I2uYBKD0vkIUVzU
	9ocnsyE2N7Y9O3hnKH1NeWE7OBHZXwipfnGSnUdzxQLBrmdnU5kEcz795X7zzpwq5QakEGZIdEh
	zXaTvmixZjbkcQINN5Pq/Tn5PpKitFZLlloJS6hbkdEzjVxkoXD8s3vAOVr6CgHAQFU0cgj
X-Google-Smtp-Source: AGHT+IGbEp/peBJuhcDteHEcsJcjsxPwZakFFAsvv3VQz6djQago49uF+3rZcczAa067rQgwFVSA3Zt+IdZHmtnIe8Y=
X-Received: by 2002:a05:6122:a04:b0:55b:180f:fed6 with SMTP id
 71dfb90a1353d-5615be677b9mr5771158e0c.13.1766707763980; Thu, 25 Dec 2025
 16:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20251221-nvme_ns_validation-v1-0-9f7a385707af@gmail.com>
 <20251221-nvme_ns_validation-v1-2-9f7a385707af@gmail.com> <88f1a3af-c6f4-42eb-bf63-504998028973@grimberg.me>
In-Reply-To: <88f1a3af-c6f4-42eb-bf63-504998028973@grimberg.me>
From: Alex Tran <alex.t.tran@gmail.com>
Date: Thu, 25 Dec 2025 16:09:13 -0800
X-Gm-Features: AQt7F2qX0SaZEamGxy7XzSEVEJfoV9z-7typu3la6qrmqCMrY1nAghoStFFo_is
Message-ID: <CA+hkOd4vg=7OSjH8d5cA_GtQ27GnGO7wG2EWTuVU7SbqfpyKLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme/host: add delayed retries upon non-fatal error
 during ns validation
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251225_160926_077148_134F29DC 
X-CRM114-Status: UNSURE (   9.08  )
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

> Given that ns scanning is already async, wouldn't it be simpler to
> simply retry locally
> in a loop?

It would be much simpler to perform this locally in a retry loop.
Thanks for the feedback! I'll follow up with a rework in v2.

-- 
Yours,
Alex Tran

