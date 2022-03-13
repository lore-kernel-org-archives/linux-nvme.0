Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6ADC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 21:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tJHa6JKFDscsSEurCzG9MK0b3hvjTr26NmT70tZt0vA=; b=SYTUiKv1cXny1dcL3AJu6CzYOd
	gTOYK/HJ62P24nBZh5ybnWpNvtwc6+K14vcEU+wSvPrQfQGEOp6HV+f2l1c+e3kwF3w/523yiUwTq
	E1sEeOUW5rDmoUC7rI5vTuCguA6KdGb8YyISD9We70V3J7ZvSAOMVUigBp1I2B/y9emtjKwzi1Tym
	mtgDOox8IjIDikqCYD7gEXnTVF+fFEljHj5Z4+Qz5fhjyTs7FyOEGLAISUuDw7b1+g/Vx1Pz6h5AD
	yyP75mw0mYaxw/61p2j8kL5lEltN+WdfrSMej/WgRr3rsoR8mRczLdktOVCqVIFQSESLUOozAWU0I
	SiN3/J4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTVqM-003Q53-1V; Sun, 13 Mar 2022 21:33:38 +0000
Received: from mail-ed1-f43.google.com ([209.85.208.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTVqJ-003Q4g-1m
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 21:33:36 +0000
Received: by mail-ed1-f43.google.com with SMTP id y8so12259559edl.9
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 14:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=tJHa6JKFDscsSEurCzG9MK0b3hvjTr26NmT70tZt0vA=;
 b=O8hZNKCcfuStHh4pSxW8od7GFbo5zsqRVtUTxJBm22wEpH+oh7gmGyK+xGlQXFh26q
 5A0ViHf22jrzAAaHn6K9M7QN6ElyjUW0bqgzXFNHRJWtx3ixd7Nlfc0WN3pox4muKOJc
 1UNklmKZK2rL0Lt9/UxrnpHjD5yGIZow93DKhe2CIkaivToSuD1EEOBbJY9rwFZ7vzH9
 407SJ4GtTohIfVvZNAwrncVfiz4fG7qt9z6R5GBMKT0/03KaYTeM9ZtHRctkCKbB5HPj
 7+aGOLIEjNS2JjKsNFAcXzjMclgMS3PxFpEGu3Knxqb0KDPQnoeoVRLsZLilCcdAbA5w
 m8qg==
X-Gm-Message-State: AOAM53139yBK1joXQ+9C2Zl2MftDQv0m0/FZyoXu+HBbLorNJZUiua7A
 wsy0pZ8hwTGwOhpVtEheBNuUIMOCKYo=
X-Google-Smtp-Source: ABdhPJxMPpuV6DrC7UOpam7Ndh4Xdvp+5rh3TQtxDvesTMhlmQkgGKNWietGITnJSUX5jXoaY8USUw==
X-Received: by 2002:a50:cd8c:0:b0:418:65c2:8b77 with SMTP id
 p12-20020a50cd8c000000b0041865c28b77mr6914446edi.170.1647207213608; 
 Sun, 13 Mar 2022 14:33:33 -0700 (PDT)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119]) by smtp.gmail.com with ESMTPSA id
 z23-20020a170906435700b006b0e62bee84sm5891207ejm.115.2022.03.13.14.33.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 14:33:33 -0700 (PDT)
Message-ID: <ac3056fe-e5bb-92cb-2d4f-a86c04117e5d@grimberg.me>
Date: Sun, 13 Mar 2022 23:33:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv8 00/12] nvme: In-band authentication support
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Herbert Xu <herbert@gondor.apana.org.au>, Niolai Stange <nstange@suse.com>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20211202152358.60116-1-hare@suse.de>
 <20211213080853.GA21223@lst.de>
 <9853d36a-036c-7f2b-5fb4-b3fb4bae473f@suse.de>
 <4328e4f0-9674-9362-4ed5-89ec7edba4a2@grimberg.me>
 <56f1ce1c-2272-bed2-fd6b-642854b612bb@suse.de>
 <483836f5-f850-6eac-8c38-3f03db3189ab@grimberg.me>
 <0c4613ff-ba30-c812-a6e9-1954d77b1d1b@suse.de>
 <ad9af172-4b7b-4206-feab-8ab54ba7cfe5@grimberg.me>
 <e2ccd5bf-c13f-8660-c4c0-31a1053846ed@suse.de>
 <1d1522c6-7f6b-7023-9e66-a05ac5a5a0be@grimberg.me>
In-Reply-To: <1d1522c6-7f6b-7023-9e66-a05ac5a5a0be@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_143335_120936_42AA753A 
X-CRM114-Status: UNSURE (   8.47  )
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


> Hannes and co,
> 
> Do you know what is the state of this dependency? Or when should
> we expect to revisit this patch set?

Ping?

