Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51846C77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 04:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w86gJAhoELPWbQ0kBXqbW1Hm3r2Lz92kBgyMVlQb8Ss=; b=dYzoRa1tPZOUdX8oc+F4q9jq96
	4WW+I3HCcIRWX3ORGlctFivDgGE2AS4srRWhDX9osdrB7FzhaKYPMStSy+vwkQQIlic2oltG5gwiS
	fmkRaj1/MyKAIzG9dYO+9k5DDkMQ+eOkq1ZvrGxj0ygbya4YVRyEi78jsYQtVBnW48a0G7bD0rFU3
	r8W+x0btTVfMI4gw9JJ8Kyq5SHOjVYSpnIgna4k1KTdBt/HiifvibI9K+u7CWQgWQsVEthXNOJqNW
	d8A7/RB3aFt2fHA7bKac+DY5qNC+msw3qvhpDiKaSPWoVUXjsdiDZ2jF72pE1fiEfxCm9GNSnY+jR
	sdbj9AMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pocoi-000oRF-2Y;
	Tue, 18 Apr 2023 04:19:44 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pocoe-000oQY-0t
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 04:19:42 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b733fd00bso941913b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 21:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1681791579; x=1684383579;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w86gJAhoELPWbQ0kBXqbW1Hm3r2Lz92kBgyMVlQb8Ss=;
        b=Bfz2EbDY99QT7EWm8oPKuvrZRJ43BXybqqoSqz0EJbihjVWpBxJV7dDvMteaRjCUt9
         vOv3vAW11Tod+BIoEb6ck24vXPZI5dJlBExyMLkiOvI1PdHoPAPPlA6P8uE02gUK0I4Q
         vk0OeGmQGPyKb5Lw34xEnOsWtk32qAR6BXTWDXl6SVhX5pQV18n/+i6lJj1ewYwoqpYQ
         RvZmrBfGHyBpMebGoLXYPDEVP1NPaALkc9kswr/4gA5mK+aZz2fskqISCM9DSRgXYB/r
         fFl1fsToBAdnM94XbYsAEBpOtiRwFIwXZC01LF9/eD90kMpyzfrrnNZDelXydOuaHBpP
         GzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681791579; x=1684383579;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w86gJAhoELPWbQ0kBXqbW1Hm3r2Lz92kBgyMVlQb8Ss=;
        b=MfoZybdusvOVB0vNNO03mEUknx6tNR/3POGaZfLPwtfsE/u903aECDfOSJcDyfcHSZ
         pg5kb3x2b0bo3wgrdmjv/LtOLfqOer0wxnipCJ8A4nbwlBdeOHJOBEcdQ4g1Dt6wUSRs
         RKY17MGLPYH2lbqWdGNuxW+ZOai7mQxb4ktqT16Yz6lNfPDOQ0/orTE7+l3lLn+PLi3d
         zzzPFDSikVPug29lDYkOMdhjDcsIOwTRhj++wnPzncOrvhUuzX2h+iPa59RPKhP9hBcI
         7+pRiDHY5eTO/5XAxSdpYGmj/wJWWExAqGuoTk2KGJEGz3vqXwEeX/Saua7LLvsxlEal
         2OIg==
X-Gm-Message-State: AAQBX9cHLHmNLPAnGUDl193tZaULKmoopO4Jjf0tcNlTxYVmD+6+tb87
	faVYergWOUvyPzGLGC1s8rW4sA==
X-Google-Smtp-Source: AKy350ZeReyCH1wIPZxgVhnXkJZIZJmmc7+mlLTGdyROo0IgG247CGqE/6SZtiXGoBNvoBZXpB9gbw==
X-Received: by 2002:a05:6a00:1892:b0:63b:859f:f094 with SMTP id x18-20020a056a00189200b0063b859ff094mr13974233pfh.20.1681791578849;
        Mon, 17 Apr 2023 21:19:38 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
        by smtp.gmail.com with ESMTPSA id a2-20020aa78642000000b00632bb373949sm8311895pfo.158.2023.04.17.21.19.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 21:19:38 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
From: Li Feng <fengli@smartx.com>
In-Reply-To: <8310edb2-84cf-6211-f37d-d8f3df1e2320@nvidia.com>
Date: Tue, 18 Apr 2023 12:21:31 +0800
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Jens Axboe <axboe@fb.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C13EBEE0-787E-44CF-8531-B4C39C3E10CC@smartx.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413063317.2455680-1-fengli@smartx.com>
 <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
 <8310edb2-84cf-6211-f37d-d8f3df1e2320@nvidia.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_211940_321456_9EAB3DE7 
X-CRM114-Status: GOOD (  11.33  )
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



> 2023=E5=B9=B44=E6=9C=8818=E6=97=A5 =E4=B8=8A=E5=8D=8811:58=EF=BC=8CChait=
anya Kulkarni <chaitanyak@nvidia.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>> - It is not backed by performance improvements, but more importantly
>> does not cover any potential regressions in key metrics (bw/iops/lat)
>> or lack there of.
>>=20
>=20
> I've already asked for this, without seeing performance numbers
> and any regression for general usecase it is hard to justify this.
>=20
> -ck
>=20
>=20
Hi ck,
Thanks for your comment.

In the previous mail, just paste the 256k read result(1GB/s to 1.4GB/s), =
I will add
more io pattern result asap when the machine environment is available.=

