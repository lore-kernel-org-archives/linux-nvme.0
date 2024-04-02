Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C025C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 06:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ZpDpHuvqRkPr674LQuVEJQ8beI/LgLV+GDkIcfhzig=; b=CAFNkCWK8rnRFDzpY3+CMuG6rf
	e3wZTkejncNx5XsNfpBZzNv2tLLmqq9XCXpbdx4EI6LluTjgRNg5uHgxeEI6wXfNZS3PIv88m6Mwc
	xG8gJzQqDYsYn1Kb/qKpAtB8y6f7Z63zQcP/7dz11z0P3kTmj/uNuDxWPAy84laUWmpKj/V4I6Lr+
	in6A5niK3IpmLgMlSRTCzTZNIT+o7/Q/r+7jFMBoFb/jpgyM85TA9KNaKtu3koU/knPiWVNoyxl3l
	iD75CwD/2cOPX+QDngQ/c9+v/Bl4rfVeAVwc5bgzfleGhM2QNtjmBRuGMYF0ucHn11euJxlUShdCo
	sbUfJM1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrXrb-00000009wtP-0Kqx;
	Tue, 02 Apr 2024 06:43:19 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrXrX-00000009wrc-48cc
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 06:43:17 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1def89f0cfdso42999205ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Apr 2024 23:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712040193; x=1712644993; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ZpDpHuvqRkPr674LQuVEJQ8beI/LgLV+GDkIcfhzig=;
        b=f6Cui1OksGmQIghUov9HG/IARE3WMYRcFKejNjOoH7DAiYnzetZ/fSV8QkoGqrps8b
         pXyLCwy0HRp5Lm3GsSn2459APNfbT6MW3z2Q9k0sGFxj50AqmLDDkxZJw5fWaMN7lf7a
         5D3/Ba4bouE9Gp45daMbwAqCjViQwBYhgdzN1qw62s/XaC+RW7uyR+TGT7EapwaqoPKS
         HHJOMHspk9Y5/OiKa9ldenEcTHaSgNprGgTiG0Ifwgp7JcEm5zAYdyocWupJ/4snTibd
         XY3mZnd7aHXtGwmHHeQaBzglE1SYrqO5LYF+revs2W/VQelemGazaftnvuFGKxdQwSFK
         ABQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712040193; x=1712644993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZpDpHuvqRkPr674LQuVEJQ8beI/LgLV+GDkIcfhzig=;
        b=A11WO3a1iBsfQiQYqtz/nqYoiGU+Joec8KaUaXj3yUdITvsB2GnXMv+K0Hlz16e2a8
         7wCAkohDbnlxcF6snsMu9Q6Fj5iXctk3ShqORrHe/ed14jg382IdwKP2XIgzOtQ8fwI4
         CSWHj/uwvD/qvkDNAaIFozbfqI0/xPQSAgkW+w7IhxUlVZKwoWuS7rN1wYMjbyE9Uya5
         WheniWoKWOzJZIA+/33q8QWPzx8oO+iZ4WjXIkpgYqu5PSo9ZmhsBmL3uwn9mwoD9J/d
         4VgEmcBIscGzF8NhmjXLuo4PxtFgGWMkH+3YTiKqNHqGZV3i5a31Jp/DJekPkYAtoVKF
         T88w==
X-Forwarded-Encrypted: i=1; AJvYcCUf+S+NFsJEUy5SJqFTWu36oUfmmmgqywdW8jTwt9uZoxiouvCu5OXp6ETuJWX4GC8hxarW8y0K2CBx58pk+k1EjRe8XLh81m7sNBynHOA=
X-Gm-Message-State: AOJu0YzhOwaoVT2LZRCA9zRPEOJFIiCm+c4bcRjyaPePG/b26RtA6MQH
	zotpfD06mkpCZCvx40m8gnlfJd8es5OZmSee+SXsealtJUIy7YYT
X-Google-Smtp-Source: AGHT+IEM/srVZSPtUycGFnEMMDCOvK5W9K0Azw0ckKfS6iodyT0ENHw+o3pbopHF/L9b6DtyRXWrOA==
X-Received: by 2002:a17:903:1c4:b0:1dc:b64:13cd with SMTP id e4-20020a17090301c400b001dc0b6413cdmr18643219plh.27.1712040193389;
        Mon, 01 Apr 2024 23:43:13 -0700 (PDT)
Received: from ?IPV6:2600:8802:3800:75a0:2378:fa3f:c6b3:24d1? ([2600:8802:3800:75a0:2378:fa3f:c6b3:24d1])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902bd8b00b001e0c91d448fsm10141148pls.112.2024.04.01.23.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 23:43:13 -0700 (PDT)
Message-ID: <a4791bc1-f523-42fe-a00d-2cc92b35670c@gmail.com>
Date: Mon, 1 Apr 2024 23:43:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/30] null_blk: Do not request
 ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-18-dlemoal@kernel.org>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20240328004409.594888-18-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240401_234316_098829_CF7DBF5F 
X-CRM114-Status: UNSURE (   9.29  )
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

On 3/27/24 17:43, Damien Le Moal wrote:
> With zone write plugging enabled at the block layer level, any zone
> device can only ever see at most a single write operation per zone.
> There is thus no need to request a block scheduler with strick per-zone
> sequential write ordering control through the ELEVATOR_F_ZBD_SEQ_WRITE
> feature. Removing this allows using a zoned null_blk device with any
> scheduler, including "none".
> 
> Signed-off-by: Damien Le Moal<dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke<hare@suse.de>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



