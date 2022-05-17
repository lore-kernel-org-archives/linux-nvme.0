Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3F4C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 09:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6eoOamSGr7hXXwfIJbIQEnUKD1/WfupvVtlNqvTcvpg=; b=k9EAaiESLVg9Q9S8px4Tfp6ieE
	EWsTyrvvjpljTwJ5erCghejG9fGR9rYYCDLE/Axy7Q9S4V6BpJ9yxKxvoZZxFkFWdxe+b/3dI3fgf
	lvasPoOhrJCg1K1+Cf/aCEYOEOsRWfl77Co/fPP684sjGT1ILETf5jcUbWHl+ZUZY64lXg4QlG1Ix
	Nf6k6RxssBtmkCmAUemdQubyXKVM6O1HbK+zt42uVMpspo3w6yGWEnxXBt5noXZesAgez2Ha8JfBK
	lDG9M0IQylpBp9Sm4S+nuaUgUlC4gpIzyu4PRd4piIZlCu4fdbRwnhdxcaXus3yYdFmkKNt6jzxFe
	JsTSnx9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqtwA-00CtcU-Fv; Tue, 17 May 2022 09:56:18 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqtw6-00Ctad-RT
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 09:56:17 +0000
Received: by mail-wr1-f47.google.com with SMTP id r23so7958312wrr.2
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 02:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=6eoOamSGr7hXXwfIJbIQEnUKD1/WfupvVtlNqvTcvpg=;
 b=vQ0AWNuRzO5izgzLfJt13wXGwGOAknaWf1pr399uaSvjvEbKF/KuHhNXbVPnG6TbUH
 HvmJbpn0SOPzKA12EOa8MTLHwzASNDHfb0gEaPaijIzKwBTfAgwZUJif8CtLZwcEekl6
 Xadq/bYEwxMv1LNE9q0mksUcjaiVxP7SFocrgfxt1PwdAq9aow8qYBLwnJM3/cI2LEAK
 /ER8RXB3jru9RQ+xijIS7RJ6SqRqJzOqNRL+b0KwAMPbfiBVmAL8jHhON20V/PqWuJUN
 07WfnALmKOmq+cnt/xktVG/CgY39lMNbh7jm4IkPDiW7h6X58nAhgbxEmO8Z03NTCRSX
 85gA==
X-Gm-Message-State: AOAM533fJRXvYdZXmOjnpcr5e6AerRjuALXkSDr557q/rqbEwOpI7e6n
 xpxazuNxy6oBjydpW3ucpGzWHI3tjZI=
X-Google-Smtp-Source: ABdhPJxzY9VS0y8M73RMjA7YKvHGXgoUgQ9bcL9CpZz/oI+4dMoVGTOFcv/6Pwqkh0wrZad2fGL4Dg==
X-Received: by 2002:a5d:68cf:0:b0:20c:ff58:37b with SMTP id
 p15-20020a5d68cf000000b0020cff58037bmr11875546wrw.448.1652781370555; 
 Tue, 17 May 2022 02:56:10 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 q4-20020adf9dc4000000b0020c6b78eb5asm11217473wre.68.2022.05.17.02.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 May 2022 02:56:10 -0700 (PDT)
Message-ID: <dd46fded-d213-6956-8f0a-69a70e0107d5@grimberg.me>
Date: Tue, 17 May 2022 12:56:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] nvme: set non-mdts limits at I/O queue creation
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, hch@lst.de, kbusch@kernel.org,
 james.smart@broadcom.com
Cc: linux-nvme@lists.infradead.org
References: <20220517055312.50331-1-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220517055312.50331-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_025615_004913_3D454AF3 
X-CRM114-Status: GOOD (  13.42  )
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



On 5/17/22 08:53, Chaitanya Kulkarni wrote:
> In current implementation we set the non-mdts limits by calling
> nvme_init_non_mdts_limits() from nvme_init_ctrl_finish().
> This also tries to set the limits for the discovery controller which
> has no I/O queues resulting in the warning message reported by the
> nvme_log_error() when running blktest nvme/002: -
> 
> [ 2005.155946] run blktests nvme/002 at 2022-04-09 16:57:47
> [ 2005.192223] loop: module loaded
> [ 2005.196429] nvmet: adding nsid 1 to subsystem blktests-subsystem-0
> [ 2005.200334] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> 
> <------------------------------SNIP---------------------------------->
> 
> [ 2008.958108] nvmet: adding nsid 1 to subsystem blktests-subsystem-997
> [ 2008.962082] nvmet: adding nsid 1 to subsystem blktests-subsystem-998
> [ 2008.966102] nvmet: adding nsid 1 to subsystem blktests-subsystem-999
> [ 2008.973132] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
> *[ 2008.973196] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR*
> [ 2008.974595] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
> [ 2009.103248] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
> 
> Export the nvme_init_non_mdts_limits() and move the same call from
> nvme_ctrl_finish() to each transport right before each transport calls
> the nvme_scan_work() from nvme_start_ctrl() path, then proceeds to the
> ns allocation where these limits max_discard_{segments|sectors} and
> max_write_zeroes_sectors are actually used in folllwing path :-

Why not just check the ctrl->queue_count and call it accordingly?

