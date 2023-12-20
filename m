Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32510C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 09:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6XGpw12EC6uN2GX77M2IAQtKG2YNj3BoYm4+HKGcL0U=; b=elNyXv9FZ9DRYT0EVjJh0hfbGL
	fw5S5w1zekONF4Zy1ON8Gk/tip9+RoPaU1cFs+6BHBxW5hrOtwhY/Kq/uk8wc1AwLy9thyLXfO9GO
	9QFcrTa8OMvUCFzk2L96UZ/SL1AZpB9ltZRj4HyUnw5PFpky+JKDWQ29VN9iadExO2uybjS2MmrVg
	yCUebhjSiJBwlUGZ8/rVuOu1Xs8mGWUSxzCseLbu2f9khzQqLhwXweixJGwLfKKdgo+xJ65+NMnDw
	/ZF36oe2EAlCIPmWg9qUZH3PSFxxoqfXYckT2IklU7PLcDUTLS9kWuDd02Nq0RUFuB/AUqhxMwdE0
	XOLZqjFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFse8-00GhY8-1A;
	Wed, 20 Dec 2023 09:13:44 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFse5-00GhWu-1F
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 09:13:42 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d08be5fdbso9941885e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 20 Dec 2023 01:13:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703063619; x=1703668419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XGpw12EC6uN2GX77M2IAQtKG2YNj3BoYm4+HKGcL0U=;
        b=hLjF5MRf6Hx3dJkbgMnzYDwx9wuignaBUC2ke6BIksmLqa+13flKGRlTCWfWH52E9+
         cvyD3TEsJYI5YhwTTkqr0VifYst5RB1mhgGwwZkjkoh6iCJ6GIcnp69q6CnI6q/ncMs7
         jMHoFIqbxh16g8oli1Hpd9BuTGDw/E+AukHk8rrARwnklAQUmuxA6p/BDJG29UvSc8TG
         gL/kPgM6TG4sDJonunO1F0GNldiIxvdFGXcyjvfTDFMjNWwZq04lShogJIcVBVXgR+Jq
         8IgWQ+vmf0S7wnHA+U+vs80ejtaKjMypZ/1xsiw6WbxseNPQlwbv4B/Qeocav9XZWqvE
         cYFQ==
X-Gm-Message-State: AOJu0YzFHNAa5Ut9KvcqkYO34GQI6teOhZoaYKPek627FHjP4ev1L31b
	Bm33YxsG5zop/3ADhfkfPtk=
X-Google-Smtp-Source: AGHT+IEjtBVDwjYuqSwZTuxjuQFL/SRZJJQvhOfb1l4l6KhguN8tn2RiPblUn9FTKbm+yha9QW1v1w==
X-Received: by 2002:a05:600c:214c:b0:40d:35c9:7b86 with SMTP id v12-20020a05600c214c00b0040d35c97b86mr690056wml.4.1703063618824;
        Wed, 20 Dec 2023 01:13:38 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b0040c4c9c52a3sm6576776wmb.12.2023.12.20.01.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 01:13:38 -0800 (PST)
Message-ID: <9bb20bea-02b7-4b1a-bd70-63964f6b2223@grimberg.me>
Date: Wed, 20 Dec 2023 11:13:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ioccsz and iorcsz check failing
To: Daniel Wagner <dwagner@suse.de>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <6ib6nyftuap3ubf7uryt6sndmomfif47nkforsitadbda2pdkb@ie35lozrsiqf>
 <ZXyWKKhaDUpyOXsK@kbusch-mbp.dhcp.thefacebook.com>
 <74327ed0-63f6-4e9e-9d7c-2bf0eaf264d3@grimberg.me>
 <p5sosvqw3z4bajhhobw2eng73dfk6drbjgste4hrik3te4wie4@wxytk76vjlim>
 <0efbe093-6f9e-4026-92aa-3442bde68e7b@grimberg.me>
 <d2754a5a-8162-4e66-89ba-466127eb7d3a@nvidia.com>
 <c566399b-04cb-4aea-beb8-230dbdc9ebf9@grimberg.me>
 <af03a48b-1084-4049-8cf7-a48088b3e5e2@nvidia.com>
 <a4ec22ae-c7b7-4583-a41d-52755eb5f301@nvidia.com>
 <jdd6gayqq5ysuhaaidhwngtc4ba7wecwoyxpqtw36j4bpz7bhg@jgcuumcgzjpm>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <jdd6gayqq5ysuhaaidhwngtc4ba7wecwoyxpqtw36j4bpz7bhg@jgcuumcgzjpm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_011341_423005_87F4142F 
X-CRM114-Status: GOOD (  18.36  )
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



On 12/20/23 11:02, Daniel Wagner wrote:
> On Wed, Dec 20, 2023 at 02:10:42AM +0200, Max Gurtovoy wrote:
>> I just saw that Caleb also noticed that it shouldn't be relevant for
>> discovery controllers. The mail got lost in the mailbox.
> 
> I found it also in the spam folder.
> 
>> Anyway, I believe the initiator/host code should be updated for 6.7 and must
>> ignore these fields as the spec explicitly said it is reserved.
>> For the target side, I prefer to keep it 0 for reserved fields since this is
>> the convention in all the specifications that I'm aware of.
> 
> I've tried to figure out what our testing storage servers report (NetApp
> AF-700 and a Dell Powerstore). Though I can't access our equipment right
> now due to recabling activities in the datacenter.
> 
>> I have a small bug for above code so please use:
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index ee2e4c49892d..b218ac88fcf8 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3068,14 +3068,14 @@ static int nvme_check_ctrl_fabric_info(struct
>> nvme_ctrl *ctrl, struct nvme_id_ct
>>                  return -EINVAL;
>>          }
>>
>> -       if (ctrl->ioccsz < 4) {
>> +       if (!nvme_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
>>                  dev_err(ctrl->device,
>>                          "I/O queue command capsule supported size %d < 4\n",
>>                          ctrl->ioccsz);
>>                  return -EINVAL;
>>          }
>>
>> -       if (ctrl->iorcsz < 1) {
>> +       if (!nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
>>                  dev_err(ctrl->device,
>>                          "I/O queue response capsule supported size %d <
>> 1\n",
>>                          ctrl->iorcsz);
>>
> 
> With this blktests is happy and connecting to a remote nvme-tcp target
> (Linux 6.1) works fine. So if you spin a proper patch feel free to add
> 
> Tested-by: Daniel Wagner <dwagner@suse.de>

I think that nvmet should set these values as you suggested Daniel,
at the same time we can relax nvme host to issue a warning if it sees a
discovery controller that clears these values.

