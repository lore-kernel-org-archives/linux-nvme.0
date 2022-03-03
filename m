Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E07C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 20:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W427vGVOP9COvIncLQi5lkNxw4mE4Ce/dWUY7QiH0Xg=; b=2AUQESBd39r0DIAmF+aZ4a2q3H
	BQsfoJ40jyAWLDXp64xJnPk9Ue0Rk/SdICCfL2spVfwasFQMXN4u+uhvQJ2M+REzrjYWicCP1BNBi
	YRrNUErhKiAgNsHaKE8jWz3sUUGsHRjfd582rfv35RX/UMCr7m7fBwADi9LLu7EJLVIxcJbUENwk/
	T0zThWCGRFkI1xO6xX9RtnymEGXlzQVodYo+Jygh9zHRFMH7YSgpm7vzn39HWjt1jpYU2pxyLMCUd
	W35bF+iBZXnvI6ioIzT/6Rp58l91ritHlAeEXdwHryy+6qoC6ZjU8IWdF7220qoHl21jTScLVu+NC
	q3QykwZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPsNG-007l5G-Ff; Thu, 03 Mar 2022 20:48:34 +0000
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPsNE-007l4J-7U
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 20:48:33 +0000
Received: by mail-pj1-f41.google.com with SMTP id m22so5724660pja.0
 for <linux-nvme@lists.infradead.org>; Thu, 03 Mar 2022 12:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=W427vGVOP9COvIncLQi5lkNxw4mE4Ce/dWUY7QiH0Xg=;
 b=TKeI6vP6JVTPpkZb6V5rThAsH+InuvOtoCk1WT9cPlQf+24cJDVM/T6ge69iD1IS+7
 ZrZKizRv45duQ/cc0LuhKeeDT1MIyOLbNwq+aZnkeZvIoFGkvPhaafptUYXpNhaOF1/Z
 Kckkwp6hx+01CthGsyQi1InEUq0z81Fq7Rhm6ct1Jcpx1SEfgdJSWe6U9W23E2nLGP+u
 Ok0V9GeNe0VOkNfoDf3UZA/+H7rXu7a+JtbrB+S2whFlaoYaHclmjh11vSNRcLUuSBJ9
 yq2WdyUcJpzcphdtJkG+Gq+k0XQA27bPeyLwmp4YqMBPE/Y/L5fljHZ9gJIaJaBrMzUl
 TyuA==
X-Gm-Message-State: AOAM531owfYlY1+ulu7/tf7i45t5JLXLc8X6w4yyd3HvcA1nx6yTn7fB
 lO+Fq9whhzZBOzpnh83DXBk=
X-Google-Smtp-Source: ABdhPJxfF/clBtd6VN69ha8tFxwXtqt3Q8ovp5PNA9jYR15BiWZSha6oKrI3dpXe9dRFfVNKHE22iA==
X-Received: by 2002:a17:90b:789:b0:1bc:293c:1445 with SMTP id
 l9-20020a17090b078900b001bc293c1445mr7232867pjz.111.1646340509303; 
 Thu, 03 Mar 2022 12:48:29 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd?
 ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
 by smtp.gmail.com with ESMTPSA id
 lx7-20020a17090b4b0700b001b7d5b6d10asm2782399pjb.48.2022.03.03.12.48.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Mar 2022 12:48:28 -0800 (PST)
Message-ID: <52af105a-8b89-518f-7663-84163788f66b@acm.org>
Date: Thu, 3 Mar 2022 12:48:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv4 4/8] linux/kernel: introduce lower_48_bits function
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-5-kbusch@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220303201312.3255347-5-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_124832_304195_F6CCBAFE 
X-CRM114-Status: UNSURE (   7.29  )
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
> Recent data integrity field enhancements allow reference tags to be up
> to 48 bits. Introduce an inline helper function since this will be a
> repeated operation.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

