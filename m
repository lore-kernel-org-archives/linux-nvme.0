Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33660C636C9
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 12:11:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4B960551
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 12:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4B960551
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vlnb.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=N9NRvpID/8wx938Xan94/jj1iBBIw8h3tHlYGldCZvI=; b=Wm3SK01lq3M94Wtfdz9fUyBxjy
	wToC38UMso2Xs7AEN1WXxMdM0cvT7XedHGLfLs5+wBs/xZRs9jcXb5Sq6DT8dh+8nET5jI0TmrIAm
	c8glJT2XI/rsSFqIBI8tOpd87Ei9jJT8JzKUP9MORPKLv9DMalGOMeuHDSy6/tZbgmmHaZz8F7dY7
	qispHoUTUzv1o0dpAbmPZ6/hoUbjrovYuMKkM5ncu7x+02pUnB+CbH1WRcvR+79wYPZSKk/TSt5/S
	EZ+37XiTOolnDw65NlbNYF77HXmGQ/1RG0+l5ng/d3z1ocsg16AXYjv/yOCxRXdTn0DR6Y6Zoo6bh
	J3FjrMgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6B4I-00Fbq9-8F; Wed, 21 Jul 2021 12:11:18 +0000
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6B46-00FboY-7C
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 12:11:08 +0000
Received: from [192.168.0.113] ([178.252.67.224]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.163]) with ESMTPSA (Nemesis) id
 1MIMKq-1lu7qu2Piu-00EQ2C; Wed, 21 Jul 2021 14:10:48 +0200
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-7-hare@suse.de>
 <2946f3ff-bfa5-2487-4d91-c5286e3a7189@vlnb.net>
 <a728cc00-700a-203b-d229-a4592af7b936@suse.de>
From: Vladislav Bolkhovitin <vst@vlnb.net>
Message-ID: <2bbd7b78-df4c-a106-06ec-5b0ee409f2b6@vlnb.net>
Date: Wed, 21 Jul 2021 15:10:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a728cc00-700a-203b-d229-a4592af7b936@suse.de>
Content-Language: en-US
X-Provags-ID: V03:K1:8fX40Evi9CjcPavknM2HmotvQNm6H4z0k8Rcorz30fdwby9lg+q
 MBL3+ytramcbxWZvPWJCoj+wcPCZ6EdnfidB+3G8MFXnYeD6Myl9zQOkmN3De95yV2HQ4Xi
 Pj5Sn5ffdjwAvZGRFzZqmKmfATv0rMHHvGTY+hDO4Fg0qYOSNsy5uEsmpui9cd3pv8EWcO6
 Dnvv6SJjEovvz+ls9xFVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vOA8wUJZz58=:VEPtDi2xoanYA1CmMIxfp9
 NZjrXWZiOQEGkkLCOANcAF8FwiZQvT0uoVWpKxVW/3JskXAmQyueXLzxb1ffml0aqKN4kd/ew
 Wv4Pt4cBe+tyrURTtqJyaEUOl1CcAJI6SYhCu1FKnX1o6chAto7YBTwiLfkXkryDpuVw6eBg4
 RR4yyGVeysZ3TxsXlHp64cOJzcq4CBhNRS2huLnw7LGQi17pFyh9DJRZpWc5Boz3BfQQz5w5n
 6YB3zEz4nZUK0IcSkoT8vuh+PnbTn1TxlYm+D19mR5qPJGpi6qpR6BF0k1Xo4wCIByL51cG+p
 KSNcOu1MTOzQwaVrhWtEb2cEg1Dvs+R34D0pUJeWIEn0TE20Ym7VQn5SrZze5LZjNiX+dg8fc
 AW9zu2kny1b7pH/QRnVBfV3TgD5FHFYL1eVlolNc9F+OzSTNGhLqAOBbDrRLfpZ3HWP5Cfeu7
 E6G/W/VJhW+9LeKFFV+PmWTsKrFbn6s4m0fzrl1Y4kPOqntWcNSd+jMtQLrFOFZRjHXgvrrHB
 4PK5Bf9JsIVML82qypov3+fH+KBIHYWF+vCYHXTbCcQgNj8XAQ1A/xCYIJeJu7cK+STzv2/i2
 OMkhk0U+cfhQ0aPdKUu1F0/njtXfcbqZbw2i2wk30qXDVeIt6Zjim6SZB12yaYgIBrCkahxFY
 6IbcqFBveSNclb3jtUGWG3q0YrZqgyDF8iXQ95IRjuUzlk2XMoKOxetU7bQuXgcCrbhbxOrVw
 h22J6+kVL6Y+lBBqs0eZkwnP/29/5JrBeySirrfvoXiTm+9rb7Oa598FBsChC+8dW2T+R/uwA
 zfA53SbOIax/zavviaQMNSf+Hqkp2Luz0tjsBTEMFVxpVmMPY9uDxWthSF0C/5DrjekMT5E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210721_051106_608004_F17DC811 
X-CRM114-Status: GOOD (  12.72  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 7/21/21 9:08 AM, Hannes Reinecke wrote:
> On 7/20/21 10:27 PM, Vladislav Bolkhovitin wrote:
>>
>> On 7/16/21 2:04 PM, Hannes Reinecke wrote:
>>
>> [...]
>>
>>> +struct nvmet_dhchap_hash_map {
>>> +	int id;
>>> +	int hash_len;
>>> +	const char hmac[15];
>>> +	const char digest[15];
>>> +} hash_map[] = {
>>> +	{.id = NVME_AUTH_DHCHAP_HASH_SHA256,
>>> +	 .hash_len = 32,
>>> +	 .hmac = "hmac(sha256)", .digest = "sha256" },
>>> +	{.id = NVME_AUTH_DHCHAP_HASH_SHA384,
>>> +	 .hash_len = 48,
>>> +	 .hmac = "hmac(sha384)", .digest = "sha384" },
>>> +	{.id = NVME_AUTH_DHCHAP_HASH_SHA512,
>>> +	 .hash_len = 64,
>>> +	 .hmac = "hmac(sha512)", .digest = "sha512" },
>>> +};
>>
>> "hmac()" is always here, so why not to just auto-generate hmac(sha512)
>> from sha512?
>>
> 
> ... all part of the learning curve ...
> If that's true then of course I can auto-generate the hmac name.

As far as I understand, this naming convention is as stable as any other
interface in the kernel.

Vlad

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
