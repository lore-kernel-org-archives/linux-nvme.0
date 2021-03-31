Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6EDC433C1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 02:16:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CED961883
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 02:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CED961883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AExGbL2x9OZvNkKW7VvXqW5/O2Z5iVSd63LaQdmI0NE=; b=omK9YtG9DO/HCAOdZeGaMOLzT
	g9slnFfFA7AraDO2ZjXk8nu20Ibq/1kMLVP+KCCoBABWZgAE+08z4PwL/BaWsdAOK6sZKFNBn3aRx
	VGz6fTQO8AFSFWytVzsPacgGUlSd6j6KV+niv5+ow+igzcziVzLQVkLVMX3xMLkBbbOVT601rAO3N
	n2c3mhwcn5q0LOcZ75vT/tuyjBlbHRCElC3Cxx8QvFpQLIQHNrSFM7l/3EJGYJTcPWUBShmArVnOC
	XoINA5EaQLz+rwItRm8V2C+pqUGRx6TcSIB/2tik/ZdajFWQYvUH+oL6zEKdiGWpToaMI61FBqqSh
	Lvshgd2bw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRQPG-005I7c-8Z; Wed, 31 Mar 2021 02:16:30 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRQPB-005I7G-BW
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 02:16:27 +0000
Received: by mail-pj1-x102d.google.com with SMTP id
 kr3-20020a17090b4903b02900c096fc01deso428952pjb.4
 for <linux-nvme@lists.infradead.org>; Tue, 30 Mar 2021 19:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=V/4UrnKo5qZI7y90/Pp/d9tpxeC1muBQsfeO5uDyT9o=;
 b=CUIhYs6WVUIrg4GoAl/fGdZ5CwRNxYRwcxjwB0KSo2SHFeWFFFgtAx7RgCoR33ErrY
 jA52dEU3j8Hi2iQ71YmGxChP7+TSQ4h4kS4RdkEvk9QgYDp966k+mNMwhmBiTBI8bDTn
 p7xav0QeDqV4YFfPZxbqH/1L2B51YZsnnK80CpE+2HqQe0wW9IgXtqqeC5X/nB2+9vf9
 ph3KKfz1+h42O/oUHVKCDL3Adlj1irG3qR75TuTLAnpSECzn1yYlVraM0/wpvBhQdizk
 rq2ihn7807S03jnVeuYON5fOEGTmCwDxsf6l/K+cS9VopZnXsxD5rjbP5FDZHKr3S1pL
 xWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=V/4UrnKo5qZI7y90/Pp/d9tpxeC1muBQsfeO5uDyT9o=;
 b=d9J99Z6fkXiBrMRyJycJcfhaEfPmI6U7fQEUg+JrmXjBvd0L1b/eS+xy/JkAx2+3ZL
 eVkm7Falh6hFja/JxV/TRaFlopZ4SaH0bwhDNUDIVbIEiD/I00v2d4wXOWALngoVq9lq
 4JBq1bImPhxMmdTk2qqQOlWpzOyCcizAdMra58JoS6WO7AToHfe33PatK7g9W7A5WENV
 RgSPyC46CUeIx2Rp5TMJ7XFuMlwC7tifSNEh6L73DZr5k1RcX6+xYl8tpXsqXch4Q/wg
 aXIU/Gn/FjcAnjRqn28qtKouR3dZjSv3uvppweWgn2Z9vAVva1JMzAyCVObtfr1s2UmM
 0l9Q==
X-Gm-Message-State: AOAM533BcJI6fEvfAan469B43S/2VQk9FLqhCFivB96Sxed40n/doZjp
 3rNauGm/SJE7C/UdTbbJWaCYo7PM4bLK/can
X-Google-Smtp-Source: ABdhPJy1kftQgJSIF9jzn/N//gJm4avAVc7HbvtWw1PvTHczQzdZDO9K0MuH0BsTP/+a6EyomkTQ6g==
X-Received: by 2002:a17:90a:9f8d:: with SMTP id
 o13mr1166669pjp.25.1617156982721; 
 Tue, 30 Mar 2021 19:16:22 -0700 (PDT)
Received: from houpudeMacBook-Pro.local ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id u84sm312216pfc.90.2021.03.30.19.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Mar 2021 19:16:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvmet: return proper error code from discovery ctrl
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210330115907.15432-1-houpu.main@gmail.com>
 <20210330115907.15432-2-houpu.main@gmail.com>
 <BYAPR04MB49659B3B3301DA5EADDD49EF867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Hou Pu <houpu.main@gmail.com>
Message-ID: <5269963f-8e78-866c-2dd6-ecd5887fbc13@gmail.com>
Date: Wed, 31 Mar 2021 10:16:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49659B3B3301DA5EADDD49EF867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_031625_702318_3C89835E 
X-CRM114-Status: GOOD (  12.23  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 2021/3/31 7:29 AM, Chaitanya Kulkarni wrote:
> On 3/30/21 04:59, Hou Pu wrote:
>> Return NVME_SC_INVALID_FIELD from discovery controller
>> like normal controller when executing identify or
>> get log page command.
>>
>> Signed-off-by: Hou Pu <houpu.main@gmail.com>
> Commit could be :-
>
> Return NVME_SC_INVALID_FIELD from discovery controller like normal
> controller when executing identify or get log page command.
>
> Can be done at the time of applying the patch.
>
> With that looks good.
>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>
Thanks,

Hou


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
