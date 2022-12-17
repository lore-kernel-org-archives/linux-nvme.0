Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8432BC4332F
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Dec 2022 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vu8TV454cOhVOMVqKVfXfRenv85rc0qVEFVFBfvvQIo=; b=aOiFyKCbRj3IGW
	rWP2bCnNSALJ50XR2NASwYyFZDly3vA+KS0scr38JhKx7KP3PS3Tfk7XjwhHnNAg2WwxopMgz+UAl
	xydTB25Db8WMzEzktbF9KbLIppKO0SYEzSaApGL94QPeZXjzZ5fa76tfBc/gWVh2KUo7CWHlRBN7+
	sCpuKCPxuuPKxEtUDKoj7j/NxpVroj+CaJniBfFAyyyyrbSQiwtLRly27sQwrjbHF1PdVvpoTpu1c
	MY9u+CpK0zwY7U8cpLYbY4wwlVa6KbUPmHTUA251AFKt6+2GCL6rFmKdCg7egaCjGwk8AmLV0dK+u
	9jaDZI26+EYhMQTT6C3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6Ywk-00AXzQ-Cr; Sat, 17 Dec 2022 15:17:54 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6VyF-009G3C-A3
	for linux-nvme@lists.infradead.org; Sat, 17 Dec 2022 12:07:17 +0000
Received: by mail-pl1-x635.google.com with SMTP id n4so4814120plp.1
        for <linux-nvme@lists.infradead.org>; Sat, 17 Dec 2022 04:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:reply-to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vu8TV454cOhVOMVqKVfXfRenv85rc0qVEFVFBfvvQIo=;
        b=XwwLIaJAUuDJCydZsoodoYXXc10ic55z2fIo8r9aJb6yM87pk8Cg1BnNmNfOHn6tvF
         a2DyWBTdhauXSn/C+4gS/fnlN7ejUSdEI30iC9YfzPqmLpjBPObgotj+qlU/xMJeS95g
         tdjnLkmW+d4giZs1Jd/Zcp+G5bk2qKBU/RkOZQUURp5ey7SRgOUg8WB6NCchfZE4CIHg
         b9HqtwDTxBa8Eh6Z/y4C6tSHg/g3Cdkf1hEQ5+t0NEUgNP2Nq7R3SUwxzYNaD11IzYAi
         tbggQOe2h5C2LVT0pEUg5kqbB/gQSjqTsOPeATf9BSw2HTlNzdie9KyDhNyMCEa3FE6j
         Fe/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:reply-to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vu8TV454cOhVOMVqKVfXfRenv85rc0qVEFVFBfvvQIo=;
        b=VdIv7nM1487jklvdDXBJVDoti3VBbVYPQK9ouR5LvRz8y89WOZZTN4TOdnTms9cnAp
         wQJwzPhvfKw6L+/fi5Th4rB4ozN+817SdmnNSNDRgn7ijfFti310fJ9Ls8+AqmzmcgeF
         qrefjTyF0BMb1Hal1q4hwqlWhWo5wFbM/4iwYHL5SuruXciqQzmdlaP42LuHaHuArp3U
         ALrn6bOPOYpgQFELNx1xuAhdbSjuiW5+IMb13HQZezGfrjNOORUOdBUjZ2gcuf8eHHlj
         DuMc0NZ7RRwjzM2BAok4LZstddtrIKWGxYEQ9WkTHyS7mkBpXV2VuonP8MaN+/XhgHSP
         qkfw==
X-Gm-Message-State: ANoB5pm7zAGtqlfqLJYbUBilqUf+77nEj9wtUE+jJkhQzunGctV6ZDRX
	q3xbCgHiAYLwhKDhlQ0iHop49UZE5+s=
X-Google-Smtp-Source: AA0mqf5J3WJRHC58cLtO0Rj6UV9JvPAuf6uecSmDGD8oz6P0B71l6HTXQ9PVsqcEid7cxTpQ8Eq/Hg==
X-Received: by 2002:a17:902:b494:b0:188:635d:4ca9 with SMTP id y20-20020a170902b49400b00188635d4ca9mr36678095plr.2.1671278833577;
        Sat, 17 Dec 2022 04:07:13 -0800 (PST)
Received: from [192.168.0.23] (q014251.dynamic.ppp.asahi-net.or.jp. [203.181.14.251])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903244700b001894198d0ebsm3416923pls.24.2022.12.17.04.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 04:07:13 -0800 (PST)
Message-ID: <34a2e147-7073-52f0-a52c-f93c26d819dc@gmail.com>
Date: Sat, 17 Dec 2022 21:07:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: "J. Hart" <jfhart085@gmail.com>
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source drive
 corruption observed
To: linux-nvme@lists.infradead.org
Cc: jfhart085@gmail.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, hch@lst.de
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221217_040716_129851_9B9BF76A 
X-CRM114-Status: UNSURE (   4.78  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Sat, 17 Dec 2022 07:17:52 -0800
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
Reply-To: jfhart085@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I have replaced the Kingston NV1-E 500 GB NVME SSD drive with a Samsung 970 EVO Plus 500GB NVME SSD drive.  I retained the same PCIe controller (Mzhou M.2 NVME SSD-PCIe 4.0 X4 adapter).  I then attempted the same rsync transfer at single user run level as I had done before with the Kingston NVME SSD.  The transfer has apparently completed successfully and without incident. No unusual log messages or corruption was observed.

J. Hart

