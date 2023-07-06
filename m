Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F77EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jul 2023 23:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S43GjkoDOerqhWQkXmcIBu1XA2aSLW3jCsxK/tMyfPk=; b=b5UmO8gV478oRBab9W5Sz81X4S
	N3xFMLkeQgZuwl64EtyXFtBtiP2ZwqnQ01/CbNDjtzXhHectavh9YIXac/cvIEXMHYsxfXSqew0z2
	e87P0i2Bw0gFQLe09t4wUZr0ymWH9it5PnGx/y7S23nc43iBFV964CbiaitrMD6VqIPUdbtyCUTr6
	2SvKf0Qx8D9VGsLUY3OQknzBpQvl24ns0cCyLQXx69mCUm9igciQQG+lcgTjoTNjmL+RAGO+moWSC
	/1z1mkEgvxAVVYsloq58t9DuZiu+NixGuCnDO4cLheEkCbO9xF3I5ab2c54t+tkCJJSEYxaiOc+qR
	X6QDDV5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHYEx-002wVk-1U;
	Thu, 06 Jul 2023 23:18:23 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHYEu-002wUn-2b
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jul 2023 23:18:22 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fbe35e028aso3013065e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 06 Jul 2023 16:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688685498; x=1691277498;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S43GjkoDOerqhWQkXmcIBu1XA2aSLW3jCsxK/tMyfPk=;
        b=KoO+5Iqw98r0E1C90ChZpVT8Yb6ji6orZLxwLHSZGhPB39edDYp6i9rnWj61Kwcvp0
         kV76tmBpX9jAEcO1t3dRk5/Takrejs8/r7DlENC2nswfytcXN7dcsqsT+yQqWc6HqmmS
         0WasAdtN5PtrunDMzaFCWeO51wjCAWdNumYvC81PyJJ4CaNOa4MUQundLSspUzYFTQAx
         mqNTYlWO6MX0lIh07ECuYWY8C0S6Yu/urQ2Cn7ZuC3JoJgHgVyODqKxRFU1Rba9tHywb
         CpPaCZGDICmYImZIAxhpFNHX2OzQgXIBY0+/zpxQ4nv5/Ikm4r0COznYjXKkZPyV5qMh
         JQDQ==
X-Gm-Message-State: ABy/qLbW1at9Js+Zt9DutMZQlxS3n9Eb+sEg1cnpUy+cDUVdZhQQ2i5s
	e79ilTtYkvHDN2JvehGD7ag=
X-Google-Smtp-Source: APBJJlHKhGRqai6KNZHifE44uuz7SwROsEL/hugKlhbw7y4fsNF+EWxVuAebtE6qO9dwDCfym9lMgQ==
X-Received: by 2002:a05:600c:1c99:b0:3f7:e7c9:4039 with SMTP id k25-20020a05600c1c9900b003f7e7c94039mr2693676wms.4.1688685498245;
        Thu, 06 Jul 2023 16:18:18 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id c16-20020a7bc850000000b003fbb06af219sm792252wml.32.2023.07.06.16.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 16:18:17 -0700 (PDT)
Message-ID: <49422387-5ea3-af84-3f94-076c94748fff@grimberg.me>
Date: Fri, 7 Jul 2023 02:18:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: nvme-tls and TCP window full
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <f10a9e4a-b545-429d-803e-c1d63a084afe@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f10a9e4a-b545-429d-803e-c1d63a084afe@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_161820_843107_CD66C7DC 
X-CRM114-Status: GOOD (  22.25  )
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


> Hi Sagi,

Hey Hannes,

> I'm currently debugging my nvme-tls patches; with the rebase to latest 
> linus' head things started to behave erratically as occasionally a CQE 
> was never received, triggering a reset.

Bummer.

> Originally I thought it's my read_sock() implementation which is to 
> blame, but then I fixed wireshark to do a proper frame dissecting 
> (wireshark merge req #11359), and found that it's rather an issue with 
> TCP window becoming full.
> While this is arguably an issue with the sender (which is trying to send 
> 32k worth of data in one packet)

This is before TSO. it is not actually 32K in a single packet. If you
record on the switch, you will see that it is packetized to MTU size
properly.

> the connection never recovers from the 
> window full state; the command is dropped, never to reappear again.

This is a bug. And sounds like a new issue to me. Does this happen
without TLS patches applied? And without SPLICE patches from david?

> I would have thought/hoped that we (from the NVMe side) would
> be able to handle it better; in particular I'm surprised that we can 
> send large chunks of data at all.

What do you mean? if we get R2T of a given size (within MDTS), we just
send it all... What do you mean by handling it better? What would you
expect the driver to do?

> And that the packet is dropped due to 
> a protocol error without us notifying.

TCP needs to handle it. It does not notify the consumer unless there
is a TCP reset sent which breaks the connection. But I am not familiar
with a scenario that a TCP segment is dropped and not retired. TCP is
full of retry logic based on dropped packets (with rtt measurements)
and ack/data arriving out-of-order...

> So question really is: do we check for the TCP window size somewhere?
> If so, where? Or is it something the lower layers have to do for us?

We don't and we can't. The application is not and cannot be exposed to
the TCP window size because it belongs to the very low level of 
congestion control mechanisms berried deep down in TCP, that's why
socket buffers exist. The application sends until the socket buffer is
full (and evicts when sent buffers are acknowledged within the ack'd
sequence number).

> Full packet dissection available on request.

This does not sound like an nvme-tcp problem to me. Sounds like
a breakage. It is possible that the sendpage conversion missed
a flag or something, or that the stack behaves slightly different. Or
something in your TLS patches and its interaction with the SPLICE
patches.

Can you send me your updated code (tls fixes plus nvme-tls). I suggest
to start bisecting.

