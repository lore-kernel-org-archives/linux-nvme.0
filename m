Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E25CC04A94
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kARCsrtw55uLr9EkemWd6Tbds3LzJHCcB8OcESgj2AU=; b=URWkuYxBOGX7zdNjiPzYe34Ib3
	SrndrlPbwlGg7TozHOHngBftU3iSEicABoIpKbWDgttjGHoQ35z8w5HpTBX9zLsWxhqrfvmFm1uOv
	9qucPvD2Y/ixFCbCQ+blo3HHUTOk/9YWoDUEW7OEz9EVsEE40RFeZ89ZZa0aniQiyi9GbikHdajnd
	qDlVdmmje9OkqZi9SwK/KlWXf2Hjw3zBLCDFOsdoqXX5h0jhjogqQtNoe2tOyNrxdsfqn/dWWSSfN
	FyG70V3W96d6atcaHq1EGhn4Hk5sCIDbrwk/AW6wZvTVn43ymyX+fHGaJG9HLaJv7HKsgG6oEhuUU
	Iw7XQMBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTLAA-002UA2-17;
	Tue, 08 Aug 2023 11:46:10 +0000
Received: from mail-ej1-f51.google.com ([209.85.218.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTLA3-002U8a-3C
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 11:46:08 +0000
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-94ea38c90ccso143871066b.1
        for <linux-nvme@lists.infradead.org>; Tue, 08 Aug 2023 04:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691495161; x=1692099961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kARCsrtw55uLr9EkemWd6Tbds3LzJHCcB8OcESgj2AU=;
        b=kdfn7iOCCqk/9L9uKae7B9j6np3A2VJtUatZIX3VVR966Cj+NkKMKg0XhNAjtOEFwa
         3eAn2aGySCEOJuMLmH8MMrQQVtgfS+aMHXN54zU/C5pkiS7PCJP7N7jK582YnRqaTZf+
         6fMgHtTVK9mikcl5tlDl2jLSTO1+mazcY6r7bc4RXYdv77XFZQ1JsPXeYYkYyuvgleMN
         Vm9pKbtoRqNMOhvbjHPoU9mHT+gNXk3fRcYeJNmjqlg+KkbkbbbcaRrqcZE6JggieANY
         UMPVoXBxcdEYakJODb0i2iHEmx/+UATgXkdqK6zA6cFrtm5ARbWF7JNvsIrd03GwFb3J
         CRiw==
X-Gm-Message-State: AOJu0YzMau3Oiymlh/oANRoES9wAHXeVospfQ0wOyMau2AxfJR0zOH3u
	Lm3k0VS722dfEmvY693Rh8o=
X-Google-Smtp-Source: AGHT+IGHP4QDlGDTCWMKRc3M/06yScDxk+trxH2DL652mQ+Quv6kA7gtjc6Mf+MsXHuc2r0lhiHrEg==
X-Received: by 2002:a17:906:7488:b0:99c:d995:22e6 with SMTP id e8-20020a170906748800b0099cd99522e6mr4357236ejl.3.1691495160960;
        Tue, 08 Aug 2023 04:46:00 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id ce21-20020a170906b25500b009920e9a3a73sm6533702ejb.115.2023.08.08.04.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 04:46:00 -0700 (PDT)
Message-ID: <f21ab437-b3e6-a629-a912-737ce8f743b8@grimberg.me>
Date: Tue, 8 Aug 2023 14:45:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/14] nvme-tcp: control message handling for recvmsg()
Content-Language: en-US
To: Pawel Baldysiak <pawel.baldysiak@dell.com>, Hannes Reinecke <hare@suse.de>
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <0c927b66-94cf-e2e1-ae7f-0c5dc4391c72@grimberg.me>
 <20230808105403.3949653-1-pawel.baldysiak@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230808105403.3949653-1-pawel.baldysiak@dell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_044604_024504_9963E9E9 
X-CRM114-Status: GOOD (  12.00  )
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


> Hi all,
> 
> I'm testing this patchset and observe the issue with above.
> It's not only about passing cbuf, but the check below.
> When I would like to connect/discover without TLS,
> I got an error about unhandled TLS record.
> tls_get_record_type() simply returns 0 for non-TLS,
> so it breaks non-tls connections here.

Hannes?

probably need to make sure to test without tls (sweep
blktests should be enough).

