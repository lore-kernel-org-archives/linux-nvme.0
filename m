Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860D8C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Dec 2022 20:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E+gHchU3Oz901UKNs5aCpJVAXI68TSGgtu5W7VWaDAs=; b=SwI2RuHAlUvHylJywYt6w+dGvt
	or93+ENemcqmURwrMqVevGBoJrhlFP0S7n12qJXOCZ4LJfTBn8nnq5j5vQ4o8k4QNe/GaK32aGogq
	28f8WiTXyx8TrXR/gucG648zM+qRiZZJp5TVniKZJR3uyJYy1GF3TFoTYbDBlgQN/ajOGSDYV67m+
	kp0ATD7cBJsiQ3hDvr/Iyxm5QWkI9CSibPasod87w7AyvPga44bzsSf/XU/TgZgiSzGgeu7YMe/TF
	EpYLvYqrAmxBF9fZmnTjgG5+YYBAIfG6gsFOr4Qe2dWno04i2jH9z3er9nTHVhfoCHUqtPTUFB6Js
	ryMU8N+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Hon-00A3sw-N2; Mon, 05 Dec 2022 20:12:01 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Hok-00A3gt-TK
	for linux-nvme@lists.infradead.org; Mon, 05 Dec 2022 20:12:00 +0000
Received: by mail-wm1-f43.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so7257487wmb.5
        for <linux-nvme@lists.infradead.org>; Mon, 05 Dec 2022 12:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+gHchU3Oz901UKNs5aCpJVAXI68TSGgtu5W7VWaDAs=;
        b=GWQJsHVh35VOnBgU0ApbbpBk7cVgI6s4FveBnZjDLmTqUHGPH2xFDFJB8FU1uQOhJF
         zDiwHbfTSTtNkT5rabbRe1C5iCTN+ma76swPB7Zeuivrcb6nCQWR7SJZlPdUCqshTPqE
         1HzFuXp1zPELtdJNxxg0uxKOYajul5NXUdXbZNsMI5wZ9PZsjwaKw/iHO9NcnUynzMfc
         W7ez+sBAI2sDaLMsLOO061zWEH7p4CIFDFn2SyDKL5V1osfus5GlUMG/Vdplawl7Pc2U
         QbzlrLCb4BnKNUiEuyeCvZ5rIPkQdDp6pzQ513WfceklGg+ExF8dPtygYbAaURlxZvyG
         YR6g==
X-Gm-Message-State: ANoB5pkXLKUCXDkEar+co916zgzexd3M1MTNOnquH9XyGPyv7CFqeYne
	q49+uvYSPcaHBgiuyjYnS3lTDprujmo=
X-Google-Smtp-Source: AA0mqf4DLoCIgDlge7Unx9OgeIwdfBy2HpwOY4ksLkMQYGd76YpXcb8HP6ReFW/GLHTeCK4bnow5cw==
X-Received: by 2002:a05:600c:5113:b0:3cf:77c0:48ea with SMTP id o19-20020a05600c511300b003cf77c048eamr63905982wms.130.1670271114701;
        Mon, 05 Dec 2022 12:11:54 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d5649000000b0022cdeba3f83sm14817715wrw.84.2022.12.05.12.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 12:11:54 -0800 (PST)
Message-ID: <87decdfb-1a2a-d0df-d869-0e3b54e52240@grimberg.me>
Date: Mon, 5 Dec 2022 22:11:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Content-Language: en-US
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "Grupi, Elad" <Elad.Grupi@dell.com>
References: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
 <1668690824-2034939-1-git-send-email-amit.engel@dell.com>
 <4effaa95-0357-7d65-1701-8ec67ce7cc11@grimberg.me>
 <CO1PR19MB4885EB9E323178E235681F9EEE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <8e6fb5af-2992-dfe2-10dd-383c2c058f8b@grimberg.me>
 <CO1PR19MB4885EADF8C1E970867C71487EE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <a6fbc43b-7f7f-91f6-a157-186f2663b734@grimberg.me>
 <CO1PR19MB488579DCD958B74B2C8E38AEEE199@CO1PR19MB4885.namprd19.prod.outlook.com>
 <9021ae71-646f-8183-7772-7dae38a60d47@grimberg.me>
 <CO1PR19MB48854117F203A43ABFFDB17FEE189@CO1PR19MB4885.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CO1PR19MB48854117F203A43ABFFDB17FEE189@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_121158_975843_DE4E6CC0 
X-CRM114-Status: UNSURE (   9.99  )
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


> Yes, io timeout is obtainable via sysfs.
> But this io_timeout param is writable and the user can modify this value at any time.
> So I still find it usufl to have this value as part of this log.

I am sorry but I see no point in logging a static value that is
obtainable via sysfs... I Don't see this practice in any other
block device so it is unclear why this would be needed here
when no one else is doing this?

