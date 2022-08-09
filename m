Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F69BC19F2D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Aug 2022 19:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GB5/gpb1OgcApv3VLaq+R+qJBjIrW8t5fst4dgp4M/I=; b=YvWxjY9O8DBSiDjqC8C13dC75y
	OiLK36qrBF07sz/ungL8/0AmMgp/7VUhgvcxuyZKgVu+TeyvW8eWDoa71RuIVajh+LV++iIhEAcW+
	e09MeAJ6j4qs1yCviHmG2PpbzEmVKj6F/Z4KbcJKVZgVsXcBbB1VdVMZxhqDbGZDrg668DvN1hfce
	gwGSHPuV22D5wDPvkhrrtTlPv0HXYmJNe8B41OMoUsG/p7pVRi3B9BGLvOdczD5aroUNDlvkgobL8
	bgfPIviZv6YBvSwMuQn89ImTTHlmmRCPdxRSORenQfJx7/cXgIbqjoYnNIr1BiSzYxUoAWTERWgbD
	ykPq9g9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLUon-005oOk-NZ; Tue, 09 Aug 2022 19:23:09 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLUoj-005oKx-3H
	for linux-nvme@lists.infradead.org; Tue, 09 Aug 2022 19:23:08 +0000
Received: by mail-pl1-f181.google.com with SMTP id 17so12210331plj.10
        for <linux-nvme@lists.infradead.org>; Tue, 09 Aug 2022 12:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=GB5/gpb1OgcApv3VLaq+R+qJBjIrW8t5fst4dgp4M/I=;
        b=XNUoKnMDBi/0tVc2zZLUKlRaR8Y0J5icgiALU0DpE8hr0/Lwrr9bOjEbzVLqqtjNWM
         lfO1+0m5h9UMhgrLyosQqrMaf/4MTYm89XODkXYbIpbil3jBMVi/lkEHSGuvSB0ewLeS
         dmj3DxZwYqINJJW1FZzBdbcDi1ONm4oRWHmsHXxxKOQamelBK/WoOLbewzJkml0PV61G
         Dr2HEwK5wOMm8aQWDzEat2G9bHu0JfXdsGo45pOLigeItEw9CVkhRYU3tNgdw2F8Npj4
         J9uPWMVtsx43cXIlzPhZ8bOtZj2z13wRkj4UpPylYiJPbC6Nl5CrnueryYnqsdQu84pO
         bLTw==
X-Gm-Message-State: ACgBeo1awdfScmY6qgZYrWseSbxPSlP6bBXm0ykYz/eyB+uE1Zey9ZvI
	kG4voholSFDJfKUzDMIDuRajkNRBd9U=
X-Google-Smtp-Source: AA6agR6wXr3LrU89unpnzRfKNnDFJjzXPc1yphMgotIaMLByFlUYhvhPY4knSiM+7DE0jLsYRY8xmQ==
X-Received: by 2002:a17:903:447:b0:16e:cbe3:29de with SMTP id iw7-20020a170903044700b0016ecbe329demr24670117plb.65.1660072982212;
        Tue, 09 Aug 2022 12:23:02 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:61e9:2f41:c2d4:73d? ([2620:15c:211:201:61e9:2f41:c2d4:73d])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b0016fa99912d7sm9213472pla.141.2022.08.09.12.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 12:23:01 -0700 (PDT)
Message-ID: <5cf33826-7dc7-7af4-c3f3-b4631b78c93b@acm.org>
Date: Tue, 9 Aug 2022 12:22:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 02/20] scsi: Rename sd_pr_command.
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk, hch@lst.de,
 linux-nvme@lists.infradead.org, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com
References: <20220809000419.10674-1-michael.christie@oracle.com>
 <20220809000419.10674-3-michael.christie@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220809000419.10674-3-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_122305_211124_548965E0 
X-CRM114-Status: UNSURE (   9.41  )
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

On 8/8/22 17:04, Mike Christie wrote:
> Rename sd_pr_command to sd_pr_out_command to match a
> sd_pr_in_command helper added in the next patches.

No trailing dots at the end of the patch subject please (this patch and 
other patches). Otherwise this patch looks good to me.

Thanks,

Bart.

