Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58520C7EE22
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 23:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBwxZuYSoI2fhFfKRrxW7a8dQIXn2cgowQwGSCf3sb8=; b=dl8RQENsg4mEMmC9/Kw7Jhjsp8
	0kg3VQg+jIxFr6fKk/8SUTGxSodtYVtmaCakbcjoFMycXeWCD6i1gCGtvkaE91vYPGow3sj45tNLl
	d1I9CuqyEPOZECxHhnUpsBvV7gQtcTTX5RER4oelvInWo+NthjMrPnkWGvMujRWsMkYf+pWR/J4nV
	CUXV55ai+uEucpS5QccUIsflNAByr1VU1pEJOZ+MnLJB/GpkL+hakPEblN8nVhvKxuOczSeBrZfGb
	zDU1aXQMGl6Tirx47GArlLIZenRdVxa+Q0Jbz+X6/e8BsEkVlfCgX/D6rSeUyWzhzT7QCImFWh16Y
	LpTs9XOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWmZ-004WHR-1Y;
	Tue, 09 May 2023 23:30:11 +0000
Received: from mail-pf1-f179.google.com ([209.85.210.179])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWmW-004WGr-2B
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 23:30:09 +0000
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6463185f761so540217b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 09 May 2023 16:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683675006; x=1686267006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBwxZuYSoI2fhFfKRrxW7a8dQIXn2cgowQwGSCf3sb8=;
        b=KzCboh1osUVWLWebF/gR9PJSbdVvq2i+mbWHGH9NHnquSQc5RERenCDAZTamDUNn33
         gYkLCdYiZ1m/gtaYYG+T3QGOGec+nCcPiFRDEI1RSdUMhqVKQ6UI91vA6AtZ7ReYPs3y
         sqF9bUwnFpo/tDxLVxh9BmQ30DlKfp8eerIEyhB3kEojHGz2PiNuxgGGRnENIgNKoRCf
         x+9VaIXf3CvBKFSk0JeRzF1wB5vxQioJ2eJetmjGdsgsfwBzciQh+3N5vzK3/U6RDBih
         9DwiZcsbDd3NUR6uGLtb0Ca/YWueajr5NixTxjI70OtUvPiCCc0z/ImMphm9WcyxV5JJ
         z4Iw==
X-Gm-Message-State: AC+VfDyXUT7zDlOk5gulyXd6kgiSnT+f1YACjyKEaL1O5YG4dJMgIBhX
	otaqhSXh4I2KJhqOYvSo2tY=
X-Google-Smtp-Source: ACHHUZ6+mnzV23jfk1tGvM0u/lT9LsaKTrVg6N+7Kf2iOg01VgpuqfwrpGKg2WZjHvuQS3mBMWHkkg==
X-Received: by 2002:a17:90a:194a:b0:246:fbef:790e with SMTP id 10-20020a17090a194a00b00246fbef790emr14575716pjh.3.1683675004945;
        Tue, 09 May 2023 16:30:04 -0700 (PDT)
Received: from ?IPV6:2001:4958:15a0:30:c6ee:a400:39c6:2a73? ([2001:4958:15a0:30:c6ee:a400:39c6:2a73])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090a638a00b002465ff5d829sm6453702pjj.13.2023.05.09.16.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 16:30:04 -0700 (PDT)
Message-ID: <da7135cf-c96e-f79f-9d49-87ee269871cf@grimberg.me>
Date: Tue, 9 May 2023 16:30:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 06/17] net/tls: implement ->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev,
 Boris Pismenny <boris.pismenny@gmail.com>, Jakub Kicinski <kuba@kernel.org>
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-7-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230419065714.52076-7-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_163008_716041_5A877D6F 
X-CRM114-Status: GOOD (  11.70  )
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


> Implement ->read_sock() function for use with nvme-tcp.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Cc: Boris Pismenny <boris.pismenny@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>

Jakub,

Can we get an ack (or review) from you on this?

The only consumer of this is nvme, and seems to at least
work on the limited testing this series has seen.

We can take this piece from the nvme tree or not, whatever
you prefer.

