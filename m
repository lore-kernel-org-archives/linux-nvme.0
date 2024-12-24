Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08DBE77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 10:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=xzzJipNiQgKJizdlMRrU0qBEz9
	mOhYEEKFNGcwsEa2NTc4VjwEvUwdTC5JB0QA+RvRMt8JOALH3Zq9J0nEXGhT9wUqGwSKB85yMsEod
	3h80xG3Ylz8zW0Ly77kM4f5OGW0SlrcTqr+/cVGyukaa8rFsnVb2y5iwRetYGuNf8igwWzN7gvk9T
	HJYLzRW853X927tagf8USMMf2OLCUMVcJPhmkZPTHVBQm1OD3IrY7PageNV5Br8lETukUkNa9aEp6
	z5ja521ihLz8y8hnPIBBJAvT+S2fUkbpTzl79DrurYH4yGcja6LhFjBTqZYUr23gNskRuIZ9z3dwo
	kLf0ik/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2LV-0000000BmbU-2K5Q;
	Tue, 24 Dec 2024 10:41:01 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2LT-0000000Bmay-1k4V
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 10:41:00 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso52375125e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 02:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735036858; x=1735641658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=AIQkVw1eMUDOWoLGR8SAsEIushyOb1U/QdUDK9xnSnQrv5xEciCb99kiwMlg1DwARn
         dARayYzCRiB2WS1PK5xsjMQjiyRNSsGu/C+kIS/tc86jiAtwsUNy0mm008YgFUxIiTVv
         hBTmk9Be9gLfTCDlDMrhfvLlS3X6KF977eRp6SGuKMVGo15QsCOD2FNxDuFwBwpWNhB+
         nR2semJ0uF1oloun+1zQoP+VT2DH5BzZiXqK6UlVOovFkrfHMvKpyGIdW+9I1uZIS0iQ
         obEMVfnYon8ZpmqN7pZPDA1immUbBMBzlY3RWiCJPYV3uKFqvD7p+sQJhXL5W4Me+naZ
         wK0w==
X-Gm-Message-State: AOJu0YzIh66aUXxEke4arEFdsXr+uClgTlVNxE/wbVTgyH16zyc801/A
	FONZd+NwQfmQ2WylMa2uSu1gmAyZMyN159u2W2ogcBQ3Aah6oElL
X-Gm-Gg: ASbGncuR8NwSpCfC3rzcaFZCdawIeNNVffbm/bFzCRpQlgraM9hw4U50uUVMqTNBQk4
	wfdPvEirqWGMOw4l9/yhV2nt4v62CCTPEnWHzbGFkNbQLbFOg7o2sHpAS//fMOsm3Vgyg32ZnCQ
	U5blkA6p89UXBSxCtreuEb3mh7LMCcXKiv/zUWPGI95QH/iLC+zrtOPANj8Mvv48Z9Fw1DAMWhl
	QrMFVi8WnwJj2y8pfWQZQ4lZWSeQwLoNBjldV2mVdjLoBcwNSXlc0JceWdAI7zyToiAFHsfHCQF
	4yYu8sNDCD1dljVzzaGxmNM=
X-Google-Smtp-Source: AGHT+IF1oMCB/CfSXoeRPbfuqSJlzZiAtJUs29HV/rwyPxhltbjXLBZcNuq1UPW2e3Au8T1oV26/Ng==
X-Received: by 2002:a05:600c:1986:b0:434:edcf:7461 with SMTP id 5b1f17b1804b1-43668b78823mr145369475e9.30.1735036857493;
        Tue, 24 Dec 2024 02:40:57 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a71sm163090195e9.26.2024.12.24.02.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 02:40:57 -0800 (PST)
Message-ID: <7af2e735-1ed5-4682-9472-01d2e840b104@grimberg.me>
Date: Tue, 24 Dec 2024 12:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvmet: Don't overflow subsysnqn
To: Leo Stone <leocstone@gmail.com>, hch@lst.de, kch@nvidia.com,
 csander@purestorage.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 syzbot+ff4aab278fa7e27e0f9e@syzkaller.appspotmail.com
References: <20241218185000.17920-2-leocstone@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241218185000.17920-2-leocstone@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_024059_452366_BFE756AA 
X-CRM114-Status: UNSURE (   4.47  )
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

