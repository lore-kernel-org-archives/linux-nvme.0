Return-Path: <SRS0=WUqE=4B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32FEC352A3
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 23:34:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B229C20848
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 23:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bN31HsBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B229C20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KX4L+apWQMJRss8lScz2yuvz55+euvO7c6jCXoZulPs=; b=bN31HsBO0+pw5MvhEiiXNz4jJ
	dB+Ds9xf85H4i3CUdaBQ0VS3jTRPUMngzyTVViz+23WfsN4qriwMkipiPtI0ge01tJ/u91HIR4zLs
	fJUrjY94Is13ZJKLHPNESav5WZUBz6/SfDRNr7ORWOvLr5NFc/VaM8BKRRmggVujo9b2jmJsFfjUu
	ROy66vGkCgD+OyoKZhTEnguhog5PTzv5+UHidYTnOrjLDmznhC+bqbHo5eUXGGYPuc8W+3KWJSv0J
	nq2dyMwRHi6G2HbvbcRWJMXrHG8c49E2GqOyBIcbzSiEGr0o0E0xRVbyGJObkNcNuhzOtuJIP7hy4
	bRWHNOOUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2Nzl-0003sT-PZ; Thu, 13 Feb 2020 23:34:09 +0000
Received: from mail-ot1-f41.google.com ([209.85.210.41])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2Nzi-0003sA-Sk
 for linux-nvme@lists.infradead.org; Thu, 13 Feb 2020 23:34:08 +0000
Received: by mail-ot1-f41.google.com with SMTP id h9so7364966otj.11
 for <linux-nvme@lists.infradead.org>; Thu, 13 Feb 2020 15:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VCpijuuuQSiYFEz5+E2Dr5G8MuXsLNSKC818kTrQoKM=;
 b=EHDH9dRzBkubqEdmLr6aWZewcGiJc3bfuYnvdfhjD9RVHQxBwF+D5mL1Omrh883PoS
 E5MZXFPfxIA5k+Lu8ebQ1rcIortSCayvBFPNv7ACOiDmmD98/62D2k7z02YVSuvUyDex
 +roEnCWMWfTIyRzhs72Cayt0PoEym+MaUmb4m2vmSe/YulUbw5OHG0CyuuWazNwzBoFp
 WqCZx+BWdhoX1A8XcGYtiyz9NE2SMlNg4jA8ukPaaGs4f99e5oPZkKNaathEVeUwl3DA
 pYv2av4PLUtzvfiqj+gGS7KBv/5hjAT51uYvhRJ9XoBhGDA7lzAxrfaPgmHE1Tp5htPI
 JABA==
X-Gm-Message-State: APjAAAWWP+LgfunBWxtnoaPAgvWs2+8M/bnFmnEUinev9Og3AXBSKei4
 +JEoyUjsyurkGzfJh4gktejrCke5
X-Google-Smtp-Source: APXvYqx67VL3sG+SrMRelLuJeCahbNWpm1pGUT6U06Z50Hxzztv44APkW5fz21EDhuQig6nZkVvnSw==
X-Received: by 2002:a9d:f45:: with SMTP id 63mr26366ott.0.1581636840545;
 Thu, 13 Feb 2020 15:34:00 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id b15sm1304318otl.60.2020.02.13.15.33.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Feb 2020 15:33:59 -0800 (PST)
Subject: Re: Case-sensitive host NQN
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <4973fdd4-8a6c-1218-8f82-5413d3fec37f@suse.de>
 <20200212173529.GA5648@lst.de> <055b0c4e-905a-7f3f-d5eb-595e127d423b@suse.de>
 <20200212175556.GA6014@lst.de> <918ac705-7390-900e-7e79-8df71541f266@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c3353f34-db8a-8479-97a4-660c2c16b96a@grimberg.me>
Date: Thu, 13 Feb 2020 15:33:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <918ac705-7390-900e-7e79-8df71541f266@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200213_153406_928868_B9BD9F3E 
X-CRM114-Status: GOOD (  14.51  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> On Wed, Feb 12, 2020 at 06:51:54PM +0100, Hannes Reinecke wrote:
>>> IE we would be perfectly within the spec to convert the nqn to eg lowercase
>>> when reading it from /etc/nvme/hostnqn.
>>
>> We could, but why would we?  Case sensitivity is a complete pain and
>> avoiding it wherever we can is a good thing.
>>
> Because the UUID really is a number, and hence one would assume that it
> wouldn't be affected from case sensitivty.
> 
> But if the consensus is that we do not twiddle with it we should be
> documenting it somewhere (maybe in a comment in the auto-generated
> /etc/nvme/hostnqn) so as to avoid surprises or support calls later on.

We can comment. But given that I do see people leverage non-standard
hostnqns for their own comfortable use, I don't think it would be
a good idea to take any permutations of it (that may also generate
support calls).

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
