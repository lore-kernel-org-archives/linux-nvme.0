Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BD2C742A7
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Mar 2023 23:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uJDOs+yx2SWmXYevTPopcDHiVZDlJiA2mU9elmu7DUI=; b=y05hhdWr0RNQdJSrpIUuP74uIi
	OzceUvgy1kPi0rk820Q35SzjsoUDzQNrMmKmtn/1GghwJSJH2lp+z1hedfE7bffir/kpVhIsqz2Aj
	wRQcF1ZTY9lincBxiQMOa/tbrOWarc0y2Aurgk+rgTDzFS3OISTgZj7+hwCeFW0uRVyXpx7T9njjK
	1g+F0vdLrOJoZ0oN2GHVWcJr29AG/naF4mB/jvkfDMNSzXT9cOy5WGojFQVp1l+WrVDkgSubZ+4q7
	RMQr+2sr4vbWjSOpsIF5FquCXZqhVFMk9YYM8Bqtet/7y8l6Oki6c2dNFV7ppqPlYlqXnQwBMy9fz
	RlDq7sXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZgvj-002v3N-EK; Tue, 07 Mar 2023 23:41:15 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZgvf-002v0o-Fw
	for linux-nvme@lists.infradead.org; Tue, 07 Mar 2023 23:41:13 +0000
Received: by mail-pj1-x102a.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso454951pjb.2
        for <linux-nvme@lists.infradead.org>; Tue, 07 Mar 2023 15:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678232467;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJDOs+yx2SWmXYevTPopcDHiVZDlJiA2mU9elmu7DUI=;
        b=tKsnLSRkm79SgBNLvMAgCWMnAN9SX2VvEwxWV2gTNxsSLaNlXrabAG5/Px4kjW05DU
         oVTTHyEcCdiepG1hYL12mErp+ZuMw7F94wQYMkDdxnm/JV/g6XAk58V/m9gWto+wyC7U
         LVLePL91ojnCfQ+PpUSBAtJwYe+9eut10vZgD14NxeD8o0mNtASch8/HR1C8VVz8uTXg
         1qlxfdPMVg8Maql4/ZWENWiO+V7IslYjfbIaQbSCUGn5Mgg3Fm/ntN4vZOrbWKN4LmP2
         131wSX3DViVwSDl57hlhnY74hsmZOnmqVf9moLyiMqD5qQfguihe9OVils/Z7Y75GUs4
         GQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678232467;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJDOs+yx2SWmXYevTPopcDHiVZDlJiA2mU9elmu7DUI=;
        b=ZRXNGLuC8JMKj1OkHMsb3ID/8ll6BXqoYgoe9VoJfPyMSU6hH88+5fVZQltVokwAaL
         dUyYZG399uODlGh0xApUeymIRPqO3LbhSJ2ZfaNHbO017jqPeW8s74tEEOlBhmnnYAf8
         U4G0FabKP0Sf5ewWuPUqAdfEw04fz1WZVXbxb7k6ZdTyP6VFOXYw0MBo5k9+vRgyfCin
         moaQ9Y6MeErzBAsKYBa84/YBpIUNN111+DOIASaowaCfwF5bFKfxJ/XLUC8eZnz0GRHP
         2zLKe7ILDEKdLhuPUP0F2hL0bU28A/Qefjdf3tp19IRKoLF1nMePgCgxlrC0p7C7czIq
         3m0w==
X-Gm-Message-State: AO0yUKW9MbcmVwqQCnPtR/DCHlc5UNWd5o1HTlhAoELIX7LZ56R3gSRI
	HRpl/WkBWI7M4HFU9mO7AoaQ/Q==
X-Google-Smtp-Source: AK7set8a+BT4u7/u/zZVMXsr3fpQhiJ4tZvJBBO/XfhnoX6e/fKjPTuP6Z+3LfO3AQl6AW2n9vuOdA==
X-Received: by 2002:a17:903:32ca:b0:19a:723a:8405 with SMTP id i10-20020a17090332ca00b0019a723a8405mr17731246plr.6.1678232466715;
        Tue, 07 Mar 2023 15:41:06 -0800 (PST)
Received: from [127.0.0.1] ([50.233.106.125])
        by smtp.gmail.com with ESMTPSA id fz3-20020a17090b024300b00233567a978csm9680033pjb.42.2023.03.07.15.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 15:41:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20230303084323.228098-1-sagi@grimberg.me>
References: <20230303084323.228098-1-sagi@grimberg.me>
Subject: Re: [PATCH] docs: sysfs-block: document hidden sysfs entry
Message-Id: <167823246591.62837.10657118034782025874.b4-ty@kernel.dk>
Date: Tue, 07 Mar 2023 16:41:05 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ebd05
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_154111_766392_B106F66C 
X-CRM114-Status: UNSURE (   7.86  )
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


On Fri, 03 Mar 2023 10:43:23 +0200, Sagi Grimberg wrote:
> /sys/block/<disk>/hidden is undocumented. Document it.
> 
> 

Applied, thanks!

[1/1] docs: sysfs-block: document hidden sysfs entry
      commit: e33062213ff2f9151e0d125e1c00f524c2b7acfe

Best regards,
-- 
Jens Axboe




