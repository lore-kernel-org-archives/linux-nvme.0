Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F8DC4332B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:48:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B69020409
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Frs6Smxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B69020409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5V0f++Ykw2BTrtJw2USopH7ynfae1RG0xCW6UAZ4hYU=; b=Frs6Smxn1qOBrWRdBKw3yi16K
	Rz2yfg6TUoStl6PJFfjEm0xkAck3GDkW9r5OB4dtxkRRrMtpqhxrHMmyKUZWwDYL5A3PBzQ6yX0or
	eP6SvwHuR80RgElSAXZr98JZUzmFuw0oywzmFOS/mIdmTodMb0JMsrmW+vkmLSgIhQF2ZX8GmEbun
	Gl2lqA5TGvP/34vPyxjhY2VM87o0lnX6ajyUc/4DUlK3tsO0hbsgIS6tAwrEIQQdiQeHCk+5iCHjz
	2Gvvu1gNAr9lEk+Mj913s1qjQi8yFm47eVzMAjjoQKtC7C1V1G3slI4r9DrtSwr10INlmk5OOMJo5
	kB00N87JQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGWoF-0003vM-1b; Mon, 23 Mar 2020 23:48:43 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGWoB-0003u7-Rn
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 23:48:41 +0000
Received: by mail-wr1-f46.google.com with SMTP id h9so19360808wrc.8
 for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2020 16:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UfI0MAKRpMayrJBsD91obsyTr+Nqgfy+To0LwVEcYPE=;
 b=CD13/VqxPJpxqjeFhClJN6MJyRyI1HeCVrLCoJJqTxrT6D5okaL0qrao+TlzezBsJT
 um4Oy5brlBmgZCskUyAw4QgyUx2w2NgZo3MKev0dqHPkJSISGvK6ZVCleMZ9VlT5leKT
 hP3RDG4mzHt0mMqVRjjC3Wi8qhiIP2p5gIQCz0EX3mkbog6DfthGdjKx/qtBFDxYo+PT
 P2MnW/Cln46sVYQbxRlbEsz0UKt7mtLcMywI54qks5v5O0fQ7KkHgRoFxIMEIdmAa4/f
 TpnhFffpmaSPLEQyt5PG/SPOwyuBZts5AlpsxOzgbsQGyVoS4fiJEeCwI//NdlyWHYXS
 IdEg==
X-Gm-Message-State: ANhLgQ0ynvI1c9Ua3VbOBg53dsF6jGepl9TFEu8e4yuMlmhtmgSueW5w
 IQISBsn+9UFlHCHZGsNGSxxBBBbr
X-Google-Smtp-Source: ADFU+vuIWeE9kEmfdOJB1uyWBqXxkLyb1NGZulqQupfuIfKgxi386CsGPBKiQOl/+JoGaqibvqjqFQ==
X-Received: by 2002:a5d:6888:: with SMTP id h8mr23180092wru.159.1585007315457; 
 Mon, 23 Mar 2020 16:48:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:45a4:15de:f2dc:1149?
 ([2601:647:4802:9070:45a4:15de:f2dc:1149])
 by smtp.gmail.com with ESMTPSA id w67sm1621578wmb.41.2020.03.23.16.48.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Mar 2020 16:48:34 -0700 (PDT)
Subject: Re: Sighting: Kernel fault with large write (512k) and io_uring
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <MW3PR11MB4684AEE8587BFCC0A9F41DE4E5F70@MW3PR11MB4684.namprd11.prod.outlook.com>
 <4eaa3e21-833d-f6ec-3b14-58dd2022a381@grimberg.me>
 <MW3PR11MB4684AC746EE60B9E5D0D46E1E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <82255be7-fb89-c66c-442e-6fe04239768c@grimberg.me>
 <52ce2f94-e11b-c537-63d2-e9b72cf1b00c@grimberg.me>
 <MW3PR11MB46844ED6C11993D7F5D911A8E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <092f6922-ab29-c2bc-04b8-0d0c95c14ad6@grimberg.me>
 <MW3PR11MB4684FD29002D6D1FE29A4A0FE5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <2f68591c-d2f1-f632-644c-11de97511a45@grimberg.me>
 <MW3PR11MB46845357C4C1651D1C24CEBBE5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <112775b2-ef19-7e8c-630c-22bc529536cf@grimberg.me>
Date: Mon, 23 Mar 2020 16:48:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MW3PR11MB46845357C4C1651D1C24CEBBE5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_164839_904866_2F4E764A 
X-CRM114-Status: GOOD (  13.00  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> OK, this is a needed fix then.
>>>
>>> Yes, so far this removed the kernel fault seen for large write (512k) + queue depth 32 + batch size 8.
>>>
>>>> Yes, this is with nvme-5.7 tree right? which is currently based of
>>>> 5.6.0-rc4 correct?
>>>
>>> No, was not yet able to get branch 5.7 to build with our driver.  For now am running on branch nvme-5.6-rc6, the other branch mentioned by Jens to try.  This appears to be based on 5.6.0-rc3 I believe.  Will re-test on 5.7 once I can get it ready.
> 
>> OK, but this is with nvme-5.6-rc6 as is right? no add-ons correct?
> 
> Since the patch you indicated for me to try show use of the POLLING flag I went ahead and added that patch on the baseline nvme-5.6-rc6 branch before making the small suggested patch to nvme_tcp_poll that checks LIVE state.

Does the I/O timeout only happens when you run polling mode (hipri)? Or 
does it happen for non-polling I/O as well?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
