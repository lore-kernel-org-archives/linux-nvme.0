Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDA0C63793
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 14:03:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9352461244
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 14:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9352461244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=cBi4eQkeadS47jcP0ey9HvMoTuUi/XbZjt+F0LAh2Fo=; b=xvrd5SJHdWQdFd/Nmb6ZdiitfI
	2OFeHAoM4leMpYziY9EzKbjxD8wAUkUw7nBDbq01KWwyI/Zt8pQZtbIyNk22BpSJ8i+HEi1GaDvDH
	Z2sxr6BHE1CKMlsIvEkwKeK9EoFirV4A9ytrpuaRqd8GDQIhdLRz33AMX3wPixR0iJUUkyRgCVFQn
	rMSVdk/N42gcdwarPKvx3G7f4hhhZPWmKJAOkMAlk/E4HZxEkUj9E/JgrWnqscj1LAPrSyZ6SyiPE
	pPbIZBUMpL7OJCbStxW7tT/+xTiXOBbijmIyFLOgnLQB1rFbtfbmM8v9Nj7HjUIeB/MtNjRkLgwp6
	V/9JzBtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6ZI4-001pcG-JQ; Thu, 22 Jul 2021 14:03:08 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6ZI0-001pa8-Te
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 14:03:06 +0000
Received: by mail-ed1-x533.google.com with SMTP id h2so6965806edt.3
 for <linux-nvme@lists.infradead.org>; Thu, 22 Jul 2021 07:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JInVbMJ39rRbjSmp4L7SQNWHFz2ZWJnf919ts/n3e20=;
 b=TEfYm2zsec0xSajEc6hyXS2+DKfnF3FjGyPcOt2vhkHSZBEmGRRZ+cMJjbc8dPmWIP
 8gXYDEDlS0HrTw/jHDzS8f6VYY4uNfyQIRs9fZnuiG49+GfXQHG2W6rVmMveYc6UxPeB
 0GFDxBsPsk3sYQNmLDnOlMCzCcWT7krkMXko1r1rfoZSZO8jPD8/8edNkbR9nhS/h078
 4I8WW71NhKsLRqmsdrYsSh/yTbzu6pXIunABxuIC7q1+U2sfXlpuHo02vPh6sBZcv+Xn
 wSoIPGDOxa1MZ0HWcHYP7nUmsaS8hkj6sRTeWUNRIr+ygqpAUatV/Nue4LSlU484T4AQ
 7jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JInVbMJ39rRbjSmp4L7SQNWHFz2ZWJnf919ts/n3e20=;
 b=PzzIkqddJm/0lxn9oZWUlh6z7WeWYMzdjj2kJyIXXMChpr9JNtYNPb6LKlxxSR2YZ/
 Lwr5fYKd5DDV14jUkF9YUFSfk8XmfZrXDrZVMkH9zYJmri5mRhsDM1mff+hzssue468y
 cWR+UmEtmlRjoWZNvQfaDC/ndbt6gsIJPZa7omgKyiROXpxaMlKouxEp6wOJtQ/XGfjZ
 de8P/Wu/Bk6aTm48KO/ByG2Oa+JqaL+Vc9L8fgwsTXHm/dreQC9iS4DcgIKvquj5bUDn
 NJ3JNb06/VHOKQpZPy0ebUgUKjn8nrCKOMmOxgSmlCYIlqzFqc9Xe3LnxfbPih44Ceyc
 I3lw==
X-Gm-Message-State: AOAM533u+Vdn01plRgP9S4+lltsyLiy+FoZdeXh2i/AMaZUDbW4szLqU
 ewdkPwPnBBlNBc0kxxQ0ATI=
X-Google-Smtp-Source: ABdhPJzY/6unCfvzdaw4EnuqzLvgNJGgvHE9sBOh5pPBCKOjzCHjOCGuHQ+q5D/4sC1kvOLv4gJ/Fg==
X-Received: by 2002:a05:6402:615:: with SMTP id
 n21mr55763839edv.139.1626962582389; 
 Thu, 22 Jul 2021 07:03:02 -0700 (PDT)
Received: from [132.68.43.152] ([132.68.43.152])
 by smtp.gmail.com with ESMTPSA id qp12sm9547732ejb.90.2021.07.22.07.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jul 2021 07:03:01 -0700 (PDT)
Subject: Re: [PATCH v5 net-next 01/36] net: Introduce direct data placement
 tcp offload
To: Eric Dumazet <edumazet@google.com>
Cc: Boris Pismenny <borisp@nvidia.com>, David Ahern <dsahern@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Saeed Mahameed <saeedm@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, smalin@marvell.com,
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev <netdev@vger.kernel.org>, benishay@nvidia.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, Boris Pismenny <borisp@mellanox.com>,
 Ben Ben-Ishay <benishay@mellanox.com>, Or Gerlitz <ogerlitz@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-2-borisp@nvidia.com>
 <CANn89iLP4yXDK9nOq6Lxs9NrfAOZ6RuX5B5SV0Japx50KvnEyQ@mail.gmail.com>
 <7fdb948a-6411-fce5-370f-90567d2fe985@gmail.com>
 <CANn89iLUDcL-F2RvaNz5+b8oQPnL1DnanHe0vvMb8QkM26whCQ@mail.gmail.com>
 <ba72f780-840e-de73-31b3-137908c52868@gmail.com>
 <CANn89i+kHx5zzKcPQZ406fw9DWchxXrNJQhqwGe2_=hvrxSwYw@mail.gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <f3f9c769-1dc1-397d-0d06-51120bbdbc8e@gmail.com>
Date: Thu, 22 Jul 2021 17:02:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CANn89i+kHx5zzKcPQZ406fw9DWchxXrNJQhqwGe2_=hvrxSwYw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_070305_016175_F38C3435 
X-CRM114-Status: GOOD (  17.10  )
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

On 22/07/2021 16:39, Eric Dumazet wrote:
> On Thu, Jul 22, 2021 at 3:33 PM Boris Pismenny <borispismenny@gmail.com> wrote:
> 
>> Sorry. My response above was about skb_condense which I've confused with
>> tcp_collapse.
>>
>> In tcp_collapse, we could allow the copy, but the problem is CRC, which
>> like TLS's skb->decrypted marks that the data passed the digest
>> validation in the NIC. If we allow collapsing SKBs with mixed marks, we
>> will need to force software copy+crc verification. As TCP collapse is
>> indeed rare and the offload is opportunistic in nature, we can make this
>> change and submit another version, but I'm confused; why was it OK for
>> TLS, while it is not OK for DDP+CRC?
>>
> 
> Ah.... I guess I was focused on the DDP part, while all your changes
> are really about the CRC part.
> 
> Perhaps having an accessor to express the CRC status (and not be
> confused by the DDP part)
>  could help the intent of the code.
> 

An accessor function sounds like a great idea for readability, thanks Eric!

We will re-spin the series and add it to v6.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
