Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717D1C282C5
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Mar 2025 11:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kQ8cBKg5ej+Kp/w3MQ6nf2UTZ/6C1yGKdohploMEAJI=; b=AEsrecf44EEyL6CsZ5f+robhD6
	FlrgMD2OUkDNlFhJoVZgFaVec/5aAljMeZO7PUIID2CfCs8d0IUPf3KGlOsIzN2mxtceiqsiQmK3B
	i6Qg+k1UzfLpTNIQTlmAkppmpUI1g6OOmXRhCSrBUdEqBGlXOxX4dHYQeZt2N8XoHtOEBKHhVkoiG
	EkPynIvChSM38nPGv5B5IKXR8oiwdy0OqAaTck422gNLBNmzxjaAY8X0vLsxG+tm62Su0UGh264so
	mcm+0uY/GQFP/KoQxmBaop6omthsw7wxYF8QZd5zjFpgRvdzn9C0VG8C3No1EHtfiRMl5J23Ls0PP
	0mMXUnLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp3ct-00000000SPh-0lr3;
	Mon, 03 Mar 2025 11:06:23 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tp3cq-00000000SOe-3oUb
	for linux-nvme@lists.infradead.org;
	Mon, 03 Mar 2025 11:06:22 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3910e101d0fso388043f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 03 Mar 2025 03:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740999979; x=1741604779; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kQ8cBKg5ej+Kp/w3MQ6nf2UTZ/6C1yGKdohploMEAJI=;
        b=KdrQqeUQTgT1j0ttVd71tXkv2lZ+7n9SBHFcNzP4g1JEfdggWjrTCrPBIAWuc75ef4
         uXGp3GHiVkUn0x0PxKP5EOz+XqxLiBQx1rx3uazBEkOUBXNxpUXdjR1vuoF682l6/1zG
         i4+pGWTcdhrYEuxTHqLe7Utg6rav7njnxo8UjzcPIjeO0jjLoAAuObWgIkOSGpMTCn4q
         K08LNS4Pv9n+og02y41M+CTYn6YcQW3lNSPxbRGlExRccyjjQkeG7uwzn44Vnyto4hoT
         EYh3Ym8hmFRmgLI0V55gf6BGHIFvgWj6/JplEaI2UTth5ZlMXVxIV/h6lQklwEUjJac8
         YVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740999979; x=1741604779;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ8cBKg5ej+Kp/w3MQ6nf2UTZ/6C1yGKdohploMEAJI=;
        b=JLKgNgg9VrnUVa1NTR6k5M3gmaHgsmBbV6ioG3508ozTBABCObEdyqtW1jt8fGThjt
         g6zO+mELT5b4HNg/hUvic1+YzinqoB8QdIuOpQjaxpgtL8Od1ABBv60RHQumlUcHTJKY
         5OjC+hTXFVeIF0ymOu+AQbwWVuamAX2cI3R8FKqYH+GtlUzWlVzCM4/udj3GGp5nJJQa
         vNfEccNSYJ7dKdkOU/oe6O/ofbVXYJCK2z+o3QWRxknc6D0gM7ZEPOqHAX2NUXdz47pi
         ztKqVXqRgPANjtzi+4DVxh06rjrpu8PbnBwVr/MjyWqHplfJyiN07/Dj9zWHrrrnjGA4
         NjpQ==
X-Gm-Message-State: AOJu0Yy09/QxTAekLu5OLIlYhdgFB5b+GrnhEIqcOmm1By2ho8w1ZjY/
	zBY5OODxmom/zYL6VBfpFmolADJlgF3VZjtSEopv4qLFRLCShGxMBAgdkJl+tQ2KqKR/t4N7zTa
	H
X-Gm-Gg: ASbGncszPbnDoNbiCOZ919U0nzkReEMqvp+aQ4d4I8cWXCPi8DWSnaHR+e0j52SH7E4
	kWgvwt6ciHF0vB1bPz15zNLweEZ0jS/hOa1ZJMBObqR5AK4uFEv65pK5hCfzPYtDAedBCUnJ3OG
	9AAis5Ek8OSBnc+pfv8ZldfsJ2CTb0Ow0qFCqtbJ70ZJkOTWjOfVpqlgAMyByoF99xEMnpVJUzt
	NSc5/mApB7G5ukB8UKzM/oTuuu4Lqbm/ARQN9wy0rhdRsBq4+BGk4+y7Rq9o6sVPuXuT+qgpLzJ
	+gCryqSEP7DEigxrf3BZFFKXp3Jprl6oMfi1CEHF7A/4ZmtvwcSV/gZtQB8f+zVgzEUSJg==
