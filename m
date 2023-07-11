Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A72EB64DD
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 19:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a83u02dRQIY72xED+2uezS0avDMu71isv9swtNIALZ8=; b=JQrPqYSj6zOHG7RrdO/dxNMp0e
	NaN5ClzeGl57Dc0wZE7zN0fYCYzUc+0acoQT9C986rmEbUlF83YKZ/CmrvIwa+lOuiWkgRo15b8Nr
	E9cFee0XCTnOOSnpMB2xwIOT64u6IvNLmNtBrqc15Bvvsh9HBSMyYhAFVg5mYlfpzGiBTbpHgt94/
	/q/ErLCwSmf7dOsSsClXUX8koKftfZImHyQzUpHdEI3V985oEsRPa8nmA4GX1mkNogXKKxJgbWQZu
	vpNQke2Lv096LfRK/v+Ukt07zzSC/FnibTluId1mXzSxUdgZchj2eXfrbpetpLCQ3Y5hVuh8XI3i7
	NiViYA1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJJLQ-00Flxo-3C;
	Tue, 11 Jul 2023 19:48:20 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJJLO-00Flwv-14
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 19:48:19 +0000
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-403b36a4226so13778791cf.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 12:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689104897; x=1691696897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a83u02dRQIY72xED+2uezS0avDMu71isv9swtNIALZ8=;
        b=JKqSpKV4Ht1RCs65znN5FcaT6Fzpm8CWNSDqrWofvIVGWPHQ6ZOou5lIH0th0qIkki
         bOcQ8l8tyvLzlbvJ7tIsh9xgsmU6vOZVvN+Cl6eazg7r2aCiKakWf+3ZxVadiC7RTocf
         DHLehpeqzgmbb1lkgnLsFXU6zfoUs1gszngme6hF8FKu8jo3ju/JVvADLD+7S4V6hhWx
         qBDU+X4F/zHXAmOY8jvY5Z0ZD4wWKCej8vbGfw757dmwVnmBdCHsm0KGvF3O623HaiH7
         OKuP/L1BgI33B0kJBt2UB3P+8Yf6rZfCjE4sJbn+rJSwbWqdZcNpALtyjcNyOWaSBYom
         U4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689104897; x=1691696897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a83u02dRQIY72xED+2uezS0avDMu71isv9swtNIALZ8=;
        b=kaJAHoORFxFdvJVWIsx/rnaZ20blKZxUWOkEVCltMoX0D0XtR9rqgCcLRu73qt8PLU
         Gunn3rXqG/Q161duda1iP3OCt1klZM2UKlfOERzBPXIEANTE2XYqBVFgAzgvTLoL1hjD
         T8xwl6+9q6jz7MR48VXaKECxf5i0lFT2W099yAbda+RZAKfC1/u5+hqhfHhnjjO8S4kq
         dA3Iyi7cR+MSL80kzjnXoEH5GKSIeaECjvmQHHvpPxjAzhTxABoIuCS/l6z3yUQhsazU
         si9RQOI0hnd+qYsMASgiB1/ro+12Y55WTXhFp9j8W9aMNa1Fz/mjVGdAgR68YEnmX8gs
         W6eA==
X-Gm-Message-State: ABy/qLa1KZtVVYC2uUPYZ8+iIFF6rimQyoIjHZx5nGnN8xYbb4YR6Z2b
	3D1CecS44pfh/WVMEmX8HNWNeI48158=
X-Google-Smtp-Source: APBJJlGdL7ilrNyHMqXOBIq71Om0DgaeuIkOJJQskMnlU7Y+IB1gP4bhQ9reFkTJjvj+eWeP9QCoyA==
X-Received: by 2002:a0c:e108:0:b0:628:6879:ee48 with SMTP id w8-20020a0ce108000000b006286879ee48mr14571295qvk.50.1689104897481;
        Tue, 11 Jul 2023 12:48:17 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o3-20020a0cf4c3000000b0062439f05b87sm1459570qvm.45.2023.07.11.12.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 12:48:17 -0700 (PDT)
Message-ID: <5e3cb52c-ad4e-cacf-a45a-7e7c7f173806@gmail.com>
Date: Tue, 11 Jul 2023 12:48:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] nvme-fc: fix race between error recovery and creating
 association
Content-Language: en-US
To: Michael Liang <mliang@purestorage.com>, linux-nvme@lists.infradead.org
Cc: randyj@purestorage.com, csander@purestorage.com,
 ushankar@purestorage.com, psajeepa@purestorage.com
References: <20230707212157.1158725-1-mliang@purestorage.com>
 <20230707212157.1158725-3-mliang@purestorage.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20230707212157.1158725-3-mliang@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_124818_367492_1F3FE380 
X-CRM114-Status: UNSURE (   9.61  )
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

On 7/7/2023 2:21 PM, Michael Liang wrote:
> There is a small race window between nvme-fc association creation and error
> recovery. Fix this race condition by protecting accessing to controller
> state and ASSOC_FAILED flag under nvme-fc controller lock.
> 
> Signed-off-by: Michael Liang <mliang@purestorage.com>
> Reviewed-by: Caleb Sander <csander@purestorage.com>
> ---
>   drivers/nvme/host/fc.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)

This patch looks good.  Thanks

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james



