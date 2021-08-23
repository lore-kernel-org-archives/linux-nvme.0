Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E60C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 17:14:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92518613D5
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 17:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92518613D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=schcfVS2R8q6dILLBSoAS5yOklHEV8SKd9akQMdn+QM=; b=VF+/+tnmEobI/KqkiNzDqoBw0c
	2YmSSOLSSCAFF5lyfsUbMtIPwrxsXUBYzrhar/ykTo/o6c9aOwHYuZ1es9hw4Fd0p4IDbUBV3oHTu
	tn2SliqF8uqfTwlFHQhSU1ngf9OLcMMB1KshpKx6TNdo+hLV51m7DvpY0AWhzhGp0DfNcNeRhSAut
	M0+/QUkN2FUg6MvgEVrkYkbBAbpryxbrHWduvS9f078xV04GxIpjW4phjN4fJaowHfyxS05raX5Lw
	J9fNw9vlfqP9A01GDkAU0zY3LmT85Cp7gNkpFUUTIcYFOTog6hR4/goO1qAh4ZmZotCzzfTQWWSX3
	XYiaZrrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIDWE-0006Qq-9M; Mon, 23 Aug 2021 17:13:54 +0000
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIDWA-0006OY-R0
 for linux-nvme@lists.infradead.org; Mon, 23 Aug 2021 17:13:52 +0000
Received: by mail-ej1-f45.google.com with SMTP id h9so38510033ejs.4
 for <linux-nvme@lists.infradead.org>; Mon, 23 Aug 2021 10:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KLZj2LD1i0UAf3+bazXB1vSdaKBKru5JF9BniV7Zb3w=;
 b=VHmK3ic4JM5EPh1OWtvb1YNsjkgg8wBsP9LgBes+uoT9+7xFSdORR/nAz6q8xc3Rdz
 Tv3oPdnoZaWtflEBI4WU/5WMEpp7wuOvUJ+Tig2kxF3UyLaPKLbgRu7vV+McAqqkRsJd
 2uAXGdljEzyZVoNAPTxMMljTnE4R/45fffX745B3gqYpCARQlkYrIzzvXrs0jyW/ZRmQ
 YaT3AdepWFkvzacjpcqV7O1QXBwHG4OVTJ2ZAhTdymm6JnCJHrFvfW/bHiX+ILZ9P88G
 D7fHmhk72TLoPP+4XI7q6frEB3yorSWF0CcCzOhxS/vleIi5oSM+GiMVKlFAEhGEySPA
 hv8w==
X-Gm-Message-State: AOAM531ujL8smqxw9ur4lrxKxCmxi9vazVgMhclcN04ouy3F6HpyuStV
 J7Sqg3LmipTEvEiZR8jWr6Y=
X-Google-Smtp-Source: ABdhPJxGlVGrMM0SewYur5DWk57X2CIFzmM8l1Z0YtDg55QEYBhtj4Sflcy+/5r4HO9pIobBhO0cgQ==
X-Received: by 2002:a17:906:9b87:: with SMTP id
 dd7mr34850343ejc.99.1629738828966; 
 Mon, 23 Aug 2021 10:13:48 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id dg24sm9773808edb.6.2021.08.23.10.13.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Aug 2021 10:13:48 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: Do not reset transport on data digest errors
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, yi.he@emc.com
References: <20210805121541.77613-1-dwagner@suse.de>
 <47ef76c6-4430-ca24-405e-a226d4303a39@grimberg.me>
 <20210809090947.luoqaooi7gc6u6yu@carbon>
 <2e91c065-d3c6-1bef-5906-1a4648368894@grimberg.me>
 <20210811103146.ytqj5mqpioiba56x@carbon.lan>
 <20210818124430.hokmfa25lnhxnswu@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3ffb2ff9-0074-7f3e-6c40-18837c0a02d7@grimberg.me>
Date: Mon, 23 Aug 2021 10:13:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818124430.hokmfa25lnhxnswu@carbon.lan>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210823_101350_926767_E63343B0 
X-CRM114-Status: GOOD (  12.20  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> It is the correct place, lets see that it doesn't increase the struct.
>>
>> It should not according pahole:
> 
> Anything I need to do to get this patch accepted?

Yes, move the status to nvme_tcp_request, I think its
a more appropriate place for it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
