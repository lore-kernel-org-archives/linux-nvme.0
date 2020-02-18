Return-Path: <SRS0=tyJo=4G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A1CC34026
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2020 17:52:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B908E24654
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2020 17:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KfQMGBrK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TQNwyIVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B908E24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2LNxEM/m6c1+R/Qhb6we9FYdY4fZS+zWcMgUSOc8Axk=; b=KfQMGBrKfZ2u0rfM5HNJARBNN
	zRWMh77plZFLCQY2mT7o71OHQ0bYuwDabG//7i3GJg0RGYbCu9tSuzCZvgrpY5ELwFstNDT/2nODt
	Y9mfHSEVe6Uu56x5UOH/zeiYEJCemXeSTek6zVsNQwz6okCzt9X4h05URkUDJhTo6F4fxvQ5QRB2E
	mFSmg476kha73X4OkmJ5RbLsMV/mu8/1kcI/T5BHvkpAZC/g1xW4LLv5y+uLtbWRWO3znNUHqckVV
	LxrNbU7yZIYx3mmGHqEL/PvJ/rbvpf9mI0CstuT6dKFbxcgqouKQZM/i9yTKoC9LFIr8w1zmPbrkc
	2FiFfIFLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j472q-0006JL-Hd; Tue, 18 Feb 2020 17:52:28 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j472n-0006IM-GE
 for linux-nvme@lists.infradead.org; Tue, 18 Feb 2020 17:52:26 +0000
Received: by mail-wm1-x329.google.com with SMTP id p17so3916614wma.1
 for <linux-nvme@lists.infradead.org>; Tue, 18 Feb 2020 09:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=BPfhtFI4dL6bMuI+S7/9pZqCvnVzrtE24J1oai+Y2JE=;
 b=TQNwyIVaeGZAEy1lYknE5xsIAa0rBavt7l6Xmx/2bHlDBMOsXJwLPHQ964j4fuLcoz
 CPjx5zkQGtf+You9j0jK64MvycHq6vIu/zHfO94MzAx+dIz48bkC+5QGdC2Vrw7tTyxL
 SPBEpQ/1ADIBljRVGAuEJKqlyIAwoL+CBevbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=BPfhtFI4dL6bMuI+S7/9pZqCvnVzrtE24J1oai+Y2JE=;
 b=I5Z28IOmEk5OAISdhgt2wkiZF9AW4E/B6yWUDxhGK9sz14I83sGIcleHP29SkV/hSs
 6JQ9zISKMVwQiNC+dC71KDen7s8CssnmfVZkqtEaj+JTBzwwDDR7hZYqwp4zKtn8fsX1
 uh60LVFCQO7rl8jNrHCAA9F7P6PjsiPgtNTC0/limxFob3ZhcFOK7FCpBa33KX9toNVE
 hHUHqA1rEgwDMeUEL0NQbF2exNg/Fp11YJ/oz8Ld5h7zvxPJNHWtgI2VvzmjJ+vN0FZA
 0Chu5Zts0mmXtgnDgdy+5fxcxU8I/NID0wIu4AMlkiPHZZ+DxjFf7wcVifz6REaWIa1I
 TaUQ==
X-Gm-Message-State: APjAAAVqAMprZGGwYQnQBWeqk1Dpw5+vRejQ7MpCycunZuddXHGMu/mw
 kNrHkGr8LmbT2ourMmnAlGxek8kXc4gg80fkE2uJjfkC72nRFq0YlKkPApZqWuKchJLrRHfNtcy
 dmYM3pBERguHpRFaBmKG0gq9lwt5Pp0G2M2c0R88xp/DG9WI0SHLlrpZBDqyQ8hgJXueRMOZ9XE
 H8EHqPDQ==
X-Google-Smtp-Source: APXvYqxMH7yn1TaQwXwjUrc6VJrsiZ4MPGS2ygdZKaispo5YPjWBDjd2WX9yMvgr/UG2egQLmZi2uw==
X-Received: by 2002:a05:600c:2187:: with SMTP id
 e7mr4328310wme.11.1582048343034; 
 Tue, 18 Feb 2020 09:52:23 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id v22sm4202888wml.11.2020.02.18.09.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:52:22 -0800 (PST)
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
To: Keith Busch <kbusch@kernel.org>, Tim Walker <tim.t.walker@seagate.com>
References: <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
 <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <yq1blq3rxzj.fsf@oracle.com>
 <CANo=J16cDBUDWdV7tdY33UO0UT0t-g7jRfMVTxZpePvLew7Mxg@mail.gmail.com>
 <yq1r1yzqfyb.fsf@oracle.com> <2d66bb0b-29ca-6888-79ce-9e3518ee4b61@suse.de>
 <20200214144007.GD9819@redsun51.ssa.fujisawa.hgst.com>
 <d043a58d-6584-1792-4433-ac2cc39526ca@suse.de>
 <20200214170514.GA10757@redsun51.ssa.fujisawa.hgst.com>
 <CANo=J17Rve2mMLb_yJNFK5m8wt5Wi4c+b=-a5BJ5kW3RaWuQVg@mail.gmail.com>
 <20200218174114.GA17609@redsun51.ssa.fujisawa.hgst.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <57808194-dc89-a044-3778-bef607ebe6c8@broadcom.com>
Date: Tue, 18 Feb 2020 09:52:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218174114.GA17609@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200218_095225_545629_5D900031 
X-CRM114-Status: GOOD (  16.78  )
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2/18/2020 9:41 AM, Keith Busch wrote:
> On Tue, Feb 18, 2020 at 10:54:54AM -0500, Tim Walker wrote:
>> With regards to our discussion on queue depths, it's common knowledge
>> that an HDD choses commands from its internal command queue to
>> optimize performance. The HDD looks at things like the current
>> actuator position, current media rotational position, power
>> constraints, command age, etc to choose the best next command to
>> service. A large number of commands in the queue gives the HDD a
>> better selection of commands from which to choose to maximize
>> throughput/IOPS/etc but at the expense of the added latency due to
>> commands sitting in the queue.
>>
>> NVMe doesn't allow us to pull commands randomly from the SQ, so the
>> HDD should attempt to fill its internal queue from the various SQs,
>> according to the SQ servicing policy, so it can have a large number of
>> commands to choose from for its internal command processing
>> optimization.
> You don't need multiple queues for that. While the device has to fifo
> fetch commands from a host's submission queue, it may reorder their
> executuion and completion however it wants, which you can do with a
> single queue.
>   
>> It seems to me that the host would want to limit the total number of
>> outstanding commands to an NVMe HDD
> The host shouldn't have to decide on limits. NVMe lets the device report
> it's queue count and depth. It should the device's responsibility to
> report appropriate values that maximize iops within your latency limits,
> and the host will react accordingly.

+1 on Keith's comments. Also, if a ns depth limit needs to be 
introduced, it should be via the nvme committee and then reported back 
as device attributes. Many of SCSI's problems where the protocol didn't 
solve it, especially in multi-initiator environments, which made all 
kinds of requirements/mish-mashes on host stacks and target behaviors. 
none of that should be repeated.

-- james


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
