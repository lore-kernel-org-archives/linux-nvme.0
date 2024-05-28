Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B374DC27C43
	for <linux-nvme@archiver.kernel.org>; Tue, 28 May 2024 22:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bdLyN/qS3SYc66I32s3HOlY5SqViRTnYDRLEy2dSFZk=; b=jDPFdAC8/EdARzYoixomgLy3Mx
	O0JWIwX6lCbvMQOmUasvzsZtWyNOFUqX4LrhWp4SKihoh/NJo2TqZkfsF5RY1B5YpsoK0ercDa+dh
	Na7GNbNWTDWpSL4aEHSPztDmNwkT49dN0LbIsyDbUu3+DBR9hljxutOcs7A9UU56fQ7adG3SaCDaZ
	vR3SYgwrcgJtUI3rGHSmcNvjMBO8bcTCOt+dEAZcepD/QsR+FptimqIFbkzWtnR/WyScosuR3CKIB
	mKP9JVfPlhumbO3oQlKGyM9zUjra/8GN262JdrDzrB3Kg0aC7WqodlwWyd7iRdF7XzN+jSJVMJtoj
	X4qabpIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC5N1-00000002DGe-08XR;
	Tue, 28 May 2024 22:32:39 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC5Mx-00000002DFb-3p6i
	for linux-nvme@lists.infradead.org;
	Tue, 28 May 2024 22:32:37 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6fbbd937719so1048481b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 May 2024 15:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716935553; x=1717540353; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bdLyN/qS3SYc66I32s3HOlY5SqViRTnYDRLEy2dSFZk=;
        b=ed+vKIjnl7bHNE80oHSuu7eeFe/d5sxngxeCinToeEZ4PbUCnG9I8cLc33nEhSqgBm
         uM62PEyVU5fRTi2w1y0E+T9WG8msDp1Ua5D2VeYLNlE+7ZrR+/oPw5mM4mhg7IKyh3NK
         oqBxp2U1O1AuOPRsAgAHeyF7yuNsLuqZSRUszvRE1M/sox7fIQlXPqx5WcbJvazEEa2g
         qFjiXTYbQVNxI9YClOiIQ5c5Vx/LUmEp2LXjZvHhZkvcK+a7dEtsiMY3sTuq34O+lUQ3
         TijyhoXOYDnv43pI2X1fJr0UTXqfr8p2YYI6x0vlGnGdmeVCoUfDV1rmbLNUa7/lJMiZ
         BK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716935553; x=1717540353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bdLyN/qS3SYc66I32s3HOlY5SqViRTnYDRLEy2dSFZk=;
        b=uvCeHf7kR12Tt4Vnd9eEV6lcncFs6wppoTrIDY0KSYg8YkVGejBD50ysDdbN2n/BXQ
         PxM4ks0shyZtnMBqV13cVHtKK7vSu0Mkvnytm1MSuD2dtb5DwLrNStD1R9Tj6KEMsg+I
         9AMvPxpeJFmuNT+QSMqmiXB6Ht9GItRc+ut/fXpemLLs4ZbzKTEEh178q+R5jjCX5mMY
         w+XJkRtKTAo53p8LQCWy51nI5zkyOiMKdw8wY+NJdwSjUJ1Wq/fzPZYgJXgX2E9T0gBm
         YIq2igBGSYCYIGrCi6M6VxoXI0b+sFVctqb/k83R+zEnIKgUw+9OBXoeF3iAcBjK4C7d
         VaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4lWt/zeRmxEs6JYS539CpRqjERk9v4xNRhw5Kup/kxaZqC8pYe/uzeGpV0/e604PHsjk00O9UIze8Yr9AkxqeE/kM23xdy+7dCP47V+M=
X-Gm-Message-State: AOJu0Yx7nIisdujolq0f5hZ1MGZBiJVVpYYIoNczHpI+ynlNksH8NrYf
	+d5JHPHp0ClhX7RIa63LtGRgojCevQJsfUatRFAD5T2u13y6DUVP
X-Google-Smtp-Source: AGHT+IFCHuOiG7zBRaWnG3trQoh8iXsxByYswIYMxVcsPsOW51voYBzr8a/ZmgiECruTc1eYoDSZbg==
X-Received: by 2002:a17:902:680f:b0:1f4:5c38:bc98 with SMTP id d9443c01a7336-1f45c38c398mr96274035ad.57.1716935553144;
        Tue, 28 May 2024 15:32:33 -0700 (PDT)
Received: from [10.69.43.60] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9988besm85339255ad.198.2024.05.28.15.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 15:32:32 -0700 (PDT)
Message-ID: <fc2e7d24-d838-410f-aa8c-d10ee69af10b@gmail.com>
Date: Tue, 28 May 2024 15:32:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] nvme-fcloop: implement 'host_traddr'
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Justin Tee <justintee8345@gmail.com>
References: <20240527051525.762-1-dwagner@suse.de>
 <20240527051525.762-7-dwagner@suse.de>
Content-Language: en-US
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20240527051525.762-7-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_153235_989466_0DF89A32 
X-CRM114-Status: GOOD (  24.49  )
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

On 5/26/2024 10:15 PM, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Implement the 'host_traddr' callback to display the host transport
> address for nvmet debugfs.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fcloop.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 913cd2ec7a6f..e1abb27927ff 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -492,6 +492,16 @@ fcloop_t2h_host_release(void *hosthandle)
>   	/* host handle ignored for now */
>   }
>   
> +static int
> +fcloop_t2h_host_traddr(void *hosthandle, u64 *wwnn, u64 *wwpn)
> +{
> +	struct fcloop_rport *rport = hosthandle;
> +
> +	*wwnn = rport->lport->localport->node_name;
> +	*wwpn = rport->lport->localport->port_name;
> +	return 0;
> +}
> +
>   /*
>    * Simulate reception of RSCN and converting it to a initiator transport
>    * call to rescan a remote port.
> @@ -1074,6 +1084,7 @@ static struct nvmet_fc_target_template tgttemplate = {
>   	.ls_req			= fcloop_t2h_ls_req,
>   	.ls_abort		= fcloop_t2h_ls_abort,
>   	.host_release		= fcloop_t2h_host_release,
> +	.host_traddr		= fcloop_t2h_host_traddr,
>   	.max_hw_queues		= FCLOOP_HW_QUEUES,
>   	.max_sgl_segments	= FCLOOP_SGL_SEGS,
>   	.max_dif_sgl_segments	= FCLOOP_SGL_SEGS,

Daniel,

I found it odd that you had to modify fcloop, but now see what the issue 
is.  We should have had the WWN of the initiator passed to the fc tgt 
transport at the same time hosthandle was first passed. There's several 
ways to do this, such as the one you coded or modifying the ls_rcv call. 
Downside to these are they change the template or calling routines and 
breaks the driver/os binary api in an os that picks them up.

I'd like to look at doing this a little differently. Change hosthandle, 
instead of pointing to a void, points to a host structure, with the host 
structure containing WWPN, WWNN, and N_Port_ID. We can set a 
target_features bit to know if the structure is a void or a host struct. 
This keeps the driver/os api in place.  I'll put something together.

Thoughts ?

-- james


