Return-Path: <SRS0=oc1E=F3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62B5C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 08:41:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47649222BB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 08:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47649222BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TEJXJDp9c2J+OcG/rUtwQa1GPk/hOoA+qxSoM5itTYA=; b=rEuEqexcaChR6Zagtn/2oqIDp
	5WzF+jlwTgJX61Pg94Us/cYCXg5fdBU2bumj2wu/ZGek++1O0kprIGx7eNl/RllePE0Tc6RgEVz3y
	p/THkBwM2jhLrUjBOX6LpnEjaEZy4IPjkusilVhyaZXzkdyNRfGZjB4EO5k251s+sWwlTLKxOgcaB
	WsuS2QaMOXlnDvlNg9NWojRVNZk+5yNbzxbTrrwf4DbyqGtVn9pI5okhQnkZaNt/0LypHkl47mii0
	38B3lFjkljgXuEEbeVOGoadfFT06nP9smfXVSxXV8L5WSr8wFdyPWHHUBO33/VYpD4KkcBsUiYrXQ
	bavJamHow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1krziC-00072l-8t; Wed, 23 Dec 2020 08:41:36 +0000
Received: from mail-pf1-f169.google.com ([209.85.210.169])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krzi9-00072F-Qf
 for Linux-nvme@lists.infradead.org; Wed, 23 Dec 2020 08:41:34 +0000
Received: by mail-pf1-f169.google.com with SMTP id c79so9987004pfc.2
 for <Linux-nvme@lists.infradead.org>; Wed, 23 Dec 2020 00:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+kvU70Q+bL/jVLvVahoRP9ss1P9cc7wEbcGmJpYWLVs=;
 b=l80BzJGk+GbhIi+cxdVyKvCBjZHRkCHZUhA7bzGbUnAAbF5PNr0TVGbulLF2Y1kHlv
 70KNOeDfg0h0eTAOI48sV05TAhsWanRBr8dGHuZhVciDIV8LHFjGjiuIXSIj4zDqbndX
 Wq0AwU1zF0TJ/TlvqkEIWRa0wSINWaIalUrTh95acSMxxtMHw7wl/TtxNWms2sociRqx
 Rc3D5KrFqZaOrqamBrbeOliUAt6yuNy5T4QoPqozljM17F6cBgT66vjjr7v1rR60qmv+
 RMGSCPuKueYZMrvmPNSnmICrCONF96mT6vJ+3EaSBTjrcTBVUJ7Rv3kKpRIDCauyGp67
 ztQA==
X-Gm-Message-State: AOAM533jDW0r3kMWBIPovEdbKDQv62LBsZMN0jDeJjAlZA0QRq9EGEIJ
 Te/Z71mVgN7AT6D2QsEYhCmSKlVwqb0=
X-Google-Smtp-Source: ABdhPJz0U85HnYck7cErREgbtdmr3za1IcYKf+0s+cgXpX4G5WweNQ9+4nS6EPBPYvhZNQeyKGFWBA==
X-Received: by 2002:a62:384b:0:b029:19d:a5c6:d76 with SMTP id
 f72-20020a62384b0000b029019da5c60d76mr22875614pfa.16.1608712892206; 
 Wed, 23 Dec 2020 00:41:32 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:8c81:7d09:c1ab:94c8?
 ([2601:647:4802:9070:8c81:7d09:c1ab:94c8])
 by smtp.gmail.com with ESMTPSA id f90sm21773313pjd.32.2020.12.23.00.41.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Dec 2020 00:41:31 -0800 (PST)
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Hao Wang <pkuwangh@gmail.com>
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
 <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fd4541e4-78c5-ec3b-b272-467fd11f7472@grimberg.me>
Date: Wed, 23 Dec 2020 00:41:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201223_034133_928844_0152C754 
X-CRM114-Status: GOOD (  15.39  )
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
Cc: Linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Also really strange to me. This has been burning me 16+ hours a day
> for 2 days doing
> 
> And for your question, yes I did.
> Locally on the target side, no data corruption happening, with the
> same process of creating a partition on each device, creating a
> 2-device raid-0 volume, and creating a filesystem.
> I have also tested on multiple sets of machines, but no luck.
> 
> Another point I should've mentioned is that corruption does not always
> happen. Sometimes if I only copy one .gz file (~100MB), it seems fine.
> But whenever I copy a large directory with many .gz files (~100GB in
> total), there are always some .gz files corrupted.

OK, interesting.

Can you retry the test with setting max_sectors_kb to 512:
echo 512 > /sys/block/nvmeXnY/queue/max_sectors_kb

I'm trying to understand if there is an issue related
to large IOs.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
