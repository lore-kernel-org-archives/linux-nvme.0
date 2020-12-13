Return-Path: <SRS0=ZzGD=FR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1E1C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 18:34:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38AA222BB
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 18:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38AA222BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EmKIjfoYrnkN26gA+Ys5Sidun4aH9XnI6gfdePwB7ss=; b=RZS6GQepj90sb2aelcc1dKDqi
	wTiMT25yaw93zgFwHEpcK6KKt3jDPr/dVeeLvWi9rCTGDmLuhGigcNEqfdYx6IN288AFmIOfTmlK1
	1h/K3vb5gqY5fIDJv9wk/xn8U4rCuW5YK9G37SqTq5osfRF+Ipwfqgs7aSWKvjCRtNQVQ3T8B0NPL
	eCl007ynaL8xJT1fk22L6dXnSLjFF9sC9x08KK4duXjUiJQMSzcPHAoI2aZg0mh+B7GAx9DA9Uu3l
	c01K2Fwfw346L8d9So4YJ/3D6UTe2n0IJ7GB/dbslx+gVU07TWWn5SwbbrMY0bSruueRazn+EAOBS
	RIu1Wh9HQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koWCK-0001aS-HG; Sun, 13 Dec 2020 18:34:20 +0000
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koWCH-0001a2-5i
 for linux-nvme@lists.infradead.org; Sun, 13 Dec 2020 18:34:18 +0000
Received: by mail-ej1-x642.google.com with SMTP id qw4so19447585ejb.12
 for <linux-nvme@lists.infradead.org>; Sun, 13 Dec 2020 10:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jnaPckIBgTXWFDob5GePWhYJaVkqK5+2RJHvkwb+Gu0=;
 b=tbenM8E8b9KkC6iR5SjyuePF80NI0d0UqJjS1G7DldTiyIKE93d9uRcjLRKi9vxudT
 a1FF/pYi9E5SnyOxHDXGdo/yE4I/JJ8VCIDF1bPsOC3cvZZI+RbSeAhrW83tSDWqjVBu
 IreTVpBnmZqXdy/SRcUeUVTYQNhuPPk9u37LK1u9fqffLAIjoo3LnL34lnbwoWa9BrrX
 f8Nopu+FfJA+/yxkQa3lxzXxSXHebFu3OQZ79IjkF6wwWGVQezUDoyV0MwDfQ1G5GlCp
 JtibUMZvVZaFGWfSQI/R03JhpyueGSZrJh/SbWps0iHYo1S+6QLESjnCMdo6OaB2BGEa
 RY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jnaPckIBgTXWFDob5GePWhYJaVkqK5+2RJHvkwb+Gu0=;
 b=ljyBiLa42ni48lI5U1YxcKycOpvdCRDGC6mv9qDSlSDr4rU5kzKhCNZbxpl2Jyn1Ci
 7HK1Zp87hmNnltRh/3PQiMr2acKUSbVxNf6NYW0jhalp+7I5ezAnQZMEtOrKfgiTdof5
 5FatzchUtgETEgPwH9V/n3LWbroduPu9dLsrGeSlbsbqDqPYlCZ4VhLFKJTr2MSVAyJi
 2eiCqoAe4j5cOyk6UHRG5WH06tAHwsdDwMxHY3JVsRJBwFq0h1csBOAR9coE3lkPjQze
 SSNxoB0VqRZYon4c5XJ5MQL8hFEr7m/vO9YB/PHryTL+ADDlDYbR0sBQj3VMMn90r+BK
 sJ4g==
X-Gm-Message-State: AOAM533RvvR6Z7dUwaXuku8ts5Cl2Xl895DIQd2W4NhpLb4SJBs/sT+6
 LaE85UxD7oOJfKSFVQkh4fk=
