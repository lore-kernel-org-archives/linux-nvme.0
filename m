Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF385C88E4D
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 21:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hTj+cMDcQ01Oufu4utlEzkUYJwmYL7SPG/H+InwEwP0=; b=bcPwUywR5FGFDzTXSsI5r7Tt30
	8iVXcXPR02iA2zV8xksmPmoH+IV+5/7kc/D/TUqzsqt8/jGMIYoai9kQDqW/zJ7OPR9AQ1vKul4zT
	d1aJrW6w08T42K1j3MW58/bIdKHg33jg7KzY/0/zWtgU3fd/hY/M4qacrS8pFYHtCSKULD4QtGxgA
	MsUbSQgX1+B2aXI8BudmrUNvjUFS2Zm93moCsNmDvoC1El+a0flspstDfdvVq0rJJ/N+RIi/x+Xlr
	9g9CEu+xAIDHzVkHNI+dyNrPNXsXTp5lxwa8+MfXGJuL7YLLKm/twXi31YNGtQbKflA0NSQ6EKye8
	dhGBFH/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5904-00000000C1p-1wyJ;
	Fri, 11 Sep 2026 21:41:36 +0000
Received: from mail-wm2-f12.google.com ([74.125.225.140])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5901-00000000C0c-0S7l
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 21:41:34 +0000
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so183355e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 14:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789162891; x=1789767691;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hTj+cMDcQ01Oufu4utlEzkUYJwmYL7SPG/H+InwEwP0=;
        b=hUNht9KCbtnWkqMUpF8L6Feixp3tqVT4wYr8yeZsMj9oshHgUIiLsiuQb8LoxOP0N9
         JntyyABGlV6k+TLH0XTVgjicaVYzuhAvYokyuXGNT6D/3V89nh0LxViRXu+cXPbAyeme
         jCx98EZVv7gg4UYafGI/dg4rRd8gbTF0G8Dr8BSUN0r8JDAVlsxMiB0qq/U0HqJggs8L
         LS/ene5fB8g5xxAP6qauKrQ/MUtKLEbKW4GimGDiJ1ufRhngIuSRY8ZkSGG1OZOpnWa9
         gtDUxoy6oxZOQR/TQqyObSPof7Vr6gcK/KBrsBt4hrhZLOINp9vPh1Ixy6jV3024+s5Z
         4F3g==
X-Gm-Message-State: AFuF++m4dQEk0rEnWtdpktyn4IGhZcjS/SAlxhZ8jqsCqRXnyaMnwmxG
	+fHoVlMhdDnQmoMBhpuLKoSvyIIQnmASRjqxi0Q7DmKDjiNq+DJ6LFKg
X-Gm-Gg: AYBFou04G+5qLQ66P9dx5qIhn55yS2SGQJGSuI+QNZejkxwxK6rc/ImoCSTGYOkD1c1
	PLGZ0toNcS4yq7bwJIxdFr9wftYbpJ1iDxa7AEFhS9kjvUjOU8cVG8dQURgGuHjARhTiEevdN6E
	Zlttser4FlW4aawyqW69hBrSA80ltn1p+7S+1qf3Zc/xxaChBvRtjW+G0qjcj+XM2JwVGIvaF7w
	u+8SwrOCLdhE8BWcHpAKoNl1m0o6dmIK8hd5SZyZbsDPtnqYcrcVc0N1+Xgug7TCBWNyB68plPy
	QUeBk5VAa5uIisAD5vwAJ+Bw3ijlFTFxr+DmFwkdK9uxlUvKLP4eUnPTJRcSK8h2d6wX5Ndeazn
	aOBffJHkii5QVtKDjKgvwn3wrX3tWeR5Fm21QRhXxEaKCgd1az3a70CGiRGzv5GW3Lae4wM0jn2
	QoiQt2OLjdy154MY34NbAeezw5DkO/pnGDZbbR7Sze7y+1tIMPOYU5cOSRtvhJl02SMhzcjiQjH
	Z/m4v2dK7G3xHV+3A8+O8DtiIRTCKc8
X-Received: by 2002:a05:600c:190c:b0:499:8aff:59b6 with SMTP id 5b1f17b1804b1-49e6cacf772mr498775e9.14.1789162890859;
        Fri, 11 Sep 2026 14:41:30 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33fc02sm8044319f8f.16.2026.09.11.14.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 14:41:30 -0700 (PDT)
