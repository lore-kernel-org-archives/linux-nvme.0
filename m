Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DFEC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 20:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2sMm3zKjFn7LlHJVewiz0XZSHIpv45FgabOoDcCOG2Q=; b=qQjU4qpTSdV/SRfOTtuVYa+nxG
	wgZhOj7OTLFGtPeAJ14PYQko+G+Umn6roHluAZk0GYGFQE5qpWknkv7Sow2tAC84dS5qYiwG1hyBe
	5wYTe8DuTN5zFnXMIDksPNa/ePZo/N2RuFBug7jrCzIb5PO79QZImYeixLrYVBGno9SNF+0j7T/YU
	S9bb2r5lx/Cg4xrs7QJSHLhDgwQuxVa5cxCdVX19C+05FkpqdYEiBjPaLDoBrUp0PTfjmSRpiVK+L
	YdqCJ8dJBou2M7M+U8Q51L4Qxt3UBx/N8E4WNhdY3n5djXP35SLxLGuuhlUaOat3VBlNvVQHT1BId
	E3ZaBa3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPsMe-007kzs-JU; Thu, 03 Mar 2022 20:47:56 +0000
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPsMb-007kyh-Sd
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 20:47:55 +0000
Received: by mail-pf1-f176.google.com with SMTP id z15so5771041pfe.7
 for <linux-nvme@lists.infradead.org>; Thu, 03 Mar 2022 12:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=2sMm3zKjFn7LlHJVewiz0XZSHIpv45FgabOoDcCOG2Q=;
 b=cLBx2SJ+hlshPCql/vQ1fH4gzMEbyNELs2UyUXwA98u6EctNeGwBLoJoKqAJsoI1Vd
 XcpuACsH19LdeA1pcDT+vDc/wphTlzVFV//kzQq/kJnvxoAGfC+ClVgUe8fJznqaUIXk
 mXwoYDkN8enMrjNu6y/KpQctjqaUtv+KxA8XnpjYX5pSQ1cXjbFNgaCKwGtFGdCviZxj
 2qZB1Pu6XQ8+Q8YeprzMaFV99AjX5WAsQV0DaM3A+IayKpZmJCz4fzj/x09zM4e9ccl9
 kI9bv4KBj/bRwxPAY4axG2kEAOBNpdtp/zUrSq1+HPjglOAWNSRXn9O+2LCgWpggw8Gf
 OWag==
X-Gm-Message-State: AOAM533cvwgAnwK+T/H19KSarxnIeTm7NOEDSWh6oZSGGPQhNTlqQNdG
 XujKLUoBxdHzz/J9JdfMlTs=
X-Google-Smtp-Source: ABdhPJx69LPAUR7oygj04wdfE1hMPOo9j+ay8mVCgE6nTUZhfmcZ0TUOUMGoZwbD8HVR7CUIdnA/+w==
X-Received: by 2002:a63:445c:0:b0:375:9c0c:c360 with SMTP id
 t28-20020a63445c000000b003759c0cc360mr30120816pgk.588.1646340471388; 
 Thu, 03 Mar 2022 12:47:51 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd?
 ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a17090ad59600b001b7deb42251sm8622898pju.15.2022.03.03.12.47.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Mar 2022 12:47:50 -0800 (PST)
Message-ID: <c5329139-1680-7170-0dee-7ed4b6ccbd30@acm.org>
Date: Thu, 3 Mar 2022 12:47:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv4 3/8] asm-generic: introduce be48 unaligned accessors
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-4-kbusch@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220303201312.3255347-4-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_124753_955370_14271E39 
X-CRM114-Status: UNSURE (   7.00  )
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

On 3/3/22 12:13, Keith Busch wrote:
> The NVMe protocol extended the data integrity fields with unaligned
> 48-bit reference tags. Provide some helper accessors in
> preparation for these.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

