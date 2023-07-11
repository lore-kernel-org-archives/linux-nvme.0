Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2276C001B0
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 09:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hM3N1N5IEsWENYiyPhiapvjbXrCcbqpL3Zb03IqIMXk=; b=Rj178QLmLCBcEWp8wdVF1Fv5Rc
	RwkNoE5CH3UOtnQJQOAuuMt5S44s02+hk0MIgw/hyAYV+o6FIW5kmJA/y89dlWNShMcpAPpk9jK43
	uOUBcC4PlhQvBWIDxiXdqYj4T4PRkF1fSLNj+DSkbjbTSI4kyCrxHKhWzo5naglKz+IijSBGJbTp/
	c5Unf3NfzuolrJxdOQdPaeJIBdbAjxRuTt2Du37N6n42OAJ5SloVCE5bTxPPn+55DOmFZHtq02eLS
	p6C6350EGZLjp2nBZXpD/Goqv7kpmht9Hpo3dWuGDl0KFVbznqTz+YoB1lQAqxMqQuqi68cCyxLkj
	5lKNeRSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ9g8-00EHxm-2F;
	Tue, 11 Jul 2023 09:29:04 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ9g5-00EHwK-1N
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 09:29:02 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3159acfc48cso465806f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 02:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689067734; x=1689672534;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hM3N1N5IEsWENYiyPhiapvjbXrCcbqpL3Zb03IqIMXk=;
        b=WK3hhd95omjqrnAfc7nU29x2ixwSMSR8cgAmua0kddKyzhFSb+PuSLkl7Gl3QPySP+
         ma0hW3t+wWwJAbSvh8ehm4YwCmkbupcs8MXugU6diJORmgrGCGpf0WMUen5eB8RKbOCb
         rqGyLmwnLpOHtp4aRQP+Av+qzXz4YWGf7pAtaFlXHWEixXZ+ZgB4fTgek8kNFG56Prek
         0WRfMKHDp/Nwr5W95vbyR3krQ2hSWZ+XyGeau8js73ePkTXa/0Fp86PApvLqmLI/baWy
         5iZxRVjoFDwTXfi98XNR0sg/FUpPrnm4/FslyqX0nCWnXg/mO5KQNn5wEyU17EEijPfw
         0+AA==
X-Gm-Message-State: ABy/qLZ5Qt3xm87yTyA8kiz5OEkc8vKJc3t85UP0rHwdGU3E0VWEFEWX
	U7kG7/P20QaZbbHBfWdE60S5Xhh6QFs=
X-Google-Smtp-Source: APBJJlGJuBPaAEAD5FDkfW6i0zEbwS1Us2+UITc3LvcNjF1prfodKGr0CnNcdS+MB8svV/hV/Qmd0g==
X-Received: by 2002:a5d:42ca:0:b0:314:3dd7:bb9e with SMTP id t10-20020a5d42ca000000b003143dd7bb9emr13412265wrr.7.1689067733445;
        Tue, 11 Jul 2023 02:28:53 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w8-20020adfd4c8000000b003141e629cb6sm1703250wrk.101.2023.07.11.02.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:28:53 -0700 (PDT)
Message-ID: <ed5b22c6-d862-8706-fc2e-5306ed1eaad2@grimberg.me>
Date: Tue, 11 Jul 2023 12:28:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: nvme-tls and TCP window full
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <f10a9e4a-b545-429d-803e-c1d63a084afe@suse.de>
 <49422387-5ea3-af84-3f94-076c94748fff@grimberg.me>
In-Reply-To: <49422387-5ea3-af84-3f94-076c94748fff@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_022901_482184_85CE3E7A 
X-CRM114-Status: GOOD (  30.72  )
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

Hey Hannes,

Any progress on this one?

On 7/7/23 02:18, Sagi Grimberg wrote:
> 
>> Hi Sagi,
> 
> Hey Hannes,
> 
>> I'm currently debugging my nvme-tls patches; with the rebase to latest 
>> linus' head things started to behave erratically as occasionally a CQE 
>> was never received, triggering a reset.
> 
> Bummer.
> 
>> Originally I thought it's my read_sock() implementation which is to 
>> blame, but then I fixed wireshark to do a proper frame dissecting 
>> (wireshark merge req #11359), and found that it's rather an issue with 
>> TCP window becoming full.
>> While this is arguably an issue with the sender (which is trying to 
>> send 32k worth of data in one packet)
> 
> This is before TSO. it is not actually 32K in a single packet. If you
> record on the switch, you will see that it is packetized to MTU size
> properly.
> 
>> the connection never recovers from the window full state; the command 
>> is dropped, never to reappear again.
> 
> This is a bug. And sounds like a new issue to me. Does this happen
> without TLS patches applied? And without SPLICE patches from david?
> 
>> I would have thought/hoped that we (from the NVMe side) would
>> be able to handle it better; in particular I'm surprised that we can 
>> send large chunks of data at all.
> 
> What do you mean? if we get R2T of a given size (within MDTS), we just
> send it all... What do you mean by handling it better? What would you
> expect the driver to do?
> 
>> And that the packet is dropped due to a protocol error without us 
>> notifying.
> 
> TCP needs to handle it. It does not notify the consumer unless there
> is a TCP reset sent which breaks the connection. But I am not familiar
> with a scenario that a TCP segment is dropped and not retired. TCP is
> full of retry logic based on dropped packets (with rtt measurements)
> and ack/data arriving out-of-order...
> 
>> So question really is: do we check for the TCP window size somewhere?
>> If so, where? Or is it something the lower layers have to do for us?
> 
> We don't and we can't. The application is not and cannot be exposed to
> the TCP window size because it belongs to the very low level of 
> congestion control mechanisms berried deep down in TCP, that's why
> socket buffers exist. The application sends until the socket buffer is
> full (and evicts when sent buffers are acknowledged within the ack'd
> sequence number).
> 
>> Full packet dissection available on request.
> 
> This does not sound like an nvme-tcp problem to me. Sounds like
> a breakage. It is possible that the sendpage conversion missed
> a flag or something, or that the stack behaves slightly different. Or
> something in your TLS patches and its interaction with the SPLICE
> patches.
> 
> Can you send me your updated code (tls fixes plus nvme-tls). I suggest
> to start bisecting.