X-Google-Smtp-Source: ABdhPJzmEe6ZfYK6IidsPOxpeWwD5gHeunKVezRXFMMawbt4OljyGj+qo6whwYEq3WCDcsaZWw3/sw==
X-Received: by 2002:a17:906:4a4f:: with SMTP id
 a15mr20115681ejv.541.1607884455624; 
 Sun, 13 Dec 2020 10:34:15 -0800 (PST)
Received: from [192.168.1.11] ([213.57.108.142])
 by smtp.gmail.com with ESMTPSA id s1sm11677493ejx.25.2020.12.13.10.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Dec 2020 10:34:14 -0800 (PST)
Subject: Re: [PATCH v1 net-next 02/15] net: Introduce direct data placement
 tcp offload
To: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@gmail.com>
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-3-borisp@mellanox.com>
 <6f48fa5d-465c-5c38-ea45-704e86ba808b@gmail.com>
 <f52a99d2-03a4-6e9f-603e-feba4aad0512@gmail.com>
 <65dc5bba-13e6-110a-ddae-3d0c260aa875@gmail.com>
 <ab298844-c95e-43e6-b4bb-fe5ce78655d8@gmail.com>
 <921a110f-60fa-a711-d386-39eeca52199f@gmail.com>
 <20201210180108.3eb24f2b@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <5cadcfa0-b992-f124-f006-51872c86b804@gmail.com>
 <20201211104445.30684242@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <66adc6e3-d721-4589-e9c8-168c443f767d@gmail.com>
Date: Sun, 13 Dec 2020 20:34:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201211104445.30684242@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201213_133417_494555_E2EB0F80 
X-CRM114-Status: GOOD (  32.22  )
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
 Ben Ben-Ishay <benishay@mellanox.com>, linux-nvme@lists.infradead.org,
 davem@davemloft.net, axboe@fb.com, edumazet@google.com, ogerlitz@nvidia.com,
 viro@zeniv.linux.org.uk, netdev@vger.kernel.org, kbusch@kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, benishay@nvidia.com, saeedm@nvidia.com,
 hch@lst.de, Boris Pismenny <borisp@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 11/12/2020 20:45, Jakub Kicinski wrote:
> On Thu, 10 Dec 2020 19:43:57 -0700 David Ahern wrote:
>> On 12/10/20 7:01 PM, Jakub Kicinski wrote:
>>> On Wed, 9 Dec 2020 21:26:05 -0700 David Ahern wrote:  
>>>> Yes, TCP is a byte stream, so the packets could very well show up like this:
>>>>
>>>>  +--------------+---------+-----------+---------+--------+-----+
>>>>  | data - seg 1 | PDU hdr | prev data | TCP hdr | IP hdr | eth |
>>>>  +--------------+---------+-----------+---------+--------+-----+
>>>>  +-----------------------------------+---------+--------+-----+
>>>>  |     payload - seg 2               | TCP hdr | IP hdr | eth |
>>>>  +-----------------------------------+---------+--------+-----+
>>>>  +-------- +-------------------------+---------+--------+-----+
>>>>  | PDU hdr |    payload - seg 3      | TCP hdr | IP hdr | eth |
>>>>  +---------+-------------------------+---------+--------+-----+
>>>>
>>>> If your hardware can extract the NVMe payload into a targeted SGL like
>>>> you want in this set, then it has some logic for parsing headers and
>>>> "snapping" an SGL to a new element. ie., it already knows 'prev data'
>>>> goes with the in-progress PDU, sees more data, recognizes a new PDU
>>>> header and a new payload. That means it already has to handle a
>>>> 'snap-to-PDU' style argument where the end of the payload closes out an
>>>> SGL element and the next PDU hdr starts in a new SGL element (ie., 'prev
>>>> data' closes out sgl[i], and the next PDU hdr starts sgl[i+1]). So in
>>>> this case, you want 'snap-to-PDU' but that could just as easily be 'no
>>>> snap at all', just a byte stream and filling an SGL after the protocol
>>>> headers.  
>>>
>>> This 'snap-to-PDU' requirement is something that I don't understand
>>> with the current TCP zero copy. In case of, say, a storage application  
>>
>> current TCP zero-copy does not handle this and it can't AFAIK. I believe
>> it requires hardware level support where an Rx queue is dedicated to a
>> flow / socket and some degree of header and payload splitting (header is
>> consumed by the kernel stack and payload goes to socket owner's memory).
> 
> Yet, Google claims to use the RX ZC in production, and with a CX3 Pro /
> mlx4 NICs.
> 
> Simple workaround that comes to mind is have the headers and payloads
> on separate TCP streams. That doesn't seem too slick.. but neither is
> the 4k MSS, so maybe that's what Google does?
> 
>>> which wants to send some headers (whatever RPC info, block number,
>>> etc.) and then a 4k block of data - how does the RX side get just the
>>> 4k block a into a page so it can zero copy it out to its storage device?
>>>
>>> Per-connection state in the NIC, and FW parsing headers is one way,
>>> but I wonder how this record split problem is best resolved generically.
>>> Perhaps by passing hints in the headers somehow?
>>>
>>> Sorry for the slight off-topic :)
>>>   
>> Hardware has to be parsing the incoming packets to find the usual
>> ethernet/IP/TCP headers and TCP payload offset. Then the hardware has to
>> have some kind of ULP processor to know how to parse the TCP byte stream
>> at least well enough to find the PDU header and interpret it to get pdu
>> header length and payload length.
> 
> The big difference between normal headers and L7 headers is that one is
> at ~constant offset, self-contained, and always complete (PDU header
> can be split across segments).
> 
> Edwin Peer did an implementation of TLS ULP for the NFP, it was
> complex. Not to mention it's L7 protocol ossification.
> 

Some programability on the PDU header parsing part will resolve the
ossification, and AFAICT the interfaces in the kernel do not ossify the
protocols. 

> To put it bluntly maybe it's fine for smaller shops but I'm guessing
> it's going to be a hard sell to hyperscalers and people who don't like
> to be locked in to HW.
> 
>> At that point you push the protocol headers (eth/ip/tcp) into one buffer
>> for the kernel stack protocols and put the payload into another. The
>> former would be some page owned by the OS and the latter owned by the
>> process / socket (generically, in this case it is a kernel level
>> socket). In addition, since the payload is spread across multiple
>> packets the hardware has to keep track of TCP sequence number and its
>> current place in the SGL where it is writing the payload to keep the
>> bytes contiguous and detect out-of-order.
>>
>> If the ULP processor knows about PDU headers it knows when enough
>> payload has been found to satisfy that PDU in which case it can tell the
>> cursor to move on to the next SGL element (or separate SGL). That's what
>> I meant by 'snap-to-PDU'.
>>
>> Alternatively, if it is any random application with a byte stream not
>> understood by hardware, the cursor just keeps moving along the SGL
>> elements assigned it for this particular flow.
>>
>> If you have a socket whose payload is getting offloaded to its own queue
>> (which this set is effectively doing), you can create the queue with
>> some attribute that says 'NVMe ULP', 'iscsi ULP', 'just a byte stream'
>> that controls the parsing when you stop writing to one SGL element and
>> move on to the next. Again, assuming hardware support for such attributes.
>>
>> I don't work for Nvidia, so this is all supposition based on what the
>> patches are doing.
> 
> Ack, these patches are not exciting (to me), so I'm wondering if there
> is a better way. The only reason NIC would have to understand a ULP for
> ZC is to parse out header/message lengths. There's gotta be a way to
> pass those in header options or such...
> 
> And, you know, if we figure something out - maybe we stand a chance
> against having 4 different zero copy implementations (this, TCP,
> AF_XDP, netgpu) :(
> 

As stated on another thread here. Simply splitting header and data
while also placing payload at some socket buffer address is zerocopy
but not data placement. The latter handles PDU reordering. I think
that it is unjust to place them all in the same category.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
