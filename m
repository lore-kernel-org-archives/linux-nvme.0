Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068A2E7718E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2024 20:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j5J3/RmK37VMndJ+ng5woBQlhZld9vGGJhdS8VQxeTU=; b=y6L2wLMUenPW9tU8WNcVCjCT7n
	ODLUaHAfP6/txJFEWNROn9wvE9qUpF7FGlJ7mbkYR4wjw11i0czJsm18WAKpXf1tWLF2fL02EoczH
	fe1ldMr6gdydRMLa4/msW64vjDnSnNFferTlE/3Aez1j5BkzDrUSCvaJv4EM+IOQAXydFDtz4+z5c
	57v05XIfLPXxkRhOVOxUKTgX57Dx00O2HHbNSmSwWHlYmjxUxC78fY0VDLZCPXUki4VgxYe9pjCRS
	/uiZ64puL3klTMfvkzrtIVw/n8NV6KK4K738J1W4T1lEjnvm6Q1YGoiRbmR1DjcOfYxtRgErvUhwE
	JyRbsorg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPpV5-0000000AkGz-2Kau;
	Mon, 23 Dec 2024 20:58:03 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPpSd-0000000Ajyp-1PoC
	for linux-nvme@lists.infradead.org;
	Mon, 23 Dec 2024 20:55:32 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-216395e151bso30614445ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 23 Dec 2024 12:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734987330; x=1735592130; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5J3/RmK37VMndJ+ng5woBQlhZld9vGGJhdS8VQxeTU=;
        b=ICmFl5lWPeTeyvHhGHm16kGC9QSVug6HqWEouFp5jPl6RZJH+IgxDMvlsHW256PnCz
         3tQzFzgx8zJlFMKglopEdGOHwEafguU7N6rYIRFAAUyl2i+uvlbOAoTQlyrXIQMGetHx
         EXJsNklMWlhetmdqjIg15AGNScNg1E+xEABstV7MrqdMJSppTtOGB3ltetKdoGLxd/Xa
         JX4IOL6vF0VpYJ50uPjoILS6/5w2spptvg2RXJPyNnb+u7dkjhASpSwR1CwL1zBs2Gfc
         hbhsWuy0B5M8tCYOIgC9EHNVjMdSnDuC+Qw+wG3ReYOLq83RMcPSqcr/vA+TwkvIr8jP
         TjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734987330; x=1735592130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5J3/RmK37VMndJ+ng5woBQlhZld9vGGJhdS8VQxeTU=;
        b=QVuYSKK+DkGR9MmvxtL4rUMhXxY0JFdHH9BJM9vLSsI//QDHy/8odfVt6n4GCVYaeE
         pQh+2qeXJR5HNMgednGsAipk5XJt50OVeEMi3IqrKO/L20pn526Jpebsc/ZqCyWBhHG7
         5635q123NCwFATeBCVjZgYP3ilDleVi+dkf643SIoBelssLImWqk7dkuFtVBIGFhc46r
         USB0PIA8WxX2xVfnlZc7Qn2B8Kg6pjm/EHi0q+F+06cSiDFA97x9mJSVv6+MeXord8DI
         TQSwYv7DdWPZErQ9hgG04XfA4AN6np8jflA/mS6eqtdnRnBq/bw+pgFrjCBBY81hHxmq
         LfKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj59IMMHV7M8aaZO5mRlHGklHDUyggaHSdKKJm2NrkZbiLqCkAzNlIXksi9BBE0509fAylGyyPwhCy@lists.infradead.org
X-Gm-Message-State: AOJu0YxIHT/uW769uxI4dlKm6wDtWuUO1KiIOCsv4N6V1dqriK4klrbg
	gEmEnsrSKgOxV1NQlUwZ2aRyx5Z8nmPNjnGJWN5g0XjPZK4DuBL3ONPmdtxJHME=
X-Gm-Gg: ASbGncsxPAl55czH+KxCQsq8r8YuWhogIhY3k+U6zOwpvTZDbjAvqmOLyIbnF0kfyoJ
	QKaJ2vLiG9lCatTaTGkjoBZ5lc5jpf1BCf8yyRWSVr/E6OAK9NBWis2L6v9r9xqhcAk6nWq3VH5
	WuIfbYlrp52pYO9Ycna1z5RR3OVHqque9aBL/SFRV42dt84iqYA417M6TMtsxeHxxAS5YRS5QZ7
	yQWM2cypT038ywMZLx9j4WNxWynWJWaF7ITvlWHKpU/MkY0m3GqYA==
X-Google-Smtp-Source: AGHT+IEWgE+EhGuszPyZ3kVvfPYlZaWJ44Btw4stqijwKKKrA6aoF9URRe9k4cpnxjeiI1InxNPI2Q==
X-Received: by 2002:a17:903:320a:b0:215:4f99:4ef5 with SMTP id d9443c01a7336-219e6d6cc31mr220176655ad.28.1734987330428;
        Mon, 23 Dec 2024 12:55:30 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f7d83sm77971375ad.226.2024.12.23.12.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 12:55:29 -0800 (PST)
Message-ID: <ea8b4924-e397-4ff2-85b5-9efbe63a9e0e@kernel.dk>
Date: Mon, 23 Dec 2024 13:55:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] BUG: unable to handle kernel NULL pointer
 dereference in percpu_ref_put_many
To: Caleb Sander <csander@purestorage.com>
Cc: syzbot <syzbot+3dcac84cc1d50f43ed31@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
References: <6769bf7b.050a0220.226966.0041.GAE@google.com>
 <2f80272f-6cab-489d-ba2b-c1d545ac3485@kernel.dk>
 <CADUfDZqtiT8B_LvTRuzT9QB+7z+7pNqYJd_n2gQYK1d8cKkxqA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZqtiT8B_LvTRuzT9QB+7z+7pNqYJd_n2gQYK1d8cKkxqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241223_125531_384324_34E76E04 
X-CRM114-Status: UNSURE (   7.51  )
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

On 12/23/24 1:52 PM, Caleb Sander wrote:
> This is probably the same bug that is being addressed by
> https://lore.kernel.org/lkml/20241218185000.17920-2-leocstone@gmail.com/T/

Yep that looks highly plausible. We should get this queued for 6.12 and
marked for stable, it's missing the cc stable tag.

-- 
Jens Axboe


