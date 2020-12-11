Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25B2C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 18:43:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA6222BEA
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 18:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA6222BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=btF2sCT8YKUmMFgGE5iQUVOSBTR+/Eybr+tOcj6/W6g=; b=cKj4mPNDxWNCLUhG0kSjf/arj
	tQXMP83zZFZ462yAO//Tzjl+1fsh7zMmghpyH66Ni94wTYnpBgvm0GxkR0+SCQ8GFOfmkcdi+1EFg
	U/1xhRuAF2rV/LWRjj3ybeeYzPGxtvC42Zj3dBXUxaQ6JxwpE1zITT9hiYlr+CIxzG5Sftfbk1bgL
	XndBLXfigDVmQWkBDSRuoVmxitx8SLWzF+Rr7CoowCVEZMhTdxXrVZgorOEpxyL7Mi7LZc/V+fF+H
	yun8YPm5tyKGDSIzHS2jkJtSsunwk65cSU9Gpwl7M+CDHev9D50FEUwvxFl9UuK7iY2nLFZL5cRiY
	5yb5ZA0Rw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knnOE-0004wK-2b; Fri, 11 Dec 2020 18:43:38 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knnOA-0004vr-OY
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 18:43:35 +0000
Received: by mail-wr1-x441.google.com with SMTP id r7so10041110wrc.5
 for <linux-nvme@lists.infradead.org>; Fri, 11 Dec 2020 10:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zdJOjs4dTsfUx4y7I8FwfWeld9WmUm3RT92AXbQ7uCk=;
 b=WxRGxYL08TEYNZHjLDqOYS9lXzrSamCXC6RJC07gJfBWKY9nQp4wJ71jwaCxpZcrnF
 VWguMXHh6INfY8IM/GS1xha/1tqEUnQm9oYWX/nctHYvkA5Iwd47ZEFV4nleU+miRp/Z
 BcJydnVWEd/Bm7HJ27p+KNUGMFyPX0OdQiZx4KHe8go3uL9vDyo9Z2OG43dk7PQvw8ns
 pU/SaeSBGJKfCv1GJkF5QSleqe0jxeGFvE8QqbMOY4d4fp3DAe55muZGdrzKwWIC73JC
 0w2NarE8kqgBlogU6HBBcuQYT+AE5VU8NPErcjHonvEljy2k66fyu3gNkq1IOnWJ1QKm
 1vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zdJOjs4dTsfUx4y7I8FwfWeld9WmUm3RT92AXbQ7uCk=;
 b=ZzhGJrBezRw4wEklGkgvEZy5Q/mib5vw8kNDRl5Wx77TWgcZl/JSZdWHOQBUeXA6yM
 +p6JC5dekvEd+tiNZ392JBWPbAkjy9+l38w4CzEMjl8Aq95m0fjsOvh7Xi5qnu3XJYK/
 PZ/yb38aAhOSOjfGmC8yEqDwfIEkPg6IZQhk6khxQdB89sqYn2H6LyOWjBtN9Of4r0DM
 38xoBXn9gaaZ4kfzjUt8QaNsZsNCfcXQ3y/HKg3HWbkmNCO5tTsdUoy3PdoSst5vJHxL
 UOWJcYoJRhuVmrKYqaYf4cf99kLQuCMclbxiVmYhjoxiJF2Lydm5kfTyggFD3iK3bDty
 c5Fg==
X-Gm-Message-State: AOAM532gFMmHUPd1nHURaPn3Q1JgfXmp+wF1Ql/6vQB0nHI9zugEdA37
 aVqqdZkVJxV/DH/oDNiOjeM=
X-Google-Smtp-Source: ABdhPJwjehiuk7uz83zaxeXY6J28+VwLRyO3Lo50+MZF1WOP0Ke+pyo1OwjcI6Vbe82aJm+ibH05Xg==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr5254294wrw.399.1607712212101; 
 Fri, 11 Dec 2020 10:43:32 -0800 (PST)
Received: from [192.168.1.11] ([213.57.108.142])
 by smtp.gmail.com with ESMTPSA id p19sm19744861wrg.18.2020.12.11.10.43.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Dec 2020 10:43:31 -0800 (PST)
Subject: Re: [PATCH v1 net-next 04/15] net/tls: expose get_netdev_for_sock
To: David Ahern <dsahern@gmail.com>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-5-borisp@mellanox.com>
 <f38e30af-f4c0-9adc-259a-5e54214e16b1@gmail.com>
 <104d25c4-d0d3-234d-4d15-8e5d6ef1ce28@gmail.com>
 <ae89bba7-2541-e994-41da-fb791ced7aa7@gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <da5594c1-47ed-e4aa-4c28-7b61529399fd@gmail.com>
Date: Fri, 11 Dec 2020 20:43:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ae89bba7-2541-e994-41da-fb791ced7aa7@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201211_134334_816270_76C3B6CB 
X-CRM114-Status: GOOD (  12.33  )
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
Cc: yorayz@nvidia.com, boris.pismenny@gmail.com, benishay@nvidia.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 10/12/2020 5:39, David Ahern wrote:
> On 12/9/20 12:41 AM, Boris Pismenny wrote:
> 
>> is applied there is relevant here. More generally, this offload is
>> very similar in concept to TLS offload (tls_device).
>>
> 
> I disagree with the TLS comparison. As an example, AIUI the TLS offload
> works with userspace sockets, and it is a protocol offload.
> 

First, tls offload can be used by kernel sockets just as userspace
sockets. Second, it is not a protocol offload per-se, if you are looking
for a carch-phrase to define it partial/autonomous offload is what I
think fits better.

IMO, the concepts are very similar, and those who implemented offload
using the tls_device APIs will find this offload fits both hardware drivers
naturally.

To compare between them, please look at the NDOs, in particular the add/del/resync.
Additionally, see the similarity between skb->ddp_crc and skb->decrypted.
Also, consider the software-fallback flows used in both.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
