Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DD1C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l9UrvjS3kn8WnD85QY0PWYB4xiQkf0+Wi0clHJ5e9ZQ=; b=LkvIcrk0kSHTomEPdAdiCap9J/
	eLyj+6Td/WkSH3EKKezE4sE//2TvrK2+GNLsU4W+Z4WeOUQg/h+YizdSXEMEhe2/mGMrkgHXNzSiY
	McCxpb6Me7bxFNznx2eJhHv0G6XuZqUbwz1QRT8KY6T/J5qEg9iOR9EZErV0mqsZ3iS1LpNYi6KXs
	QGNjOOTLE9HFKg0DD0LT0c1SpuZHgkrfiAAluEFe8P7iuPlF+Ek4QZvjKnwWgVKOlK3drae9n/Xg/
	JNi+lYItLBviuVzs37odqCK6azxeTYHuoP7A+3b4oaf0mYQOIDoj3zPDTRENk+Wi+n1vuC5VhUJi0
	U+DwzHXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoUL-007cI6-1F; Tue, 18 Oct 2022 15:26:41 +0000
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoSp-007b6v-9y
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 15:25:08 +0000
Received: by mail-lj1-x236.google.com with SMTP id b18so18352859ljr.13
        for <linux-nvme@lists.infradead.org>; Tue, 18 Oct 2022 08:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9UrvjS3kn8WnD85QY0PWYB4xiQkf0+Wi0clHJ5e9ZQ=;
        b=Kw9w5uMcCC9IgC74rFiSTYG7oYvA0bkiT6pwWGJjFngUMFOVrZtbIUmk2xeQBGIHqt
         wvoWHHUAsCJbWphwHmG44B9PY2n2tQ9jeSKLL2Wz7uSDnooMLoA/k8Vo1kbtp+QHJrb2
         P1TryCi4/TJ1mo+pLPSC+KqYRk3raJw6U4IYl8ff9YDLPZIgPyKqeZPxylLwB6QWxhWP
         m1A+/rGWGdG7gBKTzP94002Ynhq4CFlL6H0AFg88YPDxVAB7UURvyeX+mCG005+0H2XS
         XaoboNYSUuyS8QmHzkIeP+TfiC67hP26G8kTjnFNBiLhcyi3gjtZUplPUr1CDJ9pG6h9
         rKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9UrvjS3kn8WnD85QY0PWYB4xiQkf0+Wi0clHJ5e9ZQ=;
        b=ZmhkcNNDVrZHV01n7sLFZADlINIFhxXMt4dmuSs4N2L9E7/IPGvQVKyTe862ztMiTV
         YiAlY5aGzPEYusspYtoGSLLesWR/sBvl53hHqajLtTKF7tM3z849ZaXi8csDZtyAScH9
         TdPeKdXn8pjP+qSqF2vkoVw4jlhjslMQnslsTvlvQTvFjRJtgnGQlpDkpmSEOpj7aY+S
         BL5LTJFO+hvD4u3DFNAJ2vjvkkTsikkdEqjF7THQhW1PKfhZXtvj9AYhPU3t+UytqUDk
         Iv1NQJhK33rothUue4JMYqVfejxMAAferDccHmbDYumKZmf+74wBOd/u879Rvw9KH7wJ
         rRJQ==
X-Gm-Message-State: ACrzQf2ZyBZjNGRvp4nLdhNn60BxNyW8HfJvYNb088x90RuGds7PZvoj
	5Nsb3l1OtS8nyHmi+xd4vWBp1XemIaUe4w==
X-Google-Smtp-Source: AMsMyM5SPCfHLe8j1LV1Z2sYdUbKvJRwZ8tMzXKJAx56RZbuBpy5PN5GUIYoPXulkw1dst4KAS+wgA==
X-Received: by 2002:a2e:3c0e:0:b0:26e:8b86:5b2b with SMTP id j14-20020a2e3c0e000000b0026e8b865b2bmr1371918lja.167.1666106703512;
        Tue, 18 Oct 2022 08:25:03 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id k26-20020ac2457a000000b004972b0bb426sm1876799lfm.257.2022.10.18.08.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:25:02 -0700 (PDT)
Date: Tue, 18 Oct 2022 18:25:01 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux@roeck-us.net,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-hwmon: don't return errors from nvme_hwmon_init
Message-ID: <20221018152501.i6gp5xgebh3mc6m5@mobilestation>
References: <20221018145808.681327-1-hch@lst.de>
 <20221018151421.jeqe2bi6nyj3afzi@mobilestation>
 <20221018151625.GA22639@lst.de>
 <20221018152148.ok3fmq6vuu4kbd7q@mobilestation>
 <20221018152346.GA23173@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018152346.GA23173@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_082507_379890_CE172949 
X-CRM114-Status: GOOD (  14.38  )
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

On Tue, Oct 18, 2022 at 05:23:46PM +0200, Christoph Hellwig wrote:
> On Tue, Oct 18, 2022 at 06:21:48PM +0300, Serge Semin wrote:
> > Just to clarify. Are you saying that you have already got a patch for
> > the sed-opal driver which fixes opal_dev.{cmd,resp} buffers being used
> > for DMA and takes the Jonathan Derrick note into account?
> 

> No, just the nvme patch.  For sed-opal please just resend it standalone
> to the linux-block list and the maintainers.

Ok. Thanks.

-Sergey

