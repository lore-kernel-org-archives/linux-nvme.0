Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E067FC369D1
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 22:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=fCnQUe7K6m3Q1mXEza3D/dWvlz
	TMc69/atu8KNur3Y1TEgFzvcw8TOAgbGns/N79cI9n5TGBIQ2mtI32hSEr4E+Uczv15xHzNC/YsmA
	rKvHLIlANhhCvLKRPTtmX9WNl0vGb/wSgegFfk0W6CP+1028iQesWoQWGq+07/k4ZjVEfROxlEKle
	jEywnUl+DCEDvq6PLxo9VAcbko+AkUmgt3NhXXEHsvozvhsJFyeVdtJOvfIhPgZO91xgGB/BWxfRp
	wudmxUNkyBFvfEIj+p6onwaEI1iUiG0uWz3t7uwtmqA5GSJcKBZ7FObMI7GWmNg2eIgFl4BfkXGxQ
	iBZ5W0oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8RWY-0000000130T-1iiM;
	Fri, 25 Apr 2025 22:27:58 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8RWW-000000012zn-2QMH
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 22:27:57 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso19179045e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 15:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745620075; x=1746224875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=VSfKseaKNfOOvjDonQh2XHR+OSFKdcssfN+e9oGa9Elgseht3sWf0olqpS422YOcSK
         ZLeghxikiWIbki+X6mx/TeyptXira+bhyqnfUAGuy23OxiczjaGhBJ1mo82UQ9OqJ7R4
         xEl8ncZQDDLQHfspx7J5SlGUKhbJTko1hKnJKKf3jyAon9DdzaKFzocEfdCBu9vyClJs
         ZVH1t7uDDG9saIIng4C7K3stqjFZ48+Uqu7fO5Y2gSRi7mA5Dn/mq8XL69ksB0mhVbQv
         bTtZeFVCy5VtLg1RIORaJC3vINZrBJV7LkckloXSJyaGKEcm33enzrv/ipeNM8CJ1rKy
         3VbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3CCB4d9Gp0bO5n/BPTAi2TyKE26V1VhpZCW4jOnr7QcpEzDV9lJkUDL7j9wGtg3rK/iyVDTibYMnv@lists.infradead.org
X-Gm-Message-State: AOJu0Yy9+oNMRrwePwPH1qwwjICt9aS85SndiOxpKjhnGkVpZTR5ES2u
	9Vl55ew183Ye3EScixcMz6TYAiZojgLJ6wshbDSB+w8W7778Tjho9lqh2w==
X-Gm-Gg: ASbGncsvbUAEKqrrbHrrGl0xyV1X3bObOxoZ7BXNGxtjO9PdpxDJEQkRaFlv23mRiPc
	wr4OqZVYlEfUYyYtOn5sVm14Sp5FapzQC1/xKySHmZvWWLfJnric+2dDHO1dftDlkqZ5hYBJvub
	hELXYfVUz22G+dxPc7XskEG6goLzvvCRiDhO02hSheysGZeCK96xsOIYzPZ13U2uWP4ak5Ah9ds
	kvGEWUjI0e8HdxoHGiZ+OtgWXWFOFFDlb9WiYN3D9eB9k+X0VvFdkn/zO4bhQtPm078E6FThIJs
	1tBrCMei5yroFewPOBFSn0AAp4wBzihg3dfVMg1Z
X-Google-Smtp-Source: AGHT+IGyfiLlc5zk1m+1N6ov0KEZBCP+DRqvt49C3xYwLz0SqVP+0GOUMSfuvhF8719MVXHPYSMy7A==
X-Received: by 2002:a5d:64cd:0:b0:391:2ab1:d4b8 with SMTP id ffacd0b85a97d-3a07aa5ad8emr625023f8f.1.1745620074950;
        Fri, 25 Apr 2025 15:27:54 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8cd7fsm3569868f8f.1.2025.04.25.15.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 15:27:54 -0700 (PDT)
Message-ID: <573b29ed-f9f6-4c1d-ad2e-0451f594e1ea@grimberg.me>
Date: Sat, 26 Apr 2025 01:27:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 3/3] nvme: rename nvme_mpath_shutdown_disk to
 nvme_mpath_remove_disk
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, jmeneghi@redhat.com,
 axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250425103319.1185884-1-nilay@linux.ibm.com>
 <20250425103319.1185884-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250425103319.1185884-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_152756_609468_EC8125A4 
X-CRM114-Status: UNSURE (   3.88  )
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

