Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8881FC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 16:11:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0C0608FB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 16:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B0C0608FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hfy7Gp3+JeXESUrx1Gbx2zkhaFaWF3TcaVpxpcqkTgE=; b=uHw0DaJ65BFMJVo8FYCF2dN3Um
	PXOdiTjOmMK2Zlmf5br4J7TatWnA2AkX/YPIrDHLu5x8RVJIRwh0dAD+gAjQR4NFj4GKqnO/rVJdd
	LPZmhD7EK1WisVPaf+SMlUR//qdqiRd/BuzXbSgZjVKPdj6nZTp/8tpERs6y80FeLPmWlhnMfmgPt
	7AKuNfXN3AfEng0Oe6x63PMCEcakwGVQ3rzISdDMWMvxCdPo3wLvyQej6TgqmKbctAlSKve+HU6nH
	hahZDCiQL/7rxou/5Ax+Rozwc5WY9CsJSMJ0yjAm+U4rW5H+hMZ9dRlxTEhh2g0To4inKuBuj8OUk
	hHt3MjbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnNWj-005fqZ-Ny; Wed, 17 Nov 2021 16:11:14 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnNEt-005XG5-5i
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 15:52:48 +0000
Received: by mail-pl1-f180.google.com with SMTP id b11so2497291pld.12
 for <linux-nvme@lists.infradead.org>; Wed, 17 Nov 2021 07:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=hfy7Gp3+JeXESUrx1Gbx2zkhaFaWF3TcaVpxpcqkTgE=;
 b=4AGsyvaZvkEPg4vmD/Jk6728UwPVgGLJ8HAz361jw9W6WNR34dz9UU1deRx46MK4bp
 sOrNDFdWZq3NJNpRHb2JBPST5VQLCbAmgqLT9G0omDVYab0b/FybjJXvkZY6RGMrthLH
 71DBqQqWWdKrINc4LZpI6/DT9S5i8p00RPW924e3QTJfdEzzwGt42BXW5CSaqwRoaoFW
 gsA2YM1xNgBxRoIhIvsT5PTVaq0JT657u2O1fAq254MWPmS8UPXpbrFAiyOgNi4YNd7N
 ltPsT1BTPp09FIRQX06eBc7Onifm+LC2jkRWCRqlVtbcTjUucyEFXp3iROn3CRQiZ5zO
 oGew==
X-Gm-Message-State: AOAM532ADAy55+ggYF8Ad8i5cmXGFqB0PzBjno+MH8/qOKPN9WJLvWB+
 GxZDcq0B8vKeuHXl3LzzNIc=
X-Google-Smtp-Source: ABdhPJxm8WqyX8LthpnLwyvUjiFp2PmfTmFgScb1CA1TW0//yPGqt3+fmIM8D+HX4+Lp5dSpUb7G3w==
X-Received: by 2002:a17:90a:d70a:: with SMTP id
 y10mr855973pju.36.1637164366198; 
 Wed, 17 Nov 2021 07:52:46 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd?
 ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
 by smtp.gmail.com with ESMTPSA id h196sm71706pfe.216.2021.11.17.07.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Nov 2021 07:52:45 -0800 (PST)
Message-ID: <553c2a78-1902-aa10-6cc6-a76cbd14364c@acm.org>
Date: Wed, 17 Nov 2021 07:52:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Content-Language: en-US
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "msnitzer@redhat.com" <msnitzer@redhat.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "roland@purestorage.com" <roland@purestorage.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "rwheeler@redhat.com" <rwheeler@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Vincent Fu <vincent.fu@samsung.com>
References: <20210928191340.dcoj7qrclpudtjbo@mpHalley.domain_not_set.invalid>
 <c2d0dff9-ad6d-c32b-f439-00b7ee955d69@acm.org>
 <20211006100523.7xrr3qpwtby3bw3a@mpHalley.domain_not_set.invalid>
 <fbe69cc0-36ea-c096-d247-f201bad979f4@acm.org>
 <20211008064925.oyjxbmngghr2yovr@mpHalley.local>
 <2a65e231-11dd-d5cc-c330-90314f6a8eae@nvidia.com>
 <20211029081447.ativv64dofpqq22m@ArmHalley.local>
 <20211103192700.clqzvvillfnml2nu@mpHalley-2>
 <20211116134324.hbs3tp5proxootd7@ArmHalley.localdomain>
 <ab4ec640-9a89-ea25-fe68-85bae2ae5d8d@acm.org>
 <20211117125224.z36hp2crpj4fwngc@ArmHalley.local>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20211117125224.z36hp2crpj4fwngc@ArmHalley.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_075247_249252_CFDC9477 
X-CRM114-Status: GOOD (  10.50  )
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

On 11/17/21 04:53, Javier González wrote:
> Thanks for sharing this. We will make sure that DM / MD are supported
> and then we can cover examples. Hopefully, you guys can help with the
> bits for dm-crypt to make the decision to offload when it make sense.

Will ask around to learn who should work on this.

> I will update the notes to keep them alive. Maybe we can have them open
> in your github page?

Feel free to submit a pull request.

Thanks,

Bart.

