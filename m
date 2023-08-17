Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9C2C27C7A
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 11:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/qDGBTxkIM76SBLG417AAwTBir1T75Ixp2e5rls5Pjs=; b=Id+wz9nbvXeow60WZ1Ua+UQOWR
	Jsd5nOlOxmHhTNTVOp9AYSfo5+Lxw3bpJKDP4tIAseXF9P5fLyptuq3UmRUmqQJoeUZz+H5RMpkDS
	KufPjDvmKaYpLUC77xYm9JeD8tSx0lH+/NRuAP6aHWmO7cRfjHUNnGtdg5A5W76OMJ3Vrd4x00irL
	0JKMuLqbeJeavZ0Tdg29fV61VSlgYq1bLv8uKWaWWGDHD94lZ2jJpCQqZRlk9HjbsZDYus16/IAKT
	6cbE92I8HldQ5MyaZZZWRnR9OOZjw6oeTvtTNVvzt4s8KWKKbdESbPlIeoOc1fzmGzwhBPXi2HEX6
	qDfl0o2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWass-006FDQ-2o;
	Thu, 17 Aug 2023 11:09:46 +0000
Received: from mail-lj1-f169.google.com ([209.85.208.169])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWasq-006FCd-0x
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 11:09:45 +0000
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2bb94e3f39bso6775371fa.0
        for <linux-nvme@lists.infradead.org>; Thu, 17 Aug 2023 04:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692270581; x=1692875381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qDGBTxkIM76SBLG417AAwTBir1T75Ixp2e5rls5Pjs=;
        b=CB3yWfHNRNXr+k1H4wn4Jbrwbo7HXEaIpplCpFux/KcaOeLHpDzJsg4mtB/dvd2dFI
         UJH1oKj+2u8d1gTGMozbXZ1ocPnIqxiye+G7PXSry+bujik52OgreGY/HRqYtwLvHAmP
         tQGuNlIldZyKFUxTkp4dYsznUlS8YyNufzslbJp5LbUWMLsKSNVnYTyNLPolAPcFHxe7
         rsNB+eyMSO7Nw0Qx4cAeq+2x32XL36YgPJTg4colj5oyJda3q3QhfCysyOcgxxIWmAU0
         Z9983zZDSNzOZNbRg57HYuyYTdpGV61ZyoqRf2YR6fvWsC/lEzEBnFYLL80itje2Qlc6
         SAXA==
X-Gm-Message-State: AOJu0YwHF+8+aYo1egN+x5GyOapVI2E3B4b33WfLZg5ZpX2HhcIo6Ika
	lwYx+c9x3PeMWuOePrKUkiqt0ddzYzc=
X-Google-Smtp-Source: AGHT+IFidDSV4SP+IyV3D09/9KnLZEDRuJAPZQ1NT7OC+EFw6bg4jJoyZKuSSkxqEu0t1j9VfvQowA==
X-Received: by 2002:a2e:b53a:0:b0:2b8:3c52:113 with SMTP id z26-20020a2eb53a000000b002b83c520113mr3784941ljm.5.1692270581150;
        Thu, 17 Aug 2023 04:09:41 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z22-20020a7bc7d6000000b003fbfef555d2sm2572704wmk.23.2023.08.17.04.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 04:09:40 -0700 (PDT)
Message-ID: <0569a67e-1264-1dcc-d44a-23bf8256a9e9@grimberg.me>
Date: Thu, 17 Aug 2023 14:09:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rfc 6/6] nvme-fabrics: expose support for traddr as dns
 names to userspace
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-7-sagi@grimberg.me>
 <7d60e267-be0a-41ff-8015-d3440b6eca2c@suse.de>
 <433182d8-c57e-2e51-2692-02ac8b474bf2@grimberg.me>
 <8e72f698-af99-c8a4-a672-d51d28ee7a36@grimberg.me>
 <cc448d32-f3f1-0929-18d4-15186adeac01@suse.de>
 <b4fe7c1f-1581-bad2-9203-6f4c87d6a599@grimberg.me>
 <69b5e07b-f16a-0a9e-bee2-28877dbecab3@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <69b5e07b-f16a-0a9e-bee2-28877dbecab3@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_040944_342102_7DB56FE6 
X-CRM114-Status: GOOD (  19.86  )
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


>> I listed that as an option, you should read it.
>> There are some disadvantages in doing that, it needs to co-exist
>> with the mandatory (today) traddr, which is now will be mandatory
>> only for fc. And also now the user will need to decide a conflicting
>> existing functionality in nvme-cli that today accept dns names as
>> a format to traddr, but now will need a different argument for
>> passing it to the kernel.
>>
>> Anyway, its possible, but more complicated IMO.
>>
>> Plus, I also think that it can be useful for the kernel to signal
>> capabilities and support for things that are not only valid tokens.
> 
> I cross-checked with nvme-cli; there we read the list of available 
> tokens upon failure to give the user a hint which arguments are 
> supported by any given kernel.
> So by that regard it should be fine to just add 'dns' as a parameter
> here.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Thanks,

I'd also want to hear from others (Keith, Christoph, Chaitanya, Daniel,
Martin...)

Where do you stand on the kernel exposing capabilities that do not
manifest in "valid tokens" when writing to /dev/nvme-fabrics ?

today when we read /dev/nvme-fabrics we get a string with all
the valid tokens. that is useful for userspace to understand what
it can or cannot pass in a fabrics connection string.

In the example here, we are trying to introduce a new format for
traddr argument that is now supported by the fabrics driver (tcp/rdma)
where traddr can now be ipv4, ipv6 or a dns name (where before this
patchset it could only be ipv4 or ipv6).

The question is:
Do we enforce that every new capability must come with a matching valid
token? Or do we want to expose capabilities that are not necessarily
come with dedicated tokens (like in this example)?

I think the latter is a be better approach. But could be convinced
otherwise...

