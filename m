Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC4AC5B56A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:From:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NxCs3SGLgzpqRiyM6yyv2hcenRQh/KlY76wZFHl2pjk=; b=kj1yaZPJwk0q8tmDj68tDGdNGT
	h6PB+5qJNwQRHDJ2/rLQc61O6aN1j8uiA+F3b7RMjkJAANKEqiwBdB5E23U2VNkqWo8R0tHg0g0qC
	u44LwFWGshddypPsZRlqh64/Y9Z68Gtx+MVePG06SLlvsBRpAa/On4YCGp/xvWf52AUYh28gXTTQ6
	AB4njX69w+8oLcMeRUzmXFAaqDEXeSud/dnss2pvRmu75HSZKqG4U/Adm9EM9apNjRjswECVQ98h1
	SHcx3qnM5IUEw2TQfa91tS4K8hUqF6a3f/RmZHc1VHkqNEeXRF/qxzhBtGsUmrJ+fbGKf0BTnVxT1
	U7FOqdDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDSZ-0000000GkuT-2ews;
	Wed, 12 Aug 2026 18:13:51 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDSW-0000000GksZ-3Xcb
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 18:13:50 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so155395066b.3
        for <linux-nvme@lists.infradead.org>; Wed, 12 Aug 2026 11:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786558427; x=1787163227; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:to:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NxCs3SGLgzpqRiyM6yyv2hcenRQh/KlY76wZFHl2pjk=;
        b=nDPC2duLp6T8wkKpwkwfGqHDNOF5rZnwyYQKIn1k6kRZ4nYKq6xDqc9yfhCbu6+PLZ
         5BKsDtCFT8lhYOsdW/Pqzs3edoBe/2RM6sV+uWTDIQVzUuUQUeFX295Sldw1pT/0UPmL
         gUbru5iS3K5YTe1WFQArYbvjNBSRHtSfh8IVIPY/b/T04dY6AkpUZBMA81RMt/eJTCKW
         IILtuNjIYJ+ZIwS2b3MYprIVV+GjbBL6htmvtv5qk4MOTgCjX96F4EQucRsRdLiFyuJD
         5pq4+d/bCFjI6wDw4U2Fz0RrfSzgHWRd2xxNA40vfLV/0KvPopJIFkteoz11PQ/D/LMg
         SGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786558427; x=1787163227;
        h=content-transfer-encoding:content-type:to:subject:from
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NxCs3SGLgzpqRiyM6yyv2hcenRQh/KlY76wZFHl2pjk=;
        b=Nt6bqjmZ3zJrFtjvKkvy7N3nS9yCktUPA7q+Hc5BZU8S9V0QojC5P/P8Iqeri21mEp
         YWMzp69M3SUsrShs+PEb56bdg9aPQTt09h1iBpCAKGWBJTDj+FvgsKszHCqLBMYggXsr
         sQeMse0ZiCOyqYYKkfVLd1DTfKym7WxFTJxE/tzIIvOr5dvvPnzlhm/IZNqIxqCwkVBv
         4ko9Q2z3jv/WFnGuTdbZHhNOkhmB2SFG9tBFREWBimpaz/5BocEESKCH+gdhkq6JrfUO
         dVkScz8MPBUi4W2P63SGU03ApJfXmEFUWuUNMlrH4M8QWtGcgG8BrCagiIj8o3GcOZUd
         +rNg==
X-Gm-Message-State: AOJu0Yy/wwwUYLi+6ViPd52+SoXsN0qJlDh+0IYuSdZzKHJ30p5X9cJ+
	TeM7kXnbCT6YZbECdQVoxqUwzaQ8wOfePMgn05gJ6mkciUThPtgTmp4R47f6pg==
