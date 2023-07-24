Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0C6EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 19:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zh2sIOXiXBjnHrMA4Ac/X3uiwzQt0vlGqP8W0egXbw0=; b=jA1QpgFdauhVXm8rxo6cGMMMu5
	FZ49CAGGo5j0MVP1XYCdzk5+PWRkz70vezLTTs0I+nOHJlZPlhoMEjZg1NpGNbai3YlnpWn8V/Z37
	a4WKtjwO0Q72sA21eEQL2qM94I5xwG6leM7ghVwscrdfn/AE25OyagkrzFexiZiacsueZoxDlyHOR
	bfj/SdL36jlYVcg8XAWg6rGsjs0Z2kbHOwBC+EMQmZV0Dn8dv5iYVs2s7HNlvY+VxKN9VtBE4QIh+
	xx0vxQqfO4GI4l2/dNc5Z3m9L6bSe0meP/t/bWyKGVqDHAZVGUYmEd6rnzoG3qzwzsbDzWaoQR334
	acadlwig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO1UH-005Jtq-0d;
	Mon, 24 Jul 2023 19:44:57 +0000
Received: from mail-ej1-f54.google.com ([209.85.218.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO1UE-005JtM-0Q
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 19:44:56 +0000
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-99b4865ad55so158063166b.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 12:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690227892; x=1690832692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh2sIOXiXBjnHrMA4Ac/X3uiwzQt0vlGqP8W0egXbw0=;
        b=d9AykSkndJZiJd2x7DvmkLCwbPxG4mmtMSerbTOcI0K1weKfVdFcSvlv0SKc96qcML
         7iIuhe4tn61F0my/oPCBzWCYVBaxnbURIq4HDUKS5VTxGwGEBFC+Zg6QiGpeyLvXxamC
         B3ojsfDDD0REVOm3KAq/+sR7AxtX9/AHG2j4z0xezmH/5guQGUDmQ2UxNIZK9wp02m45
         Gopz+ULzy9F0z664cEJFpDYqdvEepo0y2FY75aAc8TVnNx8ikxe5hrzlzRNbqfW8fSG6
         6l2042Xx0m09sHYZKABjhi4dd3Uhboiy0pm07imC9kxotYnunalASrnJFQK2stqPdGds
         gHJw==
X-Gm-Message-State: ABy/qLY9R0siIJo4dKhwwFZadviOE74rdrmsYe7xn3aHvy3v0b6+x6VX
	5g4ngZWzPHBIciscnVTdHGU=
X-Google-Smtp-Source: APBJJlH7Tv4CBdcvg6bLHHef5fUwGk7QJ4PoctPnunUdUFOaRjx4uUiaNb6UN93ntB/ZkQ9GKFYr6A==
X-Received: by 2002:a17:906:518e:b0:974:5480:6270 with SMTP id y14-20020a170906518e00b0097454806270mr8691149ejk.0.1690227892110;
        Mon, 24 Jul 2023 12:44:52 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id l24-20020a1709066b9800b009893f268b92sm7062624ejr.28.2023.07.24.12.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 12:44:51 -0700 (PDT)
Message-ID: <ad36e40b-65d9-b7ad-a72e-882fe7441e52@grimberg.me>
Date: Mon, 24 Jul 2023 22:44:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv8 0/6] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20230721143523.56906-1-hare@suse.de>
 <20230721190026.25d2f0a5@kernel.org>
 <3e83c1dd-99bd-4dbd-2f83-4008e7059cfa@suse.de>
 <9f37941c-b265-7f28-ebec-76c04804b684@grimberg.me>
 <20230724123546.70775e77@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230724123546.70775e77@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_124454_166869_5EB16E47 
X-CRM114-Status: GOOD (  16.11  )
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


>>>> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>>>>
>>>> Sagi, I _think_ a stable branch with this should be doable,
>>>> would you like one, or no rush?
>>>
>>> I guess a stable branch would not be too bad; I've got another
>>> set of patches for the NVMe side, too.
>>> Sagi?
>>
>> I don't think there is a real need for this to go to stable, nothing
>> is using it. Perhaps the MSG_EOR patches can go to stable in case
>> there is some userspace code that wants to rely on it.
> 
> I'm probably using the wrong word. I mean a branch based on -rc3 that's
> not going to get rebased so the commits IDs match and we can both pull
> it in. Not stable as in Greg KH.

Are you aiming this for 6.5 ? We are unlikely to get the nvme bits in
this round. I also don't think there is a conflict so the nvme bits
can go in for 6.6 and later the nvme tree will pull the tls updates.

