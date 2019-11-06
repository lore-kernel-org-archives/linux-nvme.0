Return-Path: <SRS0=IwtP=Y6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CC1C5DF63
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 16:51:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F802067B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 16:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TPupm8QV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F802067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gakwj4RdbDo81bvW8YR+g0P0OfZswhIDFFJrNvoaQwk=; b=TPupm8QVG0bJguEwD4h9dYndD
	RXMU6burJTqMg1O9qe0FjGQ3MLr8c/cV8Hdo+JsxQuiV6uAUnGQVFZabzHUSpB64MUIyTu3XnARhQ
	bX6cGLV7kNEPiLoMYJtVFApxRCsgoCHwHFoDtXCI5Qw1JeOuHmYJ76u150Zs+V/rWtRTptcn98NRL
	2wzZtXfGTEBOWWDxV+28TUNSPk1NgxxrnH++NCdNQlGjE2dqH72woU1eDbYLwSKpRjt8Ox3fMc72I
	sbHEw81wDXMNna67txXAupJUTxvPesHXbxoCM3L3OwyC+YAhA4rkdkdsbjuLzfD/lLoRKG59woQ5r
	p1vP7y1wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSOWS-0007aH-Dl; Wed, 06 Nov 2019 16:51:08 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSOWQ-0007Ze-3j
 for linux-nvme@lists.infradead.org; Wed, 06 Nov 2019 16:51:07 +0000
Received: by mail-wr1-f66.google.com with SMTP id p2so1496713wro.2
 for <linux-nvme@lists.infradead.org>; Wed, 06 Nov 2019 08:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H13vRsJixOHrfnP7x52vmKjuFZ8Iui1nBhwF28dxDlU=;
 b=suBgEpi3lXhRc0XmUZGRWLFpUr83QcrthILoTQiGSsEMKVGvvJz84j/R8eX2TXQ9AN
 oWUxe9o1jFOFUxZKh4nul4ZEjlD3ByWu3d+NUo+0fnzDlw5u9OHJkPOz0lLkK3L6Afh0
 2COhsbaWF/7F40+gi++bnBu6tBBQy757kE2sbYuumqvMoJTn92q22s0UA07XkqrrdGIf
 mpVd+41u9hwmtKb57z5MPJcnwyXQG/dxw0TXhTnvXNOCMTHNHWGgLfv7qiECR5+J+Pok
 ohNBrxbNlsdE4q8nmb9Z39tvflIWisAGt8ETCYMt4A4+gv29p9Rp4WSaOgQuIRjYS622
 L5Sw==
X-Gm-Message-State: APjAAAXgHbDv8hScFwkFN2AkyQ6IDj9lgkNc9K4edYiLHejpfbapLdK2
 7Ic2jTcBBvODhuwh/Uo+PBFps4woP80=
X-Google-Smtp-Source: APXvYqy6TmbF5tfqW3aPnPfWxJHvCM/WZf7pPyjuSa8mCTMg4mG96Tny4vxhfcl7gZ7kdktwlhfNpg==
X-Received: by 2002:adf:f282:: with SMTP id k2mr3690968wro.387.1573059063896; 
 Wed, 06 Nov 2019 08:51:03 -0800 (PST)
Received: from [10.30.10.132] (149.red-80-28-245.staticip.rima-tde.net.
 [80.28.245.149])
 by smtp.gmail.com with ESMTPSA id b8sm17530563wrt.39.2019.11.06.08.51.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Nov 2019 08:51:03 -0800 (PST)
Subject: Re: [PATCH] nvmet: make ctrl-id configurable
To: James Smart <james.smart@broadcom.com>,
 Mark Ruijter <MRuijter@onestopsystems.com>, Max Gurtovoy
 <maxg@mellanox.com>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20191103181343.3011-1-chaitanya.kulkarni@wdc.com>
 <409804f3-158b-cc3e-9b04-6499bfe1638d@mellanox.com>
 <3381ACB3-3ACC-4124-8925-09CED68BA11E@onestopsystems.com>
 <b79e612f-4b49-a80f-bc34-e672ae98c1af@mellanox.com>
 <B500B4ED-DF25-41F3-83F8-6E239718564A@onestopsystems.com>
 <c8472575-1041-c44e-e26a-1201161c22c6@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <802cb171-34de-65cc-75c5-83ef7c200dc4@grimberg.me>
Date: Wed, 6 Nov 2019 08:51:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c8472575-1041-c44e-e26a-1201161c22c6@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191106_085106_151640_429502F7 
X-CRM114-Status: UNSURE (   9.58  )
X-CRM114-Notice: Please train this message.
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Hi Max & Chaitanya,
>>
>> Does the NVME specification even allow duplicate controller id's?
> Not within a single subsystem.
> But across multiple subsystems there can be.

Yes, this patch is broken..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
