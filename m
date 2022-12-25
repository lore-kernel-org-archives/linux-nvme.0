Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C116DC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Vj+N+N5iBuDDJHQtpauLTJBVV3
	oWmJ+u5QY9tVTd3tT2f91tLBdOhLWcbZ18VRx1e+zIRtanX76nmGSFS+Uz0p/+mwUDK39UwLVtyA5
	p+9z9O0I82JKYSVQ50j4GYzkaZrEOI9JNkUXsvhp0OFgIMbFmZyPrlhhuUd+vyf/M+tmsWQNffjo8
	okULLnuw1ror/mCEGLv+uY058fsb3tPgKDi2jChegtHTebcVXyAegTXd81y94qltEC5s6z35wpwX5
	jsGNmq6wQOdpWV4C4woLW9Ok57XWS9wqg2s55sJTRB+n1GkF4Vbu249SjnXexJ0t65jzXUQN0aCj7
	bB6dRsyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OWl-00AAXj-DI; Sun, 25 Dec 2022 10:46:47 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9NtZ-009p1p-2f
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 10:06:18 +0000
Received: by mail-wm1-f49.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso2693101wms.5
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 02:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=hekVCESdD/6BisoTWDnPqxGdISa6rjZgsoAfnrOtxzrRbvqJXuJYQ62o9j1KE+3lad
         F4MDlLfNkjfDdHNMkiTq/jI8LeU5A+2Ak4vJQFSNBsZNI6grd+YJ97Xoelz9lnuq5tdU
         wKgxgeQ5GNxvnWfmOm/Xb9kUQIyMr1V0+qRLFzLOtwGp5QsQrwzu+UCWHdb+bLOnDP1i
         J1kQiJu+Id6FCcv8x+jvi8Ocd7gmqm04zIZAhiPbEsBkHT1bS161TmODt9gfKIEWlphs
         Wtbco1rIkBMM68DmzFJZUkxfURcexodiUtisEzXatPCRhlwau6S/fYi/Biol8arDRmBf
         pdtA==
X-Gm-Message-State: AFqh2kq5lrvYife7UGvvlSkdhsr49KXZack8eiqTKNNAI/qeK4UhyqVp
	xDfFMpMrn16Wp/l/nxI+ypuaU/A7POo=
X-Google-Smtp-Source: AMrXdXvX9ayPTjhMx6A4Lue0tIhnZE6lk/v6MgCsCyRY6RL+ecGOHDIzdYViIy/FZ667IWZx1BV/1w==
X-Received: by 2002:a05:600c:3506:b0:3cf:803b:d7cc with SMTP id h6-20020a05600c350600b003cf803bd7ccmr11538762wmq.33.1671962771192;
        Sun, 25 Dec 2022 02:06:11 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n41-20020a05600c3ba900b003d358beab9dsm11461886wms.47.2022.12.25.02.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 02:06:10 -0800 (PST)
Message-ID: <41027309-ba44-f88c-fb82-28af0dc24f2e@grimberg.me>
Date: Sun, 25 Dec 2022 12:06:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/6] nvme: fix the NVME_CMD_EFFECTS_CSE_MASK definition
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
References: <20221223071814.43564-1-hch@lst.de>
 <20221223071814.43564-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221223071814.43564-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_020617_148811_3ED90016 
X-CRM114-Status: UNSURE (   6.12  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

