Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C13C61DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 21:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kkvMEj0iZPLsRfKBdVVw2MOQAouKiNcu6s9TC3KKpSg=; b=amWbczvL479XfEQYnLwhnXZuvU
	Cfc5Au+C7Gk9CotdMrosTO4Y5JPerF7tA6Aja1GpGQZ+XSMf5ZGigTzsNDuSe6aZ6+Hv1HTm49PUH
	FDk5PbZiF7kKYelAFXaH5YVX6wWeoRICdNm7Sp14UVDirrq9AmDQcxAvTwIY08EeXDsuyEv1+d7wH
	7ytM4cOEG/6XIMvs83aARBi8uhZvAqh+/rvgH0twiNkEOzZaRNHx5Xq6WR8OcgdjNVDsLmtB92cQt
	j9CavC9+Q32tlrO2f1X4OUCgvXyCX7sNlRNKdSRjKtCW7LyqWiWqkyYdvGtC6XiF+k2MOCkDPqY1w
	I9cqE0UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0n3v-000000087fR-1XEd;
	Sun, 30 Aug 2026 21:27:35 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0n3t-000000087eu-0fuT
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 21:27:34 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso12588895e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 14:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788125251; x=1788730051;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kkvMEj0iZPLsRfKBdVVw2MOQAouKiNcu6s9TC3KKpSg=;
        b=J7CoD5NkxEvxiR/QUJREbEz5OCFO84Y9LG9UDShhsPpnPgHTvJDq++gGExux4/VRIm
         okLkgVG06+4rNvlBudBh73PyVrkyCOHMeXSFZMYim0DdQx9ZTqbIMQ3ecKndHr6yew0C
         Pig65PRiRG9jIxBvzK9mp+d4j+TH1nigU0FApa9NBkrAdLoYhpJHpS6qvz73y6jgQUL8
         rU9bHFeAvsSKNFsZsPhtyir7OHQ0i04RY0/icxAXmbM2EaPg8xEMSzLjAw1K3yzw8O/W
         BNphbSrSJ0+BqW2Fb91O5Rrkc+I4QEUOlpxzGltPNyjkObjdQqXinPPqGtX5ZSneyMPV
         50PQ==
X-Forwarded-Encrypted: i=1; AHgh+RpCMni7RAQC9rYmvZdBzWGO89JbdwIWuwfIUmXTa75Vcq4hW/t1RzgiHk+WV0M3q+HJ4ha3lbHvjOSv@lists.infradead.org
X-Gm-Message-State: AFuF++ljidu7uvpmkqh6bKlfmuTWAQtIJ1UruaWG4xQfv3gs2hN+3eGy
	4r4xoWv8dFPfX1iBotfiLWSPufbbGvDj5RGFRJpbZsh43+UuNDbXJSCh
X-Gm-Gg: AR+sD110eUSUdXuI/U6tVlZ7LaYB/1KlOCLLDp94BAgfm0WYw9U+e+qztLhHLpak8q2
	AWJU8FUD+WO1z09vmKdTZDbOr1LMvyzCWQbPMaPUJuU5C8nk0X04oftBP1MSsAkcYW6VZ+tlRGp
	HHFG9nWS4kZ7NDmWWAc8M4jZhUpeWX8kCer3wcR6GQu8Vu+MOtm/lsxjdzHWD7m6j1hfxnPSq0c
	zORH0OGbiiKzLIWFGcAW5/XYzZVeDFNELTjXf22qkq0Swxh00/A4DZxdFiAIhqZS2/5AC3OB8Rh
	WazZeoIQuGX/hyJlnuiKMmwzhZtkBPOvTEC4G/eZalD4LWkMyOkLjLORMc5ZkHnh2x/yWdsb5d6
	8xupE5zhAo98q54mUq3TRO2yp84zbW7j2iCwgg4H6WkMrhWX9EfNwqNltzDN7JgG/57SYiU0yM3
	rSsV+jeEYZM3Y+WBSuZhukZOluvm5oCWl7zndO2xgwGPlpA0JXatJ7CqMsQfbgbSFysP4LpnI6L
	CSokAg7nnGHpb/US4+P7QBN1yzRVXpocg==
X-Received: by 2002:a05:600c:8b42:b0:496:c93d:e2f with SMTP id 5b1f17b1804b1-49b91c57d64mr348438365e9.15.1788125251177;
        Sun, 30 Aug 2026 14:27:31 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dcaf61sm218002975e9.4.2026.08.30.14.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 14:27:30 -0700 (PDT)
Message-ID: <5fb6acc2-4ac1-4f1a-861f-13c88b3b9239@grimberg.me>
Date: Mon, 31 Aug 2026 00:27:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet: verify the hostid when looking up a controller
To: Yifei Chu <Chuyf26@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <178782553270.1581249.13595405857993482779@linux.alibaba.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <178782553270.1581249.13595405857993482779@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_142733_362779_C3173C59 
X-CRM114-Status: GOOD (  11.85  )
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



On 27/08/2026 13:12, Yifei Chu wrote:
> nvmet_ctrl_find_get() matches controllers by cntlid and hostnqn only.
> The connect data also carries the connecting host's hostid, but it is
> never compared against the hostid the controller was created with, so
> the lookup can return a controller whose recorded hostid differs.
>
> Controller IDs are allocated sequentially and easy to guess, and
> nothing prevents two hosts from using the same hostnqn (misconfigured
> clones, or a reinstalled host whose controller still exists). Such a
> host currently attaches its queues to the other host's controller and
> shares its controller state with it. Also

This paragraph is pretty useless IMO. I think you can drop it.

> require the hostid from the
> connect data to match the controller's hostid so that the lookup is
> bound to the identity the controller was created with.

Keep this.

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

