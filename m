Return-Path: <SRS0=mUzn=PT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700E6C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Oct 2021 11:56:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D658D60FC2
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Oct 2021 11:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D658D60FC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fCG9fQ62LgIEailP5ajtxYtq1pPaBLNA67XGKhl6I8U=; b=LOhpwD5hoR4jAc5i+GjeLo3i4V
	eKHz9u4CIcmRZOwgsQBKYf/WpdUu6n7l1InwVCVlQVuWT5SeAEBcv5p0zQCzLMJEo5dseYFXKXLOo
	QKKt33StttHFKveQxKbI3rTfnMDeI6E9qFOR4WyKFOc1w8BONLyoYV3x9sB4HF2IzvRbpij0jyNcc
	meETueOJiKzmPwmNK69Cm1awdcZXWo0JJoKh8T4PadPB4iFtTzobVjVfvmL2GraIdNZV217vliG3/
	E7PwXaY7s55JKexwsFEksaPPya59x91zDhExTeXbH/SJk+1aa9RJ4LDHOI7kdguVIaqobUPKhcBeW
	kE8Dq5Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mh9RO-00DwDS-Df; Sun, 31 Oct 2021 11:55:58 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mh9RL-00DwD0-EY
 for linux-nvme@lists.infradead.org; Sun, 31 Oct 2021 11:55:57 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 d72-20020a1c1d4b000000b00331140f3dc8so4140047wmd.1
 for <linux-nvme@lists.infradead.org>; Sun, 31 Oct 2021 04:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fCG9fQ62LgIEailP5ajtxYtq1pPaBLNA67XGKhl6I8U=;
 b=ot8TrWcflBsy57P4OG3xcn+CfHdOf+EuY1tOekqlF9t8TgV/qF54dHjAYh1kYegh0Y
 LhjxlebarWWTSFmEex8Ww1CJzxOgIhQSLk5jDKAY3KBiKnb4EF70t0PS4eRWe/m6X8hm
 0uL47nF0y907MXfTdmFIBy+yLBlk0MWM+yn7ctdXS5jStPl5hbzG8/MdLSQyuBGmnjt/
 bitKGx3dvoldLueWzmq8aAbsFNWaCVuozPAlbf5mhqx4Xf38nL50zUsJ9GYIiofRTfkT
 YK8GxjBOhQvpeECcJkRb5aTTn8+CaBgPCVBlA8xfklpYWVRr1BEgr0sJgpE7KeduUoAM
 6gQA==
X-Gm-Message-State: AOAM530rcq60ZrU4bVG85ktYEQBXgh0VmTfeU10I8htou8Scv4+7PVYv
 IlZ2VhHLZdsAgkKzc3j+2hilO5vI61s=
X-Google-Smtp-Source: ABdhPJyYcfB5wEGKjRKTbS8U2XWEINV//Bx0BwW+AsZ/dn5WnZ9rVSirLrB1ajkpqxgajf8k2/Hxpw==
X-Received: by 2002:a7b:cf10:: with SMTP id l16mr7275034wmg.17.1635681353047; 
 Sun, 31 Oct 2021 04:55:53 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id l4sm3917319wrv.94.2021.10.31.04.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Oct 2021 04:55:52 -0700 (PDT)
Subject: Re: Another wierd deadlock with nvme-tcp
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <4e06ce06-118e-2f67-8acc-e08fd58b7cbd@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <01be4f20-0722-42a5-ab2f-6858cc8d1a43@grimberg.me>
Date: Sun, 31 Oct 2021 13:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4e06ce06-118e-2f67-8acc-e08fd58b7cbd@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211031_045555_527618_6F2F0FE2 
X-CRM114-Status: GOOD (  13.87  )
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


> Hi Sagi,

Hey Hannes, thanks for reporting.

> and I've run into another weird deadlock; this time it's nvme-tcp not
> flushing timed out commands when deleting the controller:
> 
> [ 1685.982355] nvme nvme0: Removing ctrl: NQN
> "nqn.2014-08.org.nvmexpress:uuid:62f37f51-0cc7-46d5-9865-4de22e81bd9d"
> [ 1688.533746] nvme nvme0: queue 2: timeout request 0x72 type 4

So in this case, nvme_tcp_timeout() should complete the request
as the ctrl->state is for sure not LIVE.

In this case we should complete the requests with
NVME_SC_HOST_ABORTED_CMD - worth checking.

Also, this means that in the completion path it is expected
that nvme_decide_disposition() will return FAILOVER as
REQ_NVME_MPATH is set and the status should make nvme_is_path_error()
eval to true - worth checking.

> [ 1688.533781] nvme nvme0: failed to send request -104

In this case (-EPIPE and -ECONNRESET), nvme-tcp will complete the
command with NVME_SC_HOST_PATH_ERROR, which is also a path error
so the same behavior should happen - worth checking.

