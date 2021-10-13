Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A09C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:59:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BC260273
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74BC260273
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MmRnl1M18GB/wwQgcOurK6WxY4ZZHReY6viPB+ys0/I=; b=1/MNgx8yDNYhIEPXSO/fWrYnPA
	xG0gauQJxXkILvLTgE6c3nAwC59bE3ZAXLmLPq2YQ5j89M0dIUG6LUOvj0MLeLFguCXLWBZszyuMY
	AzMGsSjRKbIK9ooc4kLXNvnBFysT1i24Ycbq0mASaED7GKFI0e9K9SfgZSbaKPZxMmf+d7cB9eKph
	cN2MbnhyDJhGI2A7k+aB2SWpvND994iA8vAYd1xgsnsN4o4v1f3bCy3RlmOR8FyXA/TSk2pnS2w3M
	7aVCqdtPIl/PuG6dV33ZgxVP27ghVeZXsidPBPMbhm0MzbfB6bvhYkzC9bUYf49HgzhtaMKBfZFlR
	2ug7Mkng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1macuy-00GQuT-AU; Wed, 13 Oct 2021 11:59:32 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mabnV-00G5q6-M4
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 10:47:46 +0000
Received: by mail-wr1-f46.google.com with SMTP id m22so7012653wrb.0
 for <linux-nvme@lists.infradead.org>; Wed, 13 Oct 2021 03:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZiaQoyU45xhgDOKQLLeQzqGlt0Ff7V0IGrHFdC4CAG4=;
 b=OQecHuylM/tV1o9FYiGIRGwRAszeQlDRX0JYkQJFZGUfo6PtjiKdbEdtrdNzoEe74T
 6DdlpnC/EdgKvd6bK6YAQ2U8HEfODvQSKzT+VhnvcemhLMa/YvdGUeU9axm9bpevPNcx
 vlYCFHy05W35ephjYLg0FytTaTu1g1q+2/ruBQ8w6N6TqFAa7wY+BRnkIjbUKbdQnaRE
 G3qMWRWz6+UdyMLrtHvGZumF/cyv5snkhs8agxxP7RBm2LkfeRgYF21r0dMlMUzglcNn
 F5c26/AIX4ofHPoSj++75yKi0KB/b3zKputhFpgdrLIXZDmhdIbiVEDZJMI9p4VomUm1
 ScPw==
X-Gm-Message-State: AOAM532cjZvjhLb7/pFiUa3+ahsw7z4JH/z14CT5cFIn6rm5cZirIDGx
 y3iDoUj/JRf9vgGs4lhPh0rz5Rqglbk=
X-Google-Smtp-Source: ABdhPJzJynT71nTLo0q+7Ju1iSw1+NGuHD3lp2wuMN5k6g5z+IdXTFAssJ5DrKduipHsCgFHr+wJqg==
X-Received: by 2002:a1c:4b08:: with SMTP id y8mr12496863wma.98.1634122064135; 
 Wed, 13 Oct 2021 03:47:44 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o6sm5344817wms.3.2021.10.13.03.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Oct 2021 03:47:43 -0700 (PDT)
Subject: Re: [bug report] kmemleak observed with blktests nvme-tcp tests
To: Yi Zhang <yi.zhang@redhat.com>, Adam Manzanares <a.manzanares@samsung.com>
Cc: "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <CAHj4cs8pcLTjHMhh_0vebWUgwTY+UtYoKAhQntCsFvKM4zcKfA@mail.gmail.com>
 <caa2467e-9763-b9dd-db91-4cb7020bab47@nvidia.com>
 <CAHj4cs_NqB6WYQQOpqjoOFvTbbN_VydJkn1VquzTkyGpFqMM2Q@mail.gmail.com>
 <0a8810e0-4c42-4275-acd6-475fd42485fe@grimberg.me>
 <CAHj4cs_icpHAf7wN3LFt7avcPcrhjOYiSnU8SnCLQN1ObkRV1Q@mail.gmail.com>
 <CAHj4cs9QBFXca-rnP05ZmWBKDJv4aviiDQ=q2_JihMQuESE7OA@mail.gmail.com>
 <1b992460-26a6-cff6-bee4-b81ac28e93f5@grimberg.me>
 <CAHj4cs8Vff_C8FnFciHtYdnifoOHBrNtaGN1Fvpg5m2gV8JpZw@mail.gmail.com>
 <CGME20211002230919uscas1p1bc872acda3a68abc1438443d78ac921b@uscas1p1.samsung.com>
 <05d2844e-81fb-0180-03cc-423cedfd7ac7@grimberg.me>
 <20211012183446.GA264712@bgt-140510-bm01>
 <CAHj4cs94Ts7iLBjw+1Dn3FM9sjj7sTx7j=30ytshH9YTA2jdDg@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a6401bac-cfd0-9a29-ff82-dd548590301a@grimberg.me>
Date: Wed, 13 Oct 2021 13:47:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs94Ts7iLBjw+1Dn3FM9sjj7sTx7j=30ytshH9YTA2jdDg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_034745_798293_0E1060F6 
X-CRM114-Status: GOOD (  10.70  )
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


>> Hello all,
>>
>> Does the following patch fix the issue for you.
>>
> 
> Yes, the kmemleak was fixed by this patch.

Great, Adam care to send a proper patch?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
