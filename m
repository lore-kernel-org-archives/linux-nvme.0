Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD51C3DA6B
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VbxL7FuResP2O2vtoux7WkwTT7ypL+Tnt5KBx5E45Sw=; b=YkLp4w2iRzk8KX1PoyOWWrJ2uL
	6505ANC0iJP60Bcdyp9IlZ9aJAYMpwlLPNborojkcYDkG4YWDgWK0HQh9t23nXEfxLuDmZcbg7krp
	zvzctR9npvNq1KOwMwjsvjo3v1wdQv4VcWtE8OJMvK+aKAm50cfdSO7XDpr+g6ODPzqhxtnXnY9WH
	/iSkhRXLN3s+ZvqJT7sUSb4vJ4f1wFCaqI1d7Ygm4B303dtK6KR2xvcMzC0EyGgG+07543ZHU6Sx5
	AOQxrQK7dWCdSVCAHP3LUyTnxzP8V8hsg/tMoiiZZbBHjSlDzqxWItTlAWYze1Dj5IooxXUHMOShM
	ymaVT3XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTNqB-006OGs-0a; Wed, 31 Aug 2022 13:33:11 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTNq5-006OFS-Ct
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 13:33:06 +0000
Received: by mail-wr1-f42.google.com with SMTP id b16so10678922wru.7
        for <linux-nvme@lists.infradead.org>; Wed, 31 Aug 2022 06:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=VbxL7FuResP2O2vtoux7WkwTT7ypL+Tnt5KBx5E45Sw=;
        b=EhMiSVpylgAYVUUxP3AL2+4+Ku/xEaN8lnzg4OBYQ3+AEqgsJFnfe4PuCsqq251ho6
         RZS0zATPzhOnkmh9euNweIIlDMSK6IaasVmWX+7lDLGY/17UnqDC6AjvoRysNRZ1CRlv
         Gx8egOH9ufU6OiHyMpDZVREyPZKRBbNywO9/8rDpjrGm6p4iiCQZCWJZRIr1kgrPCysj
         DDfsW36A2oPNhFJyNlTfBRPGTW/9ZCPIODCk9B+VVuGDaEyb3xOHl/pKb++r4WjxtEJE
         k2k4pf0E5NPQKjh5lFA5lxEr2mzk9J4bkFRZDARgI/y72U/sLYB5E3+B5ISM4blmZZdr
         2f9w==
X-Gm-Message-State: ACgBeo0n6+/OKRWsv2MEuVW3zJnJ2cYekpJaCnVFaIkEUOXIvezzhWLe
	Xmp1kFdEC5I91I15FdU1T0o=
X-Google-Smtp-Source: AA6agR7z37H5pLYqkqMz2eR/yxcnVJpQcOcDuRez4dsTUGwAL/hbU5C1Y/WgRNdZ07wUUfHLpkcZEQ==
X-Received: by 2002:a5d:6b44:0:b0:225:fbb:678e with SMTP id x4-20020a5d6b44000000b002250fbb678emr12103751wrw.482.1661952781406;
        Wed, 31 Aug 2022 06:33:01 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b00225239d9265sm12353669wrs.74.2022.08.31.06.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 06:33:00 -0700 (PDT)
Message-ID: <dc677c86-284c-21c2-ff42-ce40a1797613@grimberg.me>
Date: Wed, 31 Aug 2022 16:32:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests] nvme/043,044,045: load dh_generic module
Content-Language: en-US
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>
References: <20220831052729.202997-1-shinichiro.kawasaki@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220831052729.202997-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_063305_462098_BE5DE031 
X-CRM114-Status: GOOD (  14.55  )
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


> Test cases nvme/043, 044 and 045 use DH group which relies on dh_generic
> module. When the module is built as a loadable module, the test cases
> fail since the module is not loaded at test case runs.
> 
> To avoid the failures, load the dh_generic module at the preparation
> step of the test cases. Also unload it at test end for clean up.
> 
> Reported-by: Sagi Grimberg <sagi@grimberg.me>
> Fixes: 38d7c5e8400f ("nvme/043: test hash and dh group variations for authenticated connections")
> Fixes: 63bdf9c16b19 ("nvme/044: test bi-directional authentication")
> Fixes: 7640176ef7cc ("nvme/045: test re-authentication")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Link: https://lore.kernel.org/linux-block/a5c3c8e7-4b0a-9930-8f90-e534d2a82bdf@grimberg.me/
> ---
>   tests/nvme/043 | 4 ++++
>   tests/nvme/044 | 4 ++++
>   tests/nvme/045 | 4 ++++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/tests/nvme/043 b/tests/nvme/043
> index 381ae75..dbe9d3f 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -40,6 +40,8 @@ test() {
>   
>   	_setup_nvmet
>   
> +	modprobe -q dh_generic
> +
>   	truncate -s 512M "${file_path}"
>   
>   	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
> @@ -88,5 +90,7 @@ test() {
>   
>   	rm "${file_path}"
>   
> +	modprobe -qr dh_generic

You should not do this, dh_generic might have been
loaded unrelated to this test, you shouldn't just
blindly unload it.

