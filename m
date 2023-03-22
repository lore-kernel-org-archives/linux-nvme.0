Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E85DC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3m7i+zffP8jLV18BUeNJ3reiF252gBIRgmXKF/VSW4o=; b=ecHmqyf9idug+2P+mX1rq5tpol
	V1HsZIcOfumyCvz8APE+lPfxAdx9CG+lwLy3GxreMq/fa1r3knT9Ew3KKY2Qdlnpy2Ce2sXTLKyw0
	QFkSv65yWvJUA8XJazBf0j+NZUTD+x3HKaiBQttcXraYt5KfpcnbYYTPbmuanN/Rjr334aeKYrfwa
	6K7xI9X19PgFyIskw03eRzD7oR128ysUprWnLUuxIkWMu0sjiZ9B1hIs6WruFSPewofFZwbJizTzX
	lGnhJ6tcQpvlKDLZob2rjKbk28o7WjOMD0mbB7Xqj5QuWwEJT6ItSD3KaD0nziff6ZHfMBxtn+obX
	7xkfg8rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1petds-00F8Pc-09;
	Wed, 22 Mar 2023 08:16:20 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1petdp-00F8Oh-1M
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:16:18 +0000
Received: by mail-wm1-f42.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so5992544wmq.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 01:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679472974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3m7i+zffP8jLV18BUeNJ3reiF252gBIRgmXKF/VSW4o=;
        b=H8dsxPqD/H5DTw8pCsEAIVFaj9YJTEx+PJ4I82P4WUdWRduo1Dy6LiZTUXBG/zgCxc
         d8FptoVTvUX41TcFL7O7tmOnYjHW28Wbwgisho83/RGbNriTfxZ3ADrR6psLxFSzbPwB
         DUX/jhIUtdSkr+SpSkvT7PFa1WhST5W3YxPPfkKP6+HHT0rLSwheGn9NN2lSgoXgKgCK
         M5goSrg/Y4WawIWWlJJz/dKtVFdewz+EaFheT0bkambe0TD5OezrkSi0fVwuVc401abs
         GmZ1wJRkWdilqA21CJJZ6rPTukft3VFspgCS5kBqjtFeY8EywlkmekXF1tyS0/v3Ax1G
         nXuw==
X-Gm-Message-State: AO0yUKWPPNRla9p8e3OsAEmzczEAE+fPYhWqu5Zgr0gMZKOTJSLPi66u
	l+7psEi/aURUelQTqbnY954dZoC9EWY=
X-Google-Smtp-Source: AK7set9P/8gSsiKFaEBTn2/l/DUTE7TSQucB+9QWRUZuQxGMuISE4lSBh0kqQZFklRRTB85ooBeJAg==
X-Received: by 2002:a05:600c:4755:b0:3ee:1c42:6582 with SMTP id w21-20020a05600c475500b003ee1c426582mr5570499wmo.3.1679472974480;
        Wed, 22 Mar 2023 01:16:14 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc40e000000b003ee0d191539sm7016764wmi.10.2023.03.22.01.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:16:14 -0700 (PDT)
Message-ID: <d57b8847-b57e-487d-cf90-c63f86716d6a@grimberg.me>
Date: Wed, 22 Mar 2023 10:16:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 00/18] nvme: In-kernel TLS support for TCP
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <98884644-99f3-7b3c-387a-66fbdd98d4ed@grimberg.me>
 <f9630511-d843-89fe-64db-1a4c41dbbd08@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f9630511-d843-89fe-64db-1a4c41dbbd08@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_011617_463203_85E9E13C 
X-CRM114-Status: GOOD (  11.26  )
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


>>> Hi all,
>>>
>>> finally I've managed to put all things together and enable in-kernel
>>> TLS support for NVMe-over-TCP.
>>
>> Hannes (and Chuck) this is great, I'm very happy to see this!
>>
>> I'll start a detailed review soon enough.
>>
>> Thank you for doing this.
>>
>>> The patchset is based on the TLS upcall mechanism from Chuck Lever
>>> (cf '[PATCH v7 0/2] Another crack at a handshake upcall mechanism'
>>> posted to the linux netdev list), and requires the 'tlshd' userspace
>>> daemon (https://github.com/oracle/ktls-utils) for the actual TLS 
>>> handshake.
>>
>> Do you have an actual link to follow for this patch set?
> 
> Sure.
> 
> git.kernel.org:/pub/scm/linux/kernel/git/hare/scsi-devel.git
> branch tls-netlink.v7

I meant Chuck's posting on linux-netdev.

