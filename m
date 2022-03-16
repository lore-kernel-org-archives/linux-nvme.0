Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DA5C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 11:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X3jw9w3ITJcYSRiUxwXSALrb2HX1/qI4NyXGsKOE6sQ=; b=2gfqVjgw7DEQ2+2hG6+Lm5lz94
	xf8ycP9GPwUZl5vie+xDmXz0xDUeMislWktbvynks5IAuVHfSNiOklQYFucujyE+a0SGl0q+9xMW5
	eb5b6Rt2ECv88dGwtc8wVJ1NC+GRtmY/1sQrqA7FSamMlsK5sgNLkCGrDbGdjooMOcKjaLXixninC
	k6vQWzY2+zA6IdNIKhb5/j4EFpXNfoaId+YvAx4kyDuhox1MhfhRiQ4n9ePNBMlTR9JH905TxShh2
	buVgisHtdL0KxcV5gcxxTGnpXxRyee9XLcbUr6TiwdT8Ibr/k9McpRnVe97AnUbSeAeF1tMV79ruO
	qaOlCXPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUS4T-00CeG7-Cs; Wed, 16 Mar 2022 11:44:05 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUS4Q-00CeFA-BR
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 11:44:03 +0000
Received: by mail-pg1-x530.google.com with SMTP id o26so52079pgb.8
 for <linux-nvme@lists.infradead.org>; Wed, 16 Mar 2022 04:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=X3jw9w3ITJcYSRiUxwXSALrb2HX1/qI4NyXGsKOE6sQ=;
 b=PElglWCpVmJpYPrZ2Bi4Wam92C2GhZFb/hUkFu4S5Lavys2leqNB3AOM/qd14qLTIH
 AnpQimtplkAnIBvNNA2zk2Bk/jS6v+uBdbziDTuCa6enABcpISo+m9iHHDZziBC2W0b/
 UzhMxHULk8fFmd3HvC3VCC6cCu4aAAD/UrVguNcDVBkByd2UAK0Vc/CvW9IuZFWLPeR3
 MpktrPf+Aq3s0ltgye+ikkYrVUEpux9PuyWQOaimwIEoRcU9DxTDiE76405cbTBn9xvX
 9ZRLlsyajhviy/PJ/m0WHRmptg94+JESZcqsmzXs9cfT2VXY6qwJD9S1LPCbUAR77+TF
 MkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=X3jw9w3ITJcYSRiUxwXSALrb2HX1/qI4NyXGsKOE6sQ=;
 b=AlwfHAhTC+rq+fPxXpjaOnjrSVTfvmlIwCGzGtquaGn/7zSL4kRbIMCeujH5DJSTMq
 ax5sgWszGuoT7HvpWl5bxCIvVe0napdnR9DpBjW3VQ2Er0AtoephRUMi349Hk1R1srYc
 sYBQnfGzqr3ActcQ6quwTOTzz8w7h4rZ7WgNl3v9AExwGakZTELZpcSBkmoGfTR4xzXI
 b6szsBNx9NEXBieSv23pbraMlgZzMhnuohSRNU2QMYHJRHXTlPdMf3d2430IkMf5OWu2
 zDSgsHGe6npLP3lNxUopw6LTKz/aWNxu769hgagyvdZG8NO+ScRTHh9WVSgSNN0D7/LC
 cwlQ==
X-Gm-Message-State: AOAM53177pNVIzKstnlOvv7g+7pFqK7IyrveqJl6KErSQohiJ/jxovoE
 +/2WFw60BK7qAzgzSXDq/iSodg==
X-Google-Smtp-Source: ABdhPJyy0Udlinl7bEMkIJYj45RWE+I5oaMZBCpf1Ihx1DjAykjEHFKso7t5UMBQynWzmgh6nWj5kQ==
X-Received: by 2002:a65:48c8:0:b0:375:9c2b:ad33 with SMTP id
 o8-20020a6548c8000000b003759c2bad33mr29224651pgs.232.1647431041007; 
 Wed, 16 Mar 2022 04:44:01 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a637f4a000000b00373a2760775sm2333715pgn.2.2022.03.16.04.43.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Mar 2022 04:44:00 -0700 (PDT)
Message-ID: <527b4816-b266-bcbf-5ebd-e7175ebbc92b@kernel.dk>
Date: Wed, 16 Mar 2022 05:43:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [GIT PULL] nvme fix for Linux 5.17
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YjGxBNRRK/VLVYsF@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YjGxBNRRK/VLVYsF@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_044402_490573_E1AF4108 
X-CRM114-Status: UNSURE (   9.66  )
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

On 3/16/22 3:42 AM, Christoph Hellwig wrote:
> The following changes since commit c2700d2886a87f83f31e0a301de1d2350b52c79b:
> 
>   nvme-tcp: send H2CData PDUs based on MAXH2CDATA (2022-02-23 14:43:11 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.17-2022-03-16

Pulled, thanks.

-- 
Jens Axboe


