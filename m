Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40965CEDD90
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 13:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UuTpuAalgyZbbPSGz9ViqBPTflz/LEC7APiSvX6DIwQ=; b=IJrqACt0CBo4A/kh5YDfn4VX1H
	o4KkfH5OYjbiLCwDNmexL6oKO2ZScAWgyh7TbfZ4DeAjt41TdwvnrnfTf2qDppnc4ic6dPcvMkcU6
	aKxrMN9gn9tPDdi9K9iHF2rXPfZDhKazhHrFMWqTVPAAGEJk5v5yzrRVGHXbyYnF21+3Z6u3QZUJe
	GWcxR8Io+9whrU90t9pdPW6aktQy5gDgAfgZbTvLdworaryi+m1vZDoD2Gl+r32CscsYwiz13GBEW
	am2tG4RPvtBRZuoemTngtWJ2EkowC7K0eNacGwpNlmoHUolVPlYu9mtkdJQxgZFAsttEEkFQqd2N8
	fFLNKXzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syWRQ-00000009Lng-2c6m;
	Wed, 09 Oct 2024 13:09:24 +0000
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syWRN-00000009Lmf-3xEC
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 13:09:23 +0000
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 019A41380295;
	Wed,  9 Oct 2024 09:09:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 09 Oct 2024 09:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728479360;
	 x=1728565760; bh=UuTpuAalgyZbbPSGz9ViqBPTflz/LEC7APiSvX6DIwQ=; b=
	XCEDelr/hIbLQqrk7YFryLONcjWpb3oo5lMTrfNCJPl48DTQcffaO1sXseAoNzOQ
	vy5KjEMFtJPGQutNgmOSMCCcN3Sd7FogyO71QRwMLvn8Vr7A5LNvIKuFB2FcmY0/
	nlHqtJQjDXaBAxjJNec3Fq2fDRPAuXZMQRa4ykveBUrjb+Plq7ZoNMOzgmakQQ8n
	TbuhiLCGd2bdP2SIwizq271i0Pg/LI91wQ0yb/baiv/A29kI942+p1ZJGme9PFZt
	1A3v0QtNpC3vpWMn3fxjiAOOqBbjCkQg+nNImnAYDS3tllsk9b/PED2OZYKe4ab6
	U8546MpIJhyRux4fmEPp+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728479360; x=
	1728565760; bh=UuTpuAalgyZbbPSGz9ViqBPTflz/LEC7APiSvX6DIwQ=; b=D
	H0ipkdnUggfKlPyC//c0imkcy3UzneEXbkXsiLrx8cW4oL2xI8kx+tGXR+7s1TAX
	YK22/7tUgIr8xXCNeEZZ8iGNnbqTnQY/Mc5gO/Pru7kqNf+jqWVRWWnUhrToFFd2
	euDTUOJjHWTdeL+Dn8C9crRM/CjUUjWW2qP9FF+QmZSG64n+/3gqxDGZ/xEaJ0FL
	IgUT5jqYpAR2KQwkuHsDYMxQjRGcdKlMUPgMf/tDtv+3W2ZU9Q0cS1lJFZN3g3iG
	amKBERm+mj8BuEMtr+U9cUfT58fL1zG6Nun/+TCwpRTM/XlCiy5knGS/jYvpdPip
	PjQVbz7SLyjGuXfwmcgVA==
X-ME-Sender: <xms:gIAGZ2j15Y-T5wOyjuQ0PKkRJFHFPCHsd3j_aletOQyLmlUAznSn4A>
    <xme:gIAGZ3AJO5MKvv2HY-kedq54US1efCgLab4-sTsZm3zjp3IONJaXudRfGq9nHPq4n
    mUWdSj9ZfzPgpF95Zk>
X-ME-Received: <xmr:gIAGZ-H8PYUitnOb9dqZhgWirOeyV8DADJk-c-0EL_qvMKKTUQ412Up5k0DnCvuUraHoCNNnx2yuEcFkfg5gU-Z2BNPr2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeforghtihgrshcuuehjpphrlhhinhhguceomhessghjohhrlhhinhhgrd
    hmvgeqnecuggftrfgrthhtvghrnhepkeefieeutddvteeguedthedvudfggfevgeevkeeg
    geefkeeufffffeelleevgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhessghjohhrlhhinhhgrdhmvgdpnhgspghrtghpthhtohepkedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpth
    htohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegulhgvmhhorghl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghsshgvlheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmrghtihgrshdrsghjohhrlhhinhhgseifuggtrdgtoh
    hm
X-ME-Proxy: <xmx:gIAGZ_Q95u54YL5zUMZG9dntRV0LfAjlltz-YuG3SiR2AZ_xaI1P6w>
    <xmx:gIAGZzxd5YSQhD33PU0lGulNs7ppYVTzUl5NIUqZYHFWgOnU4wb5Yw>
    <xmx:gIAGZ942oyMa4Bo9mm0B5ZnmwRZsrx_YAISs_0GkYkdZhOSGOZbeDQ>
    <xmx:gIAGZwxiD1v61cCD-mDVxDxu2GMfiq3QMlw000-56wzAWtm22LMtkw>
    <xmx:gIAGZ6nfWX7rWCXINgTrD8yef7XRt9CnEMLQuAFxrpldHCe_zl4DyASP>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 09:09:19 -0400 (EDT)
Message-ID: <3191de59-16bb-4c54-87c3-110a0285ac13@bjorling.me>
Date: Wed, 9 Oct 2024 15:09:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: add rotational support
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, dlemoal@kernel.org, cassel@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Matias_Bj=C3=B8rling?=
 <matias.bjorling@wdc.com>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241008145503.987195-3-m@bjorling.me> <20241009074805.GC16181@lst.de>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <20241009074805.GC16181@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_060922_074093_7ED4137C 
X-CRM114-Status: GOOD (  10.54  )
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

On 09-10-2024 09:48, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 04:55:03PM +0200, Matias Bjørling wrote:
>> +	if (info->is_rotational)
>> +		lim.features |= BLK_FEAT_ROTATIONAL | BLK_FEAT_ADD_RANDOM;
> 
> Entropy from block devices is pretty useless.  The only reason we still
> keep it for SCSI is because of retro-computing platforms without a proper
> platform hardware RNG.  NVMe HDDs reall should not show up in those kinds
> of environments.  Also without a add_disk_randomness in the nvme I/O
> completion handler this won't actually do anything.
> 

Thanks for the details. I'll remove it in the next revision.

