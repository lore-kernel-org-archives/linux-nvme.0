Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0398ACF34CA
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 22:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aKcx4mSd/6y//cnPDUFf8gQTgd9+fKKEcuxJUXsGmAw=; b=VQdEvwo0HkXBawQbP9PpsglJX1
	zNvdOmYxVsKInFurXxQ+Vtrq/4+83cE3UELXBCWBqHaYHQlmxr5uU+lSCSxUvkpaM4ckf1fJlB7ZD
	joiuiI+SN9m14mMA4YK7v04JFc8p0ifxhYvbcS5aWv3037xFnHSgsZYmLXF4oZ8hui1CAheXoPfhe
	NQmmU5F7nCtLkHU37axjrgDAEk6ymxDOij1YZHpUwtkIOXbqIVja5ncRXeYPgi8LZXviHvjE0OPwB
	J1wb3UTqV7H5yXz5xzlxr2N2rJ5xrDJDvkzOl88YPCyZjhZrtGrMbeAmbKLZ0BLNtRze8sq81vCp6
	vXyEk/yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swU6C-0000000AUhO-3RO0;
	Thu, 03 Oct 2024 22:15:04 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swU69-0000000AUgI-1OUd
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 22:15:02 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2e07d91f78aso1176277a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 03 Oct 2024 15:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727993700; x=1728598500; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aKcx4mSd/6y//cnPDUFf8gQTgd9+fKKEcuxJUXsGmAw=;
        b=01VcmyadwsE0ZOC62nvzLlpjI4Z89R8STvu9CSIIrKSLTukwlSVDkjF933upbanPv0
         MtVD+lqC3uS9kNQXstOMr+uox5iWmWlFc7qi6nTOdh5cREq/f1XDMu227KSnUCEIJSiQ
         Id9/A5Zfl9ptVXYLeMnl/JPef86ZuLxzxuZcOAtwMUKVGlVYN7km1Hxztekj0sKxR10c
         Wym6AHAsRi+SguNZgoBAuyozU9viQ1SNyWkNz3Id999e2/9HvblCbYNyJWqed4jsE4lU
         P86vaIUQioEJ98fSy2O3pEaMSa+JYcwulvxdUkE3ii9E0Wnvc/WmoynizcD14a9megpp
         pcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993700; x=1728598500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKcx4mSd/6y//cnPDUFf8gQTgd9+fKKEcuxJUXsGmAw=;
        b=HhkQECB+awvjYA94K1dpieg0oHmgDUPnIBlOgWG5GpB5e90TyEYyLbyjHDUh84IJRL
         1lf4A9zYdjMMVVAUydX16DA6QVnPru53+7BT0LMALkZwS8bJ6ZFHJJpCay/cpmUsApEm
         cgiAwNZZSfrB2wtUi/FJTuSMrbuOeFz9dyc8hWU7EbLraYpdAMiVUseQxMwwlNMrhHs3
         cHZCpoLDxB+y0QpsJU6IjDsCgR8JBkcMDZWzHKMnTxp75diBEgNPq6HD+SDxqoWJE83Q
         fpErZQDwJmidiEayDKQiogxTFqwONXnz+LofOfvSsZWHZRGkK/87s+WeULazEbiVy8Xb
         QM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUr/eegqbKU0AspEr1VIuZiT1F9TMvPAY/lwFbc0mwVGjplKXx5tUaBUBW+BiIci5HjdrZgUZfRUNIv@lists.infradead.org
X-Gm-Message-State: AOJu0YwVnu0dlc1X37s66cg13nnIrCWwCF74VcxVBXPqsYzgSf/ZPU8p
	/8wuNKUBM98GBlsJa111G6G+rOP0J03WlwXqYO7u9NmEUlnKNYtxWqEYaXhdZ5U=
X-Google-Smtp-Source: AGHT+IEa8OibXU8u5AU9dURn3INaVlJRzRZ2R5VooIMzXfRbVR8kevOP6FlKzcqQxHqYef2QRhpO7w==
X-Received: by 2002:a17:90b:224e:b0:2e0:8719:5f00 with SMTP id 98e67ed59e1d1-2e1e62a93f6mr663348a91.22.1727993700011;
        Thu, 03 Oct 2024 15:15:00 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e8643534sm8913a91.50.2024.10.03.15.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 15:14:59 -0700 (PDT)
Message-ID: <c68fef87-288a-42c7-9185-8ac173962838@kernel.dk>
Date: Thu, 3 Oct 2024 16:14:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Christoph Hellwig <hch@lst.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Kanchan Joshi <joshi.k@samsung.com>,
 hare@suse.de, sagi@grimberg.me, brauner@kernel.org, viro@zeniv.linux.org.uk,
 jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
 bvanassche@acm.org, asml.silence@gmail.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, linux-aio@kvack.org, gost.dev@samsung.com,
 vishak.g@samsung.com, javier.gonz@samsung.com
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de>
 <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
 <20241002075140.GB20819@lst.de>
 <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
 <20241002151344.GA20364@lst.de>
 <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com>
 <20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com>
 <20241003125400.GB17031@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241003125400.GB17031@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_151501_430665_FCA41916 
X-CRM114-Status: GOOD (  13.81  )
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

On 10/3/24 6:54 AM, Christoph Hellwig wrote:
> For file: yes.  The problem is when you have more files than buckets on
> the device or file systems.  Typical enterprise SSDs support somewhere
> between 8 and 16 write streams, and there typically is more data than
> that.  So trying to group it somehow is good idea as not all files can
> have their own bucket.
> 
> Allowing this inside a file like done in this patch set on the other
> hand is pretty crazy.

I do agree that per-file hints are not ideal. In the spirit of making
some progress, how about we just retain per-io hints initially? We can
certainly make that work over dio. Yes buffered IO won't work initially,
but at least we're getting somewhere.

-- 
Jens Axboe

