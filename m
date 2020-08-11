Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6351EC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 20:48:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C81520756
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 20:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A6foRLSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C81520756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8cBwo0k5aZYpd12Xc6CeDyugWqsgeVJuFBNrUw3OlZY=; b=A6foRLSqTc6ZB5rTJ1YRB60nV
	gDk9RBU58NxRiMVgx0AbOKGcpKQ+v7SOsxW+Ujxtc17P85dAI2E7T28+zCJzjGwzMMIXh9fRSZsjj
	2WVcrBP3o/FDSDC+3tZ7NofXxDBXrGf0qk25BxhYDdQcBullEg4UhryDClaytLnbfmhSAFzdQNTM/
	DS3lwt+tfQttrpwZkmADnwZ6C6zsKH626rO0McA/Ih3Xu/pfgfPmoAi0KYTUGABy3pMNKXstUClAa
	EmLhLbWWaRCJ7qJcJZ1ODCtbxFX8+M2cvRBLhjcTmOLcH/uHA+h0HzFOj5HNkFewrR2Bg5lPzxw92
	feUz6aJOQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5bC7-0003Hw-Jy; Tue, 11 Aug 2020 20:48:27 +0000
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5bC5-0003Bg-GX
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 20:48:26 +0000
Received: by mail-pj1-f43.google.com with SMTP id mt12so32042pjb.4
 for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2020 13:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J1r2hnrCNR21Y9IJ3ZhzBgpcgbEmU/7wYDZdWEGtRFI=;
 b=K6YoQHfE5NYiSB0i1QNLLKYZi/lbvBaomsI/vp8F/Ak0H5iFeIV1uRk4nGqIkDc9cs
 R8LaRCCJ9qtjkwWrTahsQD4uZnR9Pfg4Bp9NXmOrY9dGHhrzczVWXQHOCIxyOoDFJtPx
 TTS6pZOaI4G0kMjH+OC4+E3YDLG73B9pQxdRsCw0aXHmK1ZOWL3dhp6f44MA4azmAPTe
 JMuL0oyL9BKTAld+/fAkOmmbL3zLCqj3Z1qIO/AHELMsJ5R2viEN8JvqI2k27y8I6NDF
 BwDAwnfLoU1C2FGxBYp+GeGY1IpQq4HOuYT0N7nISzg+/F1xwa6n5ZqW82JCanx8qAqx
 ekSA==
X-Gm-Message-State: AOAM533/Uu//zsoFD3mgax+5HFwQuSqVXi6nA+gopQqyF5dy9gFK/g7p
 g3wgB0fTFEFplR3Q1dLQgXrq/qxsKzE=
X-Google-Smtp-Source: ABdhPJxTy346qm6xkF7DZtyj42dn9zdkZL2FZznBf+c77HlvQ1G6j8vgyS81Kypw/mVh5lCw7YZBFw==
X-Received: by 2002:a17:902:b941:: with SMTP id
 h1mr2551117pls.200.1597178902441; 
 Tue, 11 Aug 2020 13:48:22 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b58b:5460:6ed2:8ff9?
 ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
 by smtp.gmail.com with ESMTPSA id b8sm26909078pfr.57.2020.08.11.13.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 13:48:21 -0700 (PDT)
Subject: Re: nvme reservation commands during controller reset
To: Keith Busch <kbusch@kernel.org>, "Engel, Amit" <Amit.Engel@dell.com>
References: <MN2PR19MB30052441F4F22A4CAC8D396FEE4B0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200809161016.GA63121@C02WT3WMHTD6> <20200810124036.GA25070@infradead.org>
 <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200810154846.GB4159317@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <462babf2-7cde-af4a-8bf9-a5b230e282b7@grimberg.me>
Date: Tue, 11 Aug 2020 13:48:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810154846.GB4159317@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200811_164825_571700_80A18760 
X-CRM114-Status: GOOD (  14.28  )
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
Cc: Christoph Hellwig <hch@infradead.org>, "Anner, Ran" <Ran.Anner@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> We saw that in case of path error, nvme reservation cmds does not get error handling.
>> This is true via the blk layer as well as nvme-cli.
>>
>> We are working on implementing nvmeof stack and
>> this current behavior is blocking our host from running nvme reservation cmds during path error.
> 
> What's blocking you from retrying this command in your host software?
> 
> If we truly want to provide a way to hide intermittent errors on
> passthrough commands via automatic retry, it may be a little longer
> before such an interface hits a released kernel.

I think we need to keep the passthru commands as they are, but
reservations coming from the pr_ops maybe we can failover these
in nvme_pr_command?

What is the semantics in scsi btw? Didn't see any failover functionality
for pr_ops...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
