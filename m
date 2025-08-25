Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931D2CA0EFA
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 11:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sM4hZ1puiRHKUqzwGkov59Rx7fxdUJpK7AlV9haEfhw=; b=2ZO/MwT+GsHytvBNMRzNjOsOoa
	HoW+tmUMx1vlOWO0W5fsC3rMxTRkrR4NRsoBJe9P6anHQoPLwK4xY047NkprKHN77Ajk9U8Sh/KVg
	HHLw5fbbzVQ3zp5aImetEhxW1DsN3jWOFcKDYNWBHsFnizwh4/rwI05qOzmdhtxkWhDiCA3/TVFP6
	h22Io0DzG+6wGztE02ZdNDZokOqFwmreElunufZ+FNF5cyR9fmfXWC3mL4RX8bdiMOvYf/9SegCVo
	UgqO98GBjN2uIunEIXad7E/ktOD0Um1l+2UZ3W6tG4I+YLidnCQcXH6Wi9cL8pisLqVbFl8lVPa6j
	ywVnJ49Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqVNV-00000007kUq-3gNp;
	Mon, 25 Aug 2025 11:28:45 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqTRO-00000007UWl-1j6q;
	Mon, 25 Aug 2025 09:24:39 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-76e7af160f1so2830249b3a.1;
        Mon, 25 Aug 2025 02:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113878; x=1756718678; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sM4hZ1puiRHKUqzwGkov59Rx7fxdUJpK7AlV9haEfhw=;
        b=Bvbrznu10X2QG5WGf2nFCh0coPrmFC5mUPRIaHeGO8P0Psvt8zXVUAQCyC3eFdTB/g
         +yI1LhftdwBEacmD9QazTqv78lph08Y2HuLyH2xYbK+L1Ssz0uxB7RAg1KNWXgR3mSMw
         pFUDHGxWmDboEDg/I7ugcNfevMLER7UBUy75ZSlLPMhSGTalS75C6SNjaFGSAsY4reUO
         3DsCFmFP+ZGXQavugz6js1AGjjLkU80C3rz5gr+5SKQAkVgH1pq3I5oZVdAJRY/apr2A
         oHTEXAxRFcSoXhgsqqpO1DuEDg7CHtUx48RcyJRFbf9cVAeMmWkrJe1ZKhdOiFiwj7+n
         9QRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113878; x=1756718678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sM4hZ1puiRHKUqzwGkov59Rx7fxdUJpK7AlV9haEfhw=;
        b=EQThSan703wPiJnHkpk9g9ftkf6EjuzN2Oprm+8mG51/iOsNz5brz/Wm3W6jTJfFzY
         c4GrAIO20/nr17hTk6kay6zLBHVHGNA8kAu1v3x9p/csWwK3EU7ApDzAUMnBLSDXzLhA
         zRR9FpwPe5rl6XG4bVfkBD0luis5Na8UtOVu3HaSbxAgitSt0FPNufdYDaW18HSUTTIr
         c7k1Ku7TVyFp2TBUx5hYJ1JinYMrLWXc7NOk0CuCtXgKIU8GvhocGz9z5qIZKHtcOFaG
         L09rRlB2aeCjgBx59IZTfGAJiSd/HtVnb/WjJI98vu0d0anEFZ2M8yKnQDCoRADOgUOx
         aagg==
X-Forwarded-Encrypted: i=1; AJvYcCVTY7H0NTnK5EKakvN1KnNZPMx28UB8IX/xZkfet4NS22WoPk+vGn41svAMblDn8UHhsAXqqZiPHL4H9HJAJftZ@lists.infradead.org, AJvYcCWo+vaDN/vestS8yCDNHAaqQVnBCB+mnu+R/2CvcvDT9eg1tzOM+Ig3as/iZUslqpID/wzMayQd9zp5Kw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzeWkfTT2Eu+1hL2Dwqd+oPBafavKATiGIeNAdxGMp7NqcV39uW
	jmhVe719aeVuRI2IRl1cNw56X5ETWWcUZFi0KqfYkba0Qo7xhVXfA8NB
X-Gm-Gg: ASbGncvhDgusNE7EoPdPeHKEBWqN/kSreTGmOE6s4EfCAEG4qT5UTChisf/AVvDxqFw
	rj72uangPynZxoQIT4NP16s2LzZg0ppL1HJCtn/kduqXIx2BWxtthp+6JmzBXH1Djq19S27bLML
	LKTVUruV2j0NK3yXlBrAFb/g/TAzABKFQnZ+e0lFTdEW/BCt0ZHcuZmWPP18ZReDkrg62FzMdjQ
	y9NUFKIMtgC+VAPRbxt6p4iZb6BWJ6wiclUZbQ3LzfIvs3kBwDkVu+u3BjmUvIXdoREc9xvWH/3
	9uOo86X9ZMCRFsJMPZEFydqkQsMcJQgfJUjeYhHlQNETjcYZn6BddFGAAnxqZtT/gYum3TAfHYR
	pA3VHPn9qr+yjKVyl3LLDcZqtHeBBflve
X-Google-Smtp-Source: AGHT+IF2Lj1I/oMHmRomgFUcdk/gVeJ+3cAJcySQ+eYOGXApg2tOeqaENjSgPcrhwsxhI+VbRT5g3A==
X-Received: by 2002:a05:6a20:7286:b0:240:3ebe:ea34 with SMTP id adf61e73a8af0-24340d2bf18mr16359852637.33.1756113877525;
        Mon, 25 Aug 2025 02:24:37 -0700 (PDT)
Received: from [192.168.1.111] ([59.188.211.98])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7b375sm6121879a12.29.2025.08.25.02.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 02:24:37 -0700 (PDT)
Message-ID: <89826428-4a54-435b-b564-b0be49b8c7bc@gmail.com>
Date: Mon, 25 Aug 2025 17:24:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add support ANS2 NVMe on Apple A11
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_022438_452484_44884BD9 
X-CRM114-Status: GOOD (  11.21  )
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


On 25/8/2025 17:15, Nick Chan wrote:


[...]
> Patch 6-7 adds support for the NVMe controller found in Apple A11 SoC> Patch 8-9 adds the required device tree nodes.

A correction since patches are removed:

Patch 1-2 adds support for the NVMe controller found in Apple A11 SoC
Patch 3-4 adds the required device tree nodes.


> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
> Changes in v4:
> - Remove the remaining added long line in drivers/nvme/host/apple.c
> - Drop already applied SART and mailbox patches (based on top of
>   apple-soc/drivers-6.18)
> - Link to v3: https://lore.kernel.org/r/20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com
[...]

