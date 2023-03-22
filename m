Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28256C6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 11:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pUsLzBbty+zjvYqKGIqWjFdElyc0aY817o+EuZ93dRE=; b=4v2UKViK4ETBujbO3AFP8pTkJA
	I819BkX3t53N+4b/qFRD0MA9QWIoDEolblllIBpgOoL2gVR0x+HTeglSdOKDAZQpnGp+XVvKJ6U98
	snGk0QAYBOyORBHWiEwe9ejy163dy4Fqo/ieKFa7EcswtGH5DgXGhRdkwGdu0kBCnNI8JnB6v4BQy
	LKL0xmUZOR6pwN04h7B7eXuIyw0x5fWHPMLbvQCDedlfA8uMmOd2nj+RFe02Mc2SEZGj/Va+v/+3N
	pDLXvsy9dgFoFHWgDaG0kHHCpqy1tVyhVuFVpvA9yzSO5AoW9USYYJ9Jtyj9gwZkLMXFxFwD2TC79
	WMrt9Lag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pewzB-00Fox8-0l;
	Wed, 22 Mar 2023 11:50:33 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pewz8-00FowH-2L
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 11:50:31 +0000
Received: by mail-wr1-f48.google.com with SMTP id r29so16697794wra.13
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 04:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679485827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUsLzBbty+zjvYqKGIqWjFdElyc0aY817o+EuZ93dRE=;
        b=nf6i7x86t4Q77i9f02hRoaaoOfqiaWC73yaa6F3HBlLgWuuDmSYHfAQ6gYv02Y2FoY
         N4vSIUwDUr1axxoNT+VXMHt9+kjtTypB2zOYk3hTWHcQJb4S9nvFMBA2R0mHxvPP1L12
         G8MsN+FlEUC/C0xbKTGwqjTAXAQRKAY8mTIzvmBA11FtMymHW6wg9yp8Q9rF3lckCZgZ
         BqjqQkB++gbERqVES3W9V4JogtFG9VwxFZIA96W/yXokst6BVFS0zUdzJRSK7BycEXz7
         fzOA+BTl+YWnNtPsUvwlP5Xw1X/XP/BS2NLVLjuY9f4AfgUwl9wIH3Nkh/F5kESP+qet
         M/Cg==
X-Gm-Message-State: AO0yUKUJuPFpMwe02fH+HubxGhEh6FDdWmhegD4g/ZJTt+zYsU4rDGU8
	3pGP+WGhFMziOS5PLF8xoS8=
X-Google-Smtp-Source: AK7set8/OZM6RXDqQ+yuEQj6hbzhIxWyWbdcrHc6WmF+i3E0X6UTyqpYV2giOUnfN0f99r9tNRgPJw==
X-Received: by 2002:a5d:684a:0:b0:2cb:9833:1e95 with SMTP id o10-20020a5d684a000000b002cb98331e95mr3717734wrw.3.1679485827636;
        Wed, 22 Mar 2023 04:50:27 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q10-20020adff94a000000b002ca864b807csm13801937wrr.0.2023.03.22.04.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 04:50:27 -0700 (PDT)
Message-ID: <0cfcab69-c4a1-2072-a85b-12c5a087db58@grimberg.me>
Date: Wed, 22 Mar 2023 13:50:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 11/18] nvme-tcp: control message handling for recvmsg()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 "boris.pismenny@gmail.com" <boris.pismenny@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-12-hare@suse.de>
 <0be88516-8e29-a1a5-f0ff-204830c0fba5@grimberg.me>
 <cd37b4a7-41e7-b142-e87d-908a2e7bcfc7@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <cd37b4a7-41e7-b142-e87d-908a2e7bcfc7@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_045030_765017_D86022A2 
X-CRM114-Status: GOOD (  17.99  )
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


>>> kTLS is sending TLS ALERT messages as control messages for recvmsg().
>>> As we can't do anything sensible with it just abort the connection
>>> and let the userspace agent to a re-negotiation.
>>
>> Is this a problem if we do end up adding read_sock to tls?
>> Although I do see that the tls code does manage this in the
>> sk_buff control buffer, so I assume there is access to this info.
>>
>> CC'ing Boris here as well.
>>
> Yeah, that was the other reason; cmsg aka TLS alerts are only available 
> for recvmsg().
> 
> However, for TLS 1.3 the only TLS alert which does not trigger a 
> connection reset would the the ominous 'new session ticket' alert.
> But during TLS handshake development we already decided to _disable_
> session tickets as they are pretty meaningless for our us.
> Consequently all TLS alerts will trigger a connection reset, and 
> realistically we don't _need_ to know which alert type has triggered
> the reset.
> 
> So 'read_sock()' could be implemented by closing the connection on
> any TLS alert, and not giving us access to any of the alerts via
> control messages. If that makes life easier ...

Most likely read_sock() is the wrong place to ignore alerts. Probably
the better way is to do this in nvme, although its a bit harder.

