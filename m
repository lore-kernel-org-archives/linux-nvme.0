Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57495CEDD98
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 14:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PVGBHbIhqNvxDQEChY11ROMGXvZ7A+537QO2TTJjVlc=; b=cL4vKa7KXJVhUyXHVAvuOfaSK7
	qG0ZP/J3aLtbDn82y9xfrpH/A5Csg6H9Zzz3eD5XDP95cjUsCg8EX7LrAVo8cwbIvRI6LASE+woaJ
	bCTK9poxkkbhABdx0Ga1iDb9OremRlYijpvfUnnnHIa2lC5utRawG3HYSEtfBHs9tusswtEZP+tth
	yr9+A4LcLzfgoA3wDB2eKoBYryX7+f06UqDt+dXfeCuV78crxeVHO0zAPQDCuRzVzg2/jh5wNL/vZ
	oaaPcyJBOIUBo+adB6RBav7cN0T9oVPQKcClgI+T6CTjJ8SlkFH1JMv2Vgvj5K0vOWO+amQKBe6Ou
	WELzMb0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syXEM-00000009V2B-41Br;
	Wed, 09 Oct 2024 13:59:58 +0000
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syXEJ-00000009V1e-3mqE
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 13:59:57 +0000
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B69EF11401D6;
	Wed,  9 Oct 2024 09:59:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 09 Oct 2024 09:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728482394;
	 x=1728568794; bh=PVGBHbIhqNvxDQEChY11ROMGXvZ7A+537QO2TTJjVlc=; b=
	D+F3g5qS3Ip3v5bIfGjdQKGnWIk3uCXdvq/cUtE7ibQeb6Y5QeaVKxjXSqflAfq8
	+n5yN8VWIBvU8qLb8MW1eNAwAuIVLU25uWltJbRV78yTGWvg2YQIK3DWfJ37/HWt
	siEAB8DoH2xGmvulLkS0dYjTav430XJMRtW/pJ5v/7yTLbtDGK3R2CLNznVA5Xwg
	oVzOf2LahJ9e05SibYDBYejVMHtJDFstGXzwGOc6LC4exdEm7CE2d+/MoiAtw1dL
	htXtrjx0t29tWh6O4DYjh7XL3iq9xbXXmFMK5HCydot1QXO5AOTDHbZBxtvATBQ0
	MLNz2ZX1lKELMNwf3VOZkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728482394; x=
	1728568794; bh=PVGBHbIhqNvxDQEChY11ROMGXvZ7A+537QO2TTJjVlc=; b=i
	65qpZyvEfMc6/4H+g7ugNEbF1uNLxJJv5G0VUcJEfG7C0FpEs3latw2c4uLzeca3
	qBP5RukCXI0FGq3ShQRdsb+fyl90VGAm5+PSS0/OccdEBo/aUYRRV7H3zRIHfsQo
	IsX+eYoZ43d/4PUHxDXIUwXmd549gZj50r5ZTz/78CcTBbuhChAVQYUcFQdwFzKA
	6DxTF/8ciyuQeppmvYbEKMaSpn7vJHaZjilH1iVgQp5lcCpXz85dcldD5kSDJuvp
	buBZgGR+wTx5NbziTVeOWVGtAIfNGgjMK4SJmU+xY35W8DHV8Alz4HfXXWrn0eA+
	16FGxuwht1lBtGXGdam2Q==
X-ME-Sender: <xms:WYwGZxWfVOt1zygoNeIYHlKeyl7x8iPNzg1N_g_burd2WtzDnlGGqQ>
    <xme:WYwGZxm2Rl9lXJlZb9w9h2_6jdHlKQrrc-lIVdqDHLu8tG-xlMXhYw_hW5rIaHbwn
    EQoVYFWkhS6I43Yj_A>
X-ME-Received: <xmr:WYwGZ9ZWIp0uYzjpap-lJV4_6ypC_7bEmmXlvrCji4arEC63Jl5tseGVgoE3CEW1Jza7rnYMG48RYke-ByEgw1THQ2as0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeforghtihgrshcuuehjpphrlhhinhhguceomhessghjohhrlhhinhhgrd
    hmvgeqnecuggftrfgrthhtvghrnhepkeefieeutddvteeguedthedvudfggfevgeevkeeg
    geefkeeufffffeelleevgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhessghjohhrlhhinhhgrdhmvgdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggvpdhrtg
    hpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehl
    shhtrdguvgdprhgtphhtthhopegulhgvmhhorghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegtrghsshgvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    nhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinh
    hugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrg
    htihgrshdrsghjohhrlhhinhhgseifuggtrdgtohhm
