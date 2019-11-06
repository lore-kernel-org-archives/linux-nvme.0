Return-Path: <SRS0=IwtP=Y6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A145AC5DF60
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 00:20:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472CA2087E
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 00:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZrDtqGHt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MGxdBwVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472CA2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5fDSCn74mc5gDzEFVLnp/JFCSGTilz5jalYaC/VSPxE=; b=ZrDtqGHtcwfqlrUza8AulTSV2q
	iJC72aEmk0FMG1Qk+k/12XgFD+huDFeIH9NzGq1oiPBfEjXDBfmvNBKnYpTiYxHhT3+eL1c8FEQoD
	WzYRlLzXKOnp/adekDVsKDU2jYVbHCccNEL01FaY4+GQ7mEYGuc8yocBgfMG+bnjUAfDfoArGLM7M
	xEjHz3v8uJCe4WEDel6PVw7uZRyLfvkQcLom2K5U5J3Tty4WTJh3cg6bwreACJq7Uga+bdvsuKbuy
	cPdjNfDCWkrbKdEOLzaDI84/IEt4EMTLhKZwfBmX/26VkqimlDaIiJGyt77qaGDMFnIsvq+I9a5hQ
	AbDa4Ewg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS93T-0003mX-60; Wed, 06 Nov 2019 00:20:11 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS93Q-0003TE-9y
 for linux-nvme@lists.infradead.org; Wed, 06 Nov 2019 00:20:09 +0000
Received: by mail-pg1-x544.google.com with SMTP id u23so15849803pgo.0
 for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2019 16:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=AjhP9zM9Lb3wMWy1WXbtybFFKUxjVi+m8pDy4tHdHKQ=;
 b=MGxdBwVYboU0LXfgMmZgtJtYbl4dKxlO5gwybQXfZbXc1T8HMJWJk447lJL9eNWK9L
 IJhwOUnAhsPnsmBm80fp9JS8uY6vA2GCRXuRDevBYmzuHm2IeRsM7Zm1N2hRawVhFt02
 RFN/CfD9nM5kkijZOCCOYymdzZapn9ynuNWXhajrbIkXdE2ZelMqEACt65jDxbJ6sCmu
 j384I7C5GqNxEGJGe7DLG5pkFWgGBdz+DyUdleAXMDO8oJdKqU6d9vrgZhekF+JZgkNR
 c8D47p3QNs0dATSqDbXTe1Sh5VoVFyao6ZMVwpBD4g1AyTQpGtFJgmJIhGYF+/D2SUlR
 IyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AjhP9zM9Lb3wMWy1WXbtybFFKUxjVi+m8pDy4tHdHKQ=;
 b=CKDPh/yhNrNVpjuwW9d5X8Pfp0bR+H/S9NQh7RZfEwMxxJHwRxaBm4ycPRJG0ureSV
 udOJiAHn8ThcvmOHoCToyPP8hdPQ0Dh+GJQnYgJCz5AHs/JFiHtDCQZEQ9CU38jBBE2+
 otEGHWg6YQHz87USDcTWBYAfRGnO31dD8rrDIhPu5vTi1OW5VoF2ecimRE9nR5M2ow98
 /vx/oq88wKjyHuH6jYckxaEncespBpaGla9B97Y/pcvjElChS1qCvGvhRwquGcyPmjaz
 pV60ImNr+6brDeqjMlQF1KL7Ht+IQHyRYxI8pevKWYIWAF5VUXdBpZ4o7EGunhF4jRBi
 J4sg==
X-Gm-Message-State: APjAAAUNbtyrv2u7SiPTDfVRtTwNcpgtHp5q0YKUJicnNRRx9oQOqSfe
 0ruibyyiQd3cJrHs7L8UwVVDe3SfPYY=
X-Google-Smtp-Source: APXvYqz8YhJuGyknhJhSQQIbEJdhwMu+DyPnWGH7pOZpsvanY+4nN7aUbTGz7TydE1r89zzp6MRpSA==
X-Received: by 2002:a62:a50a:: with SMTP id v10mr11314741pfm.222.1572999607068; 
 Tue, 05 Nov 2019 16:20:07 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
 by smtp.gmail.com with ESMTPSA id x70sm25711211pfd.132.2019.11.05.16.20.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Nov 2019 16:20:05 -0800 (PST)
Subject: Re: [RFC] nvme-cli: Support for hugetlbfs
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20191105183412.333-1-kbusch@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <27eb0ed1-a31a-c466-7158-73d8fb5349d3@kernel.dk>
Date: Tue, 5 Nov 2019 17:20:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105183412.333-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_162008_352938_5104D9D5 
X-CRM114-Status: GOOD (  10.81  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/5/19 11:34 AM, Keith Busch wrote:
> Some commands require exceptionally large data transfers, and the
> kernel driver supports only a limited number of phyiscal segments per
> command. To help support large transfers, try to allocate physically
> contiguous space via hugetlbfs.
> 
> Rather than deal with the nuances of allocating huge pages, this patch
> requires libhugetlbfs be installed on the host system.

LGTM, and solves a real issue with user issued admin commands that we
can't break up.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
