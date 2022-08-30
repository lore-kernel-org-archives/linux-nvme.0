Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5BFECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 13:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zQxbCXG01Qvb3BtvrymBoUiMedeZJvELFPv8dZYnP74=; b=3eVPSsXPqTgRaQn0hiBd0PMxqX
	xutNbvSsNz/lcIYqqL2Qrw1vEmWB/fPiVka86Sr/aU4rzF1Q2gZLw1SeRyiMZeJQ9nvgLkk6V2QU8
	aMOcYb+DLzWuC4JBjuGo0o8n/H1ZG1Bia72QdgXREbuBoTyWLo1hhnYmO+sZAJ0KbE0nglJCg6ju5
	9pslwYeYcTHyntSKuscJlP6zMbmr9zl+/z6HA0qptt5iDWO9V/98OeQEaYnMCfv1ldo+OAbq01HDF
	mTeQxOaBQ0m60hmYTkGl1pddic2sp+c1KoQFt/GwvZuolsRsSmWdiHGbHFhKh1vCp3buk8Crm/y17
	UYOHlFEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT1G3-00HMxE-9e; Tue, 30 Aug 2022 13:26:23 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT1G0-00HMvy-N3
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 13:26:21 +0000
Received: by mail-wm1-f44.google.com with SMTP id r204-20020a1c44d5000000b003a84b160addso1848712wma.2
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 06:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=zQxbCXG01Qvb3BtvrymBoUiMedeZJvELFPv8dZYnP74=;
        b=C2WC3C3LmwD7adKfT2bjJWbmR2c0LBsobQQycJcpgq50IDYEdgAJC/4w9F+yHjevgC
         qATpxAJr+ybrTcmDLqGMcuUrFADmnILk3DBz9Gm1Zj0aVxsR3Fyi9sUXqwhmSjDWu2/T
         mUJJSFUDI9EgZIB3X5lJ2rUXqOpUkgDFAbHsgG99OSmkks61mxeiD/RIYCBLzlF1u3v0
         yabgH4xrRWG5DMvrHRE1tnlSDc5maM3aP6sP0txQ3pk+Pc5hSSn1iewa/SnOKsfa87Nd
         bn9Vq73VENO2NU5d5/wF6wc9CBUw2Awd23TehADhWhH0/0n2b5MHVxXgSc6mcXU9I5JF
         bpDQ==
X-Gm-Message-State: ACgBeo0HIImB6GWzfr0z9AoY57yZIt9LqBGSoyslceNUQVKKzd7xl9xF
	V+3paJ4umFW7X/Sef4jGxss=
X-Google-Smtp-Source: AA6agR6X4HcsJAi+hUWO7TTyNoO6Mk1pXCbji4Sk2MXQOwBLni+N5wBknafR+02LYgIr8Oj8YB8ZgQ==
X-Received: by 2002:a1c:4c03:0:b0:3a5:d65c:c1e7 with SMTP id z3-20020a1c4c03000000b003a5d65cc1e7mr10054436wmf.4.1661865977761;
        Tue, 30 Aug 2022 06:26:17 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c510600b003a5de95b105sm10696248wms.41.2022.08.30.06.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:26:09 -0700 (PDT)
Message-ID: <a5c3c8e7-4b0a-9930-8f90-e534d2a82bdf@grimberg.me>
Date: Tue, 30 Aug 2022 16:26:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>
References: <20220829083614.874878-1-sagi@grimberg.me>
 <20220830044632.j7k45lhdlyvksrxh@shindev>
 <05548286-8d18-e3b4-06db-640c9d6b1399@grimberg.me>
 <20220830102357.yahkv5qfr2ewa7uh@shindev>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220830102357.yahkv5qfr2ewa7uh@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_062620_779482_440FC51F 
X-CRM114-Status: GOOD (  16.12  )
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

>>
>>> Hi Sagi,
>>>
>>> On Aug 29, 2022 / 11:36, Sagi Grimberg wrote:
>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>> ---
>>>>    tests/nvme/043 | 1 +
>>>>    tests/nvme/044 | 1 +
>>>>    tests/nvme/045 | 1 +
>>>>    3 files changed, 3 insertions(+)
>>>>
>>>> diff --git a/tests/nvme/043 b/tests/nvme/043
>>>> index 381ae755f140..87273e5b414d 100755
>>>> --- a/tests/nvme/043
>>>> +++ b/tests/nvme/043
>>>> @@ -16,6 +16,7 @@ requires() {
>>>>    	_have_kernel_option NVME_TARGET_AUTH
>>>>    	_require_nvme_trtype_is_fabrics
>>>>    	_require_nvme_cli_auth
>>>> +	_have_driver dh_generic
>>>>    }
>>>
>>> Do you see failure without this check?
>>
>> Yes, if dh_generic is built as a module (CONFIG_CRYPTO_DH=m).
> 
> Thanks. I was able to recreate the failure setting CONFIG_CRYPTO_DH=m.
> 
> Unfortunately, your patch does not avoid the failure after the recent commit
> 06a0ba866d90 ("common/rc: avoid module load in _have_driver()"). As the commit
> title says, _have_driver no longer has the side-effect to leave the dh_generic
> module loaded. Instead, I suggest to load dh_generic in the test() function:
> 
> diff --git a/tests/nvme/043 b/tests/nvme/043
> index 381ae75..dbe9d3f 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -40,6 +40,8 @@ test() {
> 
>          _setup_nvmet
> 
> +       modprobe -q dh_generic
> +
>          truncate -s 512M "${file_path}"
> 
>          _create_nvmet_subsystem "${subsys_name}" "${file_path}"
> @@ -88,5 +90,7 @@ test() {
> 
>          rm "${file_path}"
> 
> +       modprobe -qr dh_generic
> +
>          echo "Test complete"
>   }
> 

That's fine with me, can you prepare an alternative patch for it?

