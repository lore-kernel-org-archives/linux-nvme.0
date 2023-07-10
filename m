Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEA8EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 09:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=NK/Z4NeOIPRgHO49p6UqSrSP7p
	CysXvB80IXac5aZrERg90bRP6cZlHqtVeTnALkJZWhIVKLIV4qiMVF2E87iUpDbIItnhmcOVFr9F0
	PfaRubpCmZludogM/7J0L5Q/ohyR0iocUdGoXnF0xCU2RjzFhbnlQxU02y5MHZ3991aErbYgYpA2+
	/GW/S5ItsaMtMixChVpoiyvhoBFIWf8LFpifiu6b51ZhVMjrgkeWdJtVLCrxoUspcK+EualFV7BhS
	Og76sbOC0lhOtwttRN7MrYNifG2W4/jQ+ukXHL+Fdbii30R8OFtuiGMyHU/CPPNtB6ORmK7TslGe6
	f9ErQ4fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qInF2-00B0ws-35;
	Mon, 10 Jul 2023 09:31:36 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qInF0-00B0vr-0K
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 09:31:35 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fbb634882dso10395675e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jul 2023 02:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981491; x=1691573491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=cqJlAOr5VBfi3KSyG9DRBQ2gzX9d/sS4Bopw4KDLEL2nn2znqXiWWW2WyOQWwwngbv
         q9mQHEYMNM9zlN38oYR1B/6obzlag7ynSxtZKof7SXBxoblhT3NW1ji5FO19cQs4wcN5
         rvmyL5gAiTRMa+ThjQggzkyriJwseK8lfqy9hyKn4nGEgJLcJU/FFtOgVzQVy32RsBiX
         ox+m1Dm33s0AINpDwZeCuOTlNCNBK656OdtSLM6c0bbKx6LFuG44yy/L6X/dmwvBisw3
         sARYlQHmflumV5bZ6qvQqR9MLB8eUeH6K1QHuSV1dTXcC1pZulX3XoRPfy+ew4fyfx0L
         OV5A==
X-Gm-Message-State: ABy/qLYHK0cEwHl6juIzjsQIeVK+A3cf51QfCYg2r4BfjAlYPpD2MbCJ
	RQmNSUEF2ncTDCTuWFs7/ck=
X-Google-Smtp-Source: APBJJlG7fnYAe2ON7tFEpp+MZFL3CfB1NhiN3mkpMczrNU9iuLt5F1nkwlUbilquV4imHlx2JZTlqg==
X-Received: by 2002:a05:600c:5115:b0:3fb:aadc:41dc with SMTP id o21-20020a05600c511500b003fbaadc41dcmr11135555wms.4.1688981491349;
        Mon, 10 Jul 2023 02:31:31 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e4-20020a05600c218400b003fbfea1afffsm9207887wme.27.2023.07.10.02.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:31:30 -0700 (PDT)
Message-ID: <969e651c-ec97-ece4-11a2-9109a971d175@grimberg.me>
Date: Mon, 10 Jul 2023 12:31:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] nvme: fix max_discard_sectors calculation
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230707094616.108430-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_023134_135581_D614009F 
X-CRM114-Status: UNSURE (   6.96  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

