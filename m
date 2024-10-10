Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427C2CF11FC
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 15:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Scqs7bab56Uf9R67GJfqGE4WU4ZrJVXt3HS9FjofAE=; b=NAD1jwEQPLBFo6Rk6qEwlEnu7e
	HJVf8rLpskZ/pC+j0T6y8hULeTnXIW01ppYJ+CFC5TnpK45k526XQ0tr1P+kqruYlrIxCLflFdM1r
	ab4VZUMedIl6ZGjJuYQdOmDxMgPGTBsmSgDl84fqvPr1nL9EC7b1ImNA6lfOraZGhCWDLHwkui1ZJ
	wLJbDAjMXr0AnEPEhjmTOAGvbDEP+x80gVqED8x5NGH0Tr2VHQBrfO9K7mu6+uOuxVTcvM6CyGjCx
	7kkeChelGVrBHOo6JnEtlvdXiomNJPt4+s76jza6fQSX2O1SvXnhUBWDTWniz/vTM9mCpf4P3CALr
	3jILzFgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syv4S-0000000DKIE-0wu2;
	Thu, 10 Oct 2024 15:27:20 +0000
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syugP-0000000DFRS-1gsp
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 15:02:41 +0000
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id DFBBE1380233;
	Thu, 10 Oct 2024 11:02:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 10 Oct 2024 11:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728572547;
	 x=1728658947; bh=0Scqs7bab56Uf9R67GJfqGE4WU4ZrJVXt3HS9FjofAE=; b=
	uqGxlpAFbIFziENMEbvM9q6Wa3dBp68bHBy8vg1teCbYgKHrdoLFECvnKt8ixkzY
	PCJrLVwdFtYnKcD4uNe4o6FQsAaAcu+CnKpFC8ooPxskWSOKwR+nyFde0CHtqvln
	YiI9Yzz7u4AgiQp6DSy0O+NXoqWszmMRn/SkfdI2YIB5+yCCH45LWFRASrWWTpi4
	Cq18iZvjsbYNZ58PadVQZlqQJUVeKJc0OanfawChsngJfRlzXzkdB1BFFrVevs+v
	Y/3xw0himovJQj/pgbfQ/32JhV2fZVETLGXpFxAevwT5oJRrekM3IUXTGcr3Tsvg
	MhbEwsEo7gK1XVNZiLZGVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728572547; x=
	1728658947; bh=0Scqs7bab56Uf9R67GJfqGE4WU4ZrJVXt3HS9FjofAE=; b=p
	NFLBNyEp6VUFW6kxGw2Xl3zafDzKtc0uQWZkB1wuxYUwiXhicrgax7z5bp3pEeco
	0XWyhu6uWuLA/HRCt/4Mk+FI4Z0M4rW+Edc62NOCoAHzeC8qxaFvxpZr7cRk/FtT
	ZsPMhykH5ww/26agthGQWN0hRZOwUwoV+gHQZAaVRLqaZBvrHZ99Fi1c9YTGVze+
	40TPkgOJDyBxYByD7KBKDCBHUszn6QvilW+rJbGX6lTH+0StJQP1gPfE5/iYBn4z
	fAEPw/bZNN/FaVNcCB+wSSw/rwTg5Iv3QKqA0xg27F2sNMUwhl7GgnK/QXXv58eP
	PdxhXxRtMF18NvzfblhlA==
X-ME-Sender: <xms:g-wHZwoOnJ2Um_JAjbZYlIoJSLNBqb6HWjhpfBw29NklS-UJYZcyxQ>
    <xme:g-wHZ2oSPTUite0sUqE4MJlOznq6Xc8izI4ZbJGJbeOYdQmE5KUZzxTUbmB_s7KUJ
    4Ef1Zqrvz61Lk42vP0>
