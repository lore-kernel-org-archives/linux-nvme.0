Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01900C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 19:32:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2333206B5
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 19:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cRYNcD4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2333206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VbMUTLsO8bXO4lDviQyEoL5w4h6+JhKZDXOVzmJhfJE=; b=cRYNcD4p1WFmUmUF4I0WJ+J67
	EA7edkrTW71OPXLTxugyPmH/bcg8fQnz5rz0GY/P5O1IDGeacISXpxtLYx5uJaMDdV/QvnxEWiNP/
	fQJSwEF9nmDw5yVS2IrJVhKxmNlD/V+hZRzvSKWKD+nktuDgoojl4zNWDNEdQ8huXcbSwz5J5a3ta
	qJpGdZ3Mf+4VGYZZjt/S+8xIpZQuUFBLNvU7Hacw/XT7kUwJ44os/FSMDVtPmOab0dBQzqxYY6MFS
	LwhmzX1/hoSgLY7WLBQFvBMrWAq/KBUpSPTuyMVzUmfIr1JghLW/opxzXMhIDLCUSxumS5trLDvil
	DNoOHRs6A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k87LI-0002Lb-2f; Tue, 18 Aug 2020 19:32:20 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k87LF-0002Ku-Qy
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 19:32:18 +0000
Received: by mail-wm1-f53.google.com with SMTP id d190so5922wmd.4
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 12:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GIIFF2W4gNjDyW1f14qTfO/zkxBdhfRCtn2xzsn+vbo=;
 b=B820Au4AFqptSPizk7Uj/1sDRxu+LFtusNnIbQOuaeX6uI3xahjuJDhKharTEXncnA
 Zk3hnOQcRco6u2YSqcm8luR5UcRFZ/QobIMOGBbAyy7oRBzgXJaGHux7frQIUbX34Xp8
 Mn+JGXFMW/4vM2sQDESc/z/WH/5VQcHvY8udadPae4nSMrMbws7sqVm0cDJb+WMZEVCg
 MRvNvSgeObtCQ7ejFE5rkyouF/NL3WL5+vzVitdX2bKWrNYhSnT2LOVDdpMxNWeyzI7V
 YauB0bDFfBXQSXZqPTQLR/k+ByKDrr6lBnZ6vGTvyFocAwfeyphmzPnzS2hR/HSK5leI
 yedQ==
X-Gm-Message-State: AOAM531HArAGMm4ZL82jIEURyB1ciCTMR+NE0yVGt5imW3QkDpXNE7fw
 PTIx8Y3ovgWAU8Fbkfa15bK+UhOsF7ptHQ==
X-Google-Smtp-Source: ABdhPJy7A395WwH9bf3QsQ9bKD6n0ntrB8u7enEbZhsYX1wcUr+vV5FW3IDnPFfipf+7JxO7oQd6Og==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr1376665wmi.85.1597779136199; 
 Tue, 18 Aug 2020 12:32:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dce:63f2:5e83:391e?
 ([2601:647:4802:9070:3dce:63f2:5e83:391e])
 by smtp.gmail.com with ESMTPSA id g7sm37521371wrv.82.2020.08.18.12.32.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 12:32:15 -0700 (PDT)
Subject: Re: [PATCHv3] nvme: skip noiob for zoned devices
To: Christoph Hellwig <hch@lst.de>
References: <20200818162941.2674340-1-kbusch@kernel.org>
 <20200818172504.GA28474@lst.de>
 <20200818175054.GB3097355@dhcp-10-100-145-180.wdl.wdc.com>
 <20200818180205.GA29087@lst.de>
 <bbbaf51c-d4e0-ae45-a247-1e44666f866b@grimberg.me>
 <20200818192043.GA30412@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d8ba555c-bcf1-5b98-caa7-4bd81c805de5@grimberg.me>
Date: Tue, 18 Aug 2020 12:32:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818192043.GA30412@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_153217_927877_78A8E8EE 
X-CRM114-Status: GOOD (  14.30  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 8/18/20 12:20 PM, Christoph Hellwig wrote:
> On Tue, Aug 18, 2020 at 12:10:22PM -0700, Sagi Grimberg wrote:
>> I'll wait for a new version, reverting the existing patch
>> from nvme-5.9-rc for now...
> 
> Let's just go back to v2, sorry for all the fuzz I caused.

OK, requeued v2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
