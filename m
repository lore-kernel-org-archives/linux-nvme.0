Return-Path: <SRS0=3UZ0=PO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E89C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 15:19:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A30BA60724
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 15:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A30BA60724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=oo3Gv5T51GZLs1ces4W+hml+4X
	Jd3piTHR0NrQThKqVhjSbcNh7uZ2FUmQXItqrPuChjQy7Utq7i7IgFbIUEyPj9ttN+T/BIh2oHRqF
	pFq6KMUXoav2sWnZCTlJ0HHJqGs71bdHu03nfGnio4aYrsoyP/rqbCJmhTE6MAJ29qHpEcnNJRnGM
	za5k/TaPWiktBHl3i4PoZsXPdYx9JB/0menzs7JmKsDRDuSkzuB2MjFa5KoYl8KYNfzbIwpTeuKfn
	SI44yUpg9969hJUBMP6nou04/zLRno6ESCsNOc0jBZPHGcNZNmfU9EPXjeEDKuk/3UP5tI69Gjvzz
	+3oEBLsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfOE4-0028Rj-0j; Tue, 26 Oct 2021 15:18:56 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfOE0-0028QB-UP
 for linux-nvme@lists.infradead.org; Tue, 26 Oct 2021 15:18:54 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 j35-20020a05600c1c2300b0032caeca81b7so1321239wms.0
 for <linux-nvme@lists.infradead.org>; Tue, 26 Oct 2021 08:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=0+EMnPy7Bkwq1BinwMYD20pS+7BsaaXhYwdhwGV6aU24tCH5g/jW7/dPAz/opn3YbL
 Z72HR1FeaZVMWlZ3JzzVYn6moRSpKA4v1tVsba/rB6puHu39AKKF9PWWiz6M+m9zKPri
 Wa+xu7/5FaA+BgkDqHvmNanq0txAnPy7jQqBDwkuNHdQn2H28W7lYe7eoAuxjImlz07T
 869u8ZVuS7wTLbT/TseJcuu25bcV+uUFSiSDzSWWb2n6rGXYxvvjs5i5aocpgJSmx0DT
 xpW7KbnmCt1hBPWVlROcI6OLtUwzKtXytL+g2VnEMH2Gy4vZX4FovtMHPzUkJTPi35E+
 CKRg==
X-Gm-Message-State: AOAM530YsqlNkQm7QJWOXxSW40KXGhUoy03lliP72hOY1i7qC/mymIwX
 1GEFODiGXL1S0KxBi2ABq1TJbMF47mk=
X-Google-Smtp-Source: ABdhPJwHZAlj/V5tTuA2RTMWrkue3i2Y/Yub1u+o+ivhJPyMTtpcG4VDF2Os38NEXX8jrti5YOhBFA==
X-Received: by 2002:a05:600c:1d05:: with SMTP id
 l5mr28297352wms.97.1635261530904; 
 Tue, 26 Oct 2021 08:18:50 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id p188sm870279wmp.30.2021.10.26.08.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Oct 2021 08:18:50 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: fix possible req->offset corruption
To: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <1635255115-3028-1-git-send-email-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0ec950e8-ad3a-0c50-1e7a-2a413d385447@grimberg.me>
Date: Tue, 26 Oct 2021 18:18:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1635255115-3028-1-git-send-email-varun@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_081852_996354_1127478C 
X-CRM114-Status: UNSURE (   8.30  )
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

