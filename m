Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F199C19F2D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Aug 2022 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+xNHl7PxIkebq0wdnJhmzor8UqQwWVZACiymdJlxbdU=; b=F4QSeGm3vDm6hgkh8NaZybf93Z
	RRtTM3rezm3i/RGbhPd7R10jkcqWmfhUD+RSvAuiCpcKhM3CggLkCwdRmkufws6L1xyh9uH3blD+s
	Vfx9STbEkYXL+I2iBXg7lhbEgMUObMCRXh/frxkqgdCwuFrAl1gS7Z7WV+GSO3TD5OrsuzYxgYkCw
	uWqOSNtiwFNw6a+X+ztJ3iV8qVrBQaOEwxlKse1z/KtVuj99aXNd9IwJ/xY06Y2WnNVrMX90r0KXN
	1h59Tio1MTMsi6V0DtfHZUdHd5ZQ/Qv1rTn8PWFQUbQvEkhH5Wzqrd5CxZtXb3e/RK+Onevhx19T2
	cssn5jKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLUrw-005pnr-J5; Tue, 09 Aug 2022 19:26:24 +0000
Received: from mail-pg1-f169.google.com ([209.85.215.169])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLUru-005pmq-BL
	for linux-nvme@lists.infradead.org; Tue, 09 Aug 2022 19:26:23 +0000
Received: by mail-pg1-f169.google.com with SMTP id q16so12257750pgq.6
        for <linux-nvme@lists.infradead.org>; Tue, 09 Aug 2022 12:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+xNHl7PxIkebq0wdnJhmzor8UqQwWVZACiymdJlxbdU=;
        b=iZthYzq1HfadBQ/QBD7FyN5RuBIzS0JcfZr4oYapA4k2Itt9H3l1Ma4U6Af8c5qmDj
         FSRxZI9eqBXls8KWGxLvvndIzrpwQRYR97m+eqLxVnWsRwCEVdKVbRFp9WYaancMc3Td
         i1b+WlQZygx0O0RSaK9EPdMn2P5tipwctkq5QF1KQ9E5kjZJdK7U6/xjfOSUp5okozI4
         QLvwCN4P8VLopgfXOMhRnPcWyrorRehLWmZ75RJRM0xvcjzFzvZtHtSXzJVIHBALsy1W
         og6dh6CU5aw1wnZvkDZPMADCIgJZN9ZpQz3ZktlWrApfwz/HUt8ncllIBWB6fIvexyUq
         DOgg==
X-Gm-Message-State: ACgBeo1ZNyBDMSISEMOZROsUUvshxph4RqmduyRTdENXNNxwHCWZ7cMs
	pk78V2/v4imcgX+yrfIIVnDRg47iYVM=
X-Google-Smtp-Source: AA6agR5+riNI8OSebOu0oK1S+2g9jxFt9EqMM52CmaUet8riLT+K1RsKhbZTtmktwZP+gN3LNaDlCw==
X-Received: by 2002:a65:6d98:0:b0:41d:d9:a338 with SMTP id bc24-20020a656d98000000b0041d00d9a338mr17501281pgb.421.1660073181028;
        Tue, 09 Aug 2022 12:26:21 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:61e9:2f41:c2d4:73d? ([2620:15c:211:201:61e9:2f41:c2d4:73d])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b0016a3f9e4865sm11221917pln.148.2022.08.09.12.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 12:26:20 -0700 (PDT)
Message-ID: <a3117849-420b-65fb-dafa-c2a464482f7b@acm.org>
Date: Tue, 9 Aug 2022 12:26:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 04/20] scsi: Add support for block PR read
 keys/reservation.
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk, hch@lst.de,
 linux-nvme@lists.infradead.org, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com
References: <20220809000419.10674-1-michael.christie@oracle.com>
 <20220809000419.10674-5-michael.christie@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220809000419.10674-5-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_122622_415365_13660997 
X-CRM114-Status: GOOD (  10.52  )
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
> +static int sd_pr_in_command(struct block_device *bdev, u8 sa,
> +			    unsigned char *data, int data_len)
> +{
> +	struct scsi_disk *sdkp = scsi_disk(bdev->bd_disk);
> +	struct scsi_device *sdev = sdkp->device;
> +	struct scsi_sense_hdr sshdr;
> +	u8 cmd[10] = { 0, };
> +	int result;

Isn't "{ }" instead of "{ 0, }" the preferred way to zero-initialize a 
data structure?

> +
> +	cmd[0] = PERSISTENT_RESERVE_IN;
> +	cmd[1] = sa;

Can the above two assignments be moved into the initializer of cmd[]?

Thanks,

Bart.

