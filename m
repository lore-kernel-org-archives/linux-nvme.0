Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7137FC61DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 21:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xVoiwKuQauSls3sj/0rXsJhCeUzgbFN8E0xpvwNfE+c=; b=gZW0GPyB9RFZniXOzLlIFV7TCv
	iR369it0la1PL5sWa7RTO+T51pk9EYzBlR6rOvVklqvIG/GkU8tOdrj4fSw5t2n8x/jz4iWCeYOcK
	TWMZPfnCPsotNMv+lATpg3jAMJ1IDi9c1onwyyIcMa4/bzzZp4AhFi8FiINBMt+EUS3aFRPGzgnsy
	fURqMXbLGkZyuzsHlOOyIMSJo6KFyHpQEkg3IdkjMAtvnvww3sagStti+LeoeA7rtD9EoPSsjKnGj
	JD+1OO7ia1179zAvjjEYvcos3Kizm3MbbDUK1X14La6INI+1lKk5iEEo4mDEAlfHh+ERU3IxQXk9g
	T4JGKDDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0mfH-000000085oW-01ZR;
	Sun, 30 Aug 2026 21:02:07 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0mfE-000000085oB-1ROm
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 21:02:05 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482ea739de2so1650251f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 14:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123722; x=1788728522;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xVoiwKuQauSls3sj/0rXsJhCeUzgbFN8E0xpvwNfE+c=;
        b=PNQS/0RAlu7K7avwwDSDzuBdWWoy6zFnDHA7hW7c5g0pj/3CO9I2SC08m5dXdN1swz
         r7rtzGUfBBn9hvqbLHKx5UsUgcruU9Ihm4s8jT3rBi52TQwob4U2JhbXrUcs8MGRQYb5
         CsIreuW4r1L//otAKxICH1s5x2DSd2beUc6qSUe63xQ4O1ALDSMo+ULxj/csBajFRbz1
         xuKMcOf83+50VmumBFMR2MPk/PxILrDKpIY3G/tUQmDx3QJs8lmiyxkCqFbpIo4uDobA
         K8BEDcVH+KoVoAkNWt+icJ8Nen5GqqjCuw46/T4yHcOcmKGHjzN+xUeNM+EPOEdjVAB+
         yEcA==
X-Gm-Message-State: AFuF++kLM48b4gOApskiZo6nbwTt5+58vUqG9IqMpWVTtyrqTGKVsgEH
	3oKfJ/lTofrQx0rzuvEJyLdAEtVC6OVTndTHLQwu02k34Dbyhu5iZmBq
X-Gm-Gg: AR+sD127DwX1dHmvXUE68B6oQiumFr4t9CG05A+m6ZX5TxbqkZw7aN9HVXQJsW+6EP7
	pGSkErvzrdqqpUfPn49zD7Lp7LREiQV08puDFr1LFz5qpzJfCmmiR7tUG/9H9GqopBB8K4yis3N
	Nn6/c7DKe8s7/A92pWbVeWvsC6kKCS/AMmzjEHiAO+ttaoR0t/jggB+qiDui8eI/NNIEQWN7/yz
	q1RTOtNTQcDeTXoIVeq4Wcc/ANuvDa6YPsu9jdiOZBa4w95Ye6opzwhJ+ccVZ0gBdVCD4+ZS3h3
	MboO7jevFkdgxTMdwnbCRp1opxIA+SkZHIwmzn+OP76Lk0jiqQpqdpvLVM/m91KIbr01K39eRDm
	4yCu543Whb3r9MFdk1W4fTfYwlQpF2sok/G7VhFlgZkZCO8MHkpTCaM8qCfdqaUZban6oTkG4WB
	8eOqwM/L5OyFErShjUkDrGFWg+arwCUdHFHHMgoKsSvfUIzwBsYKLhmXf2C2xY+krE4KZOCuOoZ
	77UuivmJ2T9/bQuxa++Tw==
X-Received: by 2002:a05:600c:1c0a:b0:493:bd2a:93be with SMTP id 5b1f17b1804b1-49b91c276efmr352047355e9.6.1788123722135;
        Sun, 30 Aug 2026 14:02:02 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd8148fbdsm6020305e9.3.2026.08.30.14.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 14:02:01 -0700 (PDT)
Message-ID: <47082c12-bda4-46b0-baff-3330e98e7c46@grimberg.me>
Date: Mon, 31 Aug 2026 00:02:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet-tcp: report a bounded MDTS instead of "no limit"
From: Sagi Grimberg <sagi@grimberg.me>
To: Alfonso Kuen <gerencia@idkmanager.com>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260828222356.1264-1-gerencia@idkmanager.com>
 <20260829013900.10392-1-gerencia@idkmanager.com>
 <a1770149-e633-4a58-af06-849da27fa7cb@grimberg.me>
Content-Language: en-US
In-Reply-To: <a1770149-e633-4a58-af06-849da27fa7cb@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_140204_395653_FFEE43FD 
X-CRM114-Status: GOOD (  14.50  )
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



On 31/08/2026 0:00, Sagi Grimberg wrote:
>
>
> On 29/08/2026 4:39, Alfonso Kuen wrote:
>> nvmet-tcp does not implement .get_mdts, so nvmet_ctrl_mdts() falls back
>> to the port value (0 by default) and identify-controller advertises "no
>> maximum data transfer size". The initiator believes it:
>> nvme_init_ctrl_finish() sets max_hw_sectors to UINT_MAX.
>>
>> What the initiator then issues is decided by the block layer. The
>> generic cap is 4 MiB (BLK_DEF_MAX_SECTORS_CAP), but a namespace that
>> advertises a large NOWS raises it: blk_validate_limits() takes
>> max_sectors from io_opt once io_opt exceeds that cap. On the array we
>> measured, NOWS is 65535, so io_opt is 32 MiB and the initiator emitted
>> 32 MiB commands -- from a controller that advertised no MDTS at all.
>>
>> The target cannot serve those, in one of two ways depending on the
>> kernel.
>>
>> Since 4a3f00262a04 ("nvmet-tcp: bound SGL data length before allocating
>> command buffers"), nvmet_tcp_map_data() rejects any len above
>> NVMET_TCP_MAXH2CDATA (4 MiB) with NVME_SC_SGL_INVALID_DATA | DNR, so the
>> command fails hard and deterministically. That is the right response to
>> an oversized command, but the initiator had no way to avoid sending it:
>> nothing advertised the limit it was exceeding.
>>
>> Before that commit the command reached sgl_alloc(), which for 32 MiB
>> needs 8192 scatterlist entries -- 256 KiB, an order-6 kmalloc. Under
>> fragmentation that fails, and it surfaces as NVME_SC_INTERNAL, a generic
>> status, so NVMe multipath does not fail the command over to another
>> path. A 1 MiB command needs 256 entries, 8 KiB, served from the
>> kmalloc-8k slab, which does not fail. That failure mode is intermittent
>> and load-dependent rather than deterministic; on a vendor kernel
>> predating the bound it cost us roughly 98 GiB of a 2 TiB image copy,
>> with the copy tool exiting 0.
>>
>> nvmet-rdma has advertised a bounded MDTS since "nvmet-rdma: Implement
>> get_mdts controller op" (Max Gurtovoy, Mar 2020), which left the other
>> transports untouched.
>
> Nit - instead of this patch reference - you should simply say:

Commit ec6d20e16c2d ("nvmet-rdma: Implement get_mdts controller op") left
the other transports untouched...

Other than that looks good
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

