Return-Path: <SRS0=qcAl=45=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE66BC10DCE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 06:37:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A947120575
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 06:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q3An+HBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A947120575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=q3An+HBI/3C5IQM3NW8FfGynF
	c7qbbH/1m6u+/ziXYJ+OYeOvWLByfRgGpMJ8ahrfMFRM7e5b+3sJUuYOAxgZrU/5UPOaLSVE7HSzJ
	G/Gc+Wpf0jOJLjfoFdk4jEfyggl9kjhGcfAM/h9/EVH2g3m/FywnQm57H+d43wMZIjcKiSYvFEaen
	H5pKBQ1SjWAxF1h37EOJWo3uqfEOP0WjtyFzQjuJjjiwXRwIme2bNIHAD79HkYNoURXI6AMgTvkTN
	u0Wv0pKE27+pIWCSoW27bHDdhPbud1srzJnIduKIh7PJTfuUdpEHPQoqQwM6pxPjX+tN7nigYJBFR
	kIC3Oo7Vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCHT9-0007JK-K8; Thu, 12 Mar 2020 06:37:23 +0000
Received: from mail-pg1-f176.google.com ([209.85.215.176])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCHT5-0007EQ-1J
 for linux-nvme@lists.infradead.org; Thu, 12 Mar 2020 06:37:22 +0000
Received: by mail-pg1-f176.google.com with SMTP id y30so2534031pga.13
 for <linux-nvme@lists.infradead.org>; Wed, 11 Mar 2020 23:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=J6VToM9bpOlvVLFscipjkpXNtN16/I8gTkbLLujCtE96glbRXo/ED9WjX+XaReyTcN
 N23Xz6jG3+x6SA8vXFPn1ay5yCkTtXMOq0qMPS5zhfLXMmGSFZ5Niqh/SyxbO5b5DDUu
 NoJifzkBfLTLZAv5IqPa9qljJ0DuEj/9JcXJlfZMlhWL7JrWmLLKHAf5auSNKyvsMnck
 IhKAqrzeivMjXj0amj5T5gfjOim33yTId+fj5mUO96WJFQ76M0OD1MIEcQmNThW4+y2L
 giX4EMAtK7H/hbbovxlZu0I45tJGrfYovqsftDZ2wiC3DmtnyQjaHH7Pa56XleXQK0Td
 D1iA==
X-Gm-Message-State: ANhLgQ2gctb/OCqTbxMre8LM2jrJwIpkBWJWymaaJy5uvmp9pHky2C8C
 Qo9uPS+K+qgJRVdMgr1NZl0=
X-Google-Smtp-Source: ADFU+vt5jqhXNaC1esdhtMXCbblzuafRqUwEwHAMh5XY2OvX0L/QVBJN5lHRTPz7uYc0r4h6qZHkDA==
X-Received: by 2002:aa7:9416:: with SMTP id x22mr6782981pfo.100.1583995037663; 
 Wed, 11 Mar 2020 23:37:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c47a:8519:9343:83b8?
 ([2601:647:4802:9070:c47a:8519:9343:83b8])
 by smtp.gmail.com with ESMTPSA id fh24sm7545842pjb.37.2020.03.11.23.37.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Mar 2020 23:37:16 -0700 (PDT)
Subject: Re: [PATCH 3/4] nvme: Remove unused return code from
 nvme_delete_ctrl_sync
To: Israel Rukshin <israelr@mellanox.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
 <1583938849-5787-4-git-send-email-israelr@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a8a97c36-c650-1059-2601-48fa2f1f2ab6@grimberg.me>
Date: Wed, 11 Mar 2020 23:37:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1583938849-5787-4-git-send-email-israelr@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200311_233719_083382_EEA131AC 
X-CRM114-Status: UNSURE (   9.05  )
X-CRM114-Notice: Please train this message.
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
Cc: Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
