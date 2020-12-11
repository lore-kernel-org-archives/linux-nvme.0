Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D9EC4361B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 02:44:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B08E2310B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 02:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B08E2310B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mdQx3v2gxdxbWvaZOW0h7v0auxnG/iEX/i2JYCSFQdw=; b=f8REpRxStW853bpzs8lZGb/0F
	oJA9iE+TWdjrCV9Io3rMYPN2qUUguPyXWVdfmwlPO0A0b/FeFWWhiRC1sM+kpPF+pW5W6UlLHbdxP
	h7kW5iS/OFoklWqhe2hMp61AQ07QJ1ogIO/BoNqMM8383oWGtxuZhzl35HIDz3YGWaUz9q7MTkXLy
	ybjMU6/V0N80uQCHsoPLQ+SY5YsE/9F241jicx8XdsjFcW67uyEIxjSLU1pPzWf29SU/4EKAkdpmN
	byeE4xAM7QlhHY8Jhb20W/ik3laNei5yGQhCum9fto/gLjBizOLODs1qcU9wvpIj7o57/zZo8O6RU
	XKtgvGs6Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knYPd-0007gr-8l; Fri, 11 Dec 2020 02:44:05 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knYPa-0007gR-Rz
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 02:44:04 +0000
Received: by mail-ot1-x341.google.com with SMTP id 11so6975247oty.9
 for <linux-nvme@lists.infradead.org>; Thu, 10 Dec 2020 18:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0tDJteBxsHXuPyW1+tQBCz8KaIIo5H8mUeLrXX+9d1k=;
 b=oehVFYK/Qnp+XElR2S2D5ykPhtvCwvJF6NP74vU//hm/BkNyBjSmZt+wqRr+O/GdRU
 gsZlh7pbfyOp/l9haNSTaUGBwpA0sIvADwHKHxSAsaAEAvwjfasQujYXL4cWXykhv1VH
 wotwYznBRCIOMrWRZ74qSIBONYD49m8dDvUJxSDrRtbDISVdoI7PFWXcPM6pkkxX4919
 3VQn1yDLW5uT/p/H8vlS7Tw58+STGqMxlHnbUJ24TgT2mnAX08YQ6SS1lt9ZPTrhcwCh
 2VI4cQVXrwA3N0orJQ9huVtktQ2xmg1G6mE6yvXvxNXMvgMLDNTWqxQcm6S6PHc44Cjp
 aDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0tDJteBxsHXuPyW1+tQBCz8KaIIo5H8mUeLrXX+9d1k=;
 b=jfPBjjCAAZM19ORJJkrN93gjKv7iPzQ684kY8Ohqhjo0BVWiNb9DeJxpLNuqisnkck
 nphucsn75xcmLEnfK3MVMHjlK4PLdzHwaI1dyTxgAPo1zf4TXZEZGBh8W1Iwhk9Vrxq8
 bVyFPD1GtAHmDrTSwHL71g4pknxM62wEGHs2xDVsVC8Cn4HRg8e6hy4jZa0sGprXdpW0
 WyUDXrQKZjPggg0W4cVOebflwYqhGSsj/2cDRm92Fentp7xxwVdoNdMHys67dpLbLBPe
 8kKCzWvvSTt5g7gZouGle4f5iEmovtFRxI3aCDqtVy+aZolwlpPaJu6Em4QBWZxmGaME
 bMEw==
X-Gm-Message-State: AOAM531KKnfAIkRsZZ4nr7wGhB6u9e8mNBaCUdGVQLYqgXzCQV1a+up+
 NEIK86DZ4uXHKa0LTUK3WJb8yR6fXcQH3Q==
X-Google-Smtp-Source: ABdhPJwfTjxk6Deev7ECfhrA/aCwgb8wvbJAowJk+Tc/HXZ6uCkkUAAyuIOpUMGAm0s58mkbgY7bWg==
X-Received: by 2002:a05:6830:10d2:: with SMTP id
 z18mr8198842oto.90.1607654640782; 
 Thu, 10 Dec 2020 18:44:00 -0800 (PST)
Received: from Davids-MacBook-Pro.local
 ([2601:282:800:dc80:6139:6f39:a803:1a61])
 by smtp.googlemail.com with ESMTPSA id d62sm1474713oia.6.2020.12.10.18.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Dec 2020 18:43:59 -0800 (PST)
Subject: Re: [PATCH v1 net-next 02/15] net: Introduce direct data placement
 tcp offload
To: Jakub Kicinski <kuba@kernel.org>
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-3-borisp@mellanox.com>
 <6f48fa5d-465c-5c38-ea45-704e86ba808b@gmail.com>
 <f52a99d2-03a4-6e9f-603e-feba4aad0512@gmail.com>
 <65dc5bba-13e6-110a-ddae-3d0c260aa875@gmail.com>
 <ab298844-c95e-43e6-b4bb-fe5ce78655d8@gmail.com>
 <921a110f-60fa-a711-d386-39eeca52199f@gmail.com>
 <20201210180108.3eb24f2b@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <5cadcfa0-b992-f124-f006-51872c86b804@gmail.com>
