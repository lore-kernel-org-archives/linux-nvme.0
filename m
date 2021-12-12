Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FB1C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Dec 2021 09:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fifelt/bojGZF7wUYLjk3F6h1IysQZnfRPcp1j4KSmY=; b=pwd/YkM3mGfrZZkfR66G2cIX8L
	+zRlaNuddHQxZHB4Ojayin55fDyHl9UGsTc+wyhABTl3mTEQOG9pA3sv6425xfRIYu38SFRpfd1GW
	lgmWAhnZXliBWvTi0NwKP4RSw6+8aIS3JoHlewCAEpvOmmwgAH2WTTGs4LxX7xyLJAut+jmCxvX12
	Yx5PcEDATRjMN3Yv6sKb0iquSV8msDzciZQGR/kbygQgodNorUIuc9vwPwmrtfBbza0j0ltwkoIqu
	9csavEgKD5GxYvLZkelQzbI5K2IJtevC3XZAJJ5Zm0mOxMO0alXTSbKUicKG0K3kv3jLSw8Up4GJA
	cZE5YrHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwL1P-006DqF-QO; Sun, 12 Dec 2021 09:19:55 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwL1C-006Dpj-RI
 for linux-nvme@lists.infradead.org; Sun, 12 Dec 2021 09:19:44 +0000
Received: by mail-wr1-f44.google.com with SMTP id d9so22171550wrw.4
 for <linux-nvme@lists.infradead.org>; Sun, 12 Dec 2021 01:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fifelt/bojGZF7wUYLjk3F6h1IysQZnfRPcp1j4KSmY=;
 b=wm850xrSi87NApXJZh739WHM5KmJipHs1NELymIRue4cw4FB8gktTlxrWAhWGBKMnG
 58h1FMm6a89dqLafb91SlcOnZfhR2kggBKmNWWLzwqGA3aBc35IibBWsErXqjtEIx9Sm
 SMjWDbYIu17KDrca8K0bFkG7fzwXRagGZkcb1vXS9AruMzEosCkxbIJnjbSMf6tdh3Ah
 0G1MQdMXEKC9z23suv5VfV03aQDk5gSp+rWxMIb6d+Ln4zPvqgaRSc/97ylpfm8Ac9+H
 iZuXM8ILRdUZLhRIn4Q9AOda35N+50mMNaoTf+2+m5Y2SCETcde8z+xkWH55ptHuh+1d
 rUUA==
X-Gm-Message-State: AOAM533FSdte12LuHn4lkTpR4miPJhumoMww69b5acijtoJHVptHMPjA
 otyg6SXKz0x+GK5Lvm0Bxk96erX/fpk=
X-Google-Smtp-Source: ABdhPJw32nhkfQGTkRzcsEhO0XaB0ri9LV/PwUiIIlp2q8BWYosMFyjqJmMm4tlSb3Z8Yf+AwNw1Xg==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr24963307wrt.88.1639300780384; 
 Sun, 12 Dec 2021 01:19:40 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id j40sm3550207wms.16.2021.12.12.01.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Dec 2021 01:19:39 -0800 (PST)
Subject: Re: [PATCH 2/3] nvme-core: move gencounter check into nvme_cid()
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20211210112116.9299-1-chaitanyak@nvidia.com>
 <20211210112116.9299-3-chaitanyak@nvidia.com>
 <20211210154324.GA3856533@dhcp-10-100-145-180.wdc.com>
 <d0ce0b57-211a-5e04-9528-a99a83f22600@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <879b8c22-878d-3bb5-413f-559df240935b@grimberg.me>
Date: Sun, 12 Dec 2021 11:19:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <d0ce0b57-211a-5e04-9528-a99a83f22600@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_011942_925833_07F37FE1 
X-CRM114-Status: GOOD (  15.48  )
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


>> External email: Use caution opening links or attachments
>>
>>
>> On Fri, Dec 10, 2021 at 03:21:15AM -0800, Chaitanya Kulkarni wrote:
>>> -     if (!(ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
>>> -             nvme_req(req)->genctr++;
>>>         cmd->common.command_id = nvme_cid(req);
>>>         trace_nvme_setup_cmd(req, cmd);
>>>         return ret;
>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>> index 98d7627cfdce..2be0191e1a1f 100644
>>> --- a/drivers/nvme/host/nvme.h
>>> +++ b/drivers/nvme/host/nvme.h
>>> @@ -511,6 +511,8 @@ struct nvme_ctrl_ops {
>>>
>>>    static inline u16 nvme_cid(struct request *rq)
>>>    {
>>> +     if (!(nvme_req(rq)->ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
>>> +             nvme_req(rq)->genctr++;
>>>         return nvme_cid_install_genctr(nvme_req(rq)->genctr) | rq->tag;
>>>    }
>>
>> No, this will incrememnt the counter every time someone queries the
>> command id for this request, which happens in multiple places. The
>> counter can't be modified for the lifetime of the request.
>>
> 
> Yes, the right thing to do here is to create a new stub for
> CONFIG_NVME_DEBUG_USE_GENCTR and !CONFIG_NVME_DEBUG_USE_GENCTR
> case and move the quick check in there, will send out V2.

Don't understand the global config option at all, distributions
will probably enable it anyways (as the default needs to be set
to Y anyways). However, this set was obviously not tested with nvme-tcp
because it breaks it completely. And it is also in general a bad
practice IMO to increment the genctr on every install. It needs to
be in a different helper.

Please make sure to test nvme-tcp on your v2.

