Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B90CD98D2
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2026 20:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a2o1XTR7VeYkIhqu4UtENSoBuqpZfEyKyn3oza9yC94=; b=0ndIHyywTRL28SmCnXps/IIM4Y
	MNfittgkQgKsBoKvy4Mnh3Q/1xrdKEtxlEL7DS/qnqk/xDe+PggNBxbRDXA7aMmLF6I3eLkAOO0M1
	VRKyuiLaO3F9GlU9S0Kcu9GRh24DdeauJ3r5rnBz4Sbyj/NT+m2nvrLVb2DbFxfELu08Z5udGixKg
	DiwAeYqfha73KQzDM7wPP5X54XG8G51JRu8QNkKm79XcJ6u0ips+d1Wqymh3ZjW+Fk+wpJj9lLWgn
	P6HdPY0r8stROU8FLcqfl9Y9ByXfZGsLeW+M4i+Vaf5NJDv1LnlnRgsLKcOTTctWwLzwDMj+Kjq9T
	Yx4pOAEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZaW2-0000000GJFG-45uS;
	Tue, 16 Jun 2026 20:36:10 +0000
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZaVz-0000000GJEp-3NO8
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jun 2026 20:36:09 +0000
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-7e6da33a561so4487140a34.3
        for <linux-nvme@lists.infradead.org>; Tue, 16 Jun 2026 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781642166; x=1782246966; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2o1XTR7VeYkIhqu4UtENSoBuqpZfEyKyn3oza9yC94=;
        b=HbLy6nOhSDeb1P9by0wTjPx2b4ho+vNuNG7UTNclQvW2c7pezElTCmgRH3qj0NnVyU
         KeieRozd+kVkf1W+Y27/nspby3ASIn4TsLtgFdievYT59bXrHMlT8XVyNHsBalmMCS6E
         6OT+ZsW47TlOKprijlTWPYUfmZtu1qzImtip81FOZN7gR3pYc+RLfnzcdypT5yGO97H+
         te+65rM26JSHoRIBto2HcajXXZIdyOx9blWjTjPXpcKr+7j7oIJHrY3r1D+Njf9NvtP5
         73JIeeBahKp8D/4SWCWO/MT74W7KdDwrHhVBwMr18BdOybAqpoCN1s3hsJp64juDOYd6
         GoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781642166; x=1782246966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2o1XTR7VeYkIhqu4UtENSoBuqpZfEyKyn3oza9yC94=;
        b=KCfCm7sEpso+0SyewBL1TT0+uOeKMs7ToQt1HNZdNPtGljV8lzdPkI2ehzP6oqG+Pz
         bOkJGpCs94ewGNOAGOctDzfW7Vy4S2iY0GCohT0edj60pSWbLng5HKhXJF04rjsjGc6Q
         ISkh45Y/kcNJwww3LxnmfqvpByuqaKlZ1K2LbQNvQNtG4KJtQmuHKIQcBJfi/e1TRiqx
         LxB5wrYXRHcqyt29AMuT2YjIlbQMR0cE35xaGc4D7H6XSCnVQ4MGjG/zkCXmVOjVtssb
         WAjwcqZ8/hh1YLgH5TEV3in5d485CaRev726aupYiXZmEoVjRvFydWshjAtxIIGoWaG1
         Ps4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9zAXTw3EJhESwBKn/0xs1Jinaqt8eHh80q3WtD+ARUOjMBb3+59K63CMk4pG6kbI55b/UrbWC+/c5/@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+6R9OHJcnJFTgjXg3a5l1Q03MGHNuUeiGkciAiL+RVp54CGow
	6DgC7Q91roZ5O+PwxOhP2OJoouDtWk4kG/q8FRVGMF81Gc81hcxMJSrAK0ntAI9Yt2I=
X-Gm-Gg: Acq92OHbMkndYGWdoSQL3lVPIMwW7IKvgpnVlQfxagkhYvPbE8b5+iefxhmzcp166gw
	Eswzm9meqnrIKGdd0KQNmNm0f6Qo+VRLn+JuqYkEq4f/2z35JHFJVeU9ULk0ppSMvi7qWK+C3QN
	rcir5XimUJNu87sWXoj69Th/vPK7Bak0VGNfqlcX4vvD8Rkzg7yFFFs8ycSPcUyhceLWJi2fzvk
	iszxT7vJNqcLWRpg2K9Zj2HCqQJ2KIS67jbUc+WIeJRpaTwT1P31rPxBJMeGyJOaSk3Q2Gp8eCl
	J9tckxS7E1xcwCrQWiIkD3FuL+FGyYZA0qTqGqGRlByDEe9kO0Isk1Gr8ZGH8kjaQiTAo7LBC3J
	zAwTWOeM0UREFWzmfg42KM8W5JHEJpChgTEcjBatlbqKwYfkMKPZHVkWKuybRBvjkU0eOd1SPEi
	tSvRSaySR3gg+kLLdrpgROJpue20GfMhGYzt6/LVqpD7i5jGD/Hp3Lx9H59iC9I11H8gEUY6Wrg
	CCOEMMFqA==
X-Received: by 2002:a05:6830:3747:b0:7e6:fd45:9cbc with SMTP id 46e09a7af769-7e90b3b982dmr1104256a34.14.1781642166451;
        Tue, 16 Jun 2026 13:36:06 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6de65bsm7523821a34.19.2026.06.16.13.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 13:36:05 -0700 (PDT)
Message-ID: <fcfa9bc9-4f7d-478c-90a2-ec4efd4c7d43@kernel.dk>
Date: Tue, 16 Jun 2026 14:36:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Landlock: LANDLOCK_ACCESS_FS_IOCTL_DEV bypass via io_uring
 IORING_OP_URING_CMD
To: Bryam Vargas <hexlabsecurity@proton.me>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Paul Moore <paul@paul-moore.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260616201633.275067-1-hexlabsecurity@proton.me>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260616201633.275067-1-hexlabsecurity@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_133608_105101_AC7181E7 
X-CRM114-Status: GOOD (  12.12  )
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

On 6/16/26 2:16 PM, Bryam Vargas wrote:
> Hello Micka?l, and Landlock / io_uring folks,
> 
> A task confined by a Landlock ruleset that grants READ_FILE/WRITE_FILE
> on a block or NVMe character device but withholds
> LANDLOCK_ACCESS_FS_IOCTL_DEV can still reach the device-command
> surface through io_uring IORING_OP_URING_CMD with the IOCTL_DEV check
> bypassed: the request enters the device-command handler (block
> discard, or the NVMe char-device passthrough) where the equivalent
> ioctl(2) is denied. The destructive completion and the NVMe-admin
> surface follow from the code -- see Impact.

I've said this before, but apparently it hasn't been received - this
isn't an io_uring issue. If landlock is missing a hook, then that's on
landlock and they should add it. Other security handlers already have
that. Hence no need to broadcast this to a bunch of lists, it's strictly
a landlock issue.

-- 
Jens Axboe