X-ME-Received: <xmr:g-wHZ1NrpGZM8gznyUZzTMlrPme6J5cuW1mNm0PcQ8CEBPJIGFT7GinnR_9WlE9Otg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeforghtihgrshcuuehjpphrlhhinhhguceomhessghjohhrlhhinhhgrd
    hmvgeqnecuggftrfgrthhtvghrnhepkeefieeutddvteeguedthedvudfggfevgeevkeeg
    geefkeeufffffeelleevgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhessghjohhrlhhinhhgrdhmvgdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepugifrghgnhgvrhesshhushgvrdguvg
    dprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehksghushgthheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepughlvghmohgrlheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptggrshhsvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhnvhhmvgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epmhgrthhirghsrdgsjhhorhhlihhnghesfigutgdrtghomh
X-ME-Proxy: <xmx:g-wHZ36w1ZtvHQRAz6wV-bNl21yCkN0-UYnDXYniZmYs263VDuxFjA>
    <xmx:g-wHZ_4d-YqDMBDlbdNfqcFKxvP8TBlPdHR5tKcoEooXd2MTTqr9Cg>
    <xmx:g-wHZ3iVEmhoM3ph89eYyxaT6jv7J5TKSICvQuIdOH-aL8biXCfJHg>
    <xmx:g-wHZ54FcU8fX_YAbtorup20GXV-G13norbXxQutvPxj7L8kU8GoMg>
    <xmx:g-wHZ8Hsz5J32hEkD7q6M0JOexE5O-tszx8hp1zpcAQ8hDa3wOW4osxc>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 11:02:26 -0400 (EDT)
Message-ID: <535aa25d-eae0-40ad-a2f9-bdd72dbcd972@bjorling.me>
Date: Thu, 10 Oct 2024 17:02:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: make independent ns identify default
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
 kbusch@kernel.org
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241008145503.987195-2-m@bjorling.me> <20241009074611.GB16181@lst.de>
 <0076eb5e-6816-490e-abaf-a0a4a25a2915@bjorling.me>
 <d98d0311-b5a8-46f3-bdc2-6265ed00fb2e@flourine.local>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <d98d0311-b5a8-46f3-bdc2-6265ed00fb2e@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_080229_995370_51650296 
X-CRM114-Status: GOOD (  14.24  )
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

On 10-10-2024 16:47, Daniel Wagner wrote:
> On Wed, Oct 09, 2024 at 03:19:59PM GMT, Matias Bjørling wrote:
>> On 09-10-2024 09:46, Christoph Hellwig wrote:
>>> On Tue, Oct 08, 2024 at 04:55:02PM +0200, Matias Bjørling wrote:
>>>> However, the independent namespace data structure
>>>> is mandatory for devices that implement features from the 2.0+
>>>> specification. Therefore, we can check this data structure first. If
>>>> unavailable, retrieve the generic attributes from the NVM command set
>>>> identify namespace data structure.
>>>
>>> I'm not a huge fan of this.  For pre-2.0 controllers this means
>>> we'll now send a command that will fail most of them time.  And for
>>> all the cheap low-end consumer device I'm actually worried that they'll
>>> get it wrong and break something.
>>>
>>
>> It's a good point. Damien, Keith, and I were debating it during ALPSS. They
>> preferred the "send command and see if it fails" approach over writing
>> specific conditions where it would apply. Note that Keith did suggest to
>> avoid the command on 1.0 and 1.1 devices, and they were known to fail with
>> unsupported CNS ids.
> 
> FWIW, there are some devices out there which will log these attempts and
> spam their error logs. There were plenty of reports against nvme-cli
> when nvme-cli issued a command which could fail.

Got it. So, given the feedback from you, Keith, and Christoph. It's safe 
to say it needs to be a conditional check.

Would anyone object if the

  if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
      (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS))

statement would include a check for endurance group support?

The idea being that it's mandatory for a device to implement an 
endurance group in case it exposes the rotational flag. That check would 
limit the failed command check to relatively new devices.



