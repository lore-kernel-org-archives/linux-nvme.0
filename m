Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E52BC6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 09:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0sWY1I1ouoHv+2nnWuzegkDW1CdXzXe2ZWoPGTCpomo=; b=QlZCraOCluKtNZDYn7jTxvL9tT
	YlE+gU/XSAoc5LUoBPY+aFMY3fKmzD11kPyEWP1E6DUA/ut/3kQbORZ1r7PO2KFsAwTCh2xe8HB3J
	fpp0Vc3F8BKqEGOtJWsPf892WcDHsz9Ap7pZRgMqkvbQ3DSXudk3k49xZ+QPk42rpsEfPVzrd7pCu
	eTWnaoKQP9gq2NoGYFRrg6oegtKDjwwR9QQCH/iGTAft5zvLF2OMWDhiEs+ElABX4TP90ImBkD+Oq
	mPpGqPGAU2pGmP55yJn75Bb4ljG5B8CunG81FGUrFhQcThMamdxXyfjyqKhcz6I5HyWcwC8WRRmxk
	GPoP4cRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp4Dc-004krR-0H;
	Wed, 19 Apr 2023 09:35:16 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp4DZ-004kqQ-18
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 09:35:14 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-2f45377dcc7so897719f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 19 Apr 2023 02:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681896910; x=1684488910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sWY1I1ouoHv+2nnWuzegkDW1CdXzXe2ZWoPGTCpomo=;
        b=KLEcWtm4j22lICd/mDcTUT0p76xWowy+hx/gRfMZi2F0TbHTsGU2SxshgITm6QK0ZV
         XVQ/tmVoM1Iu/LeFONL49o35Ol31vhtUJKEIGEq38ZPcoIqP9kgJtq9NGXuDizhqT9je
         UC+EJxXtI6JyXb/9U3GyVbg+IcEpufx5xG6qsLKTpK71c4U4n2q6e9M7EOpoqejwfQac
         DLSXNMPKm2e4pij+neUe87LEgN5OQHN4BQ8r9U7w1yDQpNEMd3fhAtxbIWz052fwKIC6
         QAIf8CEuyXjcD68lFMoqVLo4/SpiAxTfforbupAweCKe5ae5Qns5YVzYXpUFniDDdSbA
         z9WQ==
X-Gm-Message-State: AAQBX9cQpn/CWt5UYBQTjssmYFUg3b5ZhZTwiXVSS+QoLBCWMoYLCTTb
	88rYi3zQf6JVTeVbgPtJqvy+I7XER0A=
X-Google-Smtp-Source: AKy350ZwhuxxJWTKUjlgixT4N2ciSdmd6sKtnqLbDals7lQi48bSv7DKA2JD7JxtmJFBt1aMbuu8Hw==
X-Received: by 2002:a05:6000:112:b0:2f9:ee11:e5c3 with SMTP id o18-20020a056000011200b002f9ee11e5c3mr6340073wrx.2.1681896910530;
        Wed, 19 Apr 2023 02:35:10 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4743000000b002f9e04459desm8458477wrs.109.2023.04.19.02.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:35:10 -0700 (PDT)
Message-ID: <088e9b60-3092-2642-b3c3-2248e2e51cd6@grimberg.me>
Date: Wed, 19 Apr 2023 12:35:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/4] nvmet-fcloop: unblock module removal
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230418130159.11075-1-dwagner@suse.de>
 <nlogr5rdxqvilsz4iolktfpdvflvvithwaoa3vrx2fsjqlho4q@4upw7jq3aem2>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <nlogr5rdxqvilsz4iolktfpdvflvvithwaoa3vrx2fsjqlho4q@4upw7jq3aem2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_023513_389394_F500B0D1 
X-CRM114-Status: UNSURE (   8.08  )
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


>> nvme/041 (Create authenticated connections)                  [failed]
>> nvme/042 (Test dhchap key types for authenticated connections) [failed]
>> nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
>> nvme/044 (Test bi-directional authentication)                [failed]
>> nvme/045 (Test re-authentication)                            [passed]
> 
> I suppose these should be disabled for fc as all this is tcp specific.

Umm, no their not...