Message-ID: <9cb2f10e-bea0-44b2-a7dc-e2eaeb5ca96e@grimberg.me>
Date: Sat, 12 Sep 2026 00:41:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: accept ANA group ID NVMET_MAX_ANAGRPS in configfs
From: Sagi Grimberg <sagi@grimberg.me>
To: Andrew Stellman <astellman@stellman-greene.com>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260910154849.66095-1-astellman@stellman-greene.com>
 <3a06fc29-4364-4573-b12c-39b42d95a4b3@grimberg.me>
Content-Language: en-US
In-Reply-To: <3a06fc29-4364-4573-b12c-39b42d95a4b3@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_144133_163385_FDCB2902 
X-CRM114-Status: GOOD (  16.06  )
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



On 12/09/2026 0:40, Sagi Grimberg wrote:
>
>
> On 10/09/2026 18:48, Andrew Stellman wrote:
>> nvmet_ns_ana_grpid_store() and nvmet_ana_groups_make_group() accept an
>> ANA group ID in the closed range 1..NVMET_MAX_ANAGRPS, but then pass it
>> through array_index_nospec() with NVMET_MAX_ANAGRPS as the size.  That
>> helper treats the size as a half-open bound, so the maximum valid ID,
>> 128, is rewritten to 0.
>>
>> nvmet_ana_group_enabled[] is NVMET_MAX_ANAGRPS + 1 entries wide, so
>> index 128 is a valid slot, and the controller advertises ANAGRPMAX =
>> NVMET_MAX_ANAGRPS.  NVMe Base Specification 2.4, section 8.1.1
>> (Asymmetric Namespace Access Reporting), "ANA Groups", defines a valid
>> ANA Group Identifier as "a non-zero value that is less than or equal to
>> ANAGRPMAX".
>>
>> Two visible effects.  Writing 128 to a namespace's ana_grpid succeeds
>> but the namespace lands in the reserved group 0, which Identify
>> Namespace then reports.  Creating and removing ports/N/ana_groups/128
>> increments slot 0 on create but decrements slot 128 on release, leaving
>> nvmet_ana_group_enabled[128] at 0xffffffff, so every subsequent ANA log
>> page reports a group 128 with no namespaces in the Inaccessible state.
>>
>> Use NVMET_MAX_ANAGRPS + 1 as the array_index_nospec() bound at both
>> sites, matching the array's actual size.  A namespace assigned to group
>> 128 now follows the same path as any other group: its ANA state is
>> Inaccessible until ports/N/ana_groups/128 is created and configured,
>> where before it sat in group 0 with an uninitialized state and I/O was
>> allowed.
>>
>> Tested on 7.3.0-rc1-qpb-cc-base+ (unpatched) and 
>> 7.3.0-rc1-qpb-cc-anagrpid+
>> (patched) in an arm64 QEMU guest with nvmet over NVMe/TCP to
>> 127.0.0.1.  Before: ana_grpid written as 128 reads back 0, and the ANA
>> log after mkdir+rmdir of ana_groups/128 lists group 128 with nnsids 0,
>> state inaccessible.  After: ana_grpid reads back 128 and the ANA log
>> lists only group 1.
>>
>> The issue was found by Claude Opus 5 running Quality Playbook, an
>> LLM-driven code review tool:
>> https://github.com/andrewstellman/quality-playbook
>>
>> Fixes: 20dc66f2d76b ("nvme: prevent potential spectre v1 gadget")
>> Assisted-by: Claude:claude-opus-5 [Quality Playbook]
>> Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
>> ---
>>   drivers/nvme/target/configfs.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/configfs.c 
>> b/drivers/nvme/target/configfs.c
>> index 413ee2d16d29..0d4c69c4697a 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -698,7 +698,7 @@ static ssize_t nvmet_ns_ana_grpid_store(struct 
>> config_item *item,
>>         down_write(&nvmet_ana_sem);
>>       oldgrpid = ns->anagrpid;
>> -    newgrpid = array_index_nospec(newgrpid, NVMET_MAX_ANAGRPS);
>> +    newgrpid = array_index_nospec(newgrpid, NVMET_MAX_ANAGRPS + 1);
>
> There is a condition above:

--
         if (grpid <= 1 || grpid > NVMET_MAX_ANAGRPS)
                 goto out;
--

I assume that this patch was not tested?

