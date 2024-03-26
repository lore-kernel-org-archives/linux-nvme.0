Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82A5CD11DD
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8wqdoMnkrN7rjrsKiPfbY6y3EFtn8rvPWfbEwpsZQA=; b=kJzZFy6giOp2rrznEk3XPXkRJN
	0ouT7tmM1CriJEZS+vE2egQFWdimwtZ/LmE8BkuNxn07yO4Xs5CMpb9PRdndYZglntO5aRu6nfJxo
	H0ZN96K3ved15uGyiVqZNrlOG7EqW+fOl+dGfIYNr4B5jWynrpCVP2aeYoS9JmPd3A4vGG+4uPe/s
	2NcXiMVbS9IUjQx9tn/idRVdqUGAPR1Vdu12xQsWa67wda2cjaizAJqGmeMJQgaV86fG21wHLbZIN
	iB636bXEjP+ijjCqDUF99HQN4vOPCL2Wy57XzyhqfDdXwYJxtRMhCVULcXVMdHTqcwWZUG6ZYQzFi
	OfSfFXCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp7Cy-00000004ls7-2rzj;
	Tue, 26 Mar 2024 13:51:20 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp7Cu-00000004lrH-1sMw
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:51:18 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6e6ce174d45so4024968b3a.3
        for <linux-nvme@lists.infradead.org>; Tue, 26 Mar 2024 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711461073; x=1712065873; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8wqdoMnkrN7rjrsKiPfbY6y3EFtn8rvPWfbEwpsZQA=;
        b=SND21HORfywKjGyEV3OLbNiKTHZRRfOkculZIe4s4x9ummVVblDP+52ivkv0sKgy5r
         RNBk+0KTEH55xagoirvmZeT/Ll/3R5V7lqFAXkG9zEzcLyTd4SmeFeD1LuUw72iTeIRT
         GohylJDsVbzcy2Nxk3PhGcUke7rSNycDPSZUp27OtNDlzxvim+rA16kmxPxXhJmFgukC
         0JJ+ODLKeyAD6bElNWNe0jaeNNUx62QyILNGp6tlL3gFqriLElatAnCWKNkRHiFa7+Yl
         PYE3VIaOFEq8V5mT2fwPDFfZua2EsHCDpbtB2p6zuj9jj86EopmNfhTZ0j7+OmHZnmyj
         xp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711461073; x=1712065873;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8wqdoMnkrN7rjrsKiPfbY6y3EFtn8rvPWfbEwpsZQA=;
        b=C+ZQ0QP63edr/Cgwo0TQPafSUoNIbtI1Snl+g5Qe84pgNFkvNxWK/2QuLlV2gajWEm
         sKB79BLCo4wQrISjfGq3cCYH/HPZwaqp30tczGpLmJZNG8yoKp4qNyvyfup5K6jDEIhB
         /oNrql9ecJ3tXGSP48P4T+B1XznvSxM0wYI3lyFn8lUcYcJ4JbDR0DT0DWyMaAvAZ6bf
         TxihpYI/qdJZ4LNtBeCuB3Tn0D7LMbKv1Bcl5MteEXaLvgkuIRqUk+jf1aQ8EhHrsfR7
         kYSe1Wd+SMYQpfWswQ5VDN6vPdu/cRA+9OL0wdulQL5p/D9wriN4LCeBlKlZzUzG03GY
         UBXw==
X-Forwarded-Encrypted: i=1; AJvYcCXKwc9DygjZasfI2MSW1p/okZg5ZBgNg/AR7G2I9EacyKabG8mgkQlefTns9KBgImASqD929KX4Z1DtauAspFJBKIOV52w8YhtXsbMnf70=
X-Gm-Message-State: AOJu0YwS+6bXmCvBqk9JE6CWbMkvhvEvC7yPQf6v3oPXAVVmlpnTYmal
	tMTAZ5KNotAGXXhdgmYrf09o1B7q2l8e4zWz+n3Rvz9fe/gAv85vEVIgu7to
X-Google-Smtp-Source: AGHT+IFGnmFqFAW8kNaZcw8Pjnk361VW/USoB6+GP2h5QDOrPwOfrXpi2KAQrcNi5neNyC4yoDT1/A==
X-Received: by 2002:a05:6a00:844:b0:6e7:117:c5d5 with SMTP id q4-20020a056a00084400b006e70117c5d5mr9965998pfk.23.1711461071320;
        Tue, 26 Mar 2024 06:51:11 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:ad8c:fe86:c9db:d9cb? ([240b:10:2720:5500:ad8c:fe86:c9db:d9cb])
        by smtp.gmail.com with ESMTPSA id h25-20020aa786d9000000b006e72b591105sm5909379pfo.108.2024.03.26.06.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 06:51:11 -0700 (PDT)
Message-ID: <86f5c815-a2a3-44ca-a8d5-70198e62a643@gmail.com>
Date: Tue, 26 Mar 2024 22:51:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: initialize identify ns data to NULL
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
References: <CGME20240325154544epcas5p4acf7f376241637872a433314489586fa@epcas5p4.samsung.com>
 <20240325154503.11510-1-ikegami.t@gmail.com>
 <dee7f8a3-34af-e12c-ac7d-721960fc0744@samsung.com>
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <dee7f8a3-34af-e12c-ac7d-721960fc0744@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_065116_832699_B55486E0 
X-CRM114-Status: UNSURE (   9.76  )
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


On 2024/03/26 17:50, Kanchan Joshi wrote:
> On 3/25/2024 9:15 PM, Tokunori Ikegami wrote:
>> Currently nvme_identify_ns() sets the data to NULL if failed.
>> Also the data is not freed if the function returned failure.
> If it fails, it frees the allocated memory too.
> So I don't see how the patch helps.
  Yes I think this just helps if in future the nvme_identify_ns() 
function or the caller functions changed the implementation.

