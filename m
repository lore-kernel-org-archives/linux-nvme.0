Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31FBC021B2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 07:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=TbE5SdZv7Vdh7tfQTqKE/KdGcM
	ozLucCybhK0p26RPYgqXKpe+pXBITwop8MwaHkLEAO+y8/VWQYl9/3JD+nhm60eY50RVoDVhNWPR3
	0qp/qpf75h9pJkONSQ1MqKa05PkmqghQbIjws1Kk8JSrgOajuJ3AK4Hs9FoGOOj8Nx4VsA/94wKP5
	qoJh7+WPUKD2yftx3QF+Rw881wgXxx/GLGwCd4nlUVdXg4fm27YKe9W5aNUyHCcV/N6PT0Vdkepub
	yBsmTAXdsMn5rWqo0uhrrHDtnsdze/nBgLlFERbR3LWWvk6Pp6j5d70zAc+OzrhFQW7aa0jNoB6oJ
	O8nxMdPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmpcy-0000000GF25-0xY7;
	Tue, 25 Feb 2025 07:45:16 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmpcv-0000000GF1i-1zy9
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 07:45:14 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f406e9f80so4823617f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 23:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740469512; x=1741074312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=OYG+l8uY7YSrJh+c3S+ZqXyGz3d2f9+hNV3rPI9KAIPL9lJx28zN2PH6VGksnMkk77
         kdRG2Mp6qz3uZ1Mesgg47rF+OT28CnUSqt6HJsNI/rP03P9CXQaBEHZYzsw5KkaFev6t
         9Nimvrpjku/OX5WRKMfReooqVeyAA1AtA47sK1ARQIw/6jInE8NQRf7qvWEwrvaXHqfj
         UsyZFfp9AFBWlFZXGvbCB5L0V3+QlixXzrrmK39XkSHMmS3pisgRis3hgnJVzyDjkP7E
         vvkT3Gj1uhy4Z3hLVJyMopqAHYYvkOXgsKedFtBBHCB0SHcworFdQZ5Wtxm30KV9OFkR
         BPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaLUK9pVDaxjcr8uY9XR9jdGj1tZqoZi8XmavaiVAHg6BSNsphn1CHTwuNq0QvPZUuHIc1DYlxSQaM@lists.infradead.org
X-Gm-Message-State: AOJu0YzV3SgmO5HhVH21oz/9fBX25a1pPs+zziBER6xj4KWiL8SUimbs
	ecmzsuxMsAIJ2Il5sqiUp0sEhD95N7uuhvnsVKu3lxWeEgjHVXkik+nI9w==
X-Gm-Gg: ASbGncsu/bUBfOuS8KDnrfFW+lAQ5WlnsL7jG5EIL786Jz2NBuUz2ebutmIaGaspa+p
	kZop+MDnwJeZausC+C2D77o3mbiSjR1Ix2L1tiltdiLSs7HdKM40OBIIHhHtcNo/QbKDmnB1/Iz
	jNYgiB0KhoXunjQ48/u7bv3v+jM76paBD2GDPRgh+TdJNu/ldqc4mBMN3xKxtHjSjsIC7teqJNp
	/ptioxLXh1Az9nUhsfJL2dJesHXk4VI7b/Nic4K9ojt+v2bSNFjPAmgvpPaPn15KCfWgjgfueQ4
	cvQY33jYbU++CiQ8ZiwBUVcb7NW7xEQ5GwIvI5UxstlDU13qSi03MXER/5vJNdwc5hvF
X-Google-Smtp-Source: AGHT+IHi1LuRU7krIDgpRiv1cutorXEY+VPXXIG/ZLGCjeBAqizyJI1o5n3/+4v9NJEwo1m37mU6zg==
X-Received: by 2002:a5d:64eb:0:b0:38f:4acd:975c with SMTP id ffacd0b85a97d-38f6e97a27dmr14927083f8f.27.1740469511656;
        Mon, 24 Feb 2025 23:45:11 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd882973sm1352441f8f.48.2025.02.24.23.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 23:45:11 -0800 (PST)
Message-ID: <4591283b-e556-4e3a-a2b2-099400999d65@grimberg.me>
Date: Tue, 25 Feb 2025 09:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] nvmet: Add 'sq' argument to alloc_ctrl_args
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Damien Le Moal <dlemoal@kernel.org>
References: <20250224123818.42218-1-hare@kernel.org>
 <20250224123818.42218-9-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250224123818.42218-9-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_234513_521191_2E9CDE4F 
X-CRM114-Status: UNSURE (   5.64  )
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

