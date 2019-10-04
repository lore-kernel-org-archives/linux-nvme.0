Return-Path: <SRS0=SS5y=X5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B949C4360C
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2019 21:57:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8A0222C0
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2019 21:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h+cmZ+dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8A0222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=31AbupFgJkrs0n3AT7TMRFtqSzV3rZE8cGHBbpLOMXk=; b=h+cmZ+dcX7G2BXSMvg+FpY8D8
	jsoYJzlbqR/E/rdPSpULqc0fgdMh6Pq1HTyQccnrBl0cD1bz+82VUub1KG5DXW9YW6yViJdaA2iOw
	JuG5nqRLGWbLobCxYpQOTE4uwIGF5L+NkTDxa3NNgCRCaf2W0pbOA8quPl8byqUf3w+GIiZunWcc6
	rpWWhlexpQ25dGA76VgcYsdYfcJqmuQ7EdXxVBVj8k8+vGxVA7aytR4imkY3K6pYGW2fOGLQYkiUr
	3G0OSbS+IwP9l29KTZBonBxXj58bXvSgpGlefhU2c/ajGmMfA/Y2keAh9csJPh17sHNLAJ/3hydaL
	P5iFrY9Yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iGVZY-0006lb-UE; Fri, 04 Oct 2019 21:57:12 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iGVZW-0006ky-Hr
 for linux-nvme@lists.infradead.org; Fri, 04 Oct 2019 21:57:11 +0000
Received: by mail-wr1-f68.google.com with SMTP id r5so8773446wrm.12
 for <linux-nvme@lists.infradead.org>; Fri, 04 Oct 2019 14:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mxtxJwMe9uanemYQftoEf1kgotb7mky/DIJJ4tfSUHo=;
 b=pzORuWIfVAOSJ/o32SerU2oqujub51Yvi8J2dQ5wz3aP/Jx1xR6g8kk64HKS+A1OQW
 B4slS2y6Yoe0y1o0FTG3yXX6pyVQhkQ+OSQUH5x0WQBNumwmNb5oCj8TFWbx7Dz6zttE
 MoRvn/FljdmTcKoae0X/y8MwvoBR/DXVF6rFTwJHM4EEh/A86VHGe75Mvu8PtsubXWNs
 z+M8oHsHgOMWlIzfZjkYVkYZE3TA+YZiQn5X0REsioRFvYFxa+YnFRXsyn+qJgpN+0w1
 A9f1pLhbJ6rxRFkD4dXQ+F3rr9DvQUjV5ISCrOlTPBQai4KrnWAKBG8J9Fj9ffJGvmnX
 +GxQ==
X-Gm-Message-State: APjAAAW125ZGprtOtL0m4QunqAnhWL16ZKK/WiaXHwGpqf7t23fdcoTv
 nDN4K0YTsH9jvsL57m1uIlg=
X-Google-Smtp-Source: APXvYqzUKkiicQTWJ9LVb4JRQo4+ptFxb2J7tYV0jkYR6TQUfRVkZPcr2peItqYTj8R38VimA60KRQ==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr5700853wrq.194.1570226228340; 
 Fri, 04 Oct 2019 14:57:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id j1sm16216926wrg.24.2019.10.04.14.57.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Oct 2019 14:57:07 -0700 (PDT)
Subject: Re: [RFC PATCH] nvme: retain split access workaround for capability
 reads
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Keith Busch <kbusch@kernel.org>
References: <20191002073643.5339-1-ard.biesheuvel@linaro.org>
 <20191003114901.GA34459@C02WT3WMHTD6.fritz.box>
 <CAKv+Gu_YCRwvtc=QSu0V2i1GESxHv9ndkqe0cyJsDaL6LQATDw@mail.gmail.com>
 <20191003120325.GB34459@C02WT3WMHTD6.fritz.box>
 <CAKv+Gu_5MWeNVq2NePnTcLcGvYgJS-cZ7BRf11rBt+iLhdW0-w@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d1df7e40-8a31-d2d0-eede-f8083f38b648@grimberg.me>
Date: Fri, 4 Oct 2019 14:57:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_5MWeNVq2NePnTcLcGvYgJS-cZ7BRf11rBt+iLhdW0-w@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191004_145710_596578_C1ECC107 
X-CRM114-Status: GOOD (  11.44  )
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
Cc: axboe@fb.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>>> Broken since v5.3, so if this gets fixed one way or the other, please
>>>>> add cc: stable.
>>>>
>>>> Since 5.3?! 'git blame' says the code has been this way since 7fd8930f26be4,
>>>> which was from 2015 during the 4.4 development cycle.
>>>>
>>>
>>> That may be true, but the box in question happily boots a v5.2 kernel.
>>
>> Looks like your observation was introduced with c0f2f45be2976abe.
> 
> Indeed. The corrupted read produces a bogus minimum page size, and the
> driver gives up.

Oops... Sorry... But in all fairness that was bound to happen at some
point...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