X-Google-Smtp-Source: AGHT+IFXsUYLxm8Df30+KsC35vTZ6zstjg62rje6R1G9L3oOQ25nE/E4W1Oe3hkZUEWPeieF2m9H4Q==
X-Received: by 2002:a05:6000:4029:b0:38f:2726:bc0e with SMTP id ffacd0b85a97d-390eca138d2mr11479696f8f.44.1740999979152;
        Mon, 03 Mar 2025 03:06:19 -0800 (PST)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? (megane.afterburst.com. [2a01:4a0:11::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm13933050f8f.27.2025.03.03.03.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 03:06:18 -0800 (PST)
Message-ID: <913d3824-04c7-4cb1-a87b-01f9241a37aa@suse.com>
Date: Mon, 3 Mar 2025 12:06:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
From: Hannes Reinecke <hare@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Matthew Wilcox <willy@infradead.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
 <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
Content-Language: en-US
In-Reply-To: <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_030620_947129_2521195A 
X-CRM114-Status: GOOD (  13.16  )
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

On 3/3/25 08:48, Hannes Reinecke wrote:
> On 2/28/25 11:47, Hannes Reinecke wrote:
>> Hi Sagi,
>>
>> enabling TLS on latest linus tree reliably crashes my system:
>>
>> [  487.018058] ------------[ cut here ]------------
>> [  487.024046] WARNING: CPU: 9 PID: 6159 at mm/slub.c:4719 
>> free_large_kmalloc+0x15/0xa0
[ .. ]
>>
>> Haven't found a culprit for that one for now, started bisecting.
>> Just wanted to report that as a heads-up, maybe you have some idea.
>>
> 
> bisect is pointing to
> 9aec2fb0fd5e ("slab: allocate frozen pages")
> and, indeed, reverting this patch on top of linus current resolves
> the issue.
> 
> Sorry Matthew.
> 
It's getting even worse; after reverting above patch I'm getting a crash
here:
[  968.315152] Oops: general protection fault, probably for 
non-canonical address 0xdead000000000120: 0000 [#1] PREE
MPT SMP NOPTI
[  968.328747] CPU: 30 UID: 0 PID: 665 Comm: kcompactd5 Kdump: loaded 
Tainted: G        W   E      6.14.0-rc4-defaul
t+ #306 9ca11b70f9498982db3664c8471cfe00b0a16485
[  968.345747] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE
[  968.351913] Hardware name: Lenovo ThinkSystem SR655V3/SB27B09914, 
BIOS KAE111E-2.10 04/11/2023
[  968.362371] RIP: 0010:isolate_movable_page+0x7c/0x130
[  968.368826] Code: 02 75 3c f0 48 0f ba 2b 00 72 34 48 89 df e8 8b e0 
f6 ff 84 c0 74 20 48 8b 03 a9 00 00 01 00 75
  16 48 8b 43 18 89 ee 48 89 df <48> 8b 40 fe ff d0 0f 1f 00 84 c0 75 61 
48 89 df e8 ff d8 f2 ff f0
[  968.390698] RSP: 0018:ff582840034c7bd0 EFLAGS: 00010246
[  968.397354] RAX: dead000000000122 RBX: ffc1af3dcf400000 RCX: 
ffc1af3dcf400034
[  968.406145] RDX: dead000000000101 RSI: 000000000000000c RDI: 
ffc1af3dcf400000
[  968.414950] RBP: 000000000000000c R08: 0000000000000000 R09: 
000000000f400000
[  968.423755] R10: 0000000000000400 R11: ff4187a00d995780 R12: 
00000000003d0000
[  968.432562] R13: ff582840034c7d30 R14: 0000000000000001 R15: 
0000000000000001
[  968.441365] FS:  0000000000000000(0000) GS:ff41879ffaa00000(0000) 
knlGS:0000000000000000
[  968.451245] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  968.458488] CR2: 000055b303833c20 CR3: 000000005a838002 CR4: 
0000000000771ef0
[  968.467295] PKRU: 55555554
[  968.471120] Call Trace:
[  968.474655]  <TASK>
[  968.477804]  ? __die_body+0x1a/0x60
[  968.482521]  ? die_addr+0x38/0x60
[  968.487030]  ? exc_general_protection+0x19e/0x430
[  968.493115]  ? asm_exc_general_protection+0x22/0x30
[  968.499395]  ? isolate_movable_page+0x7c/0x130
[  968.505180]  isolate_migratepages_block+0x39a/0x1090
[  968.511555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  968.517728]  ? update_curr+0x19e/0x220
[  968.522725]  compact_zone+0x368/0x1090
[  968.527722]  ? srso_alias_return_thunk+0x5/0xfbef5
[  968.533896]  compact_node+0xa8/0x120
[  968.538720]  kcompactd+0x21e/0x2b0

which again points straight into the 'allocate and free frozen pages'
patchset. Something's buggered there, and I'm not sure if further
bisecting will be getting us anywhere.

Matt?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


