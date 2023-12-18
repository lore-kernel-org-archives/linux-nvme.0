Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE27FC35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 09:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dwv/dZdexy97f26buYBZifesoBivV6iIgW/5FYN9YAI=; b=Loq1YP3TTvfVVjW6R+AvfkydR3
	a88vIBLuc2+6M4vERvh59ddpRBIeIDXodQcctFz2EQD3aUwjPHFv9gXRIoEiyf/IrAnXI/4f/VJ2g
	K3wWZSY7kN+oSBZ/XP1NWzjIPGA+ZIZLqOKOc/3lVZFHsUMv2er8JJvx+RVq6Dg/FIAjT6o4Re3SB
	frcZF3/RwvPmMSgiFxbJobOrTw8gaCKkEIqz9EUhn4XXvn+Joqb8g1ze5pNxcxJ1ljx/JP2iIqvKA
	Tsk5FxfqXQz//CWFza6l4/nB+cX4m/KPh3ae8vKf5e8YFxa9/h4vANipWx+784YgTgrlfbvmjrX4J
	RGMqXzFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFAPT-009ke1-1N;
	Mon, 18 Dec 2023 09:59:39 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFAPR-009kc9-0U
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 09:59:38 +0000
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5534be5787cso155225a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 18 Dec 2023 01:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702893574; x=1703498374;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dwv/dZdexy97f26buYBZifesoBivV6iIgW/5FYN9YAI=;
        b=nLIr9l5OT6JJAzGxcAjJHRSLfSLu6eUhYk4bbS9HmXR24H5kW65uInf7EhHSnOKWzS
         2HjkShSx2kmjB+AgQnN9GVLxlUCN5O9flKnE4WBRAsnng7RVxJNNjUOHTgZP2ZhhMVFA
         IsTrBSKurZtLya2Y/xDlZx/8ipLgApFrWpUqMcbZLjwSappaVFbtQSUdYFdiqixhL5m5
         BKoOjzUyus1uvk+hqpt7e0GcQkk0ElHP4rTsSXclziE0vsVHP/X71qivAEUWHAAppbPg
         YMdxoDqvxf7P1fR5N9QJoDsoNl70XhITJSwbBcjwKdtqqsBrFZhOa6UKBn8uDd2QwgH/
         yDxg==
X-Gm-Message-State: AOJu0YyMEwC4IjY5fcYJPBi+b0/Rhc5YUfiAXjIOfJGfTgXJNHFf49P7
	CuKjI9qonG6dur35QVyw5SkktcWr5CA=
X-Google-Smtp-Source: AGHT+IHcUyOWH+s3UDR7ht5syND2aBcDxfOnSiRAL8oas62ywVivHg9Q4M1HdEsbgLJMiYF5bjtQ9Q==
X-Received: by 2002:a50:cc8e:0:b0:54f:64f4:c2f1 with SMTP id q14-20020a50cc8e000000b0054f64f4c2f1mr17190400edi.2.1702893574151;
        Mon, 18 Dec 2023 01:59:34 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d30-20020a056402401e00b00551c8f814d0sm5958903eda.90.2023.12.18.01.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 01:59:33 -0800 (PST)
Message-ID: <74327ed0-63f6-4e9e-9d7c-2bf0eaf264d3@grimberg.me>
Date: Mon, 18 Dec 2023 11:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ioccsz and iorcsz check failing
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <6ib6nyftuap3ubf7uryt6sndmomfif47nkforsitadbda2pdkb@ie35lozrsiqf>
 <ZXyWKKhaDUpyOXsK@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZXyWKKhaDUpyOXsK@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_015937_186237_D939C007 
X-CRM114-Status: GOOD (  19.03  )
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



On 12/15/23 20:08, Keith Busch wrote:
> On Fri, Dec 15, 2023 at 03:48:04PM +0100, Daniel Wagner wrote:
>> Since commit 2fcd3ab39826 ("nvme-fabrics: check ioccsz and iorcsz") my
>> testing fails with these checks when trying to connect a remote target
>> (Linux nvmet) via nvme-tcp. Looking at the TCP frame I see these values
>> are 0 on the wire.
>>
>> When running blktests with nvme-tcp via the loop back device all is
>> good.
>>
>> When running blktest with nvme-fc via the loop back device the first
>> check fails because ioccsz is 0. I've added a bunch of debug prints:
>>
>>    nvme nvme0: I/O queue command capsule supported size 0 < 4
>>
>>    nvmet: nvmet_execute_identify:687 cns 1
>>    nvmet: nvmet_execute_identify_ctrl:469 ioccsz 4 iorcsz 1
>>    nvmet: nvmet_copy_to_sgl:98 buf ffff8881348a6000 len 4096
>>
>> So this part looks good to my eyes. Not sure where the problem could be.
>> In case someone spots the problem as I can't really make sense of it at
>> the moment.
> 
> Weird. I optimistically thought I'd find a problem, but nope, I am
> confused. The code looks like it's doing the right thing, and your
> target side prints appear to confirm that, but host sees a different
> result. Is anything else in the identify wrong, or is it just these
> fabrics fields?

I don't see any issue in the code as well.

I'm wondering if this has something to do with MSG_SPLICE_PAGES that
is just now uncovered?

Daniel, can you try to clear MSG_SPLICE_PAGES from nvmet_try_send_data ?

