Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6356C47DD9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q6HL5mz3men3aXqeSIZfRDeBbJ39BbseeMmPygiNxBI=; b=kBsaAceEkl0WQV65I83KIUUfyx
	BtcNdEjbKJqhqyOu8k+6Tzh8TSZTO1X25bTEuyQh4vuomWm4ZPNQMwDgkraMNY9iNDbAc6DPGCxCc
	Vn6Tznm1llxIEl6CtTSxgkB34msdHdAZgseFHEnhqXyX0QPhliXLINSZR5WEp3IlXLs67CvRsy9XV
	4auDSNbb9ukEUGo30rHNNhUJMJhYKdX5PQ513j0KGjAH0vZLskVdoY9p7JFZ79HNQa25kU0/5Jmxm
	DukrxPBY9+a8Xe/HEFrfK5p4GbM4mHSjNFRODNamwbdxtWLRmsNFVvyqW/hpB2MMJ6CQCIVZxpCHO
	y0nExW8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyL9-00DK6d-1E;
	Mon, 22 Jan 2024 17:44:07 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyL7-00DK5e-1z
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 17:44:06 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3392b2b51ceso97698f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 22 Jan 2024 09:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945443; x=1706550243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6HL5mz3men3aXqeSIZfRDeBbJ39BbseeMmPygiNxBI=;
        b=YHm80uLYrqbryw82qDrN+Bm6yOloUmcvBHkvNKteozkhjaL62C1rXDfPHrcnae1ZrQ
         OA5yKJc0UnWI0x7gHo67N+ijEqDSqa5ptGnKEkKpxjSilQJ9qUR/ESUsKqAGjca/HERf
         qp7NoZTVk2nMh9TVYAD22QHHwEYZwy6Tpit2Samtu68PKIa3dBxwJH3WnPQDZdFkPBrl
         Y9s/bKxrDXLCUl/M6JGQXboI6e9DY0lk/Gf0abXliptyy091wCvUuw0W1Se31CAMBGxB
         +3yGS0Vvp7jOFF10BOkrVAtxKqjpnWnTEgJVJT+OtJ2ELo8fMlhssx1agfmB5NKhAgQ7
         vW6Q==
X-Gm-Message-State: AOJu0YxnbCp+OjYNyj8s7zbd7PXx22zs6falJ+cJ98e5ufu5TGx1ZuD7
	gd6xkYSgMYvxv2R2f+fNWpTnb9UdNPMHmLoa7HrlooX9ZFYa1zVB
X-Google-Smtp-Source: AGHT+IFPI2TU5StHJWPjZKmB/Z24OW8kolJW8y/ZGk86QZ195Hlo7SF8wJLQwA2gnDWld9etcQVZFQ==
X-Received: by 2002:a05:6000:184c:b0:337:bfd8:65f with SMTP id c12-20020a056000184c00b00337bfd8065fmr6715067wri.1.1705945443305;
        Mon, 22 Jan 2024 09:44:03 -0800 (PST)
Received: from [10.100.102.67] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0040e4733aecbsm39744487wmq.15.2024.01.22.09.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 09:44:03 -0800 (PST)
Message-ID: <c807f58c-d1e3-4c6c-a505-2658da14ac95@grimberg.me>
Date: Mon, 22 Jan 2024 19:44:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] nvmet: introduce new max queue size configuration
 entry
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: israelr@nvidia.com, kch@nvidia.com, oren@nvidia.com
References: <20240104092549.25721-1-mgurtovoy@nvidia.com>
 <20240104092549.25721-8-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240104092549.25721-8-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_094405_653380_5EFBA387 
X-CRM114-Status: UNSURE (   4.42  )
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

|Reviewed-by: Sagi Grimberg <sagi@grimberg.me>|

