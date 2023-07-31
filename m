Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D22C001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 13:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w/O1d7MIPSh5ePF3sOAwkkKiFiK4AngaB1+xxMGz+Is=; b=r8Mb5wLmlNwum5tvqjEryn1Dic
	4Jb/97u9pkhfa/ro17Od6uS5c8QhYZogxuqVMpITrJbMccLJXAL6LKRtnoo1NRtPRLdgPAl602Nlm
	s0hCgYFitoTXK9Dg9rw+Og4Ko+h+z7/6Ivpis6SJd3NyoRKHw+QA021+JMyHIwjRrJhTENXfrZkf2
	O/bzbF30rUcmCZ2zuYKffvwNVLfWBp04BjkiBy1BblZPDkcal9lvxMLh7FAr7qj3k8cS/M/X48Xw8
	OklDs+9OZ4TjeiLrl/3Zv9VosqMCZJ2Cl//GaQ024rkYDBgRt0uexvBeYjyOZHa7J0OG1wmmdKvOb
	dHeXbkfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTBo-00FqJ8-0w;
	Mon, 31 Jul 2023 13:44:00 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTBl-00FqIm-1G
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 13:43:58 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3fe23319695so1848465e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 31 Jul 2023 06:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690811035; x=1691415835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/O1d7MIPSh5ePF3sOAwkkKiFiK4AngaB1+xxMGz+Is=;
        b=IjF76QSv63uesiCiCQHX91oYJJieYT23uc7kQEYMWBIN1ecwdJEKNqjCU4vPQkjUUw
         POvsTr5rIEsn9pZiviIBEjMhtCSzco0Mor7VyvlHYIK3aTOkDP9FviGR8fOKoIBu2GY6
         AIzOyKFYHefpUf74LQoLY8/0Z1bEFIhNfiMGYEqUn0doySKtVvzsaoxRQE1o/bmH+vJh
         8U7vdDB2K/xTTKkDa6SCw2F7Bz6nbkcAvmfaW/wqe2rtT3miRWkcQ7LP4/TXGBL6e8s7
         ZKEa7zeIYv/0jcC3VmYE7+2sUPklfT9GDCQybD4gDf4Jd2nhJhjXgAjuCwrqgSNpnD11
         cC0g==
X-Gm-Message-State: ABy/qLZwib3m8YNeiy2epM7cXDh7StpMzUIuG2ykkoz4qoLgadinRYw7
	LGpUKNcRVbcIndHGuBZ1maE=
X-Google-Smtp-Source: APBJJlHzojZa6I5Fzu7Th3JjRWdmGkYj/yJXbD1Naj9Bl5oWOV9AWvrwupWzbrKqEFKZTCtCt6qk0A==
X-Received: by 2002:a05:600c:8814:b0:3f6:8a3:8e59 with SMTP id gy20-20020a05600c881400b003f608a38e59mr5954354wmb.1.1690811035238;
        Mon, 31 Jul 2023 06:43:55 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c240900b003fa98908014sm14149561wmp.8.2023.07.31.06.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 06:43:53 -0700 (PDT)
Message-ID: <e2f28086-7750-9bfc-6f44-c681584270de@grimberg.me>
Date: Mon, 31 Jul 2023 16:43:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvmet-tcp: fix data digest calculation for multiple
 H2CData PDUs
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Varun Prakash <varun@chelsio.com>
Cc: linux-nvme@lists.infradead.org, Rakshana Sridhar <rakshanas@chelsio.com>
References: <20230727150731.5905-1-varun@chelsio.com>
 <20230731060119.GD30150@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230731060119.GD30150@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_064357_452532_A79146C2 
X-CRM114-Status: GOOD (  10.76  )
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


>> transfer length, it works if host sends only one H2CData PDU per cmd, if
>> host sends multiple H2CData PDU per cmd then target reports data digest
>> error.
>>
>> This issue was fixed in commit fda871c0ba5d ("nvmet-tcp: fix receive data
>> digest calculation for multiple h2cdata PDUs").
>>
>> commit ed0691cf5514 ("nvmet-tcp: fix regression in data_digest
>> calculation") reverted the fix done in the above commit.
> 
> This simply seems to revert this revert again and not address the
> reason why it was reverted.

We no longer map/unmap per pdu, so the original issue addressed
in fda871c0ba5d should no longer exist.

This part is missing from the change log though.

