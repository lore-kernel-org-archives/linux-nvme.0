Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3892AC2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 04:01:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD70B206B6
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 04:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lwMKC9ux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD70B206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1y+mM3+gFuivQFo48oEdjXvGevrgInyzxlJoKE4smi4=; b=lwMKC9ux52A0A1gFZ5cE2bZTq
	gOI5nX5AnnzMwa9O1yZT4LsAB6sX2JeAaWmlaFdWecs9tAamrGq+2G+LYRMPxIkyl8ZWdIKCwmC3h
	Y4W8irdxzH093Ma+KXS09vLUyJCINOojoXOxZQSyo2mlHRcT2/dIHQBforNNrZa22+LxHX7SpsjTZ
	4siuoeGBOeakscyFaPgmOXhMi39U28eJ6jHai6gsj0zxvmY+fMP1kLKKZHSMSRr6wjPP98A4trBDz
	mXB6pw+zgl9LnVKyMLULIsf/inTifcqMBiLJppsqj7dFnyo9gmo/ePHXX44xQ6T+RPIy+bYxuJyRo
	UvDwCUd7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbyMQ-00035B-G5; Mon, 09 Nov 2020 04:00:54 +0000
Received: from mail-pf1-f172.google.com ([209.85.210.172])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbyMJ-00034l-Ci
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 04:00:53 +0000
Received: by mail-pf1-f172.google.com with SMTP id q5so3854873pfk.6
 for <linux-nvme@lists.infradead.org>; Sun, 08 Nov 2020 20:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ntBIH3ZAfDJ/AHfgFY05A3o4QdzI+kIMyJ04Xyg0QKo=;
 b=H1BqDRSctZ7QTxcfcF/ipZKO3w4Ck4TJ05v64Ucc41b7DB+w7k1O6ZzMadHOZ8oRTG
 zVfj8TuKEsGPXNhZGqKqAcgexJNfbtVZQ3kI0pduCi7J2zBLeP7H977LK5O5OvHsMKrP
 a8JS5UOG9qvFk26/yP/ZM6zo/DexxahFyxWn2NZs+lnPTG5L98bj6zN/hLy9LVO9gfrj
 2lJobA5hWoHJIP5jTQGrUCzehpPBSwra3e6GeOsfdkUxsM5f8MTiJQsI8eq4fz4x8XNm
 gDjRptwhWhg9mnAwX7f5sYRQ2G9YuBqsaad4/ltct7+ffA0lVYeHLMzoJ9gb3nIbmkxB
 gI0Q==
X-Gm-Message-State: AOAM531HAj0Uo91q66UFKlgKglMvZ9QPzBrogsJkSBCfl7JPHcNdsDKM
 JBEjSbjoulAKPDjJ10g9tKk=
X-Google-Smtp-Source: ABdhPJynf7DY0LVhhpxg+fogXgaFV7eW4l89QOkGsiSk1Hlj4wQXTdXpUUgKcoU+JptHcaPblqIyjQ==
X-Received: by 2002:a17:90a:5211:: with SMTP id
 v17mr10602089pjh.200.1604894445290; 
 Sun, 08 Nov 2020 20:00:45 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id x26sm9299005pfn.178.2020.11.08.20.00.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 20:00:44 -0800 (PST)
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
To: Keith Busch <kbusch@kernel.org>
References: <20201108040903.8185-1-bvanassche@acm.org>
 <20201108082403.GB40741@kroah.com>
 <20201108223152.GA2219646@dhcp-10-100-145-180.wdc.com>
 <8ee7a7b0-5be4-99a3-7314-77d784e2ebb7@acm.org>
 <20201109023544.GB2219646@dhcp-10-100-145-180.wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <90da3071-0d73-f007-5892-d683de71d964@acm.org>
Date: Sun, 8 Nov 2020 20:00:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109023544.GB2219646@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201108_230047_631497_9C0EF4E3 
X-CRM114-Status: GOOD (  15.29  )
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
Cc: Greg KH <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/8/20 6:35 PM, Keith Busch wrote:
> The only user space visible artifact the driver creates on bind is the
> controller character device, and access to that during a reset is
> handled by the driver's state machine.

Hi Keith,

Is nvme_dev_fops associated with that character device? If so, in
nvme_dev_open() I found the following:

	switch (ctrl->state) {
	case NVME_CTRL_LIVE:
		break;
	default:
		return -EWOULDBLOCK;
	}

Does this mean that nvme-cli will succeed or fail depending on whether
or not nvme_reset_work() has finished? Isn't that something that can
cause trouble if nvme-cli is invoked from a udev rule?

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