X-Gm-Gg: AR+sD11uxI8h/O0l9uogc3NkV9G6j2ujjFngMnjDJpvMYNn6L8AhA/fJIBomOU7tFLY
	t7avb1qiAKl9Fk0XAg7CG/v8tMhAa7pXoYekS07MeGG5+JZO+8T7hsZ0nif/7qk/CYC4et/nZZa
	nBqZ6DPoq4fimu9t0i1FEGEtLPzvEdF2UeyVIJ0aQTr2/GuKsJlEtIcMWLl0/g3j52uudlki+4w
	UAbXBsO3r7Y42TyusHFv5vlruZjkdl6B8c547/g8SyzKZHKu9p++EDKLW7WgRa+Ms7JLUQqOz7P
	mD1jYWCtmfH2gIKH35u0BXbsesMWH4F43XfzNnsM69UL0/FQl0tP3SNCoe3L5TvjWiDy2/0BeOn
	chIY4HlhDiaZ0Ki1xnxHTBINt2GYONCsRuLjczgcUjogdj3sT/F9gJOFRewpbiFVgC11UfWryn7
	xEg8nz0CfzDnKhApBxIHD+QrH4VXkuWlEIvLc+UrlmUA8aDjLdAOYGPSk+QZCLdmh7
X-Received: by 2002:a17:907:9622:b0:c15:dbc7:a6c1 with SMTP id a640c23a62f3a-c2108b1a284mr9640866b.0.1786558426746;
        Wed, 12 Aug 2026 11:13:46 -0700 (PDT)
Received: from [192.168.0.111] ([78.137.12.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c210887680esm2671066b.54.2026.08.12.11.13.45
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 11:13:45 -0700 (PDT)
Message-ID: <7098b4f3-8ee9-4e80-a517-4204726308a0@gmail.com>
Date: Wed, 12 Aug 2026 21:13:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dmytro Bagrii <dimich.dmb@gmail.com>
Subject: Workaround proposition for pre-2.0 controllers
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_111348_900815_45FD63A9 
X-CRM114-Status: GOOD (  13.95  )
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

Hi All,

There is a known issue with pre-2.0 controllers that causes non-volatile 
ErrCount to increment at every boot. An example of such controller is 
144d:a808 SM981/PM981/PM983 NVMe SSD Controller found in Samsung SSD 970 
PRO.

This is definitely a flaw of firmware implementations that treat Invalid 
Field in Command as an error worth loging and incrementing the counter, 
rather than simply return an error code. However, it is unlikely that 
firmwares for existing devices will ever be updated, especially by 
manufacturers that no longer active.

The issue confuses userspace disk health monitoring tools and make users 
prone to overlooking real errors.

My proposition is to allow to workaround the issue with a quirk flag. 
Since it is known that specific controller does not support 
nvme_admin_identify opcode with cns=5 and cns=6, issuing these commands 
can be omitted. Using quirk module option allows users to decide whether 
to workaround the issue or not.

Whether to add a quirk to nvme_id_table[] for known affected controllers 
is out of scope of this proposition.

Option 1: re-use NVME_QUIRK_IDENTIFY_CNS by extending its effect for 
versions >= 1.2.0, not only for 1.1.0 <= version < 1.2.0.
Pros: Minor code changes.
Cons:
    It's not yet clear to me whether the driver can issue 
nvme_admin_identify with cns > 6 if controller already rejected cns=5 
and cns=6.
    The impact for devices that already have NVME_QUIRK_IDENTIFY_CNS set 
but claim support for version > 1.1.0 is unclear, if any such devices exist.

By the way, the comment for NVME_QUIRK_IDENTIFY_CNS in 
drivers/nvme/host/nvme.h is misleading: it states that "The controller 
doesn't handle Identify value others than 0 or 1 correctly" but 
nvme_id_cns_ok() actually allows cns values up to 3.

Option 2: introduce another quirk flag.
Pros: Independent control, with no devices potentially affected by default.
Cons: More code changes.

I would also prefer to leave ioctl() behavior as is, allowing userspace 
to issue nvme_admin_identify with any cns value.

I could try to prepare a patch if the idea isn't rejected outright.

-- 
With best regards,
Dmytro Bagrii


