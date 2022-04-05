Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A79AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 10:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VlLy+d7Rw2ljgAM9HpAnx9VhOVyjoKvxn3y0DPmrut0=; b=kg6+faeg5hnvNsw33N7/SEGpua
	dnU4DeBXpW+D17nNZ57qKj+y5IAftZkJx7r475MvtKdrACnyu07aHNFfgRKo1GLhwszEP83Rqvhk8
	oPcnTAFq69iSXJLMEocAQflUZXXFM37XP6gcPQ05TDhjNLVr2zRcTvR0BfdSBbTr1/KDQcnooZkO0
	4CFuhL9TF82Uf0odKRP5wJZerG0egr5M/CrUpmGEPl820Tx9bq7W101SuIRUDy4btfQK80hruR5Q8
	1IVKYAgyV0p1rgALhctxSwD2a5zeQj9BnEP90uHLgIlcSC3xt/9J15eEHG3iMJ/QtBQwtUXMl7dKu
	+NKHC7qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbgXY-000fiQ-Pk; Tue, 05 Apr 2022 10:36:00 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbgXW-000fhP-Mw
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 10:36:00 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 n63-20020a1c2742000000b0038d0c31db6eso1353030wmn.1
 for <linux-nvme@lists.infradead.org>; Tue, 05 Apr 2022 03:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=VlLy+d7Rw2ljgAM9HpAnx9VhOVyjoKvxn3y0DPmrut0=;
 b=6dtBvBIugiH35SLeIhxwWLsT1TkWAd2WjpMkKCO6uIB4UV8bpjoxiMSOcbMiDFmnVT
 0jJwF2Q2T+4DfuRACEWjyO6BHRwKIIfec5D511nujiam2Q4P+HQl1pfdp4SoD9XQH3yD
 U1xTduDvz1wz+BroyTcCTKUjRW5oV9bAxuq80lfKF8TQyqc7R450CLzdoKWC1F69rZhG
 pSrYfWCNEB+72qo8nUHv58MHVz8lrUkKHnsuhT1OH3CRWDTJ23SuY7m2ByaEn6G/fGlC
 Z8ZxdmM52j0R+MdA0wovi3sJdJm755LeRvwOs2y5ISjc0JhVuv1VFFrhIRC/+LqK2K04
 Zqhg==
X-Gm-Message-State: AOAM531/pRyG5aEshTL0zF4DAWwtdHT3BdkONlseqhGpTa3+jQYOs+sd
 SbYYmLnOtfTkoozmzsf+SUs=
X-Google-Smtp-Source: ABdhPJzh4DkX+h8M0BZyZCvJfn+oHdJxZ3pxG6RydgGcojiMFYoTMXRlAt2KDA3132bUfwDIcs6PEA==
X-Received: by 2002:a05:600c:a4b:b0:37b:ea2b:5583 with SMTP id
 c11-20020a05600c0a4b00b0037bea2b5583mr2503813wmq.139.1649154956361; 
 Tue, 05 Apr 2022 03:35:56 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 a12-20020a5d53cc000000b00205a0ee9c74sm11249961wrw.89.2022.04.05.03.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Apr 2022 03:35:55 -0700 (PDT)
Message-ID: <1ff01a7a-2687-4a90-672a-e9218cc54331@grimberg.me>
Date: Tue, 5 Apr 2022 13:35:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] nvmet: make the subsystem type configurable
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-3-hare@suse.de> <20220405054740.GD23466@lst.de>
 <3d773039-ce36-277f-34c5-e0530567c4d3@suse.de>
 <20220405060946.GB24073@lst.de>
 <66428672-250b-950e-ab7c-0a6ceb10c06e@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <66428672-250b-950e-ab7c-0a6ceb10c06e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_033558_780789_3CA1F5DB 
X-CRM114-Status: GOOD (  12.36  )
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


>>> I actually looked into that with my previous attempt, and really 
>>> found no
>>> good way of having an entry which is
>>> a) pre-filled
>>> and
>>> b) removable by the admin later on.
>>>  From what I've seen all pre-filled entries are static; I haven't 
>>> found a
>>> way to do pre-filled dynamic entries.
>>
>> I don't think we need to remove the well known discovery subsystem. But
>> we can allow removing all entries from it and thus reporting an empty
>> log.
> 
> Hmm.
> We still would need to pre-fill these entries when creating subsystems.
> Bringing us back to square one, namely there is no way to create dynamic 
> pre-filled entries.

Why do we need to remove it altogether? Why not just make these
subsystems attach to port(s) like any other subsystem?

