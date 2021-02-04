Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF72CC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:43:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2225664F41
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2225664F41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DciuHduH+t7yiGPTtMIGmxoSt3n8DNq2AZdy0ZV428E=; b=EtnX7Im1aock3owfofkjxKfVL
	PDX0/Sxl6/K+AZznQi18YPP++W5liQ+5sdc9JuK1sXRl16SNU8+yH4Wea/+Ph4G59j0hRsz/KxOxX
	sH7Jkm60sxAKAHCcRJBfLBP7SALWyLzHGGvEBtPv78su8BwkEIYj0QG5faDs8QhgfQiUtMfPY+ND5
	7a3OFY1yA0RgkFSeU+QgrE5CLn+0ZBFNl0j+AsLbxMLcOmP9IWNb/nnXWYZpgXBi7V2jBnm5zvBM5
	1FDYT/mIOO/3arRHhbTK1Z3gdMfoOX7K5S1bsj55MwhbbxtCwWaRluIZwnYAbgQXNsl//27fVlvTp
	EMg6EBf2g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7ZIp-0007qo-Hq; Thu, 04 Feb 2021 07:43:47 +0000
Received: from mail-pf1-f169.google.com ([209.85.210.169])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7ZIn-0007qL-KV
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 07:43:46 +0000
Received: by mail-pf1-f169.google.com with SMTP id w18so1580456pfu.9
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 23:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2CbhOpZ9klp+fAi0PjWE6cHHm/IFzuaMrcyfUxeVQ9g=;
 b=nAZL6K/z3CcVVNLv1rNURa2z9z5rdvHBTQiSbrwUBCVEfK9/OeQFTJ5tzXYdovwnna
 NcVRZbtHmNtG/BjVAp23CWhstplh+ACBI0jQGbaIxzwsiKv2F1GVnrrafWLpRFyPbmeE
 a76VYOh7KpugFSun9XdseLsOzRO+la1ahM+Co1+wYe/LP9sahO/SaiDAjj12pcjysosA
 fkmh2z/KFekff6xijzHtjAg1klDruEMkIcPre3edsqZMlRwHp/LGhxN+np+KZxD116eP
 inb0Cq0/hVFLI2s9nQhLU+1GI8cXSSptW/hUjeR5rm1uqZ58ZBuWcmLj/55r8XOxtMXj
 dayw==
X-Gm-Message-State: AOAM532+e/joA4R9C05G/FifmQtU77EazZcHFWbkOXJhio+b6X/nzSEG
 TjAHexurLgeTXcL+2sixnJvm31CK9fs=
X-Google-Smtp-Source: ABdhPJwZn6ccBXQlYNIUCaKOFgF4E2pL+O1L5w6is2WfjsRInKcQkeshEcRsqUanwLgPxzB9GW4HPw==
X-Received: by 2002:a63:724a:: with SMTP id c10mr7805366pgn.124.1612424623848; 
 Wed, 03 Feb 2021 23:43:43 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:9e2b:41e5:65d1:d6f2?
 ([2601:647:4802:9070:9e2b:41e5:65d1:d6f2])
 by smtp.gmail.com with ESMTPSA id 68sm4975000pfg.90.2021.02.03.23.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 23:43:43 -0800 (PST)
Subject: Re: nvme-tcp bricks my computer
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB45443358535A404035588EC5F2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <42f94a06-cc66-87dd-3a92-de793a228d22@grimberg.me>
 <SJ0PR19MB4544B86790800C6371E7F96AF2B49@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ccb20293-efdf-ee96-d97f-405ced9b67a5@grimberg.me>
 <69e0073c-35cd-552d-eccd-2092ab49c38d@grimberg.me>
 <SJ0PR19MB4544A3DF2B1B2A1EEB8D1B41F2B39@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <43ca75a5-e751-6b9b-2a0d-336dbbc207a1@grimberg.me>
Date: Wed, 3 Feb 2021 23:43:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB4544A3DF2B1B2A1EEB8D1B41F2B39@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_024345_746916_5C3C6A7E 
X-CRM114-Status: GOOD (  19.28  )
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi Sagi,
> =

> I was able to capture a bit more info. Again, because my computer =

> freezes (i.e. no keyboard or mouse response) I could only take a picture =

> of the screen (attached). This does say NULL pointer dereference.
> =

> To answer your questions:
> =

> Q)=A0Does this happen if you directly connect to a normal nvme controller?
> A) I still need to try this. All I know is that it doesn't happen when =

> the controller returns=A0OAES[31]=3D0.
> =

> Q)=A0What is your target implementation? Is this the nvme target thatis =

> built into Linux?
> A) I work for Dell, and I'm on the same team as Douglas Farley and Erik =

> Smith, whom I believe you've had discussions with. Dell is currently =

> developing a Central Discovery Controller (CDC). That's the target I've =

> been testing with. I need to find different targets I can test with but =

> working from home makes it a bit difficult. I will check with my team =

> tomorrow to see if I can connect to a different target.
> =

> Q)=A0Can you share your kernel config file?
> Q) Can you run gdb on vmlinux and share what this provides?
> A) I'll get that tomorrow (both questions).

For the record, I compiled Fedora 33 kernel and ran it on my VM
and it doesn't happen. I also modified Linux nvme target to
report the same limits as your target and still it doesn't happen.
--
[  162.006049] nvme nvme0: Failed to read smart log (error 24577)
[  162.006060] nvme nvme0: queue_size 128 > ctrl sqsize 32, clamping down
[  162.006063] nvme nvme0: sqsize 32 > ctrl maxcmd 31, clamping down
[  162.006778] nvme nvme0: new ctrl: NQN =

"nqn.2014-08.org.nvmexpress.discovery", addr 192.168.123.1:8009
[  162.008939] nvme nvme0: Removing ctrl: NQN =

"nqn.2014-08.org.nvmexpress.discovery"
--

So something here seems to be specific to your env.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
