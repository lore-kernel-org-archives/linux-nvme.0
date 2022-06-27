Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF343C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 12:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=elgNjSSpHuHdjKLYGZj9G0XDY6ITUKoOmReh9FRBdNo=; b=DuB9JwhXCYo3b//TMuPQ9n0RuJ
	StV8mBB2ojUhlw47fMmG79fXJIUcoHauOtyD7tEcHK4jIUk3iyLCSrYEEw7GQYx8sNd/VCrsPkOWI
	C1VFcTxTCqb8GLxf1BBOy+TgK3m5djpqpcbAbK9df5eqqaPOFlRX4mNEDskcoftQMkLVnM3TJhBOn
	h9x64uN7X6jeR6rOXDGPONfq5moPupbpeA21YOIzKvhQxwESxWNwlK/EfYMV0s0TAQehsBhY64zrm
	zrgzA8kVIAr2vnRzCmXVGjlvY8Onr/1iEqA+fzT4nckP0xmfAyCd/onnt/FkXH7CDBuoNaDx4P9YY
	LA7ebx4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5nmE-000q1n-N0; Mon, 27 Jun 2022 12:23:38 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5nm9-000pzD-SR
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 12:23:35 +0000
Received: by mail-wr1-f46.google.com with SMTP id d17so7180601wrc.10
        for <linux-nvme@lists.infradead.org>; Mon, 27 Jun 2022 05:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=elgNjSSpHuHdjKLYGZj9G0XDY6ITUKoOmReh9FRBdNo=;
        b=FIH/FEnOrYa/duv4XJGdU7peBa+gdMdPlfPt7UFhEdpS7mUSnyF7I88QWfsbFbqsqP
         7xC1Fxt+LWhIO48CQxkJXz15/oKLtFOPB/+HqHc2Y0pe7zyjIVLq3dRh0Y5lgDauXBGH
         NKFiZN2pMMFaA9gPWWyd8IWGk9MUCwbrH+jAUZXaUDh9ljzb7UqjroEdKYUqSzTHwK24
         AP+84ahTLKP2jdnmWubF5T1UnA8rFVUf9CqgR1xUNR+AF3Jm6yuvZ4107qLSlCgG3WFW
         pNyqdKExWQCOev7fTXTSpNEpK+8/vM2FTean9gt3ZiZQor+fILXpvCmjNcuIWreD4CAb
         vbNw==
X-Gm-Message-State: AJIora+f/9GwovBo+RqxtDohXkWBO8VxO/DsI1XbK7q8T2pQFuqoovPg
	zPtF5EkK8OO/m9h5poLDf+Q=
X-Google-Smtp-Source: AGRyM1vCufXxYz2KuGLVv1RVT8vdduv99HC1vKzPS7SztcXVMETNEet/vFa+TsSy5T9/6jTzekbQtw==
X-Received: by 2002:adf:ebce:0:b0:21b:bcaf:e17a with SMTP id v14-20020adfebce000000b0021bbcafe17amr11325433wrn.466.1656332609061;
        Mon, 27 Jun 2022 05:23:29 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g16-20020a1c4e10000000b0039c5a765388sm13197634wmh.28.2022.06.27.05.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 05:23:28 -0700 (PDT)
Message-ID: <bd16884c-25fb-eae2-ad2d-1cbb1ff09333@grimberg.me>
Date: Mon, 27 Jun 2022 15:23:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv18 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220627095207.105201-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220627095207.105201-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_052333_970061_0C479232 
X-CRM114-Status: GOOD (  18.43  )
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


> Hi all,
> 
> recent updates to the NVMe spec have added definitions for in-band
> authentication, and seeing that it provides some real benefit
> especially for NVMe-TCP here's an attempt to implement it.
> 
> Thanks to Nicolai Stange the crypto DH framework has been upgraded
> to provide us with a FFDHE implementation; I've updated the patchset
> to use the ephemeral key generation provided there.
> 
> Note that this is just for in-band authentication. Secure
> concatenation (ie starting TLS with the negotiated parameters)
> requires a TLS handshake, which the in-kernel TLS implementation
> does not provide. This is being worked on with a different patchset
> which is still WIP.
> 
> The nvme-cli support has already been merged; please use the latest
> nvme-cli git repository to build the most recent version.
> 
> A copy of this patchset can be found at
> git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel
> branch auth.v17
> 
> The patchset is being cut against nvme-5.20.
> 
> As usual, comments and reviews are welcome.

Thanks Hannes, will take this for a test drive as well.

Can you please respin the blktest set with additional
tests to fail bad dhchap_ctrl_key?

Thanks,
Sagi