Date: Thu, 10 Dec 2020 19:43:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210180108.3eb24f2b@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_214403_164305_D1B1A311 
X-CRM114-Status: GOOD (  26.21  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Yoray Zack <yorayz@mellanox.com>, sagi@grimberg.me, yorayz@nvidia.com,
 Boris Pismenny <borisp@nvidia.com>, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, edumazet@google.com,
 linux-nvme@lists.infradead.org, davem@davemloft.net, axboe@fb.com,
 Boris Pismenny <borispismenny@gmail.com>, ogerlitz@nvidia.com,
 viro@zeniv.linux.org.uk, netdev@vger.kernel.org, kbusch@kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, benishay@nvidia.com, saeedm@nvidia.com,
 hch@lst.de, Boris Pismenny <borisp@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/10/20 7:01 PM, Jakub Kicinski wrote:
> On Wed, 9 Dec 2020 21:26:05 -0700 David Ahern wrote:
>> Yes, TCP is a byte stream, so the packets could very well show up like this:
>>
>>  +--------------+---------+-----------+---------+--------+-----+
>>  | data - seg 1 | PDU hdr | prev data | TCP hdr | IP hdr | eth |
>>  +--------------+---------+-----------+---------+--------+-----+
>>  +-----------------------------------+---------+--------+-----+
>>  |     payload - seg 2               | TCP hdr | IP hdr | eth |
>>  +-----------------------------------+---------+--------+-----+
>>  +-------- +-------------------------+---------+--------+-----+
>>  | PDU hdr |    payload - seg 3      | TCP hdr | IP hdr | eth |
>>  +---------+-------------------------+---------+--------+-----+
>>
>> If your hardware can extract the NVMe payload into a targeted SGL like
>> you want in this set, then it has some logic for parsing headers and
>> "snapping" an SGL to a new element. ie., it already knows 'prev data'
>> goes with the in-progress PDU, sees more data, recognizes a new PDU
>> header and a new payload. That means it already has to handle a
>> 'snap-to-PDU' style argument where the end of the payload closes out an
>> SGL element and the next PDU hdr starts in a new SGL element (ie., 'prev
>> data' closes out sgl[i], and the next PDU hdr starts sgl[i+1]). So in
>> this case, you want 'snap-to-PDU' but that could just as easily be 'no
>> snap at all', just a byte stream and filling an SGL after the protocol
>> headers.
> 
> This 'snap-to-PDU' requirement is something that I don't understand
> with the current TCP zero copy. In case of, say, a storage application

current TCP zero-copy does not handle this and it can't AFAIK. I believe
it requires hardware level support where an Rx queue is dedicated to a
flow / socket and some degree of header and payload splitting (header is
consumed by the kernel stack and payload goes to socket owner's memory).

> which wants to send some headers (whatever RPC info, block number,
> etc.) and then a 4k block of data - how does the RX side get just the
> 4k block a into a page so it can zero copy it out to its storage device?
> 
> Per-connection state in the NIC, and FW parsing headers is one way,
> but I wonder how this record split problem is best resolved generically.
> Perhaps by passing hints in the headers somehow?
> 
> Sorry for the slight off-topic :)
> 
Hardware has to be parsing the incoming packets to find the usual
ethernet/IP/TCP headers and TCP payload offset. Then the hardware has to
have some kind of ULP processor to know how to parse the TCP byte stream
at least well enough to find the PDU header and interpret it to get pdu
header length and payload length.

At that point you push the protocol headers (eth/ip/tcp) into one buffer
for the kernel stack protocols and put the payload into another. The
former would be some page owned by the OS and the latter owned by the
process / socket (generically, in this case it is a kernel level
socket). In addition, since the payload is spread across multiple
packets the hardware has to keep track of TCP sequence number and its
current place in the SGL where it is writing the payload to keep the
bytes contiguous and detect out-of-order.

If the ULP processor knows about PDU headers it knows when enough
payload has been found to satisfy that PDU in which case it can tell the
cursor to move on to the next SGL element (or separate SGL). That's what
I meant by 'snap-to-PDU'.

Alternatively, if it is any random application with a byte stream not
understood by hardware, the cursor just keeps moving along the SGL
elements assigned it for this particular flow.

If you have a socket whose payload is getting offloaded to its own queue
(which this set is effectively doing), you can create the queue with
some attribute that says 'NVMe ULP', 'iscsi ULP', 'just a byte stream'
that controls the parsing when you stop writing to one SGL element and
move on to the next. Again, assuming hardware support for such attributes.

I don't work for Nvidia, so this is all supposition based on what the
patches are doing.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
