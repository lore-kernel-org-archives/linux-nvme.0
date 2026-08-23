Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAA6C5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=1UiSpG45DZIx0+3zJfDtbktXMj
	7oA5tdKRQ2XA6ebHlvHm0NqtQYgYqjDuy6q98T1nPZbLmCpZjsBOCQEUiw+Oj/Ot6/iKPJYls2OLZ
	uJo3ijgbIIgpynEDWHB8kyoRG07vcV/UqXccJah4PIcDlJNhgGHEjyE2AENo8hA09Y3R+NFTDWX7K
	CxI6GYROXLbWWiwY9Af99Cq+8tn7ssZ544JYm/U4VZgRtR6BDKOpIChI5mfGnCNMESmxxiP+xVU8K
	XRr1jiru4f4LFuvwc1+4gSVmIfe356uVRgHNa0j4NSwi3D3qVD9JAN8rMuQ42K2R9/Xpbs7BRzY+V
	CnJrcMOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwSv-0000000EwUJ-062P;
	Sun, 23 Aug 2026 00:53:37 +0000
Received: from mail-ed1-f51.google.com ([209.85.208.51])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwSr-0000000EwTt-01z8
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:53:34 +0000
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so3982801a12.0
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787446411; x=1788051211;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=IJAvgQBLBnmsL+BmUUBOKuHErVN47YVAyqpyW8n4E+1nJqgyRmLBXdgsGxmUXkGndR
         54WnrDBYtNRWdsAy4VavkM1fDh5ilLRtwfauG2HDnqXPCVuvRgu9l/6Vhm4bT/d+yVJn
         zcHdO4e2TIV0zjdARTWmk5a4u+E9tttstaij24nLOiqdFUwuYlzXi7coqC6ltzFZSSxT
         9i5DJiFKrWKk2NwbqGT0eAPVyuSDqst/JvPm0ADpxYb4qGkCaH0LIZ2RL4OG2EA6ISjG
         KjfRkdS8XGuNTamRQtX14wIAcDdDbeVkEPO9+N/pRPM5pjS0d6ckj1h9HGXnlkj1Rbsi
         if9g==
X-Forwarded-Encrypted: i=1; AHgh+RrqFlstwy8C6Dy3LN1KJNiP5Dfh7EtCUWhnvcQzS2/7tl3tgE/UEMw22XW59OPuBm1/QG5hWgFK4wuI@lists.infradead.org
X-Gm-Message-State: AFuF++lTcgxJ2svaekAkjM8OvmYunIntzuGdRjw0NXV3OB/1WnlQLqoe
	GMNoJvfxtTvPRY9KC/fQLdWdt7AHCQ1P7pu1/7Cu90qJfox+kPRVXeSZ
X-Gm-Gg: AR+sD11mugjm4AxNmNII9873mgIyaEYySW1/ZIefM8NfGBqnkwKJAWPnZ9szQTJEqI+
	HWvYJsjzdHlzTGUkTfWjvJLMOwsHS1OwykrN05NuSEzPTe0EhWUdemX+bJh1jR1CwPwt1ddvaNA
	XEp1Fdcek2EMp20shQ9/pEXSN15FpTdCS9K8gWfPK03MZGhpYCZsDJhnLC2M04nVHvneOHw5ITh
	fgKyLMd+oiXIKStzxPYCj6QAyCZ5pSAs9v8ntxCdO9agKgiOVo3JuXCgWwqETaiOvXdbwtXXJ+i
	Tv4L59IhX71jWEOPsta7EYNQFh+7RNqFHig7Nhwct8oyfHcKSueGrcdtt4+DeG7VdodGTGueKdI
	oNpWDUQI3mEDIhRDOKbq2NrjCgXTGLttYp2wRhKDBNwj5Ntg4YxzsTWdKgSPJu3IScOosD4uqdA
	1E3ccH0cTCr4PtuHFz5Hoo4Sey6T7WkQsRPu+th8s9sJ22/Uejt8ykCcKhft/87iz294nfRe0gO
	heS4TV7aV655n1G/y+41UQ=
X-Received: by 2002:a05:6402:1f0d:b0:69f:b1d3:3903 with SMTP id 4fb4d7f45d1cf-6a582b2667cmr9947199a12.8.1787446411228;
        Sat, 22 Aug 2026 17:53:31 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e025158sm544703a12.11.2026.08.22.17.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:53:30 -0700 (PDT)
Message-ID: <2ad2def8-68b4-41c2-8704-a122380a3e63@grimberg.me>
Date: Sun, 23 Aug 2026 03:53:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/16] nvmet: Implement CCR logpage
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, James Smart <jsmart833426@gmail.com>,
 Hannes Reinecke <hare@suse.de>, Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-5-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260712022437.3743117-5-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_175333_043812_955FBC43 
X-CRM114-Status: UNSURE (   4.78  )
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

