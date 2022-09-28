Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9E9C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 20:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NpdsHQEIDdCIsjS4rJOXdQLGW1MVZ2l8Zrf9pn/IUAM=; b=EBbMa15zeto/X9Jb7GlXesduzX
	kTiJjDEfkm9V6Rh95GedlkWJXzZeJRslRwsU2t67E9CGDm6Z7kn7hD2qESQc1XKDSr1A+TvgPAcox
	14Cu5xIwCJagZJqge5qO8LPZbCkO5hB8sxxgfZydWXRpwdeLasOOIpWOFDeNWbG+HcEPyU46dSI7W
	uId2f5ERHfEyB6i8Kos5IgNzak5zRCGWusyiU5dOpE7ykvshTMUIeeU7NcwVfe8MNW45/ReVJtQ2j
	vELUpp8cS3sV36wHJFt4q8BuG6PX8huQDibYAn6Q01T78URXRscwJifv2O0JaRF/8tNqN+NmLLywM
	lBSIf38Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oddKO-000Fn3-If; Wed, 28 Sep 2022 20:06:44 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oddKK-000FjS-HM
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 20:06:41 +0000
Received: by mail-ed1-f54.google.com with SMTP id v4so1385946edd.5
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 13:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NpdsHQEIDdCIsjS4rJOXdQLGW1MVZ2l8Zrf9pn/IUAM=;
        b=I+8GHSIxAWHbxISwPpePBRqAM5EYRebxVB4YslvqmlxBy4is4fVOkqCvyAUrjPv29x
         hoqcRKp1Wu54fa07ajAHbqj3JhqLP/mZ4WLxXuYx4GpgNT06ZkZr+FD88uo8gDNsnEno
         mtZixMUI/cv2iFmKl22TBIsdxCM+lA6OY4KeM64oqZdJR1MaohPvgW+wo+8EC37A6ifW
         8FkSafUrhZQ+9ISjBXgNfQRJ3O+fFlLgukPL2NNRLCgeGin4lZTpkP9u9pAvzX6vrh2b
         yHc39X1kCzVSj8GFLjaY814MWUzEZH/2mH2lZeLXNl61mSU7EOFG1Ou0EraaIIcD3gS5
         rcEA==
X-Gm-Message-State: ACrzQf2CnPhX0nRq7uDoJGt3r2A9r2xNrrhZiC43TkqyVVrJVeHiYEzT
	50ZkLI/iPSNwd8/EC2b14kM=
X-Google-Smtp-Source: AMsMyM5PJoycU8Ui4fhjygiqFC952OSDs0u8VL0XFbztoo/Ua4aXNcqWvGaZBqQN3070m8SCzwC/mQ==
X-Received: by 2002:a05:6402:40cc:b0:452:697e:da18 with SMTP id z12-20020a05640240cc00b00452697eda18mr34024979edb.288.1664395597966;
        Wed, 28 Sep 2022 13:06:37 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906318200b0078116c361d9sm2891417ejy.10.2022.09.28.13.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 13:06:37 -0700 (PDT)
Message-ID: <79fbae63-f41e-c1ec-237c-11befc85990b@grimberg.me>
Date: Wed, 28 Sep 2022 23:06:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-multipath: fix possible hang in live ns resize with
 ANA access
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Yogev Cohen <yogev@lightbitslabs.com>
References: <20220928135816.132213-1-sagi@grimberg.me>
 <YzSCoDP2PO7jIRLT@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YzSCoDP2PO7jIRLT@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_130640_625267_54DF1E45 
X-CRM114-Status: GOOD (  11.54  )
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



On 9/28/22 20:21, Keith Busch wrote:
> On Wed, Sep 28, 2022 at 04:58:16PM +0300, Sagi Grimberg wrote:
>> @@ -172,16 +172,18 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
>>   void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
>>   {
>>   	struct nvme_ns_head *head = ns->head;
>> +	struct nvme_ns *n;
>>   	sector_t capacity = get_capacity(head->disk);
>>   	int node;
> 
> Cosmetic nit, the new declaration ought to be below the capacity line for
> reverse-xmas tree goodness.

Will do.