X-ME-Proxy: <xmx:WYwGZ0Wpzqf8BPUI7r4BIzE3-RsOhTgV71w19yC5JEv3OUzUAAeNsA>
    <xmx:WYwGZ7nU8Tx-clkD6ulhiLb8jp5kBUhZIp1a8WVPZ2jOzpIM-GM0UQ>
    <xmx:WYwGZxdliEEsrQ6druNxnMD5s7jaOI65Okn2_emRkdSA9pt3EHOfNQ>
    <xmx:WYwGZ1FGtwdkPcQT0o_-8ghy7O1owMTdDp5CxdjUbEw2eOrRnmxsFA>
    <xmx:WowGZ0ilJOmLheR48W4lgZwGSTQigPfx2IeWgkuqcGmO3lqwqkTQqfxv>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 09:59:52 -0400 (EDT)
Message-ID: <3a680224-8f45-4612-bc11-40515c30e7e8@bjorling.me>
Date: Wed, 9 Oct 2024 15:59:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: make independent ns identify default
To: Hannes Reinecke <hare@suse.de>, kbusch@kernel.org, hch@lst.de,
 dlemoal@kernel.org, cassel@kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241008145503.987195-2-m@bjorling.me>
 <a33f4ebe-de7d-479b-97d6-3d98e34ab94f@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <a33f4ebe-de7d-479b-97d6-3d98e34ab94f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_065956_448453_1BF67617 
X-CRM114-Status: GOOD (  23.38  )
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

On 09-10-2024 08:16, Hannes Reinecke wrote:
> On 10/8/24 16:55, Matias Bjørling wrote:
>> From: Matias Bjørling <matias.bjorling@wdc.com>
>>
>> The NVMe 2.0 specification adds an independent identify namespace
>> data structure that contains generic attributes that apply to all
>> namespace types. Some attributes carry over from the NVM command set
>> identify namespace data structure, and others are new.
>>
>> Currently, the data structure only considered when CRIMS is enabled or
>> when the namespace type is key-value.
>>
>> However, the independent namespace data structure
>> is mandatory for devices that implement features from the 2.0+
>> specification. Therefore, we can check this data structure first. If
>> unavailable, retrieve the generic attributes from the NVM command set
>> identify namespace data structure.
>>
>> Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
>> ---
>>   drivers/nvme/host/core.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 0dc8bcc664f2..9cbef6342c39 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3999,7 +3999,7 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, 
>> unsigned nsid)
>>   {
>>       struct nvme_ns_info info = { .nsid = nsid };
>>       struct nvme_ns *ns;
>> -    int ret;
>> +    int ret = 1;
>>       if (nvme_identify_ns_descs(ctrl, &info))
>>           return;
>> @@ -4015,10 +4015,9 @@ static void nvme_scan_ns(struct nvme_ctrl 
>> *ctrl, unsigned nsid)
>>        * data structure to find all the generic information that is 
>> needed to
>>        * set up a namespace.  If not fall back to the legacy version.
>>        */
>> -    if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
>> -        (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS))
>> +    if (!nvme_ctrl_limited_cns(ctrl))
>>           ret = nvme_ns_info_from_id_cs_indep(ctrl, &info);
>> -    else
>> +    if (ret > 0)
>>           ret = nvme_ns_info_from_identify(ctrl, &info);
>>       if (info.is_removed)
> 
> That is a very odd coding. 'info' will only be filled out for a non-zero
> return value of nvme_ns_info_from_cs_indep().

I may have misunderstood. Only if nvme_ns_info_from_cs_indep() return 0 
will the information be filled. Otherwise, if it is an NVMe error, 
nvme_ns_info_from_identify() is tried, otherwise it's a hard error, and 
it errors out completely.

> So why not check for that?
> But if we get an NVME status back there is a fair chance that something 
> else than 'invalid field' (or whatever indicated that the command is not 
> supported). That then would cause the device to be misdetected without 
> the admin knowning.
> Shouldn't we add a message if we fall back to nvme_ns_info_from_identify()?

Hmm, we could. Buuuut, at this point, there's more devices falling back 
to nvme_ns_info_from_identify(), than devices that implements the 
independent ns identify data structure. So I wouldn't mind it being 
silent. If we want to debug a potential misdetection, tracing could be 
enabled to track down what's happening.

> 
> Cheers,
> 
> Hannes


