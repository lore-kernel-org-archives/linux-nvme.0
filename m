Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE23CEACEE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Oct 2024 17:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tAN9+Fgd7PdcO/S9osl9BZBdIn0Oo+OHK8n02sQXHo4=; b=WG58NQWQZ4rCX3Ueu7fS2+/jVg
	M6lC+vd07JeD0x9hYP2iP+AK7Q8D2IytqBPlhHM+L5JpHYAB3kCIhHzo1r9Sgi+kP8Ly2KQ9leDqT
	BK/AWFSBCZa+8pwH/bUjaYn9KBDRFSP8YVjfDCN2+jf6lmGzzVTGIo6vutQcxetEDYaqgU0PY6Kle
	eRilEKoZXKARmMSx4iGRdNjothklbtqKiM7JrlJ3kAOc/ItqrUaP/52iPTX/p1GIVx2RsubRyFZC+
	jT2J5++jcWy3cGfxLcHjIN2t1rttIxt8U0QSLV4T8nkfYUuiBDOVZxkTRSYUxmvXE+Ze+fi4+lkPU
	aMSot+oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svgiw-00000003fHj-1TFz;
	Tue, 01 Oct 2024 17:31:46 +0000
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svfaH-00000003UxR-1PGp
	for linux-nvme@lists.infradead.org;
	Tue, 01 Oct 2024 16:18:47 +0000
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3a3445ab7b5so15310615ab.0
        for <linux-nvme@lists.infradead.org>; Tue, 01 Oct 2024 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727799523; x=1728404323; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAN9+Fgd7PdcO/S9osl9BZBdIn0Oo+OHK8n02sQXHo4=;
        b=FYBj6MFInD6YjMuAXDNgND0Gdigc9Gxfkl5Yy2W17+GQ0Kzqr7EElivE8NjpcWBHtW
         hQsp762IS6SCc4hKVul4qkU59BGMmQfGN+A8sfg3bp3C4TZq7c+/jZEx5irOM2GhA+gB
         f86uNaZED4CmEI6UTTYmL1djL+ppxmFNwX2S1djS7LEAnUhlkKRtaypKMeWKXxO29hXu
         3c2SG8xAmOn/F1ZeAmi4x5EvBmh2VWyNtXqsAipTmSRiWNm1IZiWuPbVFam2xilJQv33
         WVGwsJDOdU6gPBZvDl28NRPwyjIJUs4B4v5UQJ4TOTTOUsT9W4DQLdS//XCJo88KslPM
         BYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727799523; x=1728404323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAN9+Fgd7PdcO/S9osl9BZBdIn0Oo+OHK8n02sQXHo4=;
        b=vns9JBDMJXiQBU74LKU3zVpu4cRKSUSiH497ih+4cMig5L2vRw2SpToWvB7XU9FKxj
         FfmcCdQyW+JwuVw0dVSrPiRItdPDo4roVE/HNDJ1M/rgDNjyflu5PaC6KvDKancQbLzx
         DLnJeo6NwAxVOj0GKTsgeHHLPApJMN0YtjsN0tUp34MR7WQrexIXox8FQZPs5qHNwkpk
         /yFM+XAu6fqvkbRmiicQLUyE8iwSq0P0AfWiDJ1tISJfI9IHTkgk2AH/M/QrG3WQglxm
         nexvLn/IcRVQcI7BbKX+nOe/cvsa6o8lQmUjLv45ule3TEAFbQdVsEZJR9GgxH+7UGkz
         M4ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm9afa9WZwf0CU88wDfVp/SVZRDqHOw2MXERkrH+N7UJvuUTcCsQHRMgCzp53uFeSJKciiiBnJa/X+@lists.infradead.org
X-Gm-Message-State: AOJu0YyiLiPK3EeZdiqNpyNxGD/1kyIfe4EBzkaS3/IBQ5EmWpYPY3Jp
	O6grQOrlNILf2xZ0xnRJrAt9YRLqZSMUdvR31LgGg/PJLMp3XsXf4eztxS+N3mQ=
X-Google-Smtp-Source: AGHT+IEVRPJ/uF7tZwik0ff3xUr95buoTs5S0Hs3+xr4rSMiaRrnSDjMAIRQglj6MrbFnKyykiXTPw==
X-Received: by 2002:a05:6e02:148a:b0:3a0:cc84:9859 with SMTP id e9e14a558f8ab-3a35eb6177fmr28452955ab.10.1727799523118;
        Tue, 01 Oct 2024 09:18:43 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888c2f4esm2640662173.110.2024.10.01.09.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 09:18:42 -0700 (PDT)
Message-ID: <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
Date: Tue, 1 Oct 2024 10:18:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
 martin.petersen@oracle.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
 jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
 bvanassche@acm.org, asml.silence@gmail.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, linux-aio@kvack.org, gost.dev@samsung.com,
 vishak.g@samsung.com, javier.gonz@samsung.com
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241001092047.GA23730@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241001_091845_744081_58ACD05C 
X-CRM114-Status: GOOD (  13.03  )
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

On 10/1/24 3:20 AM, Christoph Hellwig wrote:
> Any reason you completely ignored my feedback on the last version
> and did not even answer?

Probably because he got a little tired of dealing with the bullshit
related to this topic.

> That's not a very productive way to work.

Have to say, that neither have your responses been. Can't really fault
people for just giving up at some point, when no productive end seems to
be in sight.

As far as I'm concerned, this looks fine to me. There are customers
wanting to use us, and folks making drives that support it. It's not
right to continually gatekeep this feature just because you don't like
it.

I need to review the io_uring bits, but that should be the least of it.

-- 
Jens Axboe

